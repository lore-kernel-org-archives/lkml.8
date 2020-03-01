Return-Path: <SRS0=2gEN=4S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67514C3F2D1
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Mar 2020 16:52:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36F6021556
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Mar 2020 16:52:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YEleoFK1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726602AbgCAQwf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Mar 2020 11:52:35 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:38139 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726204AbgCAQwe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Mar 2020 11:52:34 -0500
Received: by mail-io1-f67.google.com with SMTP id s24so8962616iog.5;
        Sun, 01 Mar 2020 08:52:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=LwKzNUI6J0auIJ5BlaThpyOtWbiBMINS20BDjkZqn68=;
        b=YEleoFK19OCp6RJkkVCvc2R2r4JjO+s54QzexWKkW+eRs7qRf6BzXyVyVbWBX432DW
         bauQ9+Wf0IP9DUm023ovyON1Up7H5SjQTOHCz33zjgHsmU/+npfQuFrgTJv61WnbpDpA
         BkXevIkLcmHNDs/cG1zaCZZ/SPEq6QODO9WH4E5nFau5gN7uq+laqgGzROL7DnwgNwVL
         h61SSIKwl5h3A7/gRwVu9Dfp5c17Ug5ZlSQ6i8wPJrWudPB/inTrFrrL0lKCmVpePW51
         dTyTG2s3wm22FmLoFRb4lwQ1NtflvrsPoyLpTBEo9D8HEM2VgC5RVmIIt9vXHsW2sEP8
         IwiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=LwKzNUI6J0auIJ5BlaThpyOtWbiBMINS20BDjkZqn68=;
        b=UG4RNMTxN09aL8nnQMiQoSa96ryskedOH8CIACvIqE6ztiIe9Tpu2GWk8cmZCA79/d
         MrjmQ64RmnfO7grd6geQslxoBF9b4Zf+OKxXFVDpsDnX+Y7r2jonwiWq2FZjj+xuCafN
         fG1zzdoaQDoD/0NKaAWkW2ofDZT1DtarmtCbFS+7cqaQpxcjOEx2nTdeMECvMXeczb90
         GMHgvEDCv+RmJokavLSVZ2OHF0v8J0uwNhRN/tMeUyFF5UL7F453e2eQIPjzMjhFe8r/
         eizNHXhaRT03kK4Z57JjUmfwDBDFK1wy7sfqnPffLGf2USjxrHrK71FLKM/kioP6JfN8
         CeBg==
X-Gm-Message-State: APjAAAUbiGSYeRTL8Of22OUSg2WpNLj28g1CFP+oW7GyTHDFEARHTWqp
        xzbIyGN+cWx3bkTO+iF/Kqbdr3ztpE9HKxRv+f4=
X-Google-Smtp-Source: APXvYqy1tIHYkdw1kyEPR+1RwbiEddGW5vcQuNpVBcuN2xd36hpBgbLsdSdVGVrEhnrk+nYqpTA5YAlIAWYX7uMy1L4=
X-Received: by 2002:a6b:b642:: with SMTP id g63mr10002372iof.122.1583081552244;
 Sun, 01 Mar 2020 08:52:32 -0800 (PST)
MIME-Version: 1.0
References: <20200226210414.28133-1-linux@roeck-us.net> <20200226210414.28133-2-linux@roeck-us.net>
 <CAD=FV=WDd4E-zDW73kb-qHo1QYQrD3BTgVpE70rzowpgeXVy7w@mail.gmail.com>
 <ce3357a1-467f-1241-ae0d-2e113116ca8d@roeck-us.net> <f94fc372-d81b-e8e4-e7ef-780fe7db1237@roeck-us.net>
 <CAD=FV=VNsOo--1x+pkwhWOWSGAQyVB6g6CE+o4q7phPSXaDXRw@mail.gmail.com>
 <20200228175905.GB3188@roeck-us.net> <CAKv9HNbugeO0E5w8PsN-EpgHBtAjOYZppkUz1u0a5Ue6k20GwQ@mail.gmail.com>
 <62d81632-4a6f-b2d8-e420-b58fb6c9d044@roeck-us.net> <CAKv9HNax9bK-60Gkv3ovZDAS_xVEQa95-J_9WKoEkifqa0u9+A@mail.gmail.com>
 <CAKv9HNaPJFE5if2th5gqAu+_ncPrfGHVS-sJ67Zy8jao1tJZvg@mail.gmail.com> <28e29bb7-b536-dd0f-d410-f4add6b2a9ab@roeck-us.net>
