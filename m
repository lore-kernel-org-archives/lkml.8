Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B9DBC433E1
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 08:45:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32FEA20678
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 08:45:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="Hch2bh2t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725965AbgHCIpU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 04:45:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725806AbgHCIpU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 04:45:20 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23D72C061756
        for <linux-kernel@vger.kernel.org>; Mon,  3 Aug 2020 01:45:19 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id k4so32638362oik.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 01:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=gCUQRtjhgMP+4GbBlVgd/KVwJHXD6T5ihkhKQfTfDnU=;
        b=Hch2bh2tVN4GKSCCG47YFGcb33DidnAU0pRKNrC6oElbJ3glt2FoXG+13dUia3VYc/
         D7B6Ra3TG2G4k8P1ViHNYEhdkuYmmYwHY3uCpoPmJz4tunDAm1LbIDEMrc0y5b6U3NvB
         INwJeEmQ9u/BXHXS33nqaRRqxkdRL7GWZ5NLE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=gCUQRtjhgMP+4GbBlVgd/KVwJHXD6T5ihkhKQfTfDnU=;
        b=RmCnAIJm4flhRm9Sz9g+NApnaeFSHzGeEw0du2ZBujSGIptcDJEnIO2F7k5BW92tVZ
         gnDDfUjdCVtZIoAnmoNdWUw5JvtZLXisDg065OFm5V2znazWphEaJzZdtSH0SzkLfrby
         vPc95gi/LHm5YJ4DHiJv1g/DDv+M14bQ2DQ7dL3DNsRcWDi/nvila/KyyCxnoF5J/DS7
         IIei+U64xc71LQB0EZcUC8AUvWheX3lcW46WPKN0fzote5ZlEQ4qvAZc+9ApdN3lw5vb
         9V+nKLOk5qgUig9gMPZkUBf2rhDK96Kvaw3jS31TOhSH1qa/IA9XC8pxMODnEHXVMAaR
         80cQ==
X-Gm-Message-State: AOAM533EefDe4RfP79qDc96bPff0q53ye2fVcnXvAoOlYsSUEOFRMGlz
        lF0vOn5TnRNqnPWvUaBLMfpi8vXZLqPjaHem8g9XMA==
X-Google-Smtp-Source: ABdhPJyId8XExJYVy8L0eC778A06mCCWCXZXLWXucocgDo0ClcYsQp5fGA/P5XZTfEUbLvnRb5egClDmVXOjvoGR4Ag=
X-Received: by 2002:aca:ab87:: with SMTP id u129mr11811035oie.128.1596444318309;
 Mon, 03 Aug 2020 01:45:18 -0700 (PDT)
MIME-Version: 1.0
References: <659f8dcf-7802-1ca1-1372-eb7fefd4d8f4@kernel.org>
 <dbcf2841-7718-2ba7-11e0-efa4b9de8de1@nsfocus.com> <9fb43895-ca91-9b07-ebfd-808cf854ca95@nsfocus.com>
 <9386c640-34dd-0a50-5694-4f87cc600e0f@kernel.org> <20200803081823.GD493272@kroah.com>
In-Reply-To: <20200803081823.GD493272@kroah.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Mon, 3 Aug 2020 10:45:07 +0200
Message-ID: <CAKMK7uEV+CV89-L1Y=dijOEy8DKE=juRfQDnNnbhbAJhFh1fYw@mail.gmail.com>
Subject: Re: [PATCH] vgacon: fix out of bounds write to the scrollback buffer
To:     Greg KH <greg@kroah.com>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Kyungtae Kim <kt0755@gmail.com>,
        Anthony Liguori <aliguori@amazon.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        DRI devel <dri-devel@lists.freedesktop.org>,
        "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>,
        Solar Designer <solar@openwall.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        xiao.zhang@windriver.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        =?UTF-8?B?5byg5LqR5rW3?= <zhangyunhai@nsfocus.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 3, 2020 at 10:26 AM Greg KH <greg@kroah.com> wrote:
>
> On Mon, Aug 03, 2020 at 10:08:43AM +0200, Jiri Slaby wrote:
> > Hi,
> >
> > On 31. 07. 20, 7:22, =E5=BC=A0=E4=BA=91=E6=B5=B7 wrote:
> > > Remove whitespace at EOL
> >
> > I am fine with the patch. However it should be sent properly (inline
> > mail, having a PATCH subject etc. -- see
> > Documentation/process/submitting-patches.rst). git send-email after git
> > format-patch handles most of it.
> >
> > There is also question who is willing to take it?
> >
> > Bart? Greg? Should we route it via akpm, or will you Linus directly? (I
> > can sign off and resend the patch which was attached to the mail I am
> > replying to too, if need be.)
>
> I can take it, if Bart can't, just let me know.

Yeah vt stuff and console drivers !=3D fbcon go through Greg's tree past
few years ...

Greg, should we maybe add a MAINTAINERS entry that matches on all
things console? With tty/vt you definitely have the other side of that
coin already :-)
-Daniel
--=20
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
