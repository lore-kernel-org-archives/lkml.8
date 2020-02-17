Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EAF3C35242
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 04:00:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5333E2072C
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 04:00:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727980AbgBQEAO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Feb 2020 23:00:14 -0500
Received: from mail1.windriver.com ([147.11.146.13]:61478 "EHLO
        mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726672AbgBQEAO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Feb 2020 23:00:14 -0500
X-Greylist: delayed 5719 seconds by postgrey-1.27 at vger.kernel.org; Sun, 16 Feb 2020 23:00:09 EST
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
        by mail1.windriver.com (8.15.2/8.15.2) with ESMTPS id 01H2OWAR013176
        (version=TLSv1 cipher=AES256-SHA bits=256 verify=FAIL);
        Sun, 16 Feb 2020 18:24:32 -0800 (PST)
Received: from [128.224.162.175] (128.224.162.175) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.50) with Microsoft SMTP Server (TLS) id 14.3.468.0; Sun, 16 Feb
 2020 18:24:31 -0800
Subject: Re: [PATCH 1/2] perf: Be compatible with all python versions when
 fetching ldflags
To:     Jiri Olsa <jolsa@redhat.com>
CC:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <namhyung@kernel.org>, <linux-kernel@vger.kernel.org>,
        Sam Lunt <samueljlunt@gmail.com>
References: <1581618066-187262-1-git-send-email-zhe.he@windriver.com>
 <20200216222148.GA161771@krava>
From:   He Zhe <zhe.he@windriver.com>
Message-ID: <8cc46abf-208d-4aa4-8d0d-4922106bee6e@windriver.com>
Date:   Mon, 17 Feb 2020 10:24:27 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200216222148.GA161771@krava>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [128.224.162.175]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/17/20 6:22 AM, Jiri Olsa wrote:
> On Fri, Feb 14, 2020 at 02:21:05AM +0800, zhe.he@windriver.com wrote:
>> From: He Zhe <zhe.he@windriver.com>
>>
>> Since Python v3.8.0, with the following commit
>> 0a8e57248b91 ("bpo-36721: Add --embed option to python-config (GH-13500)"),
> we got similar change recently.. might have not been picked up yet
>
>   https://lore.kernel.org/lkml/20200131181123.tmamivhq4b7uqasr@gmail.com/

Thanks for pointing out.

Zhe

>
> jirka
>
>> --embed option must be passed to "python3-config --ldflags --embed" or
>> "python3-config --libs --embed" to get "-lpython3.8".
>>
>> To make it compatible with all Python versons, according to the suggestion
>> in the commit log, we try with --embed first and then witout it if fails.
>>
>> Signed-off-by: He Zhe <zhe.he@windriver.com>
>> ---
>>  tools/perf/Makefile.config | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
>> index 80e55e7..b2eabcf 100644
>> --- a/tools/perf/Makefile.config
>> +++ b/tools/perf/Makefile.config
>> @@ -229,7 +229,7 @@ strip-libs  = $(filter-out -l%,$(1))
>>  PYTHON_CONFIG_SQ := $(call shell-sq,$(PYTHON_CONFIG))
>>  
>>  ifdef PYTHON_CONFIG
>> -  PYTHON_EMBED_LDOPTS := $(shell $(PYTHON_CONFIG_SQ) --ldflags 2>/dev/null)
>> +  PYTHON_EMBED_LDOPTS := $(shell $(PYTHON_CONFIG_SQ) --ldflags --embed 2>/dev/null || $(PYTHON_CONFIG_SQ) --ldflags 2>/dev/null)
>>    PYTHON_EMBED_LDFLAGS := $(call strip-libs,$(PYTHON_EMBED_LDOPTS))
>>    PYTHON_EMBED_LIBADD := $(call grep-libs,$(PYTHON_EMBED_LDOPTS)) -lutil
>>    PYTHON_EMBED_CCOPTS := $(shell $(PYTHON_CONFIG_SQ) --includes 2>/dev/null)
>> -- 
>> 2.7.4
>>

