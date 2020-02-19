Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 163BEC34050
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 12:48:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E337C24656
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 12:48:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j0CCmFUq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727497AbgBSMst (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 07:48:49 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:37637 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726491AbgBSMst (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 07:48:49 -0500
Received: by mail-lj1-f194.google.com with SMTP id q23so240712ljm.4;
        Wed, 19 Feb 2020 04:48:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dN5iCO8jDe/PtPLCP5+bsEVRnjfPHVQSbpy1yzeXeh8=;
        b=j0CCmFUqCF0GipD0Gv123st5aD6tmNEimD2gqn5eu8O/YOpGEnsNoyT2C6cNcmEhgm
         uFXj6wa9r6zJGDLJN/crPXOqyxipo5mvUWE583IfRlQS2skqxJnAs7QjMFXRIwmAEtjX
         fs4UNS1T2AxJRUKRtOXNYCYeqp/v0QMRGmQaYsvZMUE+diO3XiT0lYiWPqr4+yKI9nrg
         FE1YVcKcrJ9bTQtwCxWxaeZp95QGmytOs93FJ3qefk4q0OkWca2vRskIoZjdI0Que/bS
         dM66EzF4nd93Lj0t6SqbdwwBcnjOvVW9yMQEsUbHk8rsXfPAkSctNxokZ3BRCsmqKl09
         /GaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dN5iCO8jDe/PtPLCP5+bsEVRnjfPHVQSbpy1yzeXeh8=;
        b=F7OGUbQRjjQQkUWCc5JRiTSfIeFawe6rZAKZYAFB5eB5tzLE9bqAx7qIcxR08EbU2y
         IZrR7whiVn+4G6PxGZLVIsIf+ET6CT+HOJSUna5ImDgD6/dlBOFXEufHzxSxWHeHPJS8
         eltt5XVe6to8xJ1bLype/kXRov6NSNRxqhqYugxXGIqhMK3WH91qDDC0DqDEeHj2zPew
         WjGrbV9KK3oCYLfFuOgCZy9Z87IfF9mZTrVxmLdDRtxcGx1h2mBuIxtWbxed1txnYDf3
         FE+CJYbhXSaEivmwVmPGhPS3+7b5fn504R4paCllB8O6Cdk2d3/24333UxhUrx6b56rW
         hy1g==
X-Gm-Message-State: APjAAAV+Wc6l56aHqQQcPsuAsimOnDt09lNB9PEX2n9a/PQJcWG+a7FE
        Y8hPhRfoyhViX9Daqb4ftF6vG0ILZoSLFc0Rn/zlow==
X-Google-Smtp-Source: APXvYqzHuSu+LmGKJcSnlYrT9QzvlCV+tLoHT5TpvGPcZeuRUnkxPmYQkKQ8fvmpb9gqs+zG7gLMzaZPLnlmuq9FBqI=
X-Received: by 2002:a2e:5056:: with SMTP id v22mr15838180ljd.164.1582116527150;
 Wed, 19 Feb 2020 04:48:47 -0800 (PST)
MIME-Version: 1.0
References: <20200219115709.3473072-1-oleksandr.suvorov@toradex.com>
In-Reply-To: <20200219115709.3473072-1-oleksandr.suvorov@toradex.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 19 Feb 2020 09:48:35 -0300
Message-ID: <CAOMZO5AZrQmYmEZVC9kpbaPe+Kg71SnCsfkMj0-f+adW3dLnBg@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: imx7-colibri: Fix frequency for sd/mmc
To:     Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
Cc:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Igor Opanyuk <igor.opanyuk@toradex.com>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Mark Rutland <mark.rutland@arm.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Stefan Agner <stefan@agner.ch>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Oleksandr,

On Wed, Feb 19, 2020 at 8:57 AM Oleksandr Suvorov
<oleksandr.suvorov@toradex.com> wrote:
>
> SD/MMC on Colibri iMX7S/D modules successfully support
> 200Mhz frequency in HS200 mode.

s/Mhz/MHz

>
> Removing the unnecessary max-frequency limit significantly
> increases the performance:
>
> == before fix ====
> root@colibri-imx7-emmc:~# hdparm -t /dev/mmcblk0
> /dev/mmcblk0:
>  Timing buffered disk reads: 252 MB in  3.02 seconds =  83.54 MB/sec
> ==================
>
> === after fix ====
> root@colibri-imx7-emmc:~# hdparm -t /dev/mmcblk0
> /dev/mmcblk0:
>  Timing buffered disk reads: 408 MB in  3.00 seconds = 135.94 MB/sec
> ==================

Nice improvement :-)

>
> Fixes: f928a4a377e4 ("ARM: dts: imx7: add Toradex Colibri iMX7D
>                       1GB (eMMC) support")

Please keep the Fixes tag in a single line.

Reviewed-by: Fabio Estevam <festevam@gmail.com>
