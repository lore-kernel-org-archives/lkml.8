Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1A4DC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 23:52:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85F52207F9
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 23:52:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726824AbgETXwq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 19:52:46 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:38440 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726560AbgETXwq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 19:52:46 -0400
Received: by mail-io1-f66.google.com with SMTP id d7so5360884ioq.5
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 16:52:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3dbkyD/cvpqM50H27FORebvzPzcKiAhshHA3jHU7b0g=;
        b=ZOt6yoRA5UTkTTdL4jTESZiEAF1r53+54HvohCqFA/CEYRAIgjxL2kBKwM0/8IHgmY
         RBRtBv0HnCwoYf8bB9EZ4gvQxcIhNuUpxo3UknCEC9zNvDjAsOKES7EakhaS5q6D0kI6
         UBBCKinF+HBf1muliVByF/2p0XVs1T6CdjTR9tQu3wMMp92WBFiS5nVxIBS3DQwnPW/i
         l3JTZbssTbNIDR0lrTfaef++48eB+HUKc0Vb2C9j/Y6OMnzbWrB+RBJpnqzOfC7XaO0S
         CVM2Qe1sP69IMZI0MMUobC6Wfizpn40zuq8i/8YE3nKvPN43BIqBDCddYFfOuUDgwIAT
         VgNQ==
X-Gm-Message-State: AOAM533+yB9iiMjRmEcXtFTHSVAanBEa0RWy/orZdNofvYHuzo/Iue8E
        jBlrDYy3V7eMnPqCVcBJUNLAChfu
X-Google-Smtp-Source: ABdhPJxAfs7FVnq+uBPlNJVJ6ZvXWd3AwED8V4jCjM4Jqqk8xxwpJgZzfafDI01kdLVLhGXg8zK+sw==
X-Received: by 2002:a05:6638:dc3:: with SMTP id m3mr1536518jaj.98.1590018763530;
        Wed, 20 May 2020 16:52:43 -0700 (PDT)
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com. [209.85.166.42])
        by smtp.gmail.com with ESMTPSA id k11sm1683827ioj.0.2020.05.20.16.52.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 May 2020 16:52:43 -0700 (PDT)
Received: by mail-io1-f42.google.com with SMTP id f3so5384366ioj.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 16:52:43 -0700 (PDT)
X-Received: by 2002:a5e:8b4b:: with SMTP id z11mr5539177iom.78.1590018762757;
 Wed, 20 May 2020 16:52:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200518221904.GA22274@embeddedor> <202005181529.C0CB448FBB@keescook>
In-Reply-To: <202005181529.C0CB448FBB@keescook>
From:   Li Yang <leoyang.li@nxp.com>
Date:   Wed, 20 May 2020 18:52:21 -0500
X-Gmail-Original-Message-ID: <CADRPPNR-Croux9FgnrQJJmdF2jNnuAmC+2xMJSgSbkbRv9u8Mw@mail.gmail.com>
Message-ID: <CADRPPNR-Croux9FgnrQJJmdF2jNnuAmC+2xMJSgSbkbRv9u8Mw@mail.gmail.com>
Subject: Re: [PATCH] soc: fsl: qe: Replace one-element array and use
 struct_size() helper
