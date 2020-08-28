Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1090C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 10:07:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2CEA208CA
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 10:07:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="etwiKp50"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728994AbgH1KH1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 06:07:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728016AbgH1KHW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 06:07:22 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C4B9C061264
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 03:07:22 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id n18so321723qtw.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 03:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5DWcFLVs7+8PT9sQYHTE5MVq2/WH2ViS0B9HUra8F8Q=;
        b=etwiKp50YqqxjzNCos9NIO00Jr03pW7DFzF+Cvwstbmltbe9cyLAlWjE9Xp5sWs/IL
         mYWsCdfDQ1SIpHqOLw0iohb8cAnYQ4fp82ri8qdE+Oe8ipMwEQgvOvtxGNY/kjgj0BnO
         Osap4Lk/2ZNxm+wPPZfQBRfx0sZHGI5kpBRzHLU2PlrWR3GfdYCi+vi9BKlqRH1vVPTY
         x5Nd2DqACB6QAWHqcYuTfIEgTRMK9pgQkMWijliEYKB+E5zf4T7XsE7ccvWw9xrthxem
         Rr3KPr1lLUQhK8sngJNY/ojPmZk61KhUR3EEC8bEiwDmkWbFVisUoy9GtQuxzHN3Z5P6
         /YDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5DWcFLVs7+8PT9sQYHTE5MVq2/WH2ViS0B9HUra8F8Q=;
        b=BupEPIgE1p7HAyQCQUuRCexplWblkRE55SRJ+h2horzXvDxbtNPefG66FtYazL6eqZ
         4+IyCG3mkc5ziG7IN9eYlDGPTpnbwylfBlN0eVUo56uKMh7435iw9WcNeBhootVqbGn5
         ww60fw/rkbkK773aOzQiWqI7CDkcD4G81TfUw4FmEq1n/AFQoAFP4OOtOcjO/CsrFJv2
         f0he5HuiI1PqTAE2z9wLXHOZdnxdi2rIW3WvN40QuHLg1JFEnspVdNu6NlGKGvQIS730
         uleSc1p2yhib1bq3/m652/15qXa6RYP0aIVGzNpd7rmD4rSWOlVRWIj2ge3zUeSKQ/hu
         YJOg==
X-Gm-Message-State: AOAM531UuYOcX4L7TyhJluoMgwwCO0LWlEPQQv9zMg/M/ChcZrWeRUVV
        wf4g8wVryDMvmaKz0OdlL6CdFzYGgrIOYnw8leA=
X-Google-Smtp-Source: ABdhPJy4gCDMbQqc7Vwj3MiA4Z3DFCbhUavBfMoOblyXw08G/6XNk2GPgBbHhVh4rciyk58fLBp2f9YpkyzkGk4tI8w=
X-Received: by 2002:ac8:165d:: with SMTP id x29mr798396qtk.117.1598609239779;
 Fri, 28 Aug 2020 03:07:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200827132435.24925-1-geert+renesas@glider.be>
In-Reply-To: <20200827132435.24925-1-geert+renesas@glider.be>
From:   Greentime Hu <green.hu@gmail.com>
Date:   Fri, 28 Aug 2020 18:06:42 +0800
Message-ID: <CAEbi=3ete4X_CKqKOHJwBUegSevRix_h9C5+3K8TGyDv4Vk5Fw@mail.gmail.com>
Subject: Re: [PATCH] nds32: Fix bogus reference to <asm/procinfo.h>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Nick Hu <nickhu@andestech.com>, Vincent Chen <deanbo422@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Geert Uytterhoeven <geert+renesas@glider.be> =E6=96=BC 2020=E5=B9=B48=E6=9C=
=8827=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=889:24=E5=AF=AB=E9=81=93=
=EF=BC=9A
>
> Andestech(nds32) never had <asm/procinfo.h>.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  arch/nds32/kernel/setup.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/nds32/kernel/setup.c b/arch/nds32/kernel/setup.c
> index a066efbe53c0c098..3671129e205852b7 100644
> --- a/arch/nds32/kernel/setup.c
> +++ b/arch/nds32/kernel/setup.c
> @@ -52,7 +52,7 @@ EXPORT_SYMBOL(elf_hwcap);
>
>  /*
>   * The following string table, must sync with HWCAP_xx bitmask,
> - * which is defined in <asm/procinfo.h>
> + * which is defined above
>   */
>  static const char *hwcap_str[] =3D {
>         "mfusr_pc",

Thank you, Geert.
Acked-by: Greentime Hu <green.hu@gmail.com>
I'll put it in the next branch.
