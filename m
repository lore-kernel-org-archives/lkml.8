Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75A80C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 15:41:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5413C20776
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 15:41:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="opcEzKyT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730358AbgE0Plb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 11:41:31 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:39752 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726807AbgE0Plb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 11:41:31 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 04RFfHNS004860;
        Wed, 27 May 2020 10:41:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1590594077;
        bh=XEcyKsm3Rvw5vHQRvm9JNFUY7jNND4xv6Zl3osWxia4=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=opcEzKyTMkkG0XF+VgSiPrcP3DJbkmqd1I0/Vglf0UZFuy21+0EUMovBZ/efmrMb7
         ELXWMY0DlMVITW3WPKDNqH//uRxcrHA7YijL8Qti5jID2M2hAVD71nPPcv41apJkii
         RJDWaIHBMXi201HP+47oJKtD/BnkFW/qSsym4XuY=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 04RFfHmk094289;
        Wed, 27 May 2020 10:41:17 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 27
 May 2020 10:41:16 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 27 May 2020 10:41:17 -0500
Received: from [10.250.65.13] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 04RFfGA3097665;
        Wed, 27 May 2020 10:41:16 -0500
Subject: Re: [PATCH v25 06/16] dt: bindings: lp55xx: Update binding for
 Multicolor Framework
To:     Rob Herring <robh@kernel.org>
CC:     <jacek.anaszewski@gmail.com>, <pavel@ucw.cz>,
        <devicetree@vger.kernel.org>, <linux-leds@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Tony Lindgren <tony@atomide.com>,
        =?UTF-8?Q?Beno=c3=aet_Cousson?= <bcousson@baylibre.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
References: <20200526164652.2331-1-dmurphy@ti.com>
 <20200526164652.2331-7-dmurphy@ti.com> <20200527020101.GA891065@bogus>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <7ff61c4a-0d74-a206-2255-21ee3c7a4357@ti.com>
Date:   Wed, 27 May 2020 10:41:15 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200527020101.GA891065@bogus>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rob

On 5/26/20 9:01 PM, Rob Herring wrote:
> On Tue, May 26, 2020 at 11:46:42AM -0500, Dan Murphy wrote:
>> Update the DT binding to include the properties to use the
>> multicolor framework for the devices that use the LP55xx
>> framework.
>>
>> Acked-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>
>> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
>> Signed-off-by: Dan Murphy <dmurphy@ti.com>
>> CC: Tony Lindgren <tony@atomide.com>
>> CC: "Benoît Cousson" <bcousson@baylibre.com>
>> CC: Linus Walleij <linus.walleij@linaro.org>
>> CC: Shawn Guo <shawnguo@kernel.org>
>> CC: Sascha Hauer <s.hauer@pengutronix.de>
>> CC: Pengutronix Kernel Team <kernel@pengutronix.de>
>> CC: Fabio Estevam <festevam@gmail.com>
>> CC: NXP Linux Team <linux-imx@nxp.com>
>> ---
>>   .../devicetree/bindings/leds/leds-lp55xx.txt  | 149 +++++++++++++++---
>>   1 file changed, 124 insertions(+), 25 deletions(-)
> Convert this to schema first because it's going to need to reference
> the multi-color schema.

OK.  This seems to be my life recently converting txt to yaml ;)

Dan


> Rob
