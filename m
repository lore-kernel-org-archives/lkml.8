Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06D53C3B1BF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 02:24:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D93D220718
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 02:24:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbgBQCYX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Feb 2020 21:24:23 -0500
Received: from mail.windriver.com ([147.11.1.11]:49039 "EHLO
        mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726183AbgBQCYX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Feb 2020 21:24:23 -0500
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
        by mail.windriver.com (8.15.2/8.15.2) with ESMTPS id 01H2O0lY002285
        (version=TLSv1 cipher=AES256-SHA bits=256 verify=FAIL);
        Sun, 16 Feb 2020 18:24:00 -0800 (PST)
Received: from [128.224.162.175] (128.224.162.175) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.50) with Microsoft SMTP Server (TLS) id 14.3.468.0; Sun, 16 Feb
 2020 18:23:59 -0800
Subject: Re: [PATCH] perf: Support Python 3.8+ in Makefile
To:     Sam Lunt <samueljlunt@gmail.com>, <linux-kernel@vger.kernel.org>,
        <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>
CC:     <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@redhat.com>, <namhyung@kernel.org>, <trivial@kernel.org>
References: <20200131181123.tmamivhq4b7uqasr@gmail.com>
From:   He Zhe <zhe.he@windriver.com>
Message-ID: <30752f2a-fe0b-4150-c32d-07690fb43b82@windriver.com>
Date:   Mon, 17 Feb 2020 10:23:54 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200131181123.tmamivhq4b7uqasr@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [128.224.162.175]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/1/20 2:11 AM, Sam Lunt wrote:
> Python 3.8 changed the output of 'python-config --ldflags' to no longer
> include the '-lpythonX.Y' flag (this apparently fixed an issue loading
> modules with a statically linked Python executable).  The libpython
> feature check in linux/build/feature fails if the Python library is not
> included in FEATURE_CHECK_LDFLAGS-libpython variable.
>
> This adds a check in the Makefile to determine if PYTHON_CONFIG accepts
> the '--embed' flag and passes that flag alongside '--ldflags' if so.
>
> tools/perf is the only place the libpython feature check is used.
>
> Signed-off-by: Sam Lunt <samuel.j.lunt@gmail.com>
> ---
>  tools/perf/Makefile.config | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> index c90f4146e5a2..ccf99351f058 100644
> --- a/tools/perf/Makefile.config
> +++ b/tools/perf/Makefile.config
> @@ -228,8 +228,17 @@ strip-libs  = $(filter-out -l%,$(1))
>
>  PYTHON_CONFIG_SQ := $(call shell-sq,$(PYTHON_CONFIG))
>
> +# Python 3.8 changed the output of `python-config --ldflags` to not include the
> +# '-lpythonX.Y' flag unless '--embed' is also passed. The feature check for
> +# libpython fails if that flag is not included in LDFLAGS
> +ifeq ($(shell $(PYTHON_CONFIG_SQ) --ldflags --embed 2>&1 1>/dev/null; echo $$?), 0)
> +  PYTHON_CONFIG_LDFLAGS := --ldflags --embed
> +else
> +  PYTHON_CONFIG_LDFLAGS := --ldflags
> +endif
> +
>  ifdef PYTHON_CONFIG
> -  PYTHON_EMBED_LDOPTS := $(shell $(PYTHON_CONFIG_SQ) --ldflags 2>/dev/null)
> +  PYTHON_EMBED_LDOPTS := $(shell $(PYTHON_CONFIG_SQ) $(PYTHON_CONFIG_LDFLAGS) 2>/dev/null)

I met the same problem. Would the following change be more simple and clear?

-  PYTHON_EMBED_LDOPTS := $(shell $(PYTHON_CONFIG_SQ) --ldflags 2>/dev/null)
+  PYTHON_EMBED_LDOPTS := $(shell $(PYTHON_CONFIG_SQ) --ldflags --embed 2>/dev/null || $(PYTHON_CONFIG_SQ) --ldflags 2>/dev/null)


Thanks,
Zhe


>    PYTHON_EMBED_LDFLAGS := $(call strip-libs,$(PYTHON_EMBED_LDOPTS))
>    PYTHON_EMBED_LIBADD := $(call grep-libs,$(PYTHON_EMBED_LDOPTS)) -lutil
>    PYTHON_EMBED_CCOPTS := $(shell $(PYTHON_CONFIG_SQ) --includes 2>/dev/null)
>
> base-commit: d5d359b0ac3ffc319ca93c46a4cfd87093759ad6

