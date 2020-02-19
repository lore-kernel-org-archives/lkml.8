Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF3E5C3404C
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 01:16:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEF4E24655
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 01:16:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MIxhQup/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727939AbgBSBQJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 20:16:09 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:39552 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726757AbgBSBQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 20:16:09 -0500
Received: by mail-lf1-f65.google.com with SMTP id t23so15989724lfk.6;
        Tue, 18 Feb 2020 17:16:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oNy2Gtlxluyl1pg7RHJYch1VnxMDYsOYXEOr+VHV8TY=;
        b=MIxhQup/aF13orSt20FbVe4yvnFXR26E93dTmFRAYVt1gc7it7ZL6zaWR2mzfySi1D
         ZvrDG3bK7a6Etd7+9wD3NQixpabX3+SStpaRRfKhbXtxPDwiEczUwoks2T2hWIkpO4Y9
         VArCaNp86Y2mebNVXV6iTI0RvcewNKghXfLEgqi0fbqa6OdQk3E6QXOwDIgv35qRNM2q
         jQfhVQCwWIaHVDDj0C67skFW/bAioQzED18Z37P8M0EW0Rku2F+CRD2QSv1xqxJ/CZKs
         1m8zLAO7xO5uw3rFSpL4vvWi9iygKtKs++v++8AsFOp5PbQjbjA8kPdpyB9LJlmha3h5
         aZqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oNy2Gtlxluyl1pg7RHJYch1VnxMDYsOYXEOr+VHV8TY=;
        b=RJxITip0+8MsXWQRh29Ae/8FkhdbdLS1pQ6s42TQYyG7Ynm7cT/laM50PVoCOeNfZz
         6gsMe6sfoRjAsD/D1U8IRz/KEE9evvuJro/o2atq36c6vFsvHmTguM9Y6gMzOENK3Evm
         +1diU6BXjXh+4/eYvodRaafgWxFalW7QEKIy8lWMeDW1RxyDZM4ZCwaSbtxAL+H2dcjp
         atoms+gw2dhMnA+eCNEXtW53A0YGbJOXvRJMjoPBvTmnP+zKj74NJhAYUdW8+q0uZwgN
         ECXB+ryYjvcAJSBWdBCHSDMKMwth+aBiSFTTN6A6/fa4JMfdCLF7rsVZbznRgA/1xuXd
         veqQ==
X-Gm-Message-State: APjAAAUEIdJ5Ws3WA3vKB4GJbpXUc5FaUX1LGFQVcDwRu09nUKP+19PA
        PNNmgAhpJl/k12ZlM5Ai9Qu4WyFWSnAWUpK8r/k=
X-Google-Smtp-Source: APXvYqz/UVhGbxqnwMVSd2Vu49b0wWVkObQ8+9Y2x8gy+3Y5d2QwcpWDi8m4Naoxnll1vCe83LgywoII+oMUFFOM+o0=
X-Received: by 2002:ac2:4214:: with SMTP id y20mr11936281lfh.214.1582074966850;
 Tue, 18 Feb 2020 17:16:06 -0800 (PST)
MIME-Version: 1.0
References: <20200214192750.20845-1-alifer.wsdm@gmail.com>
In-Reply-To: <20200214192750.20845-1-alifer.wsdm@gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 18 Feb 2020 22:15:55 -0300
Message-ID: <CAOMZO5B91_RHYb9Ys+ZXNWNEawhPY37GfJY_x6pnH+dT8pPLsg@mail.gmail.com>
Subject: Re: [PATCH 1/2] arm64: dts: imx8mm-evk: add phy-reset-gpios for fec1
To:     Alifer Moraes <alifer.wsdm@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Peng Fan <peng.fan@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 14, 2020 at 4:27 PM Alifer Moraes <alifer.wsdm@gmail.com> wrote:
>
> imx8mm-evk has a GPIO connected to AR8031 Ethernet PHY's reset pin.
>
> Describe it in the device tree, following phy's datasheet reset duration of 10ms.
>
> Tested booting via NFS.
>
> Signed-off-by: Alifer Moraes <alifer.wsdm@gmail.com>

Reviewed-by: Fabio Estevam <festevam@gmail.com>
