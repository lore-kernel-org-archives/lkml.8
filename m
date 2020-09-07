Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E912DC433E2
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 14:23:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A980E21481
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 14:23:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="BorI95I0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729824AbgIGOXT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 10:23:19 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:56810 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729788AbgIGORI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 10:17:08 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 087EFTVg053388;
        Mon, 7 Sep 2020 09:15:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1599488129;
        bh=xUz4wObYEDdENZCNHUrCsFZ25ccgTnFTci7Yd+rcWYw=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=BorI95I0jkWvfjVGA5Ur5yA71XuioNLNRECHjBP6jMYdX+VZhh5z/lPsa3vX49BPw
         iFy0nXnX+qcRrXeR8cHd1SALmKnsCVg81A+Vpjn1g+VB3t9QTC8Ug65nWqGJVuAR93
         JzU8X7uyMg5b/+56W8A1o3pMVpXsF1W+j9Q/dgVg=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 087EFTtC035999
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 7 Sep 2020 09:15:29 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 7 Sep
 2020 09:15:27 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 7 Sep 2020 09:15:27 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 087EFRfd043562;
        Mon, 7 Sep 2020 09:15:27 -0500
Date:   Mon, 7 Sep 2020 09:15:27 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Roger Quadros <rogerq@ti.com>
CC:     <t-kristo@ti.com>, <robh+dt@kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <nsekhar@ti.com>,
        <kishon@ti.com>
Subject: Re: [PATCH 0/6] arm64: dts: ti: Add USB support for J7200 EVM
Message-ID: <20200907141527.x6gkvbji33r4q64p@akan>
References: <20200907103810.9870-1-rogerq@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200907103810.9870-1-rogerq@ti.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13:38-20200907, Roger Quadros wrote:
> Hi Tero/Nishanth,
> 
> This series adds USB2.0 support for the J7200 EVM.
> 
> Series is based on top of:
> 
>     Faiz's MMC/SD support series
>     https://lore.kernel.org/lkml/20200907090520.25313-1-faiz_abbas@ti.com/
>     Lokesh's initial support series
>     https://patchwork.kernel.org/cover/11740039/
>     Vignesh's I2C support series
>     https://lore.kernel.org/patchwork/cover/1282152/
>     Vignesh's Hyperflash series
>     https://lore.kernel.org/patchwork/cover/1285326/
> 
> cheers,
> -roger
> 
> Kishon Vijay Abraham I (1):
>   arm64: dts: ti: k3-j7200-common-proc-board: Configure the SERDES lane
>     function
> 
> Roger Quadros (5):
>   dt-bindings: mux-j7200-wiz: Add lane function defines
>   arm64: dts: ti: k3-j7200-main: Add SERDES lane control mux
>   arm64: dts: ti: k3-j7200-main.dtsi: Add USB to SERDES lane MUX
>   arm64: dts: ti: k3-j7200-main: Add USB controller
>   arm64: dts: ti: k3-j7200-common-proc-board: Add USB support
> 
>  .../dts/ti/k3-j7200-common-proc-board.dts     | 28 ++++++++++
>  arch/arm64/boot/dts/ti/k3-j7200-main.dtsi     | 51 +++++++++++++++++++
>  include/dt-bindings/mux/mux-j7200-wiz.h       | 29 +++++++++++
>  3 files changed, 108 insertions(+)
>  create mode 100644 include/dt-bindings/mux/mux-j7200-wiz.h
> 

Too many warnings(W=2 and others) for me to look at this series
closer.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
