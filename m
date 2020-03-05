Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5E78C3F2D2
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 18:51:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFB2E24654
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 18:51:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nV/RvK1Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726183AbgCESvZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 13:51:25 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:44234 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbgCESvZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 13:51:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=rSjMjSKSsVB1va+0Y7qf1amnEaMdNXb7x5DEMVwi2Bo=; b=nV/RvK1QPSm1IHAjb6H3lF5aud
        lETLI7i5jBERVaSxCL/7z0GGP9QdKKCGiLAkvqxvz7YgisWpYXhO8djaAX56pNP0BZU2Bvb1I0+Ht
        tS0C/WN27lx/zsSaNcwdaThi00JCWZzXnP6U06YZhWQUPTLGXUKHmj4Qm5VicETj6H7hXNiqRLpcx
        IhQt7nxF1WOmatY023WFAW9DdXcbh60Qn0Wf6tmczHfVjBnpHq7WPaxunL1nplPEQJ+xjWUMx9iPW
        yvOdSSguGGBwaI7ZDrHhj2H2yLZqQQ2hsDRlns/RzUYtaY+kDT2KgS79elqWTFq39g7VzmbY5k/kv
        lfZBMr2g==;
Received: from [2601:1c0:6280:3f0:897c:6038:c71d:ecac]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j9vad-0005a5-VH; Thu, 05 Mar 2020 18:51:24 +0000
Subject: Re: [PATCH 1/2] bootconfig: Support O=<builddir> option
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>
References: <158323467008.10560.4307464503748340855.stgit@devnote2>
 <158323468033.10560.14661631369326294355.stgit@devnote2>
 <27ae25f5-29c6-62f3-5531-78fcc28b7d3c@infradead.org>
 <20200304221716.007587c7@oasis.local.home>
 <9e7beb31-b41f-9e95-c92b-1829e420af77@infradead.org>
 <CAMuHMdVSSGbHBOvFbYaPuRH59Nmh_AaqJFfu-csJnZHOtd7mGQ@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <d305e626-bc6e-8185-df4d-c57d912039a5@infradead.org>
Date:   Thu, 5 Mar 2020 10:51:23 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAMuHMdVSSGbHBOvFbYaPuRH59Nmh_AaqJFfu-csJnZHOtd7mGQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/4/20 11:41 PM, Geert Uytterhoeven wrote:
> Hi Randy,
> 
> On Thu, Mar 5, 2020 at 5:53 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>> On 3/4/20 7:17 PM, Steven Rostedt wrote:
>>> On Wed, 4 Mar 2020 15:04:43 -0800
>>> Randy Dunlap <rdunlap@infradead.org> wrote:
>>>
>>>> On 3/3/20 3:24 AM, Masami Hiramatsu wrote:
>>>>> Support O=<builddir> option to build bootconfig tool in
>>>>> the other directory. As same as other tools, if you specify
>>>>> O=<builddir>, bootconfig command is build under <builddir>.
>>>>
>>>> Hm.  If I use
>>>> $ make O=~/tmp -C tools/bootconfig
>>>>
>>>> that works: it builds bootconfig in ~/tmp.
>>>>
>>>> OTOH, if I sit at the top of the kernel source tree
>>>> and I enter
>>>> $ mkdir builddir
>>>> $ make O=builddir -C tools/bootconfig
>>>>
>>>> I get this:
>>>> make: Entering directory '/home/rdunlap/lnx/next/linux-next-20200304/tools/bootconfig'
>>>> ../scripts/Makefile.include:4: *** O=builddir does not exist.  Stop.
>>>> make: Leaving directory '/home/rdunlap/lnx/next/linux-next-20200304/tools/bootconfig'
>>>>
>>>> so it looks like tools/scripts/Makefile.include doesn't handle this case correctly
>>>> (which is how I do all of my builds).
>>>>
>>>
>>> Do you build perf that way?
>>
>> No.  It should also be fixed.
> 
> There are lots of issues when (cross)building the tools and selftest with O=.
> I tried to fix some of them a while ago, but I lost interest.
> https://lore.kernel.org/lkml/20190114135144.26096-1-geert+renesas@glider.be/
> 
> The only thing you can rely on when (cross)building with O=, is the kernel
> itself ;-)

Yeah, oh well.  I'm not ready to just give up on it though.

thanks.

-- 
~Randy

