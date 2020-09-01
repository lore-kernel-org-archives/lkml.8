Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E569C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 12:08:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3DFC5206EF
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 12:08:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=skogtun.org header.i=@skogtun.org header.b="BnwfBWe9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728138AbgIAMID (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 08:08:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727951AbgIAL6H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 07:58:07 -0400
Received: from smtp.domeneshop.no (smtp.domeneshop.no [IPv6:2a01:5b40:0:3005::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A578C061244
        for <linux-kernel@vger.kernel.org>; Tue,  1 Sep 2020 04:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=skogtun.org
        ; s=ds201912; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ynB/1373qXSHfkD7oBCVQq27uJ8HjQ09s7IAIwHF1XE=; b=BnwfBWe9iNgxGuh18L4om3oVBd
        /GyUkTldFGTUzRAy9IIeYareqre/XRpH4DeVfvA+bR5Y6NCihc/cfZexiGqjAOWnPI29Z8uYdPMn2
        Km0bHANPT5FamoB6dNOEThtgHAfM/LFueHMHDkCYQevpdB/uH0L9xvQo2d0/3ksMPn+lCtaXuozIG
        wzqN6nKDTHXHLqAor+YRjPUFHoYFcEaRn/iQdTd4swunYwv4XbGLLTYemxTQ2U3uXbe8opRDQvDsy
        lxso51f/mEHPwjIHp0kQqiFBCj91HDP2pQESePjv8pU+s3nlO1Ppkd1Igr3I3tqQCnTuHXInY9RpO
        CT5U/pUw==;
Received: from [2a01:79c:cebf:7fb0:de97:df61:fecc:46bb] (port=35868)
        by smtp.domeneshop.no with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <harald@skogtun.org>)
        id 1kD4vH-0000ID-6S; Tue, 01 Sep 2020 13:57:59 +0200
Subject: Re: [Intel-gfx] 5.9-rc1: graphics regression moved from -next to
 mainline
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Dave Airlie <airlied@gmail.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Pavel Machek <pavel@ucw.cz>,
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
 <7efa547d-b7a4-b873-f1aa-4f19eb849fa3@skogtun.org>
 <CAHk-=wj3WskPCtHncCWLdaP6xVecLp8bDBTT57vyiU-0=Ld6QQ@mail.gmail.com>
 <d4db4a52-3001-cb02-4888-a9dfd55cdd7c@skogtun.org>
 <656b8f9f-d696-c75d-aef6-2b8b5170f2f6@skogtun.org>
 <CAHk-=wiAK=AiqTD47o-BFFZciQXpEC0SiiDnXLWJUcQtCo-Pig@mail.gmail.com>
 <101bff45-0ebd-8fb6-7c99-963aa4fcc588@skogtun.org>
 <CAPM=9twLvHu_XLJ89GVXpNo=PHPZLJuRpHggkfzvvuVf+xrwoA@mail.gmail.com>
 <0f06d704-c14e-0d86-c8bb-8c7b3a34758a@skogtun.org>
 <CAHk-=wh=MjX6+Bn-ooHT_wf4VTpe7y-5czbAUT=vaAn2VCBNBQ@mail.gmail.com>
From:   Harald Arnesen <harald@skogtun.org>
Message-ID: <71064aa0-1b62-5437-8fa6-7e7af0e3d4c2@skogtun.org>
Date:   Tue, 1 Sep 2020 13:57:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=wh=MjX6+Bn-ooHT_wf4VTpe7y-5czbAUT=vaAn2VCBNBQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Still (rc3) doesn't work without the three reverts.

I'm not sure how to proceed, I cannot capture any oops, and see nothing
obvious in any logs.
-- 
Hilsen Harald
