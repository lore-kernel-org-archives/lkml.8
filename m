Return-Path: <SRS0=HPGY=7U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8777C433E0
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jun 2020 22:30:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F0B0206F6
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jun 2020 22:30:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20150623.gappssmtp.com header.i=@networkplumber-org.20150623.gappssmtp.com header.b="VvlR6brj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727804AbgFGWab (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Jun 2020 18:30:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726788AbgFGWaa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jun 2020 18:30:30 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1068DC08C5C4
        for <linux-kernel@vger.kernel.org>; Sun,  7 Jun 2020 15:30:29 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id s88so5184479pjb.5
        for <linux-kernel@vger.kernel.org>; Sun, 07 Jun 2020 15:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OSASK+3X/fSSI7ny5aNfN21EmPCbzFlJKFZbkDaEweQ=;
        b=VvlR6brjRXBuwZ3tpMAy02H5gZcwlasl4qJ+CdlPknKlK6J1DKUAygqTgjqGui2Pu2
         VC40RGolqWQ5efcCkmJ9hdPad8zQXZFUwP+f/4T7edNil1ExJvNSwm/jlYa/kcPjTcxe
         kuQ//EzpMGrwVoaMNUSavL4CZrD+f/l6yL8tt+IUZwgH9C97TZAP2YkaXFhx6Bk3soSw
         wiNaDbGlYNx/EzzjuvIP3yt33W2pI3xb46qjtHQgiU4ZZakeMNWLL5AeRwbq5X3ceZ1U
         Z3qdTVCRCMlrYqk5czIZipjrVSriZTxhPdVUHq0ecRHDvtxtQ5QRhyFPo69+PFkMVLYz
         Aaww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OSASK+3X/fSSI7ny5aNfN21EmPCbzFlJKFZbkDaEweQ=;
        b=LQewUmwjftVu5cLDbATpDcx8QelZ3FYSh8wsO1KDh/burg8QRklcKtJxvBFpqAmpDL
         sNWzpwYUMLy0Fhbrxi7eGdzt/FEyqNUJ7O3J36PLR+aEF4WOTX+MBVxp4Jks6XuSx7YQ
         76MXDKIgqvosnx1PX+TmEgsOxrPxlxHefVmiMlCb3nEelBc20aOXQKI92t4PpVY4jBak
         AuSOTYWPS76I4lglp49lUwRS3o84AQt2GaXholmqolVfvbSpzvDfUdQ48y2R3mg4Xn3H
         tYG0qsIN3JBinxFrRoxJPDDgJ+Yag2OZ5oEgijMP37322fmQ/BXPyvkGW0leJDl350rJ
         8nBQ==
X-Gm-Message-State: AOAM531fmJn03odShXkduVj4lOfrMiS3NPHcJRiS/AUwB5vZyNaii7sY
        5ZL1p2PoSciUkZTUJlhhMY9k7w==
X-Google-Smtp-Source: ABdhPJx28YlWY0X68MCd/y/7sg3uZjiuj416dL7rHADKc/gSN2t4z1r0jfS5xPsHMZl4FzWYlW7qMQ==
X-Received: by 2002:a17:902:558f:: with SMTP id g15mr18381316pli.174.1591569029270;
        Sun, 07 Jun 2020 15:30:29 -0700 (PDT)
Received: from hermes.lan (204-195-22-127.wavecable.com. [204.195.22.127])
        by smtp.gmail.com with ESMTPSA id d4sm13615305pjm.55.2020.06.07.15.30.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2020 15:30:28 -0700 (PDT)
Date:   Sun, 7 Jun 2020 15:30:19 -0700
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Michal Kubecek <mkubecek@suse.cz>,
        "John W. Linville" <linville@tuxdriver.com>,
        David Jander <david@protonic.nl>, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Russell King <linux@armlinux.org.uk>, mkl@pengutronix.de,
        Marek Vasut <marex@denx.de>,
        Christian Herber <christian.herber@nxp.com>,
        Amit Cohen <amitc@mellanox.com>,
        Petr Machata <petrm@mellanox.com>
Subject: Re: [PATCH ethtool v1] netlink: add master/slave configuration
 support
Message-ID: <20200607153019.3c8d6650@hermes.lan>
In-Reply-To: <20200526091025.25243-1-o.rempel@pengutronix.de>
References: <20200526091025.25243-1-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 May 2020 11:10:25 +0200
Oleksij Rempel <o.rempel@pengutronix.de> wrote:

> This UAPI is needed for BroadR-Reach 100BASE-T1 devices. Due to lack of
> auto-negotiation support, we needed to be able to configure the
> MASTER-SLAVE role of the port manually or from an application in user
> space.
> 
> The same UAPI can be used for 1000BASE-T or MultiGBASE-T devices to
> force MASTER or SLAVE role. See IEEE 802.3-2018:
> 22.2.4.3.7 MASTER-SLAVE control register (Register 9)
> 22.2.4.3.8 MASTER-SLAVE status register (Register 10)
> 40.5.2 MASTER-SLAVE configuration resolution
> 45.2.1.185.1 MASTER-SLAVE config value (1.2100.14)
> 45.2.7.10 MultiGBASE-T AN control 1 register (Register 7.32)
> 
> The MASTER-SLAVE role affects the clock configuration:
> 
> -------------------------------------------------------------------------------
> When the  PHY is configured as MASTER, the PMA Transmit function shall
> source TX_TCLK from a local clock source. When configured as SLAVE, the
> PMA Transmit function shall source TX_TCLK from the clock recovered from
> data stream provided by MASTER.
> 
> iMX6Q                     KSZ9031                XXX
> ------\                /-----------\        /------------\
>       |                |           |        |            |
>  MAC  |<----RGMII----->| PHY Slave |<------>| PHY Master |
>       |<--- 125 MHz ---+-<------/  |        | \          |
> ------/                \-----------/        \------------/
>                                                ^
>                                                 \-TX_TCLK
> 
> -------------------------------------------------------------------------------
> 
> Since some clock or link related issues are only reproducible in a
> specific MASTER-SLAVE-role, MAC and PHY configuration, it is beneficial
> to provide generic (not 100BASE-T1 specific) interface to the user space
> for configuration flexibility and trouble shooting.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>

NAK
Open source projects have been working hard to remove the terms master and slave
in API's and documentation. Apparently, Linux hasn't gotten the message.
It would make sense not to introduce new instances.
