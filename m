Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3857DC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 07:46:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C16020724
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 07:46:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mysnt.onmicrosoft.com header.i=@mysnt.onmicrosoft.com header.b="dhICbLpO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728938AbgGFHq6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 03:46:58 -0400
Received: from mail-eopbgr140133.outbound.protection.outlook.com ([40.107.14.133]:37082
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728248AbgGFHq5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 03:46:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xe5ymqZJTi50lRUCRZkkM+1VI7wvA35gDuCVKzmpZSTbpSqYYmxsQY/Tk238y/leF0Clyz/9PDkCkXItmpX9BBtr3VtlXbPAXYr81DmMRKk3o5dAOQ1nZGd3eOR3Unmq8ruiA6y2UAVhCeyNOO31fgvUeQzh31cVe9lDNtsYlyxgVakF+9b5TWciKJRlXlw18Ipow1JgazOaunke2eD9kyRQoJe2Yhfun2RX/CHNzfSovZvK2iBUo4v+Yu0Q37cjPqv0AJRzBdicOpoL3+9tydWqee7axKCDHpw1yNMEIBo/10FBzL0M7LC6s8R8LKSRi+pOqF+2szvjNFE8t1Q4gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fab4z3UBrywO9B8tgF/wOSfUWQb/+NiYmw2nsnJH57g=;
 b=O5TXKbjHho9zDTor3ZVzncqc6h9PFOqF0qRdHJCQXbQbqHCKwbj6Fr+eNJPHqIwnl074rIC28o662BpNQyWswSUSS4AvzXIabhIWm52Iv7i1NQbUBF9yK8Ihv3DRWKoicm13rRtkQAhTErNw437ttGLjH/2hxHIcsAbPeDvBZ+axSe6Nb/r8qFjVFkHlVR32SX1SlP4i8szSz3RQzPV9g8uOIB+MUhvKETLcqReDoKCWqr8AEvD4hatQTTQ1UZhN7HoGUx0hMEf76EZOvOHczZj651ZOgR15RYHcrouI57XVH/i65PRjxRzbqfEZG5FjdeBM4P1zcv+LcV0QwWLqUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fab4z3UBrywO9B8tgF/wOSfUWQb/+NiYmw2nsnJH57g=;
 b=dhICbLpOGgqCdZZ6eTvbyQrs+2aPkPPf38bEd2T2hQwOrnRA4ORrlL/rv/n9e7j9xs3a2GA06JAKf2+AXMJ7wHhIyCAISy7GnyCMliwboR5OzRBafa2SEnAKn2sTpIZMp4BcIWw//Geb86G5J9ByBfpS4i+AVImmkHb7t1XYCok=
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=kontron.de;
Received: from DB7PR10MB2490.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:50::12)
 by DB8PR10MB3689.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:13e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.21; Mon, 6 Jul
 2020 07:46:50 +0000
Received: from DB7PR10MB2490.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ac04:ef33:baf3:36f3]) by DB7PR10MB2490.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ac04:ef33:baf3:36f3%4]) with mapi id 15.20.3153.029; Mon, 6 Jul 2020
 07:46:50 +0000
Subject: Re: [PATCH 1/2] arm64: dts: Add the Kontron i.MX8M-Mini SoMs and
 baseboards
To:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        "Anson.Huang@nxp.com" <Anson.Huang@nxp.com>,
        "leoyang.li@nxp.com" <leoyang.li@nxp.com>,
        "andreas@kemnade.info" <andreas@kemnade.info>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>,
        "rjones@gateworks.com" <rjones@gateworks.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "michael@walle.cc" <michael@walle.cc>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "sebastien.szymanski@armadeus.com" <sebastien.szymanski@armadeus.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
Cc:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>
References: <20200702143337.8590-1-frieder.schrempf@kontron.de>
 <20200702143337.8590-2-frieder.schrempf@kontron.de>
 <788f607c0dd7b53aeffe2dd7fe73bd419e94e164.camel@toradex.com>
