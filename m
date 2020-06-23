Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3105C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 07:55:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A06C520771
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 07:55:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592898942;
	bh=l5zyide16jRauLVyjIx4s/szDgiIKUrBdNCtYo6bAx0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=nQ0raMbvzuHPZyVl2DOKUe5YqbPxZ/TGcotfL2f3AwEFfqUYzgGt8vNPRDjh7CYWo
	 lnuU96DsGxNaaIQaeGfmHzSjH3NV8ydO3Uy3JFr2YZ5zUk3pEoO7G78o2mbaBLUT4i
	 0rAMp6pFdcyQDNczf8EgMvT8dSNfduBcv7DRjCg0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731584AbgFWHzl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 03:55:41 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:34335 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731041AbgFWHzk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 03:55:40 -0400
Received: by mail-lj1-f195.google.com with SMTP id x18so22294333lji.1;
        Tue, 23 Jun 2020 00:55:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AE10kGr/AC4PeUq4/87K8LAJGB895p/gy2rm/kQ7kJ4=;
        b=rKq8nnMYLJuroacmlhkM1JyLFstkRVgn4skw0GK4do2KeeNyBDkc7yndzYbtuR7kV1
         voyTyGoxkAKA2vr26OSq7r3psCvMdQPXX9MvuYjVoDRySWqaMrTyKm4Ub4KeP5fx6cVZ
         c9vTOu3Y0QXf4BuQ8oRbOjLkWUX7WyEdCwExzIlSWhEkiAxfj7r+o/hknHVjhpqLRtGi
         zT0fUVRAEG5amFCutL/VQ959EW76fg0+LZd5XlxV6iz6w8wq5SFYoTjXyFxNWjbyApxY
         9/Jem1wnICUfs5lvIuGhSebuj63zJe+j76aWPS6E8oXthUk9v+3n7cC78ml56uyPgllk
         NGGA==
X-Gm-Message-State: AOAM531JfvCAFZrIB3dw9jo703M33850r6iKED3iHwPQQxmuKJHnZtfn
        yQksTd/M83PXAmfkcTnhNTY=
X-Google-Smtp-Source: ABdhPJxLNANtmAbTkrexIY+LSXngC/aT3EDUbkeKwuVVf2h+rF+YsW2jP2tPBtCciU7tmTeXQ8lP/g==
X-Received: by 2002:a2e:7203:: with SMTP id n3mr10502869ljc.231.1592898937196;
        Tue, 23 Jun 2020 00:55:37 -0700 (PDT)
Received: from xi.terra (c-beaee455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.174.190])
        by smtp.gmail.com with ESMTPSA id q26sm3136567ljg.128.2020.06.23.00.55.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2020 00:55:36 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1jndmJ-0000hb-DM; Tue, 23 Jun 2020 09:55:35 +0200
Date:   Tue, 23 Jun 2020 09:55:35 +0200
From:   Johan Hovold <johan@kernel.org>
To:     James Hilliard <james.hilliard1@gmail.com>
Cc:     Johan Hovold <johan@kernel.org>, linux-usb@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2] USB: Serial: cypress_M8: Enable Simply Automated UPB
 PIM
Message-ID: <20200623075535.GE3334@localhost>
References: <20200616220403.1807003-1-james.hilliard1@gmail.com>
 <20200622085321.GA3334@localhost>
 <CADvTj4p6j1bJ8jK5t_nQC9uVRLJn_Fi07-DUu8yQvqM3ymdWMg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADvTj4p6j1bJ8jK5t_nQC9uVRLJn_Fi07-DUu8yQvqM3ymdWMg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 22, 2020 at 11:09:51AM -0600, James Hilliard wrote:
> On Mon, Jun 22, 2020 at 2:53 AM Johan Hovold <johan@kernel.org> wrote:
> >
> > On Tue, Jun 16, 2020 at 04:04:03PM -0600, James Hilliard wrote:
> > > This is a UPB(Universal Powerline Bus) PIM(Powerline Interface Module)
> > > which allows for controlling multiple UPB compatible devices from
> > > Linux using the standard serial interface.
> > >
> > > Based on vendor application source code there are two different models
> > > of USB based PIM devices in addition to a number of RS232 based PIM's.
> > >
> > > The vendor UPB application source contains the following USB ID's:
> > > #define USB_PCS_VENDOR_ID 0x04b4
> > > #define USB_PCS_PIM_PRODUCT_ID 0x5500
> > >
> > > #define USB_SAI_VENDOR_ID 0x17dd
> > > #define USB_SAI_PIM_PRODUCT_ID 0x5500
> > >
> > > The first set of ID's correspond to the PIM variant sold by Powerline
> > > Control Systems while the second corresponds to the Simply Automated
> > > Incorporated PIM. As the product ID for both of these match the default
> > > cypress HID->COM RS232 product ID it assumed that they both use an
> > > internal variant of this HID->COM RS232 converter hardware. However
> > > as the vendor ID for the Simply Automated variant is different we need
> > > to also add it to the cypress_M8 driver so that it is properly
> > > detected.
> > >
> > > Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> > > ---
> > > Changes v1 -> v2:
> > >   - Add more detailed commit message.
> >
> > Now applied, thanks.
>
> Oh, FYI I think part of the comment got dropped when you amended the
> patch
> I don't see the defines in the comment here:
> https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial.git/commit/?h=usb-linus&id=7527d963dff544b0ddfba4319824c50f2a892aeb
> 
> I think I had to temporarily change my git config with this to make it not drop
> the defines:
> git config core.commentchar "*"

Thanks for catching that! I added a leading tab to prevent those lines
from being discarded.

Johan
