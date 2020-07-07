Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1D34C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 15:33:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83D6020663
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 15:33:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="a30Zm0xl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730084AbgGGPdr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 11:33:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728651AbgGGPdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 11:33:45 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FC4EC061755
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 08:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=u+eV/Vt9JPFkjgSC7N8EDNEv2OCJ2IDe/eB3wX/AnBs=; b=a30Zm0xlb5E85J1xhQac/tdmK8
        ZayXBB0v3stbD0fr8xoc1BLj3H3+1MHN+NYM2D9uVn6b2aKpWG8/dnu/YUJqif1+D3Oa085AyhfWa
        e133Q3MgF+Jas8moPItUFjdDZ9UUFA2gKIvhTmqgbVyPzHZu4B4+UqWUIOJJLpkgl4pJJgPFhIE8U
        h/6HI/jgPiiaJC2KQxV18tB9DgkC5OfaP3zh0Zt+lyvPzsMS1tA31zYXKjvWlbtIZpuJqG948a6LU
        natX/r8SiI/6kpCuc6Pfxs2hex6s/+zufLDJuE6eEHRdCG7VA0d/MEcX6l42quUbaVdrqN4JfIqDy
        KXpwncZA==;
Received: from [2601:1c0:6280:3f0:897c:6038:c71d:ecac]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jspbF-0005Iy-Pw; Tue, 07 Jul 2020 15:33:41 +0000
Subject: Re: [Ksummit-discuss] [Tech-board-discuss] [PATCH] CodingStyle:
 Inclusive Terminology
To:     "Bird, Tim" <Tim.Bird@sony.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mike Rapoport <rppt@linux.ibm.com>
Cc:     Chris Mason <clm@fb.clm>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "tech-board-discuss@lists.linuxfoundation.org" 
        <tech-board-discuss@lists.linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        ksummit <ksummit-discuss@lists.linuxfoundation.org>
References: <159389297140.2210796.13590142254668787525.stgit@dwillia2-desk3.amr.corp.intel.com>
 <CALCETrXewAK4_fpaJNDHJVDK9mUcjghA5HwYvZFQNYVfC9M+OQ@mail.gmail.com>
 <202007062234.A90F922DF@keescook> <20200707064921.GA9411@linux.ibm.com>
 <20200707093727.22aa39e2@oasis.local.home>
 <CY4PR13MB117519F548B125CB2F10F50FFD660@CY4PR13MB1175.namprd13.prod.outlook.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <c4aec17f-3ac9-ce17-a131-b186a9b595dd@infradead.org>
Date:   Tue, 7 Jul 2020 08:33:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <CY4PR13MB117519F548B125CB2F10F50FFD660@CY4PR13MB1175.namprd13.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/7/20 8:24 AM, Bird, Tim wrote:
> 
> 
>> -----Original Message-----
>> From: Steven Rostedt
>>
>> On Tue, 7 Jul 2020 09:49:21 +0300
>> Mike Rapoport <rppt@linux.ibm.com> wrote:
>>
>>>> But that's all fine. The change is easy to do and is more descriptive
>>>> even if I can't find terms that don't collide with my internal grammar
>>>> checker. ;)
>>>
>>> How about yeslist and nolist? ;-)
>>
>> I was thinking good-list / bad-list.
>>
>> /me that has been doing a lot of git bisect lately...
> 
> I think it depends on the context.  I'd prefer a grammatically awkward verb that described
> the action more specifically, than a grammatically nicer generic term.  In other words,
> yes/no, good/bad don't mean that much to me, unless it's obvious from context
> what the effect will be.  With something like allow/deny, I have a pretty clear mental
> model of what the code is going to do.

That matches what I was about to say:
Just using yes/no does not tell someone what they are saying yes or no about.
It should be more descriptive, like allow/block.

-- 
~Randy

