Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 080EEC3F2CD
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 05:17:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D03E42072A
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 05:17:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Gxc+O5zU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725922AbgCFFRt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 00:17:49 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:40328 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725798AbgCFFRt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 00:17:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=3bHr9ux4NyUF2qa7B1BoAMKkPgaNK1CJYwDWY7H1H7o=; b=Gxc+O5zUIVcQ5vNqGHwO5rGlQF
        eKufqxLg7lrNsKnfiKylBxw4UvEzAzLt9NRpkISzx9e/QyyK8mwvZw7Jk+EpC6I2BmMt4NYpjKAPj
        RHPRHGwe345//oburQ1lx/5tiGdJlTr9tLV7QSA3A2VR16SAx73cUHMJIqCTws8A+2UR4iyQHbb6K
        7CxOzQr8mAAzGgVyHunvuOt1ZdafbBnuVVgv0l92Y6XRkpPlmJtkjPvUxOAy53zpKJDadAke+oEWl
        qXUDyvbeLAce884+UMWbxM/qAeO7o4VqgxXDHT868PlqEbSzT5F3pwMg4ta/qBluLO2CgZxXCQF83
        2esgoAyQ==;
Received: from [2601:1c0:6280:3f0:897c:6038:c71d:ecac]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jA5Mp-0005X5-Sx; Fri, 06 Mar 2020 05:17:47 +0000
Subject: Re: [BUGFIX PATCH] tools: Let O= makes handle a relative path with -C
 option
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Borislav Petkov <bp@alien8.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>, stable@vger.kernel.org,
        Sasha Levin <sashal@kernel.org>
References: <9e7beb31-b41f-9e95-c92b-1829e420af77@infradead.org>
 <158338818292.25448.7161196505598269976.stgit@devnote2>
 <5d572db0-c603-aef1-220f-b26f89ba947a@infradead.org>
 <20200306103956.7376399c71428b7a527a4d38@kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <31dc5e61-f1da-bcb3-f654-bda0ce0be02e@infradead.org>
Date:   Thu, 5 Mar 2020 21:17:45 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200306103956.7376399c71428b7a527a4d38@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/5/20 5:39 PM, Masami Hiramatsu wrote:
> On Thu, 5 Mar 2020 10:50:43 -0800
> Randy Dunlap <rdunlap@infradead.org> wrote:
> 
>> On 3/4/20 10:03 PM, Masami Hiramatsu wrote:
>>> When I compiled tools/bootconfig from top directory with
>>> -C option, the O= option didn't work correctly if I passed
>>> a relative path.
>>>
>>>   $ make O=./builddir/ -C tools/bootconfig/
>>>   make: Entering directory '/home/mhiramat/ksrc/linux/tools/bootconfig'
>>>   ../scripts/Makefile.include:4: *** O=./builddir/ does not exist.  Stop.
>>>   make: Leaving directory '/home/mhiramat/ksrc/linux/tools/bootconfig'
>>>
>>> The O= directory existence check failed because the check
>>> script ran in the build target directory instead of the
>>> directory where I ran the make command.
>>>
>>> To fix that, once change directory to $(PWD) and check O=
>>> directory, since the PWD is set to where the make command
>>> runs.
>>>
>>> Fixes: c883122acc0d ("perf tools: Let O= makes handle relative paths")
>>> Reported-by: Randy Dunlap <rdunlap@infradead.org>
>>> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
>>
>> Hi Masami,
>>
>> This patch doesn't fix anything AFAICT.
>> Didn't help in my testing.
>>
> 
> Hmm, what happens on your case? Maybe PWD is not set?
> 
> Thank you,

The binary is still built in $srctree/tools/bootconfig/.

If I 'echo $PWD' at a prompt, I get the correct pwd.

> 
>> Thanks.
>>
>>> ---
>>>  tools/scripts/Makefile.include |    4 ++--
>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/tools/scripts/Makefile.include b/tools/scripts/Makefile.include
>>> index ded7a950dc40..6d2f3a1b2249 100644
>>> --- a/tools/scripts/Makefile.include
>>> +++ b/tools/scripts/Makefile.include
>>> @@ -1,8 +1,8 @@
>>>  # SPDX-License-Identifier: GPL-2.0
>>>  ifneq ($(O),)
>>>  ifeq ($(origin O), command line)
>>> -	dummy := $(if $(shell test -d $(O) || echo $(O)),$(error O=$(O) does not exist),)
>>> -	ABSOLUTE_O := $(shell cd $(O) ; pwd)
>>> +	dummy := $(if $(shell cd $(PWD); test -d $(O) || echo $(O)),$(error O=$(O) does not exist),)
>>> +	ABSOLUTE_O := $(shell cd $(PWD); cd $(O) ; pwd)
>>>  	OUTPUT := $(ABSOLUTE_O)/$(if $(subdir),$(subdir)/)
>>>  	COMMAND_O := O=$(ABSOLUTE_O)
>>>  ifeq ($(objtree),)


-- 
~Randy

