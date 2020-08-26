Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8E63C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 07:45:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D6D6206FA
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 07:45:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="Pn8Sdh0p";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="yAIf9uKK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbgHZHpA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 03:45:00 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:46756 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726125AbgHZHo7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 03:44:59 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07Q7hmrM022417;
        Wed, 26 Aug 2020 00:44:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=Bn0e7pp5z+AU/74ciSETE4v1mN49q4Cr4d7uEnG5gBg=;
 b=Pn8Sdh0pdqPYCBzbYx6Q7h+AJaH2/g+zpaDjiyDQUiuTFsW8zRTDt8TUvGAca5TZlXQ/
 2ZAZqyGguUDJcML5EmVSCFeuFTyW4T4bdCbBx8M3e8R/gbXeEFQBDE51bmqcMcqLs1A+
 ol5n3/XePyBwIeLcZdeIk8c+QgnQ/M53wZ9pEnSh+589N2DNiySg515uSV5aRZ4l8zjp
 ZV/b6RcB85IA1aNxszu/AQ/pg+aWO3eleIFhOSZWRjuJcOVDOJsCGIeR+XlYmjzmiEvI
 WBuQtPX6MWB59O6BEEQi0AlDrtrkJjUcw1gWt124bTWaEV+JSp91zDpiZdMAObyxLY4V fA== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
        by mx0b-0014ca01.pphosted.com with ESMTP id 332xxx6ntc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Aug 2020 00:44:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JITeFZR9mpzN2h+J4yjZAtlVEp7rg21cdwGfZ01f6Bo9XgSxlv1pCbwMgYFbmeKk3ZnTX37xpI9A6GuMj0+JenYeaVV+zkKFk+lERiC1WTyNQc7yF+Ji3FQCadJrHC8VvrOAtjUXNI4W//40+YE4xO4Yle3SbkRpGkWfvTK9etmPeNGzgZd5brvPmWejxkoZXNYD41exSiMs7FYLpE8bOcc8MrFemwYjw7uniYUubyzEd835RAcG3KQ1MgB6zEE++jkcowY2TjDKjjUJtxioLC8qDwAB632QDqqSgx4iJZBZsvUv2MHLVi7S1AVvRFaKHxVH+Zqo0i5h5AtgvluGuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bn0e7pp5z+AU/74ciSETE4v1mN49q4Cr4d7uEnG5gBg=;
 b=lv1ZcYo5vi2+Np2s6t2aclrhWfvdi8deGfPl/xudoE4qn1AQ5+6TmFzh89aklnFH/or32p4XVqXNSmADsFR7T6tLupKGiJIYtR6CJS5wN23HQfXjdAFnA2Aap8MKKZXiP4MoihUK0iAhnZ9enQso4Zsiuxn79e6BY2LFXw/NQVOSDSRJYh+GK3/3r/Rp52DBwDBSXpZw02LGOJSJ6o8kN0QrVaUWNYlIZm5VwtBdjN9DeK24WvOpZMfUl4y/QNSVVmx1EcWILaE6MRj/LckErCcjyRsnTwxaUf3/ZadbqgHGly5/TQdxzzg6hCz2rkQ1Vw1FYqtY7BGfaH5/aZIUjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bn0e7pp5z+AU/74ciSETE4v1mN49q4Cr4d7uEnG5gBg=;
 b=yAIf9uKKVX9JFT6eIPGGHNGICD2+GAEYr1mhLkNhDRxHgCf9hZSRlCscK9Q4Vx8m/3D72nxflcMqsKxUNchdrJmRo7vuPa5LvgnD6UWTCTJiwaVMQ/jogNc55TZJkoUH4U+FrXP9Zdq4OAHesEuLqaaK4qtntnbwx+KB3S0vgd0=
Received: from DM6PR07MB5529.namprd07.prod.outlook.com (2603:10b6:5:7a::30) by
 DM5PR07MB3098.namprd07.prod.outlook.com (2603:10b6:3:ea::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3305.25; Wed, 26 Aug 2020 07:44:45 +0000
Received: from DM6PR07MB5529.namprd07.prod.outlook.com
 ([fe80::35cf:ffb3:3776:8362]) by DM6PR07MB5529.namprd07.prod.outlook.com
 ([fe80::35cf:ffb3:3776:8362%4]) with mapi id 15.20.3305.026; Wed, 26 Aug 2020
 07:44:45 +0000
From:   Pawel Laszczak <pawell@cadence.com>
To:     Peter Chen <peter.chen@nxp.com>
CC:     Roger Quadros <rogerq@ti.com>,
        "balbi@kernel.org" <balbi@kernel.org>,
        Rahul Kumar <kurahul@cadence.com>,
        "nsekhar@ti.com" <nsekhar@ti.com>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH 3/3] usb: cdns3: Enable workaround for USB2.0 PHY Rx
 compliance test PHY lockup