In-Reply-To: <28e29bb7-b536-dd0f-d410-f4add6b2a9ab@roeck-us.net>
From:   =?UTF-8?B?QW50dGkgU2VwcMOkbMOk?= <a.seppala@gmail.com>
Date:   Sun, 1 Mar 2020 18:51:55 +0200
Message-ID: <CAKv9HNZjWKS1thKZ84FwYabHr-o2Q-T9xc4V2Oz6NtiuogQfRQ@mail.gmail.com>
Subject: Re: [RFT PATCH 1/4] usb: dwc2: Simplify and fix DMA alignment code
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Doug Anderson <dianders@chromium.org>,
        Minas Harutyunyan <hminas@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Boris ARZUR <boris@konbu.org>, linux-usb@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Felipe Balbi <balbi@kernel.org>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Martin Schiller <ms@dev.tdt.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 1 Mar 2020 at 18:24, Guenter Roeck <linux@roeck-us.net> wrote:
>
> Hi Antti,
>
> On 3/1/20 7:51 AM, Antti Sepp=C3=A4l=C3=A4 wrote:
> > On Sat, 29 Feb 2020 at 18:33, Antti Sepp=C3=A4l=C3=A4 <a.seppala@gmail.=
com> wrote:
> >>
> >> On Sat, 29 Feb 2020 at 17:25, Guenter Roeck <linux@roeck-us.net> wrote=
:
> >>>
> >>> Sigh. It would have been too simple. Too bad I can't test myself.
> >>> I'd like to know if this is because URB_NO_TRANSFER_DMA_MAP is set on=
 a
> >>> transfer, or because the beginning of the buffer indeed needs to be a=
ligned
> >>> to the DMA cache line size on that system. In the latter case, the qu=
estion
> >>> is why the alignment to DWC2_USB_DMA_ALIGN (=3D4) works. In the forme=
r case,
> >>> question would be why the realignment does any good in the first plac=
e.
> >>>
> >>> Any chance you can add some test code to help figuring out what exact=
ly
> >>> goes wrong ?
> >>>
> >>
> >> Sure, I can try to help. Just let me know what code you would like to
> >> insert and where and I'll see what I can do.
> >>
> >
> > So I did some further research on this and it turns out that:
> >  - URB_NO_TRANSFER_DMA_MAP is not set on the offending transfers so
> > the issue really is buffer alignment
> >  - DWC2_USB_DMA_ALIGN=3D4 "works" because in my limited testcase (usb
> > 4g-dongle utilized via qmi-wwan) all transfers are unaligned. That is,
> > every urb->transfer_buffer is misaligned by 2 bytes =3D=3D unaligned
> >  - I can fix both issues and thus make the patch work on MIPS by
> > modifying it like this:
> >
> > -#define DWC2_USB_DMA_ALIGN 4
> > +#define DWC2_USB_DMA_ALIGN dma_get_cache_alignment()
> >
> >  struct dma_aligned_buffer {
> >         void *old_xfer_buffer;
> > -       u8 data[0];
> > +       u8 data[0] ____cacheline_aligned;
> >  };
> >
>
> Thanks for the additional testing. That means that the existing code
> is already broken, or am I missing something ?
>

Yes, I believe the existing code is broken if 4 byte aligned transfers
occur. I seem to have no easy way to prove that though as none of my
devices generate those.

> Updating DWC2_USB_DMA_ALIGN to dma_get_cache_alignment() was part
> of my initial fix, but then I abandoned it because I thought, well,
> the existing alignment works, so that can't be the problem.
>
> Anyway, using ____cacheline_aligned is an excellent idea. I'll make
> the changes suggested above for the next version of my series.
>

Great. In the meanwhile I'll continue testing and will report back if
I find anything new.

--=20
Antti