From:   Frieder Schrempf <frieder.schrempf@kontron.de>
Message-ID: <12338e4a-62ca-3cac-6cd9-d0a5f7576a18@kontron.de>
Date:   Mon, 6 Jul 2020 09:46:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <788f607c0dd7b53aeffe2dd7fe73bd419e94e164.camel@toradex.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR06CA0102.eurprd06.prod.outlook.com
 (2603:10a6:208:fa::43) To DB7PR10MB2490.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:50::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.99.63] (80.147.118.32) by AM0PR06CA0102.eurprd06.prod.outlook.com (2603:10a6:208:fa::43) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.21 via Frontend Transport; Mon, 6 Jul 2020 07:46:49 +0000
X-Originating-IP: [80.147.118.32]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 03226588-b98a-4f23-1110-08d82180be0d
X-MS-TrafficTypeDiagnostic: DB8PR10MB3689:
X-Microsoft-Antispam-PRVS: <DB8PR10MB3689182E3132BFC862CC598BE9690@DB8PR10MB3689.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 04569283F9
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dLQbeDBWJK9n2TmAgxtkGgwcKgDa15DpsY1xf4do1Xx8ANl2J9O0/LymU2rVs+12P0a400o+V4PIveY42U5JtUfo3jD9tKmquYAHITQLe681wV1rlEuqTUt23M4AkokiaKhomGLEQdCjmS3v+eg/hqXJLLcOigkMnLGQqYxTRWl1aK0WMLKHWqYtslTYyHJ5nzjitFCOhEf488Edraqr4+gsgSAaOc0CS7d4uvf2yazeiAeXYylHxnIclsUBHpyfZxKpdaQNBCCYoEhdgGjYn0u9ivdPT3TuDR5BwWIUUdzIUB9Y+W0ak51L0z0ezb+Up3P6wXWXPSwhJGM/7u8Jq7t1Fq2kdEUi2oM4lGIUW/joJH+1TgJQk9TyVj2BpvXb30RVWWaFJGAToBHq6hwFDA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR10MB2490.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFTY:;SFS:(6029001)(4636009)(39850400004)(366004)(346002)(396003)(376002)(136003)(83380400001)(16526019)(16576012)(26005)(8676002)(66476007)(53546011)(66556008)(4326008)(478600001)(66946007)(8936002)(36756003)(110136005)(86362001)(316002)(52116002)(44832011)(31696002)(2906002)(186003)(7416002)(5660300002)(956004)(31686004)(2616005)(54906003)(6486002)(921003)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: +kDMdHXkv7l4qNVkIK1CnpgapTGYvn6E37yoIn2JiDeFSyH8lYJC/CbrRv1caIM5Mq7dBc7IDL7YuM+AWzEUPOTqR9WkEO8ekPIUGJF/2y+W0IEcTjwj8kYRK9DAqyqY80mj9RB90Tc1o41l1J8POGg6DvifMwGqmTGQEVYGL7d6eFrDeConA7wnkC+EhcgjtYjd1CIIvEn/pouo1nesb8t4MzgG/a0JtMcrUP1ox3wHtLGjhMJPm3H292AxV444IKzDbpqSS9F4sYmzhZ6u99z8CtStkkbyLKNn1B1vFSa+9KWXDutitmuU/BYXSyAs48Bg7SBXfc+SQNDVr/Uj3LXHhIqwE+Aptl6kyRbrLi4Tad0iZaikJSdmBnslBrq3oPtSEdsyH4jGU6TaiL1rbwdDjr1aW0rvxbbI86TFFaDAAtbfwJpi132P6kf71Y3dSfawuPiWu09skfeaieuiNDxm8t5kVZdWakuR/Wuofvo=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 03226588-b98a-4f23-1110-08d82180be0d
X-MS-Exchange-CrossTenant-AuthSource: DB7PR10MB2490.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2020 07:46:50.4011
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BbUuadgrYtlIthffQqVvPP5GzzuL0q464wXkewp/V3UbJtVxXeO5aa7plI0fMpH0+S/A8/Fw/NgSd6lknoHS6w3fAmNrlJS3pP2LX6BrL80=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3689
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcel,