Thread-Topic: [PATCH 3/3] usb: cdns3: Enable workaround for USB2.0 PHY Rx
 compliance test PHY lockup
Thread-Index: AQHWetduJTzcjYjglUaGSk5K6slNnalJuioAgAALt3CAADYFAIAAAhIQ
Date:   Wed, 26 Aug 2020 07:44:45 +0000
Message-ID: <DM6PR07MB5529EB2FB7E3380321191B44DD540@DM6PR07MB5529.namprd07.prod.outlook.com>
References: <20200825120059.12436-1-rogerq@ti.com>
 <20200825120059.12436-4-rogerq@ti.com> <20200826031948.GA7646@b29397-desktop>
 <DM6PR07MB5529A43AFDEB25993595DB59DD540@DM6PR07MB5529.namprd07.prod.outlook.com>
 <20200826071504.GA19661@b29397-desktop>
In-Reply-To: <20200826071504.GA19661@b29397-desktop>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccGF3ZWxsXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctMDA1ODAxZGItZTc3MC0xMWVhLTg3NjktMWM0ZDcwMWRmYmE0XGFtZS10ZXN0XDAwNTgwMWRjLWU3NzAtMTFlYS04NzY5LTFjNGQ3MDFkZmJhNGJvZHkudHh0IiBzej0iNTU1MCIgdD0iMTMyNDI5MDE0ODI3MDMzNTIzIiBoPSJXN01QWnRMRDhTMkt3NHRKaVl4TE9OQ21YR1k9IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-rorf: true
authentication-results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=cadence.com;
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c7f4e8b6-484c-4b60-d8ff-08d84993e6a2
x-ms-traffictypediagnostic: DM5PR07MB3098:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR07MB3098E5FFB9C4B0FDA0B2DFBBDD540@DM5PR07MB3098.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mS0/1GvJ76nt4/5c0EbWFrEuruZo7ciyxCVT/lUmcgVawx4OFfsCBkpb7ZHZzr2igTe48X22qZYBoQepbzRtbNrRsxMqkcwngQvX93+0x1jFYA6VtAZBtraJRI/BVtQuNy7jKkTXJ3wfD276PrMY3ENbIq3bo9FyGcYWaK4eOWf8poSolIYzzBFmsas+VQieISlPZozyfhtuatpLAq4l6WNQcT2JFWNQVI9voSETLEHtOm/Y0iC2C+H/WGeJle2XMLiITE3C7ead7A2F8RrrCneTxDI/nF+iOPnNfYBHeK48xt4GjXuTDdghrMgI2pfU00mUnauFlYJU616DoGDpaTuUVXvlxN/q+5TBrG1Xfu7yldbnXEVt2kbZEAUcUvNp
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR07MB5529.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(396003)(376002)(366004)(346002)(36092001)(8936002)(2906002)(9686003)(186003)(52536014)(5660300002)(6506007)(55016002)(33656002)(66946007)(66556008)(4326008)(66476007)(76116006)(64756008)(66446008)(7696005)(26005)(6916009)(83380400001)(478600001)(8676002)(86362001)(54906003)(316002)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: WMilmtWBHdhvwHWuLtJdaQnhOoeqJBNeit9OuFCUhiXvHzM89d27IiRrDuiNSyg9u4FsXdFb5QMNab9iq/qiGLJKEwK5e7NLCplyF6UbvR9jg7CcnDZUiaHcauQ+WJOkGtf/AUhniQ3Q4W1iAEIdb8IyzlBKga735CjlV0xVYM1DmW6VXqDsZFg+WlKmP7Xv8cJn2gOcpeb4k2ieNTYxFmksL8HGeZ54zYgRnJlKwP8c1lVyBtQegCDGUal9uNE4EMHnL+5OYXNJhYVKLyyap56IacN3+IQUZN3CZJvyfyv2BfrDCm5MRYQTWKvT6kFIH5PNOjARxZ+JzOI+ixHJWfTN2Tt6hbUpGzKrAJ6EPJfSSR5AFpkZgy9Zo9HlS+lUpAy1xL3APr7CQIZb9TmylmgOgA4TVtWB2jU6wsrabSUt2R6LDNbpbpJUK1gPeCiO+f0xaoEJYo1XphdM8oUbLnyC+D6ml1rbYQlCE2zRSrcqj4pRlO8sY8QhcrOOSiU+oMZ2wxX9IMpO/pFG7mAVO9EhM5AGJQGRl5fVT6oZOMUhcGp0MTPXbfHC0ae4c1HeFbfQuOl2dP+WUxJhdq0YheiF5opFr7QoFAN2sM3oor6zhxevXmBoW0oHYi1VBm2LX+293V1lz5cuTnxm4Tko/w==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR07MB5529.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7f4e8b6-484c-4b60-d8ff-08d84993e6a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2020 07:44:45.0637
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L0DOChMfmSm9Ns1dNuoHR2VUAk/pzxkdjfZVYogqpO1OvHSKBFjku1TeTN/535YbQ7+1O9jvlUlfZgmSCJuYCqWWoVInrmhIxHbrfKt14t4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR07MB3098
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-26_03:2020-08-25,2020-08-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 bulkscore=0
 adultscore=0 phishscore=0 impostorscore=0 lowpriorityscore=0
 mlxlogscore=999 spamscore=0 clxscore=1015 mlxscore=0 suspectscore=0
 malwarescore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2008260060
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>
>On 20-08-26 04:04:01, Pawel Laszczak wrote:
>> >On 20-08-25 15:00:59, Roger Quadros wrote:
>> >> From: Pawel Laszczak <pawell@cadence.com>
>> >>
>> >> USB2.0 PHY hangs in Rx Compliance test when the incoming packet
>> >> amplitude is varied below and above the Squelch Level of
>> >> Receiver during the active packet multiple times.
>> >>
>> >> Version 1 of the controller allows PHY to be reset when RX fail condi=
tion
>> >> is detected to work around the above issue. This feature is
>> >> disabled by default and needs to be enabled using a bit from
>> >> the newly added PHYRST_CFG register. This patch enables the workaroun=
d.
>> >>
>> >> As there is no way to distinguish between the controller version
>> >> before the device controller is started we need to rely on a
>> >> DT property to decide when to apply the workaround.
>> >
>> >Pawel, it could know the controller version at cdns3_gadget_start,
>> >but the controller starts when it tries to bind gadget driver, at that
>> >time, it has already known the controller version.
>> >
>> >For me, the device controller starts is using USB_CONF.DEVEN (Device
>> >Enable) through usb_gadget_connect, I am not sure if it is the same
>> >with yours.
>> >
>>
>> Yes in device mode driver knows controller version but this workaround
>> Must be enabled also in host mode. In host mode the controller
>> doesn't have access to device registers. The controller version is
>> placed in device register.
>>
>
>You may suggest your design team adding CHIP_VER register at global
>register region, it will easy the software engineer life.
>
>From what I read, this register is only enabling USB2 PHY reset software
>control, it needs for all chips with rev 0x0002450D, and the place you
>current change is only for 0x0002450D, right?

