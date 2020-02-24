Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEA05C3567B
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 07:03:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A49D20675
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 07:03:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727185AbgBXHDK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 02:03:10 -0500
Received: from mail5.windriver.com ([192.103.53.11]:53568 "EHLO mail5.wrs.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726509AbgBXHDJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 02:03:09 -0500
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
        by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id 01O70LVi011567
        (version=TLSv1 cipher=AES256-SHA bits=256 verify=FAIL);
        Sun, 23 Feb 2020 23:00:31 -0800
Received: from [128.224.162.175] (128.224.162.175) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.50) with Microsoft SMTP Server (TLS) id 14.3.468.0; Sun, 23 Feb
 2020 23:00:11 -0800
Subject: Re: [PATCH] perf: Support Python 3.8+ in Makefile
To:     Sam Lunt <samueljlunt@gmail.com>
CC:     <linux-kernel@vger.kernel.org>, <peterz@infradead.org>,
        <mingo@redhat.com>, <acme@kernel.org>, <mark.rutland@arm.com>,
        <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        <namhyung@kernel.org>, <trivial@kernel.org>
References: <20200131181123.tmamivhq4b7uqasr@gmail.com>
 <30752f2a-fe0b-4150-c32d-07690fb43b82@windriver.com>
 <CAGn10uUFJLh7J5rNcbH-Y6aGGr0vK_YN40gry9PXh_tx3sSXMg@mail.gmail.com>
From:   He Zhe <zhe.he@windriver.com>
Message-ID: <3f59e138-6f19-5419-2397-fc7d2e5f9df9@windriver.com>
Date:   Mon, 24 Feb 2020 15:00:05 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAGn10uUFJLh7J5rNcbH-Y6aGGr0vK_YN40gry9PXh_tx3sSXMg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [128.224.162.175]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/23/20 12:38 AM, Sam Lunt wrote:
> On Sun, Feb 16, 2020 at 8:24 PM He Zhe <zhe.he@windriver.com> wrote:
>> On 2/1/20 2:11 AM, Sam Lunt wrote:
>>> Python 3.8 changed the output of 'python-config --ldflags' to no longer
>>> include the '-lpythonX.Y' flag (this apparently fixed an issue loading
>>> modules with a statically linked Python executable).  The libpython
>>> feature check in linux/build/feature fails if the Python library is not
>>> included in FEATURE_CHECK_LDFLAGS-libpython variable.
>>>
>>> This adds a check in the Makefile to determine if PYTHON_CONFIG accepts
>>> the '--embed' flag and passes that flag alongside '--ldflags' if so.
>>>
>>> tools/perf is the only place the libpython feature check is used.
>>>
>>> Signed-off-by: Sam Lunt <samuel.j.lunt@gmail.com>
>>> ---
>>>  tools/perf/Makefile.config | 11 ++++++++++-
>>>  1 file changed, 10 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
>>> index c90f4146e5a2..ccf99351f058 100644
>>> --- a/tools/perf/Makefile.config
>>> +++ b/tools/perf/Makefile.config
>>> @@ -228,8 +228,17 @@ strip-libs  = $(filter-out -l%,$(1))
>>>
>>>  PYTHON_CONFIG_SQ := $(call shell-sq,$(PYTHON_CONFIG))
>>>
>>> +# Python 3.8 changed the output of `python-config --ldflags` to not include the
>>> +# '-lpythonX.Y' flag unless '--embed' is also passed. The feature check for
>>> +# libpython fails if that flag is not included in LDFLAGS
>>> +ifeq ($(shell $(PYTHON_CONFIG_SQ) --ldflags --embed 2>&1 1>/dev/null; echo $$?), 0)
>>> +  PYTHON_CONFIG_LDFLAGS := --ldflags --embed
>>> +else
>>> +  PYTHON_CONFIG_LDFLAGS := --ldflags
>>> +endif
>>> +
>>>  ifdef PYTHON_CONFIG
>>> -  PYTHON_EMBED_LDOPTS := $(shell $(PYTHON_CONFIG_SQ) --ldflags 2>/dev/null)
>>> +  PYTHON_EMBED_LDOPTS := $(shell $(PYTHON_CONFIG_SQ) $(PYTHON_CONFIG_LDFLAGS) 2>/dev/null)
>> I met the same problem. Would the following change be more simple and clear?
>>
>> -  PYTHON_EMBED_LDOPTS := $(shell $(PYTHON_CONFIG_SQ) --ldflags 2>/dev/null)
>> +  PYTHON_EMBED_LDOPTS := $(shell $(PYTHON_CONFIG_SQ) --ldflags --embed 2>/dev/null || $(PYTHON_CONFIG_SQ) --ldflags 2>/dev/null)
> That change is nearly equivalent to the change I'd suggested, just
> squashed into one line. I think it's certainly more terse, but I'm not
> sure it's any clearer.
>
> It's also making the implicit assumption that PYTHON_CONFIG_SQ does
> not print anything to stdout when it exits with a non-zero return
> code. I think that's probably a safe assumption, but it seems more
> robust not to make that assumption at all.

That said, such assumption was also made in the "else" case of your change and
in the original line. If we wanted that robustness, we'd better give a stricter
condition and a warning like below.

+ifeq ($(shell $(PYTHON_CONFIG_SQ) --ldflags --embed 2>&1 1>/dev/null; echo $$?), 0)
+  PYTHON_CONFIG_LDFLAGS := --ldflags --embed
+else ifeq ($(shell $(PYTHON_CONFIG_SQ) --ldflags 2>&1 1>/dev/null; echo $$?), 0)
+  PYTHON_CONFIG_LDFLAGS := --ldflags
+else
+  $(warning Failed to get python ldflags.)
+endif

Given that such kind of assumptions spread across kernel makefiles, the
one-liner might be good enough.


Regards,
Zhe

>
> Best,
> Sam

