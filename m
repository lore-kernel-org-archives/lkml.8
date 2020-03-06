Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1FC0C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 18:26:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8731020675
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 18:26:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XlLIv4zX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726498AbgCFS0T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 13:26:19 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:49578 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726300AbgCFS0T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 13:26:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=VtZJXojkEirLuSi0/sa/AaLRuVDn5VwuZ7Frz7nT91Y=; b=XlLIv4zX9E66pRLcOo+N679vYx
        msbUw63uhGAVHLrB70cdiEI74lU7Wyj6qr4bHG+HEC22wO5B8re9UcEgyGyTEmn8NlxMZf7wp21mR
        hG6CCdOUOFn42lnwNchQeerGjqEUfFijdH0PVLngKssj+ovw9HZIXazaA7pCEG7Jr8g7q5hP7XYXH
        /rgIL1L+3Chsw4g2DRng6BQCbAo5SGwiDOzWwsqFo1x9ai30w2OC7b1gi+9O6I2W6+D1+dNAMWl/3
        POHG57IZxOVMoe8bc7mEY9/oIJ2PbKW+8hhheUmk/1YjX4OFElO3rYsWCrstP3JZT7VS8GfR1R7UA
        hQS/agUw==;
Received: from [2601:1c0:6280:3f0:897c:6038:c71d:ecac]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jAHfs-00035C-He; Fri, 06 Mar 2020 18:26:16 +0000
Subject: Re: [BUGFIX PATCH] tools: Let O= makes handle a relative path with -C
 option
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Steven Rostedt <rostedt@goodmis.org>,
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
 <69916e54-f555-191b-a9b1-8e7bc1043002@infradead.org>
 <20200307031021.4e25253e7ff4aeb14b8a1095@kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <afd5c7ed-53a1-22a3-2664-72797df8c577@infradead.org>
Date:   Fri, 6 Mar 2020 10:26:15 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200307031021.4e25253e7ff4aeb14b8a1095@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/6/20 10:10 AM, Masami Hiramatsu wrote:
> On Fri, 6 Mar 2020 08:26:43 -0800
> Randy Dunlap <rdunlap@infradead.org> wrote:
> 
>> On 3/6/20 7:07 AM, Masami Hiramatsu wrote:
>>> Thanks Geert,
>>>
>>> So Randy, what you will get if you add "echo $(PWD)" instead of "cd $(PWD)" ?
>>> Is that still empty or shows the tools/bootconfig directory?
>>>
>>> Thanks,
>>
>> OK, in these lines:
>> +       dummy := $(if $(shell cd $(PWD); test -d $(O) || echo $(O)),$(error O=$(O) does not exist),)
>> +       ABSOLUTE_O := $(shell cd $(PWD); cd $(O) ; pwd)
>>
>> I changed both "cd $(PWD)" to "echo $(PWD)" and did
>> $ make O=BUILD -C tools/bootconfig/
>>
>> and this is the build log:
>>
>> make: Entering directory '/home/rdunlap/lnx/next/linux-next-20200306/tools/bootconfig'
>> cc ../../lib/bootconfig.c main.c -Wall -g -I./include -o bootconfig
>> make: Leaving directory '/home/rdunlap/lnx/next/linux-next-20200306/tools/bootconfig'
>>
>>
>> Does that help?
> 
> Hmm, did you apply "[PATCH 1/2] bootconfig: Support O=<builddir> option" too?

oh crud.  nope.  Sorry about that.

Building bootconfig with O=BUILD is now working.

Thanks for your time and patience.

> Also, I found this is not enough for perf. perf does more tricky thing in its Makefile.

Ack.

-- 
~Randy