On 03.07.20 09:56, Marcel Ziswiler wrote:
> Hi Frieder
> 
> Nice to see some more i.MX 8M Mini action. Much appreciated!
> 
> On Thu, 2020-07-02 at 16:33 +0200, Schrempf Frieder wrote:
>> From: Frieder Schrempf <frieder.schrempf@kontron.de>
>>
>> Kontron Electronics GmbH offers small and powerful SoMs based on the
>> i.MX8MM
> 
> To avoid much confusion in NXP's nomenclature I would recommend writing this always as i.MX 8M Mini. Of course,
> in code, using imx8mm is fine.

Ok, sounds reasonable.

> 
>> including PMIC, LPDDR4-RAM, eMMC and SPI NOR.
>>
>> The matching baseboards have the same form factor and similar interfaces
>> as the other boards from the Kontron "Board-Line" family, including
>> SD card, 1G Ethernet, 100M Ethernet, USB Host/OTG, digital IOs, RS232,
>> RS485, CAN, LVDS or HDMI, RTC and much more.
>>
>> Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
>> ---
>>   .../dts/freescale/imx8mm-kontron-n8010-s.dts  |  15 +
>>   .../freescale/imx8mm-kontron-n8010-som.dtsi   |  16 +
>>   .../dts/freescale/imx8mm-kontron-n8011-s.dts  |  15 +
>>   .../freescale/imx8mm-kontron-n8011-som.dtsi   |  16 +
>>   .../dts/freescale/imx8mm-kontron-n801x-s.dtsi | 326 ++++++++++++++++++
>>   .../freescale/imx8mm-kontron-n801x-som.dtsi   | 281 +++++++++++++++
>>   6 files changed, 669 insertions(+)
>>   create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-kontron-n8010-s.dts
>>   create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-kontron-n8010-som.dtsi
>>   create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-kontron-n8011-s.dts
>>   create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-kontron-n8011-som.dtsi
>>   create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-s.dtsi
>>   create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-som.dtsi
>>
>> diff --git a/arch/arm64/boot/dts/freescale/imx8mm-kontron-n8010-s.dts b/arch/arm64/boot/dts/freescale/imx8mm-
>> kontron-n8010-s.dts
>> new file mode 100644
>> index 000000000000..0911f2d0555b
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/freescale/imx8mm-kontron-n8010-s.dts
>> @@ -0,0 +1,15 @@
>> +// SPDX-License-Identifier: GPL-2.0
> 
> Don't you want to use the more common GPL-2.0+ OR MIT variant which allows for more freedom? At least NXP's
> imx8mm.dtsi also uses that.

That actually sounds like a good idea. I will change that.

