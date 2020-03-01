Return-Path: <SRS0=2gEN=4S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE1AEC3F2CD
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Mar 2020 15:52:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A10F624677
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Mar 2020 15:52:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uU2y5uYQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbgCAPwT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Mar 2020 10:52:19 -0500
Received: from mail-il1-f195.google.com ([209.85.166.195]:40580 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbgCAPwT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Mar 2020 10:52:19 -0500
Received: by mail-il1-f195.google.com with SMTP id g6so5875741ilc.7;
        Sun, 01 Mar 2020 07:52:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1YX6Y1gQNmVyzC4OFTtavzK3SSTW7dvfILV1Msp9sSY=;
        b=uU2y5uYQGU56GBfqjH6M8RBtuS2X8yeZGTLxlAiuz89V8aaYeg1+Ysd6GgoTNrNurH
         +WeqiHMvOzzDn9T+Vpx6W33VRMO2Q85JzNKDfD8eQ5aF2DMd2AD/t+35dyGX54MHXdf2
         4C0DJtaW/OMCK559rWmYs/++F1YUtJT9eH+2J1ovHjno9S3bABNvSFjJj2ScE0nRLkrR
         L/KRiKGigHSxyDwmfrITE4BY3UNheMZB10sgBVt8NnEYqrxoBWTVTYzfoHuAfrr7ZYXl
         mk5MCrXSp4uojrWa87Nea7wRkCcmK6O6srdjfZsbYFyYl9Wp3VIQgIqu8JqQ3WxGqHsq
         bjGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1YX6Y1gQNmVyzC4OFTtavzK3SSTW7dvfILV1Msp9sSY=;
        b=UE4Fpn/8A8/kqlaZy1zrdu6blVZgWQuhhw8T9H+K4pyKlq+6omqjVDOgIybdJfmjFM
         omjYmyvN26USI2rG/hATTEPocKFIbsPh262kv/NEvCtPitt6PD8SvGwtL4f1WH9o1pD4
         90AaqLgvtIRySVy0dMnpmkUFs10CV/tEYd5t7ZGin54YSZcxpo8AaY+VbymTNuKpBmNU
         sbBU+szKn16T4Kel6XwF7o+Vv8WEb/k7JmY+qqahN2yQTNGbqSefk26qwm23WJ4Kxakb
         47r/psLNKQYuB53dNeqY+5CjwjjFyJTl/pNZU+FevUTgzGF7Bi5veJbjmFMsOJU1oimC
         tWxw==
X-Gm-Message-State: APjAAAUDoFt+IxCWZVyU/oQpz13RZjfgeKM/dvpUWOyNXmsB3NfNacqb
        9UT/yq6WjOV0DgaOK+VUO/fWJQqBox6bzsvED2Q=
X-Google-Smtp-Source: APXvYqwCbTqzM564R5Ace2Yju4ilPbJcmpWRjvWwH4/nvpX1SATJvZPFm+C16bJPOHuf3X3zpMoC1Ahtp7bFE5d+FOo=
X-Received: by 2002:a92:4a0b:: with SMTP id m11mr12562957ilf.122.1583077938497;
 Sun, 01 Mar 2020 07:52:18 -0800 (PST)
MIME-Version: 1.0
References: <20200226210414.28133-1-linux@roeck-us.net> <20200226210414.28133-2-linux@roeck-us.net>
 <CAD=FV=WDd4E-zDW73kb-qHo1QYQrD3BTgVpE70rzowpgeXVy7w@mail.gmail.com>
 <ce3357a1-467f-1241-ae0d-2e113116ca8d@roeck-us.net> <f94fc372-d81b-e8e4-e7ef-780fe7db1237@roeck-us.net>
 <CAD=FV=VNsOo--1x+pkwhWOWSGAQyVB6g6CE+o4q7phPSXaDXRw@mail.gmail.com>
 <20200228175905.GB3188@roeck-us.net> <CAKv9HNbugeO0E5w8PsN-EpgHBtAjOYZppkUz1u0a5Ue6k20GwQ@mail.gmail.com>
 <62d81632-4a6f-b2d8-e420-b58fb6c9d044@roeck-us.net> <CAKv9HNax9bK-60Gkv3ovZDAS_xVEQa95-J_9WKoEkifqa0u9+A@mail.gmail.com>
In-Reply-To: <CAKv9HNax9bK-60Gkv3ovZDAS_xVEQa95-J_9WKoEkifqa0u9+A@mail.gmail.com>
From:   =?UTF-8?B?QW50dGkgU2VwcMOkbMOk?= <a.seppala@gmail.com>
Date:   Sun, 1 Mar 2020 17:51:42 +0200
Message-ID: <CAKv9HNaPJFE5if2th5gqAu+_ncPrfGHVS-sJ67Zy8jao1tJZvg@mail.gmail.com>
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

On Sat, 29 Feb 2020 at 18:33, Antti Sepp=C3=A4l=C3=A4 <a.seppala@gmail.com>=
 wrote:
>
> On Sat, 29 Feb 2020 at 17:25, Guenter Roeck <linux@roeck-us.net> wrote:
> >
> > Sigh. It would have been too simple. Too bad I can't test myself.
> > I'd like to know if this is because URB_NO_TRANSFER_DMA_MAP is set on a
> > transfer, or because the beginning of the buffer indeed needs to be ali=
gned
> > to the DMA cache line size on that system. In the latter case, the ques=
tion
> > is why the alignment to DWC2_USB_DMA_ALIGN (=3D4) works. In the former =
case,
> > question would be why the realignment does any good in the first place.
> >
> > Any chance you can add some test code to help figuring out what exactly
> > goes wrong ?
> >
>
> Sure, I can try to help. Just let me know what code you would like to
> insert and where and I'll see what I can do.
>

So I did some further research on this and it turns out that:
 - URB_NO_TRANSFER_DMA_MAP is not set on the offending transfers so
the issue really is buffer alignment
 - DWC2_USB_DMA_ALIGN=3D4 "works" because in my limited testcase (usb
4g-dongle utilized via qmi-wwan) all transfers are unaligned. That is,
every urb->transfer_buffer is misaligned by 2 bytes =3D=3D unaligned
 - I can fix both issues and thus make the patch work on MIPS by
modifying it like this:

-#define DWC2_USB_DMA_ALIGN 4
+#define DWC2_USB_DMA_ALIGN dma_get_cache_alignment()

 struct dma_aligned_buffer {
        void *old_xfer_buffer;
-       u8 data[0];
+       u8 data[0] ____cacheline_aligned;
 };

--=20
Antti