Even I could say that this workaround should be enabled only for=20
Specific USB2 PHY  (only 0x0002450D)

This bit should not have any impact for Cadence PHY but it can has=20
Impact for third party PHYs.
=20
Pawel

>
>Peter
>
>> Pawel
>>
>> >Peter
>> >
>> >
>> >>
>> >> Signed-off-by: Pawel Laszczak <pawell@cadence.com>
>> >> Signed-off-by: Roger Quadros <rogerq@ti.com>
>> >> ---
>> >>  drivers/usb/cdns3/core.c |  2 ++
>> >>  drivers/usb/cdns3/core.h |  1 +
>> >>  drivers/usb/cdns3/drd.c  | 12 ++++++++++++
>> >>  drivers/usb/cdns3/drd.h  |  5 ++++-
>> >>  4 files changed, 19 insertions(+), 1 deletion(-)
>> >>
>> >> diff --git a/drivers/usb/cdns3/core.c b/drivers/usb/cdns3/core.c
>> >> index 5c1586ec7824..34b36487682b 100644
>> >> --- a/drivers/usb/cdns3/core.c
>> >> +++ b/drivers/usb/cdns3/core.c
>> >> @@ -443,6 +443,8 @@ static int cdns3_probe(struct platform_device *pd=
ev)
>> >>  		return -ENXIO;
>> >>  	}
>> >>
>> >> +	cdns->phyrst_a_enable =3D device_property_read_bool(dev, "cdns,phyr=
st-a-enable");
>> >> +
>> >>  	cdns->otg_res =3D *res;
>> >>
>> >>  	mutex_init(&cdns->mutex);
>> >> diff --git a/drivers/usb/cdns3/core.h b/drivers/usb/cdns3/core.h
>> >> index 1ad1f1fe61e9..24cf0f1b5726 100644
>> >> --- a/drivers/usb/cdns3/core.h
>> >> +++ b/drivers/usb/cdns3/core.h
>> >> @@ -76,6 +76,7 @@ struct cdns3 {
>> >>  #define CDNS3_CONTROLLER_V0	0
>> >>  #define CDNS3_CONTROLLER_V1	1
>> >>  	u32				version;
>> >> +	bool				phyrst_a_enable;
>> >>
>> >>  	int				otg_irq;
>> >>  	int				dev_irq;
>> >> diff --git a/drivers/usb/cdns3/drd.c b/drivers/usb/cdns3/drd.c
>> >> index 6234bcd6158a..b74803e9703d 100644
>> >> --- a/drivers/usb/cdns3/drd.c
>> >> +++ b/drivers/usb/cdns3/drd.c
>> >> @@ -42,6 +42,18 @@ int cdns3_set_mode(struct cdns3 *cdns, enum usb_dr=
_mode mode)
>> >>  			reg =3D readl(&cdns->otg_v1_regs->override);
>> >>  			reg |=3D OVERRIDE_IDPULLUP;
>> >>  			writel(reg, &cdns->otg_v1_regs->override);
>> >> +
>> >> +			/*
>> >> +			 * Enable work around feature built into the
>> >> +			 * controller to address issue with RX Sensitivity
>> >> +			 * est (EL_17) for USB2 PHY. The issue only occures
>> >> +			 * for 0x0002450D controller version.
>> >> +			 */
>> >> +			if (cdns->phyrst_a_enable) {
>> >> +				reg =3D readl(&cdns->otg_v1_regs->phyrst_cfg);
>> >> +				reg |=3D PHYRST_CFG_PHYRST_A_ENABLE;
>> >> +				writel(reg, &cdns->otg_v1_regs->phyrst_cfg);
>> >> +			}
>> >>  		} else {
>> >>  			reg =3D readl(&cdns->otg_v0_regs->ctrl1);
>> >>  			reg |=3D OVERRIDE_IDPULLUP_V0;
>> >> diff --git a/drivers/usb/cdns3/drd.h b/drivers/usb/cdns3/drd.h
>> >> index 7e7cf7fa2dd3..f1ccae285a16 100644
>> >> --- a/drivers/usb/cdns3/drd.h
>> >> +++ b/drivers/usb/cdns3/drd.h
>> >> @@ -31,7 +31,7 @@ struct cdns3_otg_regs {
>> >>  	__le32 simulate;
>> >>  	__le32 override;
>> >>  	__le32 susp_ctrl;
>> >> -	__le32 reserved4;
>> >> +	__le32 phyrst_cfg;
>> >>  	__le32 anasts;
>> >>  	__le32 adp_ramp_time;
>> >>  	__le32 ctrl1;
>> >> @@ -153,6 +153,9 @@ struct cdns3_otg_common_regs {
>> >>  /* Only for CDNS3_CONTROLLER_V0 version */
>> >>  #define OVERRIDE_IDPULLUP_V0		BIT(24)
>> >>
>> >> +/* PHYRST_CFG - bitmasks */
>> >> +#define PHYRST_CFG_PHYRST_A_ENABLE     BIT(0)
>> >> +
>> >>  #define CDNS3_ID_PERIPHERAL		1
>> >>  #define CDNS3_ID_HOST			0
>> >>
>> >> --
>> >> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
>> >> Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
>> >>
>> >
>> >--
>> >
>> >Thanks,
>> >Peter Chen
>
>--
>
>Thanks,
>Peter Chen
