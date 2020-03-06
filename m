Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F0EEC10DCE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 16:26:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3123D20658
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 16:26:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mHyBFc5l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726894AbgCFQ0t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 11:26:49 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:43974 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726166AbgCFQ0s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 11:26:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=A9pSgfSLi1laEkqgIFId1rnUulI3bKFwKPVOSv+6Om8=; b=mHyBFc5lzgO9lG71GYBIaMBNRo
        pjVoUO3/stVMH2wH7RY+WRcZGYhU1CseeoXjCBvuUjmIBWCeDvJuUclWx/ZXHkzFHZOmL8zpDtz6M
        i7maTUQKiUSbaoovi5meYGZEcIJgHX653YE/zb6pl0au2+/8tdJK3XOdYceIsKR1QLQmgsfb1riAk
        Zp3gmV7ecPb4vXpbTTQCLZxwtsEstEkFtrkTv6H6swUcA27Mez8JjVosmUnjlrZ9A0y7W13NcFfFc
        AkpWCeEmxDQQhRePLDHR7HU9MXH4mmT3Bz9uZANs7hfxFk1fhmHnTIsFTKxKeXyuaKifspZajyC2+
        XZIDsRew==;
Received: from [2601:1c0:6280:3f0:897c:6038:c71d:ecac]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jAFoC-0004gA-P1; Fri, 06 Mar 2020 16:26:45 +0000
Subject: Re: [BUGFIX PATCH] tools: Let O= makes handle a relative path with -C
 option
To:     Masami Hiramatsu <mhiramat@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Borislav Petkov <bp@alien8.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Sasha Levin <sashal@kernel.org>
References: <9e7beb31-b41f-9e95-c92b-1829e420af77@infradead.org>
 <158338818292.25448.7161196505598269976.stgit@devnote2>
 <CAMuHMdXSNwPwxOTDxK09LKTyOwL=LqTH6+HZRd=RY4P5VHg5Ew@mail.gmail.com>
 <20200307000712.62c32a04c794b9a12e2342bb@kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <69916e54-f555-191b-a9b1-8e7bc1043002@infradead.org>
Date:   Fri, 6 Mar 2020 08:26:43 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200307000712.62c32a04c794b9a12e2342bb@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/6/20 7:07 AM, Masami Hiramatsu wrote:
> Thanks Geert,
> 
> So Randy, what you will get if you add "echo $(PWD)" instead of "cd $(PWD)" ?
> Is that still empty or shows the tools/bootconfig directory?
> 
> Thanks,

OK, in these lines:
+       dummy := $(if $(shell cd $(PWD); test -d $(O) || echo $(O)),$(error O=$(O) does not exist),)
+       ABSOLUTE_O := $(shell cd $(PWD); cd $(O) ; pwd)

I changed both "cd $(PWD)" to "echo $(PWD)" and did
$ make O=BUILD -C tools/bootconfig/

and this is the build log:

make: Entering directory '/home/rdunlap/lnx/next/linux-next-20200306/tools/bootconfig'
cc ../../lib/bootconfig.c main.c -Wall -g -I./include -o bootconfig
make: Leaving directory '/home/rdunlap/lnx/next/linux-next-20200306/tools/bootconfig'


Does that help?

Thanks.

> On Fri, 6 Mar 2020 08:52:40 +0100
> Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> 
>> CC +kbuild, -stable
>>
>> On Thu, Mar 5, 2020 at 7:03 AM Masami Hiramatsu <mhiramat@kernel.org> wrote:
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
>>> -       dummy := $(if $(shell test -d $(O) || echo $(O)),$(error O=$(O) does not exist),)
>>> -       ABSOLUTE_O := $(shell cd $(O) ; pwd)
>>> +       dummy := $(if $(shell cd $(PWD); test -d $(O) || echo $(O)),$(error O=$(O) does not exist),)
>>> +       ABSOLUTE_O := $(shell cd $(PWD); cd $(O) ; pwd)
>>>         OUTPUT := $(ABSOLUTE_O)/$(if $(subdir),$(subdir)/)
>>>         COMMAND_O := O=$(ABSOLUTE_O)
>>>  ifeq ($(objtree),)
>>>
> 
> 


-- 
~Randy
Reported-by: Randy Dunlap <rdunlap@infradead.org>
