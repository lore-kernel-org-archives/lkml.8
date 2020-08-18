Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A144C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 09:32:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 640962078B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 09:32:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oiYao3LS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726593AbgHRJcO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 05:32:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726165AbgHRJcL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 05:32:11 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BDC8C061389
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 02:32:09 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id z18so15772399otk.6
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 02:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CukyYxKQagzxSnoAUerbnhafgFTcDCc+vCHDuzHrDm0=;
        b=oiYao3LSY05RtHiCa7E8GRzIrl9VRRJYDZjBtQ/ubmceLYQblalUYWs7OwMluhpnUV
         1OD/4u8SmwCBI4jQy+CFzB9DiOBMSi80AOG36VcptLnhf6mlFt3cEPpf08XASzer3N1U
         8ju50bDwgsm8cIKentn09KT7dEn43UVXAcfqk+qtmEK0ijNDJx9xsmN1YdHBtsSuJmgX
         XysM+f14J1mp0IjxEpAjmlNUmnhz1n1EVGQKFm+eyUG+fLys9+zxOsW+/DEZwSjDm1AD
         eZY+FJmAR1IxLWdli8IGiG0WHu1UOvpZRaDlGQ0XHmg+jBupgMHOuue6LE6XSsPUVN5S
         P/Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CukyYxKQagzxSnoAUerbnhafgFTcDCc+vCHDuzHrDm0=;
        b=Cl9Lrt0ZX5E+eEDYVvKJ+yRDd5McaDCEkmV8sPooVBNGRL45pOKJePg8aSURtxMMvx
         DDnYi4BW/mBNppbkshxVf5/1sfDj2bu0y+mJ95AJ3fG8igKYvntVpuP/cUSKD+tq7M32
         E9kN8hIcBYI320ebmT8qNnXLg/HOvxk4jfryNTkg/4T+zNhhbQLxRhI1VeMd9MXiGoXo
         R1r+b3r0C3Cy+NtXLvk3j0DQFbbQP1BVg7OVwhxnm9E/jexxWai1Mu0GbGUxRu+lcI4T
         KJqxcE5KamthCupZncnKhPNPENw37hr3aUQJSWuZzizDECjJD+fSMmrlFYH2gGLv8p5V
         9kvA==
X-Gm-Message-State: AOAM533GuIp8A02Wp+ES/mpxJ61kZeHBuGj24NQmzs0pxwiIaCJn7Xyl
        aKfGBHHpMAOjYDmV30z6L4m8SEt7JwAjNM0nn58=
X-Google-Smtp-Source: ABdhPJxWr9qkdSOHISPy+oYHPAYjGVOTOnZt44b3JJOq1hBBUFKJuivSXPClh61XAr/SYq05DdwSLWmaagZHOPuDyto=
X-Received: by 2002:a9d:128c:: with SMTP id g12mr13892805otg.242.1597743128285;
 Tue, 18 Aug 2020 02:32:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200817085703.25732-1-allen.cryptic@gmail.com>
 <s5hpn7pprl1.wl-tiwai@suse.de> <CAEogwTAGHOfBe4ztkx9To0gQGwHwFWzCBxn8nzWJP=wRJUJ56A@mail.gmail.com>
 <s5hk0xxppz6.wl-tiwai@suse.de>
In-Reply-To: <s5hk0xxppz6.wl-tiwai@suse.de>
From:   Allen <allen.lkml@gmail.com>
Date:   Tue, 18 Aug 2020 15:01:56 +0530
Message-ID: <CAOMdWSLJmiAxH5bvwh9b8O_MLdttU3Fsb4B_Y2tA08_P1b0BXQ@mail.gmail.com>
Subject: Re: [PATCH 00/10] sound: convert tasklets to use new tasklet_setup()
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Allen Pais <allen.cryptic@gmail.com>, perex@perex.cz,
        tiwai@suse.com, clemens@ladisch.de, o-takashi@sakamocchi.jp,
        timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
        Kees Cook <keescook@chromium.org>, alsa-devel@alsa-project.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>
> Well, then at the next time, please mention it explicitly in the cover
> letter.  Usually this kind of API conversion isn't done during rc.  Or
> it's done systematically via script or such.  So unless mentioned,
> it's not expected to be carried to 5.9.

 Sorry for having missed the detail. Will take care of it in the future.

>
> In anyway, if the final purpose is to drop the old tasklet API and
> that's the plan for 5.9, all tree-wide changes have to be done in
> 5.9 beforehand.  Was that the decision?

 The idea was to land the tree-wide changes as part of 5.9

>
> > > I have a patch set to drop the whole tasklet usage in sound/*
> > > (destined for 5.10, to be submitted soon), so if that's for 5.10,
> > > it'll be likely superfluous.
> >
> >  I have picked patches from your tree to adapt to this new API.
> > Those can be picked in 5.10 I suppose.
>
> Adapting the changes are trivial, don't worry.  It was just a question
> of how to organize changes.

Sure, Thank you.

- Allen
