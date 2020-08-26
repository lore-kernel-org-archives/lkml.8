Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AEE3C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 20:44:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DAE5A2078A
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 20:44:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=skogtun.org header.i=@skogtun.org header.b="XaNuR/x+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727107AbgHZUoW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 16:44:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726740AbgHZUoR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 16:44:17 -0400
Received: from smtp.domeneshop.no (smtp.domeneshop.no [IPv6:2a01:5b40:0:3005::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9597C061574
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 13:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=skogtun.org
        ; s=ds201912; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=81QOHKG8nskBo8noIVLaJnv+JFBD/ZOyIUZnyD6RVw0=; b=XaNuR/x+4X9LjePdzfMotUT3X8
        ordHvCiA1DEzi76Fzz0iiCngJfWoTzSKo9q/7M5ETM/tChFVtvYy4d5QQR5AFxyeSB4LfHhmwDPiv
        D6/hHyUV+qACpv3c9tY7fgRmNA2PgQ9VDnVpkKdYxoRmW7nXFz8DpkfD9b4ORLBUcPPZQUNRgMnG9
        D3Iwh2OQ1M7qNX9mRI03ELFfToCiMzpDBfrWOq0DiNzAvOVaIraFkfIMu9uwEBGAgQR1EgN8hSARl
        I/12rWQWUm4enWjjRD398PqSgVTVNU/pPfLGo3cY0jsQ9IrYt8GhNpBFmaq8l8aTJRKhRxQ3PqKx5
        aTSErK8g==;
Received: from [2a01:79c:cebf:7fb0:de97:df61:fecc:46bb] (port=56236)
        by smtp.domeneshop.no with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <harald@skogtun.org>)
        id 1kB2HG-00075B-Qd; Wed, 26 Aug 2020 22:44:14 +0200
Subject: Re: [Intel-gfx] 5.9-rc1: graphics regression moved from -next to
 mainline
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Pavel Machek <pavel@ucw.cz>, Dave Airlie <airlied@gmail.com>,
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
From:   Harald Arnesen <harald@skogtun.org>
Message-ID: <101bff45-0ebd-8fb6-7c99-963aa4fcc588@skogtun.org>
Date:   Wed, 26 Aug 2020 22:44:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=wiAK=AiqTD47o-BFFZciQXpEC0SiiDnXLWJUcQtCo-Pig@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds [26.08.2020 20:04]:

> On Wed, Aug 26, 2020 at 2:30 AM Harald Arnesen <harald@skogtun.org> wrote:
>> Somehow related to lightdm or xfce4? However, it is a regression, since
>> kernel 5.8 works.
> Yeah, apparently there's something else wrong with the relocation changes too.
> 
> That said, does that patch at
> 
>   https://lore.kernel.org/intel-gfx/20200821123746.16904-1-joro@8bytes.org/
> 
> change things at all? If there are two independent bugs, maybe
> applying that patch might at least give you an oops that gets saved in
> the logs?
> 
> (it might be worth waiting a bit after the machine locks up in case
> the machine is alive enough so sync logs after a bit.. If ssh works,
> that's obviously better yet)

No, doesn't help. And I was wrong, ssh does not work at all when the
display locks up.
-- 
Hilsen Harald
