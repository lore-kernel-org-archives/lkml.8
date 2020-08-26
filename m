Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 656D7C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 09:30:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24FE52071E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 09:30:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=skogtun.org header.i=@skogtun.org header.b="Rk7ZuCod"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728055AbgHZJaw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 05:30:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727854AbgHZJat (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 05:30:49 -0400
Received: from smtp.domeneshop.no (smtp.domeneshop.no [IPv6:2a01:5b40:0:3005::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5470C061574
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 02:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=skogtun.org
        ; s=ds201912; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:References:Cc:To:From:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=D7+Jx+ipRXUNSqtp8iDy27VRNb+YHLhYEj4OX0r9Vfs=; b=Rk7ZuCodIYXFFCOwuBS6hpeYhA
        4P72/AO7wyRNaTUHm01GfeG18wjvM6DkWx94dFq8eKmmpfUd5obekOWUQ+YW42AV8hYJRUCoOC188
        ZJcK5W0r458APqDQJCFI3L0IRbiUJVFj0buzMbEui2wossq0bacnRd0WEx39dbmvmKBNrglPd91OD
        Bi8VT1ClpxjiFFvaEgb5Kb61oTrjuy7WbQ8I+CJbkPcAJcTLU9syfl3HwxSNkejgZtPgTzx5C3BnQ
        6oo1hq1BQFPegEfJFZ7exVW4VouDnvj5wNDUytQXYm21A+iwYBrdzrYUaEZZKOwivk5xmzo2sdvkb
        qPotAq8A==;
Received: from [2a01:79c:cebf:7fb0:de97:df61:fecc:46bb] (port=45730)
        by smtp.domeneshop.no with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <harald@skogtun.org>)
        id 1kArlX-00069R-1v; Wed, 26 Aug 2020 11:30:47 +0200
Subject: Re: [Intel-gfx] 5.9-rc1: graphics regression moved from -next to
 mainline
From:   Harald Arnesen <harald@skogtun.org>
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
Message-ID: <656b8f9f-d696-c75d-aef6-2b8b5170f2f6@skogtun.org>
Date:   Wed, 26 Aug 2020 11:30:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <d4db4a52-3001-cb02-4888-a9dfd55cdd7c@skogtun.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Harald Arnesen [26.08.2020 10:36]:

> I was wrong about ssh working. The whole machine locks up when X starts.
> 
> A strange thing, sometimes I can log in from lightdm before it locks up,
> sometimes I cannot even use the login screen. Timing related?
> 
> If I don't start X, console login seems to work fine, and I see nothing
> obvious in the logs or kernel messages.
> 
> I will try to start just a window manager with startx instead of going
> through lightdm.

Disabled lightdm, started DE or WM from .xinitrc:

xfce4-session: Machine locks up
enlightenment: Machine works

Somehow related to lightdm or xfce4? However, it is a regression, since
kernel 5.8 works.
-- 
Hilsen Harald
