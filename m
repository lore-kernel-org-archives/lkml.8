Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E934BC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 18:04:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BBB0E20737
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 18:04:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598465098;
	bh=hhYf+Z5dierDFXaqkoHOh03RbOsrydhxdZgBZd2/Dl0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=CYhR82L4ZgdB8aclro6IX49tGRZynEVvzMOveQeY1CHuKVL6VJLQbyf3/7YnMRcyO
	 RCJaZbdvPAbf3ep4o5RK2dLgVN7NksdlxxbCRCsEE99lm6p6sbWoH9cUZtR48NxsAB
	 MipqpNYZSFZyl5+xV812cNV99Z9w+POM31BpShG0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726783AbgHZSE4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 14:04:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726187AbgHZSEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 14:04:54 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D734C061574
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 11:04:53 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id m22so3416946ljj.5
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 11:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WS/uJxuwiLHzldorNgMUOjPOOvCspP/oXyUz1rKFvLY=;
        b=gsl5MMtpFNjAqrtJTRY10b6SSrB695wNhgGZ6I864ob20EWqPgWYXe7hztu360LCIz
         Bjd31nxkTx3ZxjFZilSSbLw0bSNbgFN95BuF3Ay9Zjo/uP/uhRyADieYZsLTvpujmFRZ
         nNRbOTiwJDThrxDAFViWi7YqXoD/BG3OChA7w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WS/uJxuwiLHzldorNgMUOjPOOvCspP/oXyUz1rKFvLY=;
        b=XvU8vIrvHGG6nICs0lFr5ijRAXv9hX7F/tm69mMBN3PwiR3tPR6PeZuS+Rs7adXQR9
         WyH1Xlxhjy3noHD3mzaDO/LX2TMiWdmhr5ppOHC8eKEXuU+oEBkeaBJvgorncILko4gb
         VeW6d5/RuQonY+7U9A1AOcRJxZsRZIgScKOPMoXYKNgNbOvvxjOhZC/NyHsv16mPkumj
         oR2ewegrUCRwu72p6TIln33srlxeY+ltVMZrc0DvTQHtOdzOROfiHzaNSp0WxNEfCMo8
         6TBSrw+3sW2oM7lVGQuvxfUPjmB5wD3cMrkNVYRNWwBPwnhho9CrKlelAiz6wSoJUkpo
         bLFw==
X-Gm-Message-State: AOAM530OJ0ikQEJmI3iGtegky3XL2Gbp/WaCUDLIFqXIeMuWEyi//JLI
        0ryT56BzsUT2Pj6yxBgdp3evdgO30JIAQw==
X-Google-Smtp-Source: ABdhPJyAyGLPrUmnu+6I1q0nVRRozt9sSCTUopcLhlnuVfVm9MNcRm3xqq+OWDV5F8V1wO5hSR6Bww==
X-Received: by 2002:a05:651c:231:: with SMTP id z17mr7194727ljn.109.1598465091385;
        Wed, 26 Aug 2020 11:04:51 -0700 (PDT)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id d13sm724749lfl.89.2020.08.26.11.04.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Aug 2020 11:04:49 -0700 (PDT)
Received: by mail-lj1-f178.google.com with SMTP id i10so3441224ljn.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 11:04:49 -0700 (PDT)
X-Received: by 2002:a2e:b008:: with SMTP id y8mr6907538ljk.421.1598465088967;
 Wed, 26 Aug 2020 11:04:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200817161132.GA4711@amd> <CAHk-=wh6_eWwvpL=AhOeY0btf_dkpu+0joNzPZWfbBWgAeAhMA@mail.gmail.com>
 <CAPM=9tw8LVWsuA6m_nkUDgm00iz2txYRNZY0b0WWZbyiUVzLEw@mail.gmail.com>
 <CAHk-=wg34bw1ude07nC_XCPOJHZ21-v6117p4574d5S7iP4gxw@mail.gmail.com>
 <20200820092349.GA3792@amd> <CAHk-=wjX=ck_u8uvp=PjGCQ3M9igE-yqyRPsJ54th1gQWpwMnA@mail.gmail.com>
 <20200821091900.hzbivycs5ky5d3iw@duo.ucw.cz> <87tuwr59te.fsf@intel.com>
 <7efa547d-b7a4-b873-f1aa-4f19eb849fa3@skogtun.org> <CAHk-=wj3WskPCtHncCWLdaP6xVecLp8bDBTT57vyiU-0=Ld6QQ@mail.gmail.com>
 <d4db4a52-3001-cb02-4888-a9dfd55cdd7c@skogtun.org> <656b8f9f-d696-c75d-aef6-2b8b5170f2f6@skogtun.org>
In-Reply-To: <656b8f9f-d696-c75d-aef6-2b8b5170f2f6@skogtun.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 26 Aug 2020 11:04:32 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiAK=AiqTD47o-BFFZciQXpEC0SiiDnXLWJUcQtCo-Pig@mail.gmail.com>
Message-ID: <CAHk-=wiAK=AiqTD47o-BFFZciQXpEC0SiiDnXLWJUcQtCo-Pig@mail.gmail.com>
Subject: Re: [Intel-gfx] 5.9-rc1: graphics regression moved from -next to mainline
To:     Harald Arnesen <harald@skogtun.org>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Pavel Machek <pavel@ucw.cz>, Dave Airlie <airlied@gmail.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Matthew Auld <matthew.auld@intel.com>,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 26, 2020 at 2:30 AM Harald Arnesen <harald@skogtun.org> wrote:
>
> Somehow related to lightdm or xfce4? However, it is a regression, since
> kernel 5.8 works.

Yeah, apparently there's something else wrong with the relocation changes too.

That said, does that patch at

  https://lore.kernel.org/intel-gfx/20200821123746.16904-1-joro@8bytes.org/

change things at all? If there are two independent bugs, maybe
applying that patch might at least give you an oops that gets saved in
the logs?

(it might be worth waiting a bit after the machine locks up in case
the machine is alive enough so sync logs after a bit.. If ssh works,
that's obviously better yet)

              Linus
