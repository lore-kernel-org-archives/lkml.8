Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18D53C33CB3
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 22:13:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF14C24679
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 22:13:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S74dWuBq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728774AbgANWNm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 17:13:42 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:44726 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726491AbgANWNm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 17:13:42 -0500
Received: by mail-lj1-f196.google.com with SMTP id u71so16148461lje.11;
        Tue, 14 Jan 2020 14:13:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cm+CoTM0+jhOXDNc30YUOsZAT6IC0O3DFYyTQEFb64Y=;
        b=S74dWuBqv3AbnCdv3dgeQq/lxdwYTrhinVamWcvPdDyekZU35ibKEMhjrC5G+zJU/a
         HLvEGMR5spesjlGfGtswHQrvcUedM/E0QwkgCcGHEz5tdVmcQvuChLd+2a1uB3ZFZaJW
         wu9dVz6659OdbEOu7cFkes2SeGnaufGc476swME+HHtu5yMszvN/se0TdjWTLtbIRXxo
         HgvgZchckDeg53Slmdr+KNMjHzu0z9iJOeSn5l8f/c/UjvfHf6G574NbUIwE/Yqj2KTV
         msXk+SbQGsqdU9RD04fTTdIPguj48HAMKM7EtqeVav72zAg3A+kizc66ghVrGcwRJAu9
         OXVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cm+CoTM0+jhOXDNc30YUOsZAT6IC0O3DFYyTQEFb64Y=;
        b=CbLwrewlPjOlb2pFnaaut1c0Fei9ZTknlOpJaWbCa1483nakmiKSvacky5Y3ZofHDv
         jYWmPpSaZ1VwdIoFnV1DjX+m8G7LHS0CbgNZ1S7vNvf8B7QqfIGmPTidBO+yu0Rc3u8K
         n1xCZj4tGcak8dYa2zQYgw0v7pnXH2im/+qUa/eNWA3RE92C+KF2V4gUuwDwL5m7Iytd
         SzljK98K0hrWBqAItM7xKpMuQSUQwqdaFTbhF1TBwxdsSFa/xiU2fIJFwa6KMG9Ihwj7
         oYGGL1D++f0Dp4QO9sR29NmLFAUvPch5CT/UGYE4d7IGWuP4LVdFAiXa7BazU3xNXhfa
         JAag==
X-Gm-Message-State: APjAAAWifMSxqPSt+mhiX6iFHaXU1bq1DP5ehHrXcnP6McA3liUhiLhp
        j1BkB6i2UkuthW22CWGctx1+PzgUZ+NSupNrXCQ=
X-Google-Smtp-Source: APXvYqwN82PPY2p/a4NKRmOqyvi3rbYFvy/BLp5c2pkHMed/zTaGeP3v+iuRDWViPLXh0eZZNQcY0U7v9CZ+YZhZJXs=
X-Received: by 2002:a2e:8197:: with SMTP id e23mr15595800ljg.250.1579040019756;
 Tue, 14 Jan 2020 14:13:39 -0800 (PST)
MIME-Version: 1.0
References: <1579038243-28550-1-git-send-email-han.xu@nxp.com> <1579038243-28550-2-git-send-email-han.xu@nxp.com>
In-Reply-To: <1579038243-28550-2-git-send-email-han.xu@nxp.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 14 Jan 2020 19:13:26 -0300
Message-ID: <CAOMZO5D0LoE8-kJbJ+7AEHJ9PODmCD5Ttv3MUSk7=feWPrdN1Q@mail.gmail.com>
Subject: Re: [PATCH 1/6] dmaengine: mxs: change the way to register probe function
To:     Han Xu <han.xu@nxp.com>
Cc:     Vinod <vkoul@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Esben Haabendal <esben@geanix.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        dmaengine@vger.kernel.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-mtd@lists.infradead.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 14, 2020 at 6:48 PM Han Xu <han.xu@nxp.com> wrote:
>
> change the way to register probe function for mxs-dma

Please provide the reasoning for such change in the commit log.