> 
>> +/*
>> + * Copyright (C) 2019 Kontron Electronics GmbH
> 
> I know that there is much about 2020 to rather be ignored.

Indeed, but I also once learned that you don't change the original date 
in a copyright notice as it is used to express when the content has been 
published or created first (and the original version has been online on 
our server publically since 2019).

> 
>> + */
>> +
>> +/dts-v1/;
>> +
>> +#include "imx8mm-kontron-n8010-som.dtsi"
>> +#include "imx8mm-kontron-n801x-s.dtsi"
>> +
>> +/ {
>> +	model = "Kontron i.MX8MM N8010 S";
>> +	compatible = "kontron,imx8mm-n8010-s", "kontron,imx8mm-n8010-som",
>> +		     "fsl,imx8mm";
> 
> I believe now with Linux having dropped the strict 80-column line length coding style limit we are allowed to
> go up to 100 (;-p).

Right, I remember seeing some discussion about extending the column 
limit. I will need to update my text editor's config.

> 
>> +};
>> diff --git a/arch/arm64/boot/dts/freescale/imx8mm-kontron-n8010-som.dtsi
>> b/arch/arm64/boot/dts/freescale/imx8mm-kontron-n8010-som.dtsi
>> new file mode 100644
>> index 000000000000..5b178ce4ce1b
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/freescale/imx8mm-kontron-n8010-som.dtsi
>> @@ -0,0 +1,16 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (C) 2019 Kontron Electronics GmbH
>> + */
>> +
>> +#include "imx8mm-kontron-n801x-som.dtsi"
>> +
>> +/ {
>> +	model = "Kontron i.MX8MM N8010 SoM";
>> +	compatible = "kontron,imx8mm-n8010-som", "fsl,imx8mm";
>> +
>> +	memory@40000000 {
>> +		device_type = "memory";
>> +		reg = <0x0 0x40000000 0 0x80000000>;
>> +	};
>> +};
>> diff --git a/arch/arm64/boot/dts/freescale/imx8mm-kontron-n8011-s.dts b/arch/arm64/boot/dts/freescale/imx8mm-
>> kontron-n8011-s.dts
>> new file mode 100644
>> index 000000000000..5c44bd77ed32
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/freescale/imx8mm-kontron-n8011-s.dts
>> @@ -0,0 +1,15 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (C) 2019 Kontron Electronics GmbH
>> + */
>> +
>> +/dts-v1/;
>> +
>> +#include "imx8mm-kontron-n8011-som.dtsi"
>> +#include "imx8mm-kontron-n801x-s.dtsi"
>> +
>> +/ {
>> +	model = "Kontron i.MX8MM N8011 S";
>> +	compatible = "kontron,imx8mm-n8011-s", "kontron,imx8mm-n8011-som",
>> +		     "fsl,imx8mm";
>> +};
>> diff --git a/arch/arm64/boot/dts/freescale/imx8mm-kontron-n8011-som.dtsi
>> b/arch/arm64/boot/dts/freescale/imx8mm-kontron-n8011-som.dtsi
>> new file mode 100644
>> index 000000000000..303594867b8f
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/freescale/imx8mm-kontron-n8011-som.dtsi
>> @@ -0,0 +1,16 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (C) 2019 Kontron Electronics GmbH
>> + */
>> +
>> +#include "imx8mm-kontron-n801x-som.dtsi"
>> +
>> +/ {
>> +	model = "Kontron i.MX8MM N8011 SoM";
>> +	compatible = "kontron,imx8mm-n8011-som", "fsl,imx8mm";
>> +
>> +	memory@40000000 {
>> +		device_type = "memory";
>> +		reg = <0x0 0x40000000 0 0xC0000000>;
>> +	};
> 
> Isn't the boot loader supposed to filling that in?

Hm, probably yes. I thought it would be good to have the upstream DT 
fully describe the modules, including the memory size. But if it is more 
common or useful, I will fill in the memory size for the smallest 
configuration (1GB) only and let U-Boot overwrite the value if it 
detects modules with larger DDR.

> 
>> +};
>> diff --git a/arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-s.dtsi
>> b/arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-s.dtsi
>> new file mode 100644
>> index 000000000000..d825e52e0beb
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-s.dtsi
>> @@ -0,0 +1,326 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (C) 2019 Kontron Electronics GmbH
>> + */
>> +
>> +/ {
>> +	aliases {
>> +		ethernet1 = &usbnet;
>> +	};
>> +
>> +	/* fixed crystal dedicated to mcp2515 */
>> +	clk16m: clk16m {
> 
> I believe a more human readable variant e.g. as follows is preferred:
> 
> osc_16m: clock-osc-16m

Ok.

> 
>> +		compatible = "fixed-clock";
>> +		#clock-cells = <0>;
>> +		clock-frequency = <16000000>;
> 
> Also the use of the optional property clock-output-names is recommended.

Ok.

> 
>> +	};
>> +
>> +	leds {
>> +		compatible = "gpio-leds";
>> +		pinctrl-names = "default";
>> +		pinctrl-0 = <&pinctrl_gpio_led>;
>> +
>> +		led1 {
>> +			label = "led1";
>> +			gpios = <&gpio4 17 GPIO_ACTIVE_LOW>;
>> +			linux,default-trigger = "heartbeat";
>> +		};
>> +
>> +		led2 {
>> +			label = "led2";
>> +			gpios = <&gpio4 19 GPIO_ACTIVE_LOW>;
>> +		};
>> +
>> +		led3 {
>> +			label = "led3";
>> +			gpios = <&gpio4 18 GPIO_ACTIVE_LOW>;
>> +		};
>> +
>> +		led4 {
>> +			label = "led4";
>> +			gpios = <&gpio4 8 GPIO_ACTIVE_LOW>;
>> +		};
>> +
>> +		led5 {
>> +			label = "led5";
>> +			gpios = <&gpio4 9 GPIO_ACTIVE_LOW>;
>> +		};
>> +
>> +		led6 {
>> +			label = "led6";
>> +			gpios = <&gpio4 7 GPIO_ACTIVE_LOW>;
>> +		};
>> +	};
>> +
>> +	pwm-beeper {
>> +		compatible = "pwm-beeper";
>> +		pwms = <&pwm2 0 5000 0>;
>> +	};
>> +
>> +	reg_rst_eth2: regulator-rst-eth2 {
>> +		compatible = "regulator-fixed";
>> +		regulator-name = "rst-usb-eth2";
>> +		pinctrl-names = "default";
>> +		pinctrl-0 = <&pinctrl_usb_eth2>;
>> +		gpio = <&gpio3 2 GPIO_ACTIVE_LOW>;
>> +		status = "okay";
>> +	};
>> +
>> +	vdd_5v: regulator-5v {
> 
> I would stick to consistent reg_ pre-fixing.

Ok.

> 
>> +		compatible = "regulator-fixed";
>> +		regulator-name = "vdd_5v";
>> +		regulator-min-microvolt = <5000000>;
>> +		regulator-max-microvolt = <5000000>;
>> +		regulator-boot-on;
>> +		regulator-always-on;
>> +		status = "okay";
>> +	};
>> +};
>> +
>> +&ecspi2 {
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&pinctrl_ecspi2>;
>> +	cs-gpios = <&gpio5 13 GPIO_ACTIVE_LOW>;
>> +	status = "okay";
>> +
>> +	can0: can@0 {
>> +		compatible = "microchip,mcp2515";
>> +		reg = <0>;
>> +		pinctrl-names = "default";
>> +		pinctrl-0 = <&pinctrl_can>;
>> +		clocks = <&clk16m>;
>> +		interrupt-parent = <&gpio4>;
>> +		interrupts = <28 IRQ_TYPE_EDGE_FALLING>;
>> +		spi-max-frequency = <100000>;
>> +		vdd-supply = <&vdd_3v3>;
>> +		xceiver-supply = <&vdd_5v>;
>> +		status = "okay";
> 
> I find the property ordering a little confusing but that might just be me.

I think it's "compatible", "reg" and "pinctrl" first, then the other 
properties in alphabetical order and "status" last. So I'm not really 
sure what to improve here.

> 
>> +	};
>> +};
>> +
>> +&ecspi3 {
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&pinctrl_ecspi3>;
>> +	cs-gpios = <&gpio5 25 GPIO_ACTIVE_LOW>;
>> +	status = "okay";
>> +
>> +	userspi: userspi@0 {
>> +		compatible = "kontron,user-spi";
>> +		reg = <0>;
>> +		spi-max-frequency = <100000000>;
>> +		status = "okay";
>> +	};
> 
> I thought from earlier discussions you intended to drop that and either specify it from user-space directly or
> use an overlay instead.

Yes, indeed, but when I learned about the possibility to override the 
device's driver from userspace, I already had sent out this patch. I 
will remove the userspi node in the next version.

Thanks so far for reviewing!
Frieder
