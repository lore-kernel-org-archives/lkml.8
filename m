Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8A1AC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 08:36:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75E5620707
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 08:36:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=skogtun.org header.i=@skogtun.org header.b="I1//bUbC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727043AbgHZIgM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 04:36:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727000AbgHZIgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 04:36:12 -0400
Received: from smtp.domeneshop.no (smtp.domeneshop.no [IPv6:2a01:5b40:0:3005::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBF63C061574
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 01:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=skogtun.org
        ; s=ds201912; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=veGH0sj8CpzoB7z2Ugw0Q7KAeYkTLywoEl9R0uF1e9I=; b=I1//bUbCUvJq2ScYDDJp6AyFTB
        su4UHilEJ3AGqu6Zu9cPO9EZegXAAZ6TB0o2laIHgyIHWBUIsIrrlC5SpboU+fWbmjqsnBx84TVIT
        rhwuZ4wTlDa6gSZzW5dZiTh328CivPVxU5Bt1ipvmj44gqlX/R4gwZDZ4a1U92fShrV2wcoVdWYwb
        2Yx56Tnb691FD8OVbmCGMyIbS+w9yZpKcgDSlxWBtPUS45m/Keazh0jAn3ixyxMVaQ6C2h5LWjOT+
        WL3V3HDppIEjUoueIwtj67REL3TF12lCt0GaFVI31lMkyBhKqpcdX87vQiLCEXtEiTR544dCsH8Qn
        KaAaRecg==;
Received: from [2a01:79c:cebf:7fb0:de97:df61:fecc:46bb] (port=58798)
        by smtp.domeneshop.no with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <harald@skogtun.org>)
        id 1kAque-0006B5-M3; Wed, 26 Aug 2020 10:36:08 +0200
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
From:   Harald Arnesen <harald@skogtun.org>
Message-ID: <d4db4a52-3001-cb02-4888-a9dfd55cdd7c@skogtun.org>
Date:   Wed, 26 Aug 2020 10:36:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=wj3WskPCtHncCWLdaP6xVecLp8bDBTT57vyiU-0=Ld6QQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds [25.08.2020 20:19]:

> On Tue, Aug 25, 2020 at 9:32 AM Harald Arnesen <harald@skogtun.org> wrote:
>>
>> > For posterity, I'm told the fix is [1].
>> >
>> > [1] https://lore.kernel.org/intel-gfx/20200821123746.16904-1-joro@8bytes.org/
>>
>> Doesn't fix it for me. As soon as I start XFCE, the mouse and keyboard
>> freeezes. I can still ssh into the machine
>>
>> The three reverts (763fedd6a216, 7ac2d2536dfa and 9e0f9464e2ab) fixes
>> the bug for me.
> 
> Do you get any oops or other indication of what ends up going wrong?
> Since ssh works that should be fairly easy to see.
I was wrong about ssh working. The whole machine locks up when X starts.

A strange thing, sometimes I can log in from lightdm before it locks up,
sometimes I cannot even use the login screen. Timing related?

If I don't start X, console login seems to work fine, and I see nothing
obvious in the logs or kernel messages.

I will try to start just a window manager with startx instead of going
through lightdm.
-- 
Hilsen Harald
