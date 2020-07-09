Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C898C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 00:12:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E57EA20775
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 00:12:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XpkdGxGr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726203AbgGIAMI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 20:12:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbgGIAMH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 20:12:07 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A326DC061A0B;
        Wed,  8 Jul 2020 17:12:06 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id q7so338889ljm.1;
        Wed, 08 Jul 2020 17:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V0QuEy94Oqtv5Hq07Ru2rABdbi+qMx9R/lannai1iIU=;
        b=XpkdGxGrTssyStH4hPr9o39/wGfwxJOKn8aISQ/OnLCcepLWPR1w4pIMHeafrZI1EV
         DjDtwpk/5SSxwSZZR2momLv97Fbf4Jfk0CjkaqsnCH3LBRNJ45TfAeASwq48kQy+o5aR
         Avbgpj19UhQgfIKDeXEh6Mp2X6FEXY3T+J3phIQykb0jwdJroGJ17NSLjLWQdZ8Kz725
         8MdO93M/8TTUjiTGEhJQs+mRsItVcF7ordRMR6p79PaEQFbEcXMIhsqfucLnBEmnQMpF
         9GAQR48c/4Y5Tu6XGZ1BXY/q9aVaN1jhF2KOdjOO02xIXXXBwz3U245VW/2mFAnKjGye
         v4SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V0QuEy94Oqtv5Hq07Ru2rABdbi+qMx9R/lannai1iIU=;
        b=dvhL14rRqRAEhO5DIFjOEDRJRbcUkGSgcLWI2k24DCJVRs/vBOIk0fr2Zlohebm2vC
         Q0ObedXVg77kLqmZMZN3lWzKgzYUEe8qRDQZGNRgKCFvncF76WoIfGZNqtiMBDZmsrI+
         3BWGRO78cJZLnMRRFh7VahTUYnLgyDx7Asv0dT4pTZaJlwOp774GY4OcUtdimDyrr5Bq
         9fFP4CHy/J7OCihhCLhYyrbZDq6rjXBa3Vmo8d8LlM+aFC7CWQWvzaRdUIRmN4QRyMsN
         +RIU2GzPcRtscooQkIAdtpjVeu09qVhs6llEC/0Hbjzfe+BgbmoHu8uzg2Xeus221Sdx
         I1Gw==
X-Gm-Message-State: AOAM531NZMbzKEg+umbrjQBiaeHzvOerI4EcKvwTEbdvntabcAWaI63G
        9KFRbgLTLzpb+m31nRb8vqvzNfJIme4a9pUrgkI=
X-Google-Smtp-Source: ABdhPJwdaVK1ZOVAijaz2w1HJRm3OeUKV77sdjHcARzAwDpy0T3UAGzu/yH7+moDerWi3jJvwg2ZVTh+CwkjndQdrOs=
X-Received: by 2002:a2e:808d:: with SMTP id i13mr32283739ljg.452.1594253525115;
 Wed, 08 Jul 2020 17:12:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200708232501.6200-1-cphealy@gmail.com>
In-Reply-To: <20200708232501.6200-1-cphealy@gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 8 Jul 2020 21:11:53 -0300
Message-ID: <CAOMZO5Dshsx++kdd3rdew8CJXTA7ktKnpaoJjtTGW9pfvDeHEQ@mail.gmail.com>
Subject: Re: [PATCH v2] ARM: dts: vf610-zii-dev-rev-c: Configure fiber port to 1000BaseX
To:     Chris Healy <cphealy@gmail.com>
Cc:     Andrew Lunn <andrew@lunn.ch>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Stefan Agner <stefan@agner.ch>,
        Rob Herring <robh+dt@kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 8, 2020 at 8:25 PM Chris Healy <cphealy@gmail.com> wrote:
>
> The SFF soldered onto the board expects the port to use 1000BaseX.  It
> makes no sense to have the port set to SGMII, since it doesn't even
> support that mode.
>
> Signed-off-by: Chris Healy <cphealy@gmail.com>

Reviewed-by: Fabio Estevam <festevam@gmail.com>
