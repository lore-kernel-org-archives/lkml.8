Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 568C6C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 21:47:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 330132072C
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 21:47:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728436AbgETVrf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 17:47:35 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:43035 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726510AbgETVre (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 17:47:34 -0400
Received: from mail-qk1-f170.google.com ([209.85.222.170]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MfqGN-1j8XSm19th-00gFcE for <linux-kernel@vger.kernel.org>; Wed, 20 May
 2020 23:47:33 +0200
Received: by mail-qk1-f170.google.com with SMTP id g185so5253239qke.7
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 14:47:33 -0700 (PDT)
X-Gm-Message-State: AOAM532qBkTkp4VZmgp8HR8SHOjSmJ8i6mbepUf2CfdXt38Ju/MMBhjQ
        bFy8dI3OLy9bw20sgVXXOgbHQeZXQndRQ0I7kTc=
X-Google-Smtp-Source: ABdhPJyblIrQ+FRZ1+vkFqa3kdJbj+kys6/D4wP2ixD7ofRKYpJXj4RlX4GmhOt1oDcZB88uKDthYwKoTZHGVVxcXsQ=
X-Received: by 2002:a37:46c9:: with SMTP id t192mr3930837qka.3.1590011252195;
 Wed, 20 May 2020 14:47:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200520195440.38759-1-hdegoede@redhat.com> <20200520195440.38759-5-hdegoede@redhat.com>
In-Reply-To: <20200520195440.38759-5-hdegoede@redhat.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 20 May 2020 23:47:16 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1sDRsfsmPf4=Q3mG75VVNoD3CC7Rrgb4BZMEEfTu66qA@mail.gmail.com>
Message-ID: <CAK8P3a1sDRsfsmPf4=Q3mG75VVNoD3CC7Rrgb4BZMEEfTu66qA@mail.gmail.com>
Subject: Re: [PATCH 5/8] virt: vbox: Add support for the new
 VBG_IOCTL_ACQUIRE_GUEST_CAPABILITIES ioctl
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:TaUUWBtUgfAuSuzzgjd25jxD1K9SzRzgnJGvcd+vwrx0laSDhsD
 H4iv/naeoh5xROWsqPtGUj6Yr1cjqYbohjLrjqi933VpeXAe1qBjrYZDHctPu2aOqnP4Ajx
 wb0aHljygvGfRorOMb+LZae1owhpQNGuBLi4syqBH3UTjbNwgM8MZWpzu6qvhdW5JV3NRGl
 /zFVGWnwEAcN7udHsZttA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/tw2pKrYFzI=:RDsBAbqVUOqR/4w7johhLh
 ymfa6MRrr4/uz43v3+kzCNKyY+OjDhNv0JXa7puqS9D5T+hLsG6mxB5FGt4szEg1caWyKQcaa
 oiCwTSIO0JeLoNGWGrXgTFQqSBq84g9Vnw88mhr2bvfPI/OQz+no3RmBDMOre8SjRxYJGMWKy
 fbLKIxFgUORlQysRW9Wqo5oYzGhcJUOHB2XPMYvxiaJUP9j8ZplSw1A28iqzXw4vZWtAltXgr
 OzUCwP6RnrHdG+eba+Bk7d5biCc9SHWIr6ZeQznmwmoHUDgmDepLNZNg81cS/T3kU83NAIzgd
 BZaglF0IPiPHiY6T2CPCKX44rkarUykKDsds8lULumVDeJYPOLXnyPiHYgWKjID+SBTqyQvsL
 27Tl3zMEXXILINgXUArDIOY8XSz6mqrZBd5NNMxDkQjDG8ZVv8eFqUO8n2mc6F+c2WQGDo40v
 ksIudIw4rie/tLurj7YRnGT2L+GyG1dSIo7zxuhwpvWUUJRhJCVzyBBRLxISbp49gzw9jQjwD
 P3TwAgnCFcClW1LHvwmIu+8aElDzsUH+e58b76IniQShV9RGFu8V7eNrDTNvNFBpX1xC/w7nG
 RMXIfLVHIGkCgOubdOcYYvAICoKKFonSZxcmb8LrENkTUGrs1KZ5BnpUUnfosNaLaQ+/OZ7Cb
 TIFckgyWwgtN/UlpsWx2zZQu/Qgz5JzBNoqzTUxEZ2TzUg6tD1Czn7FUhR0QP+E97lb+thD3x
 Qc8wiMOykfcTTxkTnPNzpnf/As+WndghHHttCARHPY9paAJNkI3u/Wr38kT1BpMO9vOkTrt7X
 s5cwjhZHjDka91HED4VeMRc9eCK/tO0zNkoN3oZkZSqzIdztCM=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 20, 2020 at 9:55 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Add support for the new VBG_IOCTL_ACQUIRE_GUEST_CAPABILITIES ioctl, this
> is necessary for automatic resizing of the guest resolution to match the
> VM-window size to work with the new VMSVGA virtual GPU which is now the
> new default in VirtualBox.
>
> BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1789545
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

This is not a great interface, but I see no bugs in the implementation
or problems with portability.

If you want to improve it a little bit, note that spin_lock_irqsave() inside
of mutex_lock() is a little bit silly since you know at this point that
interrupts are enabled and you could use spin_lock_irq() instead.

I assume the driver does the same thing everywhere but I did not check.

       Arnd
