Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4264C4BA10
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 12:43:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A30821927
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 12:43:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oQ1YXDo6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726974AbgBZMnC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 07:43:02 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:41770 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726277AbgBZMnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 07:43:01 -0500
Received: by mail-lj1-f193.google.com with SMTP id h23so2923646ljc.8;
        Wed, 26 Feb 2020 04:43:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=naHmwMkEZlsq2F2BdV78t7a2n6KXkH4cArO0DzqKw9s=;
        b=oQ1YXDo6+jB9aH9a05GU0xwO2NeTx0pZ2jpQW5sC7FObezAamb9GLR1j9y80Vd7PW4
         5XEffKqjS2T8VLrsMUL0B2r14bi6hf7ak0FjH/qafJEHkGVUiPpOwEC2K/SotBZqNBdT
         I+xDbdHSXNJZgX2OTKDz5Vc3iMPuXVCPpvMLeAy3NPWzFm1nmue6F3HMibuTpfGnayE+
         SyzzsNrJ6YpQLC0V2Bkc85eHEJ8Yu/7h9Bj3XtOnkGKqumkYA9Zv2fUGZW4rRP7XZJG1
         HxEaYpF9FFJMrft2C6sK5HsayCuwHzrqHHWgJ8KAOXTKT0rjr9T+KJL5lwtaAOtbpBc5
         7TkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=naHmwMkEZlsq2F2BdV78t7a2n6KXkH4cArO0DzqKw9s=;
        b=EtxSzbmchcmJjktcb4SoSENIZxGQPTQyT8gfAQt+AaA84jxHSfb4421fachBs/J2rx
         DvKDPyKAuUb2O+tQ8t/YPm97r2A/EWsrKjX/NERI85V1omFPpzwnyatxtA0IT7dP4OEA
         3GF2FWSFfMPJSC/cPV1ca6KwKaI6EPuTbAZAxfxJ2MWLlgVX+OuBF5o57EBKtdCgxrdt
         xP3LDGZCgX0jnlDjnoaRvvfKehf2J5uIzW3FLjzjkKcedLdJn/rKNUdcdxU6cOLr2dAm
         Y5IBCoe6Icq/s75vllkhDOXKrmd0Gy4pfmTRA+Ap7kd85ASVEaI1+sDNGFAyKqz32EUi
         QgJg==
X-Gm-Message-State: APjAAAUu7ntuq4HjmiF5nJnG5eToRTDBiGTwdDzfwsBAdL/G8IRD5Nur
        VViM816/jg3rDqPN2LsG3BdnQVb/NSaeX5YSvwA=
X-Google-Smtp-Source: ADFU+vtwr9qHZQRp7nOQn9p0PoE3msDjcGJRvRyC8H+RwcRzDCO3GQIm5dNAC1Bue/fML340D2kMrue/X63xSXz+WfQ=
X-Received: by 2002:a05:651c:d4:: with SMTP id 20mr2838816ljr.269.1582720979846;
 Wed, 26 Feb 2020 04:42:59 -0800 (PST)
MIME-Version: 1.0
References: <20200224062917.4895-1-martin.kepplinger@puri.sm> <20200224062917.4895-2-martin.kepplinger@puri.sm>
In-Reply-To: <20200224062917.4895-2-martin.kepplinger@puri.sm>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 26 Feb 2020 09:42:49 -0300
Message-ID: <CAOMZO5BxS-+1=NVgZ4nJcneVGMr7B8sLL+gYidXfgrvPSRB0JQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/8] arm64: dts: librem5-devkit: enable sai2 and sai6
 audio interface
To:     Martin Kepplinger <martin.kepplinger@puri.sm>
Cc:     Rob Herring <robh@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, kernel@puri.sm,
        Yongcai Huang <Anson.Huang@nxp.com>,
        "Angus Ainslie (Purism)" <angus@akkea.ca>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin,

On Mon, Feb 24, 2020 at 3:31 AM Martin Kepplinger
<martin.kepplinger@puri.sm> wrote:
>
> From: "Angus Ainslie (Purism)" <angus@akkea.ca>
>
> Add missing sai2 and sai6 audio interface and pinctrl definitions for the
> Librem 5 devkit.
>
> Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>
> Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>

Maybe you could rearrange patches 1 and 2 like this:

Add simcom 7100 modem support
Add sgtl5000 support

This way it is clearer where SAI2 and SAI6 ports are actually used.