To:     Kees Cook <keescook@chromium.org>
Cc:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Qiang Zhao <qiang.zhao@nxp.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 18, 2020 at 5:57 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Mon, May 18, 2020 at 05:19:04PM -0500, Gustavo A. R. Silva wrote:
> > The current codebase makes use of one-element arrays in the following
> > form:
> >
> > struct something {
> >     int length;
> >     u8 data[1];
> > };
> >
> > struct something *instance;
> >
> > instance = kmalloc(sizeof(*instance) + size, GFP_KERNEL);
> > instance->length = size;
> > memcpy(instance->data, source, size);
> >
> > but the preferred mechanism to declare variable-length types such as
> > these ones is a flexible array member[1][2], introduced in C99:
> >
> > struct foo {
> >         int stuff;
> >         struct boo array[];
> > };
> >
> > By making use of the mechanism above, we will get a compiler warning
> > in case the flexible array does not occur last in the structure, which
> > will help us prevent some kind of undefined behavior bugs from being
> > inadvertently introduced[3] to the codebase from now on. So, replace
> > the one-element array with a flexible-array member.
> >
> > Also, make use of the new struct_size() helper to properly calculate the
> > size of struct qe_firmware.
> >
> > This issue was found with the help of Coccinelle and, audited and fixed
> > _manually_.
> >
> > [1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
> > [2] https://github.com/KSPP/linux/issues/21
> > [3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")
> >
> > Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> > ---
> >  drivers/soc/fsl/qe/qe.c | 4 ++--
> >  include/soc/fsl/qe/qe.h | 2 +-
> >  2 files changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/soc/fsl/qe/qe.c b/drivers/soc/fsl/qe/qe.c
> > index 447146861c2c1..2df20d6f85fa4 100644
> > --- a/drivers/soc/fsl/qe/qe.c
> > +++ b/drivers/soc/fsl/qe/qe.c
> > @@ -448,7 +448,7 @@ int qe_upload_firmware(const struct qe_firmware *firmware)
> >       unsigned int i;
> >       unsigned int j;
> >       u32 crc;
> > -     size_t calc_size = sizeof(struct qe_firmware);
> > +     size_t calc_size;
> >       size_t length;
> >       const struct qe_header *hdr;
> >
> > @@ -480,7 +480,7 @@ int qe_upload_firmware(const struct qe_firmware *firmware)
> >       }
> >
> >       /* Validate the length and check if there's a CRC */
> > -     calc_size += (firmware->count - 1) * sizeof(struct qe_microcode);
> > +     calc_size = struct_size(firmware, microcode, firmware->count);
> >
> >       for (i = 0; i < firmware->count; i++)
> >               /*
> > diff --git a/include/soc/fsl/qe/qe.h b/include/soc/fsl/qe/qe.h
> > index e282ac01ec081..3feddfec9f87d 100644
> > --- a/include/soc/fsl/qe/qe.h
> > +++ b/include/soc/fsl/qe/qe.h
> > @@ -307,7 +307,7 @@ struct qe_firmware {
> >               u8 revision;            /* The microcode version revision */
> >               u8 padding;             /* Reserved, for alignment */
> >               u8 reserved[4];         /* Reserved, for future expansion */
> > -     } __attribute__ ((packed)) microcode[1];
> > +     } __packed microcode[];
> >       /* All microcode binaries should be located here */
> >       /* CRC32 should be located here, after the microcode binaries */
> >  } __attribute__ ((packed));
> > --
> > 2.26.2
> >
>
> Hm, looking at this code, I see a few other things that need to be
> fixed:
>
> 1) drivers/tty/serial/ucc_uart.c does not do a be32_to_cpu() conversion
>    on the length test (understandably, a little-endian system has never run
>    this code since it's ppc specific), but it's still wrong:
>
>         if (firmware->header.length != fw->size) {
>
>    compare to the firmware loader:
>
>         length = be32_to_cpu(hdr->length);
>
> 2) drivers/soc/fsl/qe/qe.c does not perform bounds checking on the
>    per-microcode offsets, so the uploader might send data outside the
>    firmware buffer. Perhaps:

We do validate the CRC for each microcode, it is unlikely the CRC
check can pass if the offset or length is not correct.  But you are
probably right that it will be safer to check the boundary and fail
quicker before we actually start the CRC check.  Will you come up with
a formal patch or you want us to deal with it?

>
>
> diff --git a/drivers/soc/fsl/qe/qe.c b/drivers/soc/fsl/qe/qe.c
> index 447146861c2c..c4e0bc452f03 100644
> --- a/drivers/soc/fsl/qe/qe.c
> +++ b/drivers/soc/fsl/qe/qe.c
> @@ -451,6 +451,7 @@ int qe_upload_firmware(const struct qe_firmware *firmware)
>         size_t calc_size = sizeof(struct qe_firmware);
>         size_t length;
>         const struct qe_header *hdr;
> +       void *firmware_end;
>
>         if (!firmware) {
>                 printk(KERN_ERR "qe-firmware: invalid pointer\n");
> @@ -491,19 +492,39 @@ int qe_upload_firmware(const struct qe_firmware *firmware)
>                 calc_size += sizeof(__be32) *
>                         be32_to_cpu(firmware->microcode[i].count);
>
> -       /* Validate the length */
> +       /* Validate total length */
>         if (length != calc_size + sizeof(__be32)) {
>                 printk(KERN_ERR "qe-firmware: invalid length\n");
>                 return -EPERM;
>         }
>
>         /* Validate the CRC */
> -       crc = be32_to_cpu(*(__be32 *)((void *)firmware + calc_size));
> +       firmware_end = (void *)firmware + calc_size;
> +       crc = be32_to_cpu(*(__be32 *)firmware_end);
>         if (crc != crc32(0, firmware, calc_size)) {
>                 printk(KERN_ERR "qe-firmware: firmware CRC is invalid\n");
>                 return -EIO;
>         }
>
> +       /* Validate ucode lengths and offsets */
> +       for (i = 0; i < firmware->count; i++) {
> +               const struct qe_microcode *ucode = &firmware->microcode[i];
> +               __be32 *code;
> +               size_t count;
> +
> +               if (!ucode->code_offset)
> +                       continue;
> +
> +               code = (void *)firmware + be32_to_cpu(ucode->code_offset);
> +               count = be32_to_cpu(ucode->count) * sizeof(*code);
> +
> +               if (code < firmware || code >= firmware_end ||
> +                   code + count < firmware || code + count >= firmware_end) {
> +                       printk(KERN_ERR "qe-firmware: invalid ucode offset\n");
> +                       return -EIO;
> +               }
> +       }
> +
>         /*
>          * If the microcode calls for it, split the I-RAM.
>          */
>
>
> I haven't tested this.
>
>
> --
> Kees Cook
