Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9677C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 03:32:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 925B92053B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 03:32:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="R9rEOl7h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbgHRDcN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 23:32:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726357AbgHRDcM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 23:32:12 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78BD5C061389
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 20:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=F5xFqaunYPNzZR8j8lPHydUHGVB0Vc0j165OWeHrHVw=; b=R9rEOl7ht4hVwd+uFqo95SqwUg
        bE+Dpx+r1gDIRdlqifVRb1BmN1QIBmck8XJQ2D/Cnk/rgWQ6XYBq+Hpt880N1Dxumqf1Y8SILOxCn
        1SoUsGQhKcPu3g/ntDNcrdWWpXo6AW37nd24PsH3Ux0sBzWbwB5mlNLM1ZDD/LkPhDfa9PLBEWDVw
        VTq0v93JveKSBY2P4/BwzYhjcK+rDliIitNf7SALrF7MDSrZLTlRbHqp0rlMvOBJsH7yUirtyRAeG
        9bJsfjySTEwtG+0ws4Qn6ssTDjWlclq5RH4iu3dCOckLyI8Nmf6YYHRcz5pmDHWQ7Eq6JhJrSOWn+
        QqmzwJlQ==;
Received: from c-73-157-219-8.hsd1.or.comcast.net ([73.157.219.8] helo=[10.0.0.252])
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k7sM5-00028x-CO; Tue, 18 Aug 2020 03:32:09 +0000
Subject: Re: [PATCH] genksyms: keywords: Use __restrict not _restrict
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Joe Perches <joe@perches.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <15f52e9b0e50296aba35871bc1575a684c4a258a.camel@perches.com>
 <CAKwvOd=8C94K-9VCqdCn9FXiyfDhKxMu=4AGem1bGgp8m6z0fw@mail.gmail.com>
 <CAHk-=wjjHN32BXdqu1iP8WSZoqdGPDDiqVLUbBgYG+=JO3MJCw@mail.gmail.com>
 <bc2ca9785cb7cf86c59c8922269d2dfc077ec3cc.camel@perches.com>
 <e5737af8-f38c-659a-9c10-9a106edf81a3@infradead.org>
 <CAK7LNARc22dcj03=BKYxEi2PxBeNn91LBig-eXOBowXK+oUQoQ@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <f264c943-2ce0-23ec-f9f4-83ca8bff8785@infradead.org>
Date:   Mon, 17 Aug 2020 20:32:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAK7LNARc22dcj03=BKYxEi2PxBeNn91LBig-eXOBowXK+oUQoQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/17/20 6:05 PM, Masahiro Yamada wrote:
> On Sun, Aug 16, 2020 at 7:46 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>>
>> On 8/14/20 8:17 PM, Joe Perches wrote:
>>> On Fri, 2020-08-14 at 20:05 -0700, Linus Torvalds wrote:
>>>> On Fri, Aug 14, 2020 at 7:14 PM Nick Desaulniers
>>>> <ndesaulniers@google.com> wrote:
>>>>> What's KAO? Urban dictionary has no entry. :^P
>>>>
>>>> It goes back to 2003 and the original keywords.gperf file, see
>>>>
>>>>    https://git.kernel.org/pub/scm/linux/kernel/git/tglx/history.git/commit/?id=46bd1da672d66ccd8a639d3c1f8a166048cca608
>>>>
>>>> from the BK history conversion.
>>>>
>>>> It might be Kai Germaschewski's tagger name?
>>>
>>> I think it was Keith Owens.
>>
>> Probably.  A.K.A. kaos.
>>
>> --
>> ~Randy
>>
> 
> 
> Perhaps, we can remove "KAO"s ?

Should be OK to do that.

> Anyway, I was trying to pick up this patch.
> 
> 
> I take patches from patchwork, but it looks like
> the server (https://lore.kernel.org/patchwork/project/lkml/list/)
> has been down for a while...

Yes, it is having some issues.
I have asked for help on that.

-- 
~Randy

