Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4B2DC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 16:32:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A558B2074D
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 16:32:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=skogtun.org header.i=@skogtun.org header.b="gOzfmTZU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726998AbgHYQcO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 12:32:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726938AbgHYQcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 12:32:07 -0400
Received: from smtp.domeneshop.no (smtp.domeneshop.no [IPv6:2a01:5b40:0:3005::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95AE3C061574
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 09:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=skogtun.org
        ; s=ds201912; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Azq8s/g0P7WuVH3XCd58/5BNtHWhEWrZ8Xs/jBWMaEA=; b=gOzfmTZUDkwhzWbfXXFxiyUrJe
        iUX8kg4P+tCCZ6cTVVvJq59/y4QVEBCizu8a9cwNnRk9Lqy7YstihRDV36wxbC20Rc/k9T8eLRoqs
        aay6r4MgjFMBfhrcfyTcQIm4bfona+6074HuaNdRYd8IN5WtFsWULgDSMMxaVdvkODdLUkC+yVMJ5
        o4h/l5ylsG4Mh8Jh9Fkhwgzo3CFNFcZyTOMynPNBrwJD9PV2dtPNf5MAUk9KSyQN1Fe7aJsCrmkgn
        wsOzVD/C0j9SSQS9qUNXC8+ABxz3x2t5yAdEsmuSg/IUuwBpjQdAsEjPmCgVddvq7aeN12OHUHtG3
        rnH4ecVw==;
Received: from [2a01:79c:cebf:7fb0:de97:df61:fecc:46bb] (port=53120)
        by smtp.domeneshop.no with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <harald@skogtun.org>)
        id 1kAbrZ-00031x-Af; Tue, 25 Aug 2020 18:31:57 +0200
Subject: Re: [Intel-gfx] 5.9-rc1: graphics regression moved from -next to
 mainline
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Pavel Machek <pavel@ucw.cz>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Dave Airlie <airlied@gmail.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Matthew Auld <matthew.auld@intel.com>,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        kernel list <linux-kernel@vger.kernel.org>
References: <20200817161132.GA4711@amd>
 <CAHk-=wh6_eWwvpL=AhOeY0btf_dkpu+0joNzPZWfbBWgAeAhMA@mail.gmail.com>
 <CAPM=9tw8LVWsuA6m_nkUDgm00iz2txYRNZY0b0WWZbyiUVzLEw@mail.gmail.com>
 <CAHk-=wg34bw1ude07nC_XCPOJHZ21-v6117p4574d5S7iP4gxw@mail.gmail.com>
 <20200820092349.GA3792@amd>
 <CAHk-=wjX=ck_u8uvp=PjGCQ3M9igE-yqyRPsJ54th1gQWpwMnA@mail.gmail.com>
 <20200821091900.hzbivycs5ky5d3iw@duo.ucw.cz> <87tuwr59te.fsf@intel.com>
From:   Harald Arnesen <harald@skogtun.org>
Message-ID: <7efa547d-b7a4-b873-f1aa-4f19eb849fa3@skogtun.org>
Date:   Tue, 25 Aug 2020 18:31:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <87tuwr59te.fsf@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jani Nikula [25.08.2020 11:55]:

> On Fri, 21 Aug 2020, Pavel Machek <pavel@ucw.cz> wrote:
>> On Thu 2020-08-20 09:16:18, Linus Torvalds wrote:
>>> On Thu, Aug 20, 2020 at 2:23 AM Pavel Machek <pavel@ucw.cz> wrote:
>>> >
>>> > Yes, it seems they make things work. (Chris asked for new patch to be
>>> > tested, so I am switching to his kernel, but it survived longer than
>>> > it usually does.)
>>> 
>>> Ok, so at worst we know how to solve it, at best the reverts won't be
>>> needed because Chris' patch will fix the issue properly.
>>> 
>>> So I'll archive this thread, but remind me if this hasn't gotten
>>> sorted out in the later rc's.
>>
>> Yes, thank you, it seems we have a solution w/o the revert.
> 
> For posterity, I'm told the fix is [1].
> 
> BR,
> Jani.
> 
> 
> [1] https://lore.kernel.org/intel-gfx/20200821123746.16904-1-joro@8bytes.org/

Doesn't fix it for me. As soon as I start XFCE, the mouse and keyboard
freeezes. I can still ssh into the machine

The three reverts (763fedd6a216, 7ac2d2536dfa and 9e0f9464e2ab) fixes
the bug for me.
-- 
Hilsen Harald
