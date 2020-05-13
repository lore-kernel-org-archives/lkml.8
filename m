Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC5CBC2D0F8
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 07:09:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6E29206F5
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 07:09:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730583AbgEMHJg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 03:09:36 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:45672 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729189AbgEMHJg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 03:09:36 -0400
Received: by mail-ot1-f67.google.com with SMTP id e20so12625723otk.12;
        Wed, 13 May 2020 00:09:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tQBKncGAceygAQVR48tADdwtIIB18GAq7ci7gmWLAQ8=;
        b=jGTF+Y1iulKZgUZ+ZlNV0v08VBm8XlHhfbD+YsZXTAmevDSThtBSiDZQHZG1pq0NHG
         BH+IpY/sXhr7OiuYgXcKLYpzWraMZ8d76UsoEqMLgkWYS/ESQEyhLF2HPtiLf34nwIqt
         P6zG6TQHMxP9hi0sbbH35CyMPHEwR36NGjtmYFTg/daGBGjV3Qc4+v23nlimVmYB/RDd
         5GEQisJZv8Cbf0f5HyTV0jVFekswfn/mEzpGYfhod0nzklRILfRDrSvGJDHVq4bATIPZ
         GmTtMq1fGDxFPSToDc7xd3UaMrmx4zs5Qj2WyNFbzj6wfVyPEgAoBppw7zJ3r6Eo+gzE
         TGzg==
X-Gm-Message-State: AGi0PuYQPxl+mck3NQ/nK80xylzw/yritxJsITcgNvfxOF2+ncdXNxFP
        SOI++aqodB5RTDUlA7FzXi11KnlnKXSbV2d4gy2/QA==
X-Google-Smtp-Source: APiQypIBT17ifmw4vzyJJL7IX/eEsBrLn2/Wj5bSVTTtat1HEGfYI4uCfrVdxSM2De7RpwnxP7jndUR8WmXw7H79LJg=
X-Received: by 2002:a9d:63da:: with SMTP id e26mr18492173otl.107.1589353775974;
 Wed, 13 May 2020 00:09:35 -0700 (PDT)
MIME-Version: 1.0
References: <1589316769-13277-1-git-send-email-alencar.fmce@imbel.gov.br> <1589316769-13277-2-git-send-email-alencar.fmce@imbel.gov.br>
In-Reply-To: <1589316769-13277-2-git-send-email-alencar.fmce@imbel.gov.br>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 13 May 2020 09:09:24 +0200
Message-ID: <CAMuHMdWiNhpEbXbTcYVJ2gP5X++gwmP5Wb2n9VYchTBFyi07GA@mail.gmail.com>
Subject: Re: [PATCH 2/3] video: fbdev: ssd1307fb: Support to pixel inversion
To:     Rodrigo Rolim Mendes de Alencar <455.rodrigo.alencar@gmail.com>
Cc:     Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        alencar.fmce@imbel.gov.br
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rodrigo,

On Tue, May 12, 2020 at 10:53 PM Rodrigo Rolim Mendes de Alencar
<455.rodrigo.alencar@gmail.com> wrote:
> Pixel inversion in hardware is performed by issuing the
> command 0xa7. This patch adds a boolean  property to control
> color inversion.
>
> Signed-off-by: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>

Thanks for your patch!

> --- a/Documentation/devicetree/bindings/display/ssd1307fb.txt
> +++ b/Documentation/devicetree/bindings/display/ssd1307fb.txt
> @@ -22,6 +22,7 @@ Optional properties:
>    - solomon,com-seq: Display uses sequential COM pin configuration
>    - solomon,com-lrremap: Display uses left-right COM pin remap
>    - solomon,com-invdir: Display uses inverted COM pin scan direction
> +  - solomon,color-inv: Set Inverse display mode (invert pixel color)

Isn't that software configuration instead of hard description?
DT describes the hardware, not software configuration, so this may not
belong here?

>    - solomon,com-offset: Number of the COM pin wired to the first display line
>    - solomon,col-offset: Offset of columns (SEG) that the screen is mapped to.
>    - solomon,prechargep1: Length of deselect period (phase 1) in clock cycles.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
