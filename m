Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C847C2D0E8
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 13:19:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62E182073E
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 13:19:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gQLZrvno"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727639AbgCZNTb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 09:19:31 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:33087 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbgCZNTb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 09:19:31 -0400
Received: by mail-lf1-f66.google.com with SMTP id c20so4810624lfb.0;
        Thu, 26 Mar 2020 06:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/cZKe6yaVZ+MS26EGN9XirOADarYN9QROabu87gs8nM=;
        b=gQLZrvnoocuQ2F2nXvwgVK7w6/kKNzt9RGVW9UTt+8OKYI/AAvxHo3N7aUz6Dpl8jM
         EEeX9oKpAVveC6OoXo63ZcVFymKOIFiFq1Dbgv6xWNY8yjIAIb0dMbxx5SHc+hUzfqPW
         9rw3OPHnweZH7aRLVkJuEq3mbaxBA9gv1FMoR2zUk/KMMlCj3AQU3PsKlXMPgik1y7KY
         Q+KjsoTIDRAREUNBXfz9vVCPiwQt+fkys5BVrMh9i9JJXMdEcU3bB16SkBi0Sflb+W7u
         FCfZgjiKM7VeL9FwWVdr+zFFbWD3RYEs22LX1lstq57Tm9vCahjll96hSc8xY8svDD4u
         ZfGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/cZKe6yaVZ+MS26EGN9XirOADarYN9QROabu87gs8nM=;
        b=BRI+SWERZovYi0pdMHulCrxo7+M6ZBipTMQWlvWOimjxD81vefWsZo7+DiQK+mYij+
         pW8SkYHiDVGjmr09MHHltwkgfTaLsfss2jU3LmSO7g7Gsnjpw/Ncp2/oqNRMCW7cXBBW
         HHpevivO/jSVhFcnJVx4sKLrPeu7GVlAYDPrDZnXhICjmj8a/raEBn9ikhzZi9Uqlg0E
         01YrC5RwdePBt+hOVnmuOk3hLOCebFWebmcpU1XraVRQZ7NEY8oqWLUmJvba7t+8rlXN
         3a2ZuoDqwMD0BIANGcslaxEx+8lRQB5F1DJ3GyGyT9hB0qjLR0GRb4V29/qb3woiCyfT
         x0PQ==
X-Gm-Message-State: ANhLgQ06/hKvOp8wMaowywSQE7yZ6g2zF+m6huqAw3iM0zGMfGFSJuq6
        1HBPuv+w+bj5KOJlHN11PSlAK6wnxtdtJVYUU58=
X-Google-Smtp-Source: ADFU+vtE93SO/uQRDrFJCL+w0U1WehePGtl3rrWT1hKTmbVw0hW/48J8Hf3GThxzBsv8MvzebfE9G3Rf2iYxT5SsH4M=
X-Received: by 2002:a19:c781:: with SMTP id x123mr5578435lff.140.1585228768015;
 Thu, 26 Mar 2020 06:19:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200324144324.21178-1-aford173@gmail.com> <20200324144324.21178-2-aford173@gmail.com>
In-Reply-To: <20200324144324.21178-2-aford173@gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Thu, 26 Mar 2020 10:19:19 -0300
Message-ID: <CAOMZO5AnsYi9xM392NofOyuzCmHe6Pry=C9GHWR3JmgEkVJ5Gg@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm64: dts: imx: Add Beacon i.MX8m-Mini development kit
To:     Adam Ford <aford173@gmail.com>
Cc:     "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>, aford@beaconembedded.com,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 24, 2020 at 11:43 AM Adam Ford <aford173@gmail.com> wrote:
>
> Beacon Embeddedworks is launching a development kit based on the
> i.MX8M Mini SoC.  The kit consists of a System on Module (SOM)
> + baseboard.  The SOM has the SoC, eMMC, and Ethernet. The baseboard
> has an wm8962 audio CODEC, a single USB OTG, and three USB host ports.
>
> Signed-off-by: Adam Ford <aford173@gmail.com>

Reviewed-by: Fabio Estevam <festevam@gmail.com>
