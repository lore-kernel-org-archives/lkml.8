Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E01DC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 05:47:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BB2721501
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 05:47:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=topicbv.onmicrosoft.com header.i=@topicbv.onmicrosoft.com header.b="M0Sgx8Jt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726195AbgE2Frt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 01:47:49 -0400
Received: from mail-eopbgr60057.outbound.protection.outlook.com ([40.107.6.57]:22019
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725562AbgE2Frs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 01:47:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=topicbv.onmicrosoft.com; s=selector2-topicbv-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=anAYRx8XI2NF5Sa3StDdmE+WNBMuGZoP3tteH40kI2I=;
 b=M0Sgx8Jte/9uakEVjPS+bwyyEyfuZw7TKeBqyEFnvY2qpHN2oz6gDV71p/mmRQI18SYDSkvMmYPTnrwQd4vRxXZ8NOfYu3Q8KYSK+k6SbERwa8WwP5SOHhNpKlhLwCNHNn90kOSKMbiHkivCI3/FX9Tkm9qWQAokqdBYyOIyA3o=
Received: from AM6PR0502CA0040.eurprd05.prod.outlook.com
 (2603:10a6:20b:56::17) by DB6PR0402MB2933.eurprd04.prod.outlook.com
 (2603:10a6:4:9c::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.19; Fri, 29 May
 2020 05:47:43 +0000
Received: from VE1EUR01FT038.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:20b:56:cafe::b7) by AM6PR0502CA0040.outlook.office365.com
 (2603:10a6:20b:56::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.17 via Frontend
 Transport; Fri, 29 May 2020 05:47:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 13.81.10.179)
 smtp.mailfrom=topicproducts.com; vger.kernel.org; dkim=none (message not
 signed) header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=topic.nl;
Received-SPF: Pass (protection.outlook.com: domain of topicproducts.com
 designates 13.81.10.179 as permitted sender) receiver=protection.outlook.com;
 client-ip=13.81.10.179; helo=westeu13-emailsignatures-cloud.codetwo.com;
Received: from westeu13-emailsignatures-cloud.codetwo.com (13.81.10.179) by
 VE1EUR01FT038.mail.protection.outlook.com (10.152.3.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3045.17 via Frontend Transport; Fri, 29 May 2020 05:47:42 +0000
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (104.47.13.57) by westeu13-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Fri, 29 May 2020 05:47:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YtUFOrthPxeoYnS1C0xIrwgEZPiKOG6Q445fPfgqYD4Z/ahhyDbPrlUXUNavb6nux5jM1VO7y601pvSUqGv+Fm65I4QRzPmQFTK3lXx3k/v29FbSKOCriT+iwOyzM8pKjKh/w3BAz+iu4NMWDObcG7WIwyZvGI/XnpUeKPcV5BIHRRGwnrLE1yVCpfigiCO3Cjl8X6dZIksoIgzI4W8ezNiywfbsQfcSnjywRvmiuJyh3zMjK7ZduLoZ194JpSYKIL2i8JxWB1PEVzceVZbmH4wOkM8xd54zAPmAmDBWXXGYNiuKM4t8a8loIEOciY0ME99uMk3MNFYXUQG0nbU7jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5jiksq+6QuJrP1v/gucs/zTjDFJ24im2Zbg4mEC5z1k=;
 b=QUtUc7vjVf4xloeRD7VI2N2gLV3GzSteIw3M8gHCcaj1DlwNJDlTisPUVT0GkhETYLuGJ2D6LO0SJISMBiuLMpW66+q34OpKB1vhoRjRB23iOxf2h+RNZglUIV4ZPuKWWkHBtPgkX0WTe2J96DzHRHt2il1xCCg3+KdTCd6p/Cy2/5XQtIF98onMWKeFzjxHx9T6pnve9Nhs4xuu8J8VcyWapfeU4ew+Mmh+Z4l2T9k1lpVLxr3HuJlAOtoMrzzTdoyhmYvdZXMSlYm6vT+s/KvTwXTKwvf2FeTxtgYjjtI3STqETezO3g91zBOHMzY9aS9fdXXNKf6WC5y39jMwrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=topicproducts.com; dmarc=pass action=none header.from=topic.nl;
 dkim=pass header.d=topic.nl; arc=none
Authentication-Results-Original: vger.kernel.org; dkim=none (message not
 signed) header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=topic.nl;
Received: from DB8PR04MB6523.eurprd04.prod.outlook.com (2603:10a6:10:10f::26)
 by DB8PR04MB5881.eurprd04.prod.outlook.com (2603:10a6:10:a7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.17; Fri, 29 May
 2020 05:47:38 +0000
Received: from DB8PR04MB6523.eurprd04.prod.outlook.com
 ([fe80::6cf6:7323:7395:eec9]) by DB8PR04MB6523.eurprd04.prod.outlook.com
 ([fe80::6cf6:7323:7395:eec9%7]) with mapi id 15.20.3045.018; Fri, 29 May 2020
 05:47:38 +0000
Subject: Re: [PATCH] usb/phy-generic: Add support for OTG VBUS supply control
To:     Peter Chen <peter.chen@nxp.com>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20200526145051.31520-1-mike.looijmans@topic.nl>
 <20200528112051.GB2604@b29397-desktop>
 <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.976751ef-854e-4011-a18e-b2d0439b2aee@emailsignatures365.codetwo.com>
 <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.0d2bd5fa-15cc-4b27-b94e-83614f9e5b38.5ef445e7-974a-4eff-8ab7-9d43664977e4@emailsignatures365.codetwo.com>
From:   Mike Looijmans <mike.looijmans@topic.nl>
Organization: Topic
Message-ID: <3fe53080-cc74-3b0b-3041-2c4fde1b7e30@topic.nl>
Date:   Fri, 29 May 2020 07:47:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <20200528112051.GB2604@b29397-desktop>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-ClientProxiedBy: AM0PR01CA0089.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:10e::30) To DB8PR04MB6523.eurprd04.prod.outlook.com
 (2603:10a6:10:10f::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.130] (83.128.90.119) by AM0PR01CA0089.eurprd01.prod.exchangelabs.com (2603:10a6:208:10e::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.19 via Frontend Transport; Fri, 29 May 2020 05:47:37 +0000
X-Originating-IP: [83.128.90.119]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3f3e1ffb-2d59-4f22-859c-08d80393ce38
X-MS-TrafficTypeDiagnostic: DB8PR04MB5881:|DB6PR0402MB2933:
X-Microsoft-Antispam-PRVS: <DB6PR0402MB2933D3743EDA5634ED4CBA8B968F0@DB6PR0402MB2933.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;OLM:8882;
X-Forefront-PRVS: 04180B6720
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: qOt1pKm1WdVsQPGzrDvjBZAD1/R8H7d4ubvFjwTtJuvMjECrqt7erbuX2SZmkE/Pbj/fKOfaokJyOX3jMpDFOsO5Wi1nVZ6a4islj1gV/XSiR+fBd1p0sQeVRaSAWT88izJI3j4xJ/YOslPT5tR1uRCIm6o6+CzD3A/iBXsNJZbQ/+fs5HuhAxQNxbp2a5fs/seryJUooj6GcHFKPurjjIqL39mFZ4m+YOs+ZN7OOSw6HybXgQ6+PGMV/lHV8OJXS8Si2l9xoGB9JD3eRruwNCFBEa9mQuHrkJc12VMvuuDG/xWy0/W/zozea0bVKOQPfs5bdhM6CrTEmSSf4lZTRV4BQAx0Xhj9wkj+dgkCbL9pCk2jdKSy++PB83Zn2RoHZFdgnePWBPqHBucZ7TBpVw==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6523.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(366004)(376002)(39840400004)(346002)(396003)(136003)(2616005)(8936002)(5660300002)(6916009)(956004)(2906002)(6486002)(8676002)(44832011)(42882007)(186003)(16526019)(52116002)(66946007)(66556008)(31686004)(83170400001)(508600001)(66476007)(36756003)(53546011)(54906003)(36916002)(26005)(4326008)(83380400001)(16576012)(316002)(31696002)(41533002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: Hx+2l4r4GbigV+fsMPLLnsVoWp/r+lUurcDyYELZ7AQakUtMnn6bcjRZXty6bVPnyzT6Jq1LpYKIhcCibctqNsv/kqnAkZ7fsMft5ioFZMZ1wrX6nOEuU633ktwFrXAAcUg/Kd9BZe0RYi6AlQeh2rQUpVs2JzR6XZowt3dRI22mZgYoayB0xV1CmjUtKQUBR9tKu6hjalme4reZz14j3uXUcoL0SAhSbTIxA0XZIU2XjufCcdm/kolKeEJgt+ndHY5aQUeej2y81dz7E2prxdsfosvIqBvrpAwLccG4tEqFUZgIhYvLPfpxBo1IUg+CjJ2XbdWSWR3DUfF1xXOQcFmF6h26bXaK6hioZys6+hZ1myJ4ipD1UdsbIpgQtZn9tZGL56W3faenrHSHnm2p8todNgrbE9S1MMFsPq8TnxLy/k9DdkJLOsrejdcMdtrx5LxDzK8IsWEpo1HhaVcTXM0Gtuf1lHFCmZA5g2RoCDQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB5881
X-CodeTwo-MessageID: 36dc21c5-d3bc-4653-8822-c19752e021a0.20200529054740@westeu13-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR01FT038.eop-EUR01.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:13.81.10.179;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:westeu13-emailsignatures-cloud.codetwo.com;PTR:westeu13-emailsignatures-cloud.codetwo.com;CAT:NONE;SFTY:;SFS:(136003)(346002)(376002)(396003)(39840400004)(46966005)(16526019)(36756003)(316002)(6916009)(70206006)(47076004)(336012)(31696002)(42882007)(31686004)(44832011)(7636003)(2616005)(356005)(8676002)(70586007)(956004)(2906002)(83170400001)(7596003)(82310400002)(53546011)(8936002)(15974865002)(6486002)(26005)(5660300002)(508600001)(16576012)(186003)(54906003)(36916002)(83380400001)(4326008)(41533002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 8bf848b7-4752-42b4-e6f9-08d80393cb74
X-Forefront-PRVS: 04180B6720
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YfX/ZV367RJRgS00ZxWJ1Q7gB2UOvenZ4AyNWVCuKrR/bj/CnYsHFKgHVMGbMSWDABNCQjyM69aKezIX7HgzghklcHZll92+LfpmBrsllC4l43f9eIHAQPBHVqLrChRXr2KY4+cNU6rHgG6Ci+0O0C6Dd7p33hv/2JQ3BPGDOoVf9P9XOpqFYNhVotxnRaZlZFq1N93AytRkC7VSzHoXchvKB0eKvbpiVLgAce6BvXpsdjOMPiPOtDxmM9vhi+qP5eKizMrjvMjc3d+pFJMaKfTSopHKwdcRdU7fiuh+mRgU8XX98P6+lakI8aduAaOmMdhOcoJOx/np2rmhNjg7MxlJ9bFRecrpiY4H1Fksy0vaEH3hNWGXd7xNcjmOjx1aMwjSbCaGx7QQTFAoR5IqOafFMzUNtcTratbL9uHDjWVSHgjjYcFToxPYTQ//pSUV93s56EOhh+CL71QfwpxM88HaF6P86TjScabMNp1PVBAVrfU8dg93qtDuxb0cBi88S/rJjFnupH9QiCM3JgtVWQ+ItlCbvNl0pCnhCxSOfnE=
X-OriginatorOrg: topic.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2020 05:47:42.5592
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f3e1ffb-2d59-4f22-859c-08d80393ce38
X-MS-Exchange-CrossTenant-Id: 449607a5-3517-482d-8d16-41dd868cbda3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=449607a5-3517-482d-8d16-41dd868cbda3;Ip=[13.81.10.179];Helo=[westeu13-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0402MB2933
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Met vriendelijke groet / kind regards,=0A=
=0A=
Mike Looijmans=0A=
System Expert=0A=
=0A=
=0A=
TOPIC Embedded Products B.V.=0A=
Materiaalweg 4, 5681 RJ Best=0A=
The Netherlands=0A=
=0A=
T: +31 (0) 499 33 69 69=0A=
E: mike.looijmans@topicproducts.com=0A=
W: www.topicproducts.com=0A=
=0A=
Please consider the environment before printing this e-mail=0A=
On 28-05-2020 13:20, Peter Chen wrote:
> On 20-05-26 16:50:51, Mike Looijmans wrote:
>> This enables support for VBUS on boards where the power is supplied
>> by a regulator. The regulator is enabled when the USB port enters
>> HOST mode.
>>
> Why you don't do this at your host controller driver?

That was my first thought too, but it made more sense to do it here.=20
It's about how things are connected on the board, and not about the=20
controller. Also makes for a consistent devicetree when using different=20
SOCs on the same carrier board.

I already needed this driver to properly reset the USB phy, which the=20
controller driver also did not do. So it made sense to add the vbus=20
power control to this driver too.

If you have a strong preference for the controller driver, I can move=20
this to the DWC3 driver which happens to be the controller for the=20
latest batch of SOMs.


>
> Peter
>> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
>> ---
>>   .../devicetree/bindings/usb/usb-nop-xceiv.txt |  3 ++
>>   drivers/usb/phy/phy-generic.c                 | 44 ++++++++++++++++++-
>>   drivers/usb/phy/phy-generic.h                 |  2 +
>>   3 files changed, 48 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/usb/usb-nop-xceiv.txt b/D=
ocumentation/devicetree/bindings/usb/usb-nop-xceiv.txt
>> index 4dc6a8ee3071..775a19fdb613 100644
>> --- a/Documentation/devicetree/bindings/usb/usb-nop-xceiv.txt
>> +++ b/Documentation/devicetree/bindings/usb/usb-nop-xceiv.txt
>> @@ -16,6 +16,9 @@ Optional properties:
>>  =20
>>   - vcc-supply: phandle to the regulator that provides power to the PHY.
>>  =20
>> +- vbus-supply: phandle to the regulator that provides the VBUS power fo=
r when
>> +  the device is in HOST mode.
>> +
>>   - reset-gpios: Should specify the GPIO for reset.
>>  =20
>>   - vbus-detect-gpio: should specify the GPIO detecting a VBus insertion
>> diff --git a/drivers/usb/phy/phy-generic.c b/drivers/usb/phy/phy-generic=
.c
>> index 661a229c105d..ebfb90764511 100644
>> --- a/drivers/usb/phy/phy-generic.c
>> +++ b/drivers/usb/phy/phy-generic.c
>> @@ -203,13 +203,43 @@ static int nop_set_host(struct usb_otg *otg, struc=
t usb_bus *host)
>>   	return 0;
>>   }
>>  =20
>> +static int nop_set_vbus(struct usb_otg *otg, bool enabled)
>> +{
>> +	struct usb_phy_generic *nop;
>> +	int ret;
>> +
>> +	if (!otg)
>> +		return -ENODEV;
>> +
>> +	nop =3D container_of(otg->usb_phy, struct usb_phy_generic, phy);
>> +
>> +	if (!nop->vbus_reg)
>> +		return 0;
>> +
>> +	if (enabled) {
>> +		if (nop->vbus_reg_enabled)
>> +			return 0;
>> +		ret =3D regulator_enable(nop->vbus_reg);
>> +		if (ret < 0)
>> +			return ret;
>> +		nop->vbus_reg_enabled =3D true;
>> +	} else {
>> +		if (!nop->vbus_reg_enabled)
>> +			return 0;
>> +		ret =3D regulator_disable(nop->vbus_reg);
>> +		if (ret < 0)
>> +			return ret;
>> +		nop->vbus_reg_enabled =3D false;
>> +	}
There's a "return 0" missing here, will fix that in v2
>> +}
>> +
>>   int usb_phy_gen_create_phy(struct device *dev, struct usb_phy_generic =
*nop)
>>   {
>>   	enum usb_phy_type type =3D USB_PHY_TYPE_USB2;
>>   	int err =3D 0;
>>  =20
>>   	u32 clk_rate =3D 0;
>> -	bool needs_vcc =3D false, needs_clk =3D false;
>> +	bool needs_vcc =3D false, needs_clk =3D false, needs_vbus =3D false;
>>  =20
>>   	if (dev->of_node) {
>>   		struct device_node *node =3D dev->of_node;
>> @@ -219,6 +249,7 @@ int usb_phy_gen_create_phy(struct device *dev, struc=
t usb_phy_generic *nop)
>>  =20
>>   		needs_vcc =3D of_property_read_bool(node, "vcc-supply");
>>   		needs_clk =3D of_property_read_bool(node, "clocks");
>> +		needs_vbus =3D of_property_read_bool(node, "vbus-supply");
>>   	}
>>   	nop->gpiod_reset =3D devm_gpiod_get_optional(dev, "reset",
>>   						   GPIOD_ASIS);
>> @@ -268,6 +299,16 @@ int usb_phy_gen_create_phy(struct device *dev, stru=
ct usb_phy_generic *nop)
>>   			return -EPROBE_DEFER;
>>   	}
>>  =20
>> +	nop->vbus_reg =3D devm_regulator_get(dev, "vbus");
>> +	if (IS_ERR(nop->vbus_reg)) {
>> +		dev_dbg(dev, "Error getting vbus regulator: %ld\n",
>> +					PTR_ERR(nop->vbus_reg));
>> +		if (needs_vbus)
>> +			return -EPROBE_DEFER;
>> +
>> +		nop->vbus_reg =3D NULL;
>> +	}
>> +
>>   	nop->dev		=3D dev;
>>   	nop->phy.dev		=3D nop->dev;
>>   	nop->phy.label		=3D "nop-xceiv";
>> @@ -278,6 +319,7 @@ int usb_phy_gen_create_phy(struct device *dev, struc=
t usb_phy_generic *nop)
>>   	nop->phy.otg->usb_phy		=3D &nop->phy;
>>   	nop->phy.otg->set_host		=3D nop_set_host;
>>   	nop->phy.otg->set_peripheral	=3D nop_set_peripheral;
>> +	nop->phy.otg->set_vbus		=3D nop_set_vbus;
>>  =20
>>   	return 0;
>>   }
>> diff --git a/drivers/usb/phy/phy-generic.h b/drivers/usb/phy/phy-generic=
.h
>> index 7ee80211a688..a3663639ea1e 100644
>> --- a/drivers/usb/phy/phy-generic.h
>> +++ b/drivers/usb/phy/phy-generic.h
>> @@ -14,7 +14,9 @@ struct usb_phy_generic {
>>   	struct gpio_desc *gpiod_reset;
>>   	struct gpio_desc *gpiod_vbus;
>>   	struct regulator *vbus_draw;
>> +	struct regulator *vbus_reg;
>>   	bool vbus_draw_enabled;
>> +	bool vbus_reg_enabled;
>>   	unsigned long mA;
>>   	unsigned int vbus;
>>   };
>> --=20
>> 2.17.1
>>

--=20
Mike Looijmans

