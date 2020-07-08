Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F83BC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 00:41:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D2A82073E
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 00:41:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A+UBbUBL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728894AbgGHAl0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 20:41:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728253AbgGHAlZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 20:41:25 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C435C061755;
        Tue,  7 Jul 2020 17:41:25 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id 9so52121940ljv.5;
        Tue, 07 Jul 2020 17:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4wnuVyqn/A+1xmBGPh5S2duo0jwqPLTeNICw59XWtkg=;
        b=A+UBbUBLolCw9CI/FbAhnbfMEGKs93AFTnyD6mQMd7IJj2RCIxuMDejG/247BpZcCr
         +lIksVysqfwcYB/7hQ1Y8OfSw9nX88KhiocpJpSZsUg+GzHTBtC6d2kxKMYIcC6aS9t1
         0cIyEu0HQthUKNKkdxymEeunAo/hQWc+tcoXcib/ZlevSfu98BH6czzVGgN/qwe/DbZk
         Q1a59ZCAyaPrTEsaLxHGy05Z3cSrLrek0JMD/so+XKXQgp4HhBXoZ5TPGsMZUWB3dnBh
         L3DGUEd1KldP5SLZtFGNhKPdR9asqTDgJH8fW/w0wFDlVnKmG3FK57odsbo6Hu9fQv4L
         9vfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4wnuVyqn/A+1xmBGPh5S2duo0jwqPLTeNICw59XWtkg=;
        b=DCtU3zXId+7HhCFy3FsQsezyiwHNhFAGwlKGMGCFqHT0nJhzptGltf2fOkhwzmitsA
         +zppMdGfiWirUhiWEDsZFyOpYQAcB+sYJ5pgyudp1XWQ8SI8jv46PDqwETV/BXdfrVZL
         7VTBn6lFNE0hQqNOmTG83WzlCutgHyDtBXg77yBKGzyDBTnFdmjQ9b6f/G97cuLdSSov
         QFUvcBsSB9DJ0eCYwfmsggc1LTRVLtb5HlP9sahSF9N+36N0r/w2W8RSZMue/tIv3cgJ
         Y6ZlDUAei2j1417URKltcLUlvBshi+NfmVWLG9FJovRR0XR35qWH8pEwlbzbHkCjaPf1
         NBJQ==
X-Gm-Message-State: AOAM531Pd4E1urrUPyFrZ9X079VUer/XEjkmdPy5ZGrikapt4D4s65sH
        QTXRmPBqD/wogXhObE8HCqbYuXXeRRHNihvKE+k=
X-Google-Smtp-Source: ABdhPJzdfphDYsZlnp34qJP3MAFltospm+PDY6UqHOByUfcmYtgk8TrPyp9ErjwYoGKFqEhyyi5c8+0AiW/zTkUSuTY=
X-Received: by 2002:a2e:808d:: with SMTP id i13mr28941619ljg.452.1594168883388;
 Tue, 07 Jul 2020 17:41:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200708003209.4737-1-cphealy@gmail.com>
In-Reply-To: <20200708003209.4737-1-cphealy@gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 7 Jul 2020 21:41:11 -0300
Message-ID: <CAOMZO5BYDXbVUKad4Cn0fauGMEFu4ZPSOwunrFxMq7+bDYPtMw@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: dts: zii-ultra: update MDIO speed and preamble device
To:     Chris Healy <cphealy@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chris,

On Tue, Jul 7, 2020 at 9:32 PM Chris Healy <cphealy@gmail.com> wrote:

>                 #address-cells = <1>;
>                 #size-cells = <0>;
>                 status = "okay";
> +               suppress-preamble;
> +               clock-frequency = <12500000>;

Sorry, I missed this in the previous review.

The recommendation is to have status = okay as the last property.

Please move suppress-preamble and clock-frequency = <12500000> prior
to status = "okay"
