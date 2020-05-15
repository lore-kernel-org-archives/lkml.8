Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A215C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 18:18:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D02032070A
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 18:18:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="aUgXK6Sj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbgEOSS5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 14:18:57 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:18972 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726206AbgEOSS4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 14:18:56 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 49NxW01cC9z7B;
        Fri, 15 May 2020 20:18:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1589566734; bh=ibTN24of7CC9GYhGpn9w94v7GehPRPTxrrybf7nWK+o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aUgXK6SjBE3skG2RJxmzVo44RCiO+5kz1JeHPog7kjzR/vNVC4kZ8RjBTQ5f0xlYo
         wg4acm3Ox/HQHEm/nOIzdjcqvL3q3dBJ0Kq5A3kRR7R8pVY1VF5kPB6Gjf6he8Lsrw
         YTRIjp7tNqoyjgUMXXy1C/EyDAYpvxdtRfXX2wy13z4Hui/m5n6xJ+lHzlIgrrk3uK
         p22Dg8Koh5e+zKz6PaETkaO2NQtidlG61In2Dsj2+OxzSaBmDtjVs9MTFiFS7e3uhI
         tJ/cLZReypv7pvN4O0q+KeHlXZk6W5wx7uvyszyYh3L8eRZhCSfIwFJezp/vhjvVNu
         qEUA2PVpgovRQ==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.2 at mail
Date:   Fri, 15 May 2020 20:18:47 +0200
From:   =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        David Heidelberg <david@ixit.cz>,
        Peter Geis <pgwipeout@gmail.com>,
        Stephen Warren <swarren@wwwdotorg.org>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Pedro =?iso-8859-2?Q?=C2ngelo?= <pangelo@void.io>,
        Matt Merhar <mattmerhar@protonmail.com>,
        Zack Pearsall <zpearsall@yahoo.com>,
        linux-tegra@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 2/6] ARM: tegra: Add device-tree for ASUS Google Nexus
 7
Message-ID: <20200515181847.GA13860@qmqm.qmqm.pl>
References: <20200514213654.12834-1-digetx@gmail.com>
 <20200514213654.12834-3-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200514213654.12834-3-digetx@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 15, 2020 at 12:36:50AM +0300, Dmitry Osipenko wrote:
> There are few hardware variants of NVIDIA Tegra30-based Nexus 7 device:
> 
> 1. WiFi-only (named Grouper)
> 2. GSM (named Tilapia)
> 3. Using Maxim PMIC (E1565 board ID)
> 4. Using Ti PMIC (PM269 board ID)

Hi,

I've briefly looked at the PM269 devicetree (PMIC part) and it looks very
similar, if not the same, to what I deduced from the TF300T kernel.
Those devices don't look to differ much from original Cardhu tablet
devkit, so maybe the trees can base off of that?

I would also guess that because of this 'ram-code', memory timings would
be duplicated between devices. I can see small differences between
ram-code=1 timings of Grouper and TF300T, though they look like arbiter
tuning differences. I'll have to test if my TF300T works with Grouper's
settings. In case they work, could you split the memory timings to another
dtsi file?

BTW, shouldn't EMC timing set match MC? I see more frequencies listed in
MC than EMC nodes.

Best Regards,
Micha³ Miros³aw
