Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FF81C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 21:10:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B64320658
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 21:10:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cpWNBhuf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728188AbgGNVK0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 17:10:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727939AbgGNVKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 17:10:25 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2D82C061794
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 14:10:25 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id l17so7338644iok.7
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 14:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tf9PAf4+scrz48zRc1kpOyACTjUnABDU7s5fr84q2Xs=;
        b=cpWNBhufuFQNDA2gpemEkyku+gKrlNiQt3MhwI1Eugw/Bx6Y0AYdA21C8z0JAUNfHb
         9js0LLzYMMUrX76NM3O+OIdWsFtaDqEimtbf2jPZmG45ku17m5JsSioQvJzpgAvqhPvs
         n4QCFMP3DwDh/tkETDRDxy4mhoouYJCJcKvXlsY1v25wvGr6/WN9Kxetf6ApX2A0Ret+
         sp3n5A7pP65mjvAbQo2k/XC0KVZdWM5qeKjmfm/Un78MHqsfxgyIf82nxRgtqNAq8NkE
         1EfxMyhngVhXWdkjHy8gHjgkBGEiclN7ZDujnXYZzyOWOrLrQJD3AbtTwvWop8cg0641
         h9Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tf9PAf4+scrz48zRc1kpOyACTjUnABDU7s5fr84q2Xs=;
        b=opyVl/uyGKSXUeyOw88w8biawyN7s+F+PA4S9iqzTaQD/hLT49eKJF/UFymfGf7KtP
         4A2dLqt7hzX4Ie4VeU5DmTGgRtONAwEygDE528F4JDBIhHC3srddVS4S1bKv0lUWFrmH
         Mcd+vkP8aHMkQP73EfGtGtCDlbELQXqvdrsy/EquoDfUT3iCsJfQIwP8l76nf5Ghr7wA
         Vp8tCEF3i6vOBSeG4zfVWqM8fm/+xORkNJ0rzPxXZ7vUo+TxVCTCLNM+h4RGKnSAGsOR
         MCClfqg4iHIOZtCEZcRxpwpe6TXem3GTNM4c38xUaOCV+E8Stquc0awIq53Rr50Wnm7R
         A9jw==
X-Gm-Message-State: AOAM533IsPaVSPEuwhzuBkV4hCyROPvZ7gg1c/VzoZwD+6qoO6Fuongn
        25fnh4v+jFI530j+imD4KpoWFtH93N+YxM82PH6SLg==
X-Google-Smtp-Source: ABdhPJzMjt9SabBaf1o//577oui3GOmtQID23iPxyM0BvroWjYHuwu82cadQM1D4S+NKjseqAU1eQd+4NuDPbMB8/UM=
X-Received: by 2002:a6b:5b0e:: with SMTP id v14mr6876818ioh.145.1594761024680;
 Tue, 14 Jul 2020 14:10:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200713215759.3701482-1-victorhsieh@google.com>
 <20200714121249.GA21928@nautica> <20200714205401.GE1064009@gmail.com>
In-Reply-To: <20200714205401.GE1064009@gmail.com>
From:   Victor Hsieh <victorhsieh@google.com>
Date:   Tue, 14 Jul 2020 14:10:11 -0700
Message-ID: <CAFCauYPo_3ztwbbexEJvdfDFCZgiake1L32cTc_Y_p4bDLr7zg@mail.gmail.com>
Subject: Re: [PATCH] fs/9p: Fix TCREATE's fid in protocol
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Dominique Martinet <asmadeus@codewreck.org>,
        v9fs-developer@lists.sourceforge.net,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please disregard this patch.  I misunderstood the protocol and have
found the actual problem in the hypervisor's 9P implementation.  Sorry
about the noise.

On Tue, Jul 14, 2020 at 1:54 PM Eric Biggers <ebiggers@kernel.org> wrote:
>
> On Tue, Jul 14, 2020 at 02:12:49PM +0200, Dominique Martinet wrote:
> >
> > > Fixes: 5643135a2846 ("fs/9p: This patch implements TLCREATE for 9p2000.L protocol.")
> > > Signed-off-by: Victor Hsieh <victorhsieh@google.com>
> > > Cc: stable@vger.kernel.org
> >
> > (afaiu it is normally frowned upon for developers to add this cc (I can
> > understand stable@ not wanting spam discussing issues left and right
> > before maintainers agreed on them!) ; I can add it to the commit itself
> > if requested but they normally pick most such fixes pretty nicely for
> > backport anyway; I see most 9p patches backported as long as the patch
> > applies cleanly which is pretty much all the time.
> > Please let me know if I understood that incorrectly)
> >
>
> Some people assume this, but the stable maintainers themselves say that Cc'ing
> stable@vger.kernel.org on in-development patches is fine:
> https://lkml.kernel.org/r/20200423184219.GA80650@kroah.com
>
> And doing so is pretty much inevitable, since the tag gets picked up by
> 'git send-email'.  (Yes, there's also "stable@kernel.org", but it's not actually
> what is documented.)
>
> - Eric
