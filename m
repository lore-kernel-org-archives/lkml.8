Return-Path: <SRS0=eufF=BE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29C65C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 19:54:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0D3D20758
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 19:54:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Xg7p7nod"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727982AbgGYTym (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jul 2020 15:54:42 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:60824 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726727AbgGYTym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jul 2020 15:54:42 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 06PJsap0001301;
        Sat, 25 Jul 2020 14:54:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1595706876;
        bh=Aaksztzrfs7ZnVJl7Uo5foZqIiLfpt+fEVbTgERsXos=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=Xg7p7nodeeTjLodTkGLLHQeT4TBNHYWrsyzYeeznqT5JCgo1ethS6CZKbF+wDQucA
         YS6pXI5rioij19trS5r4zfHKcgiM2UI3uD+S5hy/mH+X4z56KGq9BP7xNgYlqOLy9I
         YHHJ1+wyD2izVqK8W5ScHTZ5e9/f0797niNjamww=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 06PJsaVr042359
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 25 Jul 2020 14:54:36 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Sat, 25
 Jul 2020 14:54:36 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Sat, 25 Jul 2020 14:54:36 -0500
Received: from [10.24.69.198] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 06PJsW3X043152;
        Sat, 25 Jul 2020 14:54:33 -0500
Subject: Re: [PATCH v4 0/2] Add new PHY APIs to framework to get/set PHY
 attributes
To:     Swapnil Jakhade <sjakhade@cadence.com>, <vkoul@kernel.org>,
        <kishon@ti.com>, <linux-kernel@vger.kernel.org>,
        <maxime@cerno.tech>
CC:     <mparab@cadence.com>, <yamonkar@cadence.com>,
        <tomi.valkeinen@ti.com>, <jsarha@ti.com>, <praneeth@ti.com>
References: <1594968633-12535-1-git-send-email-sjakhade@cadence.com>
From:   Sekhar Nori <nsekhar@ti.com>
Message-ID: <f1f2cdca-99a1-2bcc-6fe2-9ce95553a7cd@ti.com>
Date:   Sun, 26 Jul 2020 01:24:32 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1594968633-12535-1-git-send-email-sjakhade@cadence.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vinod,

On 7/17/20 12:20 PM, Swapnil Jakhade wrote:
> This patch series adds a new pair of PHY APIs that can be used to get/set
> all the PHY attributes. It also adds a new PHY attribute max_link_rate.
> 
> It includes following patches:
> 
> 1. v4-0001-phy-Add-new-PHY-attribute-max_link_rate-and-APIs-.patch
> This patch adds max_link_rate as a new PHY attribute along with a pair of
> APIs that allow using the generic PHY subsystem to get/set PHY attributes
> supported by the PHY.
> 
> 2. v4-0002-phy-cadence-torrent-Use-kernel-PHY-API-to-set-PHY.patch
> This patch uses PHY API phy_set_attrs() to set corresponding PHY properties
> in Cadence Torrent PHY driver. This will enable drivers using this PHY to
> read these properties using PHY framework.
> 
> The phy_get_attrs() API will be used in the DRM bridge driver [1] which is
> in the process of upstreaming.

Is it possible to queue these for v5.9 also? I did notice that phy
updates for v5.9-rc1 are posted already. But these APIs are needed for
the DisplayPort driver thats getting ready for merge too. Having these
queued now will make managing dependencies much easier.

Thanks,
Sekhar
