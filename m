Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76665C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 04:04:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C9D920707
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 04:04:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="Q+b/LFgN";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="kU9QR20n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726240AbgHZEEN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 00:04:13 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:47956 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725267AbgHZEEM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 00:04:12 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07Q3xnOM001625;
        Tue, 25 Aug 2020 21:04:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=as6HPH4gjNMPWgOq+DyMvGn4RLyMXAMZdzqYPrxcC4Q=;
 b=Q+b/LFgNBElJw+VHBYMqpz7ZXM/2BPhmfIWtRFS88d6hAMUJz6T+CfTCIX2HuSzyNTTa
 1bWX2UVbsMfMsVq2u0W8YWgzJ72Li/MPWKD68WmUrkqTlCKVlTmsfD1oBRsE2mF0Y+tU
 ujoq4a0XlRKZuc2yfroaq+8C7/n3K678Gxu1HIvEFfFxvjdLXoLUbXobk5gJSj9XH5lv
 Q9TyghKSmXQI9lBHtbMeOf9uPOKT1R5EqSMgacpfDNKbTetojxxkH3WCxgXl4LAofAIF
 3OPj4GQ+A//SaGnulq0fLJ66fa2F3VXM1NLvxZk2OZRJnLGwpy4ejcNnlPEFvUjO9HRD iQ== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
        by mx0b-0014ca01.pphosted.com with ESMTP id 332xxx61my-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Aug 2020 21:04:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bx7+eKEGRcWOBxASaM1nDGXbuX7spcOMQB6PF/ByOl/0SpMTf58r7J34wTHhoJyG0zBW0B4ZleEvP3kUDob0OV4JhcAr0caFDxyX81PHDuz7m5V710V4AZ6ECYMjsy3DdbRIhOJMSCoGH26x+KdwhgLro+apwLiYgMh9RCzI8xRR7PHLvHAyjvdbmaGpe+sDSCKTxrhMcnEHgTwUyT/6WfNaFV//wKm9VgSmXE/4OU0oO2QQzW7s4iGDMhsDeLnqU2zH6lwLDIyzaH71xUyN/bSgIypvKSDT9UJQqTCjeAjDZ5AqYJTCPsRhWYMPYkid01Emr+lfSmfrWlSRz7I++w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=as6HPH4gjNMPWgOq+DyMvGn4RLyMXAMZdzqYPrxcC4Q=;
 b=XjDSZ8MghUxFxZjTTBOP1F9Cj/pRiRjIk9D4dioteylYBB73+irSWdu+PCgN2KJoqbWEDSpxu2Fs1361K7LZYjHk/u4nJabFzUv472B6UDVFeHl30aGj4NhiKJPcP05ZwPJQ5zpLkNw9r/h2E8hxH/j1PKueHsuoth/zBG8ED4LZHW14QzLSGE0pLGqrUv6QE/V6lhIlQadKmG3Y4chw7DFHggoKt3rY5Vj4OaWtlbb/y6bCT1TzX6Et7RGeHXavxRUasRU5Gt/FOkR0/DHc44xl/W+FAESOO/KWYc0QhPUeWH5bDX07ydeW5dapqNWWsgsW2aKQrQugCTo0+FhWBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=as6HPH4gjNMPWgOq+DyMvGn4RLyMXAMZdzqYPrxcC4Q=;
 b=kU9QR20n6MyHEUsn+oZnrfq9NL0Zd8yyo88Js1E9bdY4nd1BMZJee1D8Pz7e6SGbisPtTLeqOJRsanM12MIwW39G5jv6wG3KHuCeD1LB2pOQm6gycfJXcx7d6/gSo15jVtX+Cc2b3o9P1lh3gLfJ9euIJE0bBfzHjNe6wgVFIJw=
Received: from DM6PR07MB5529.namprd07.prod.outlook.com (2603:10b6:5:7a::30) by
 DS7PR07MB7638.namprd07.prod.outlook.com (2603:10b6:5:2d1::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3305.26; Wed, 26 Aug 2020 04:04:01 +0000
Received: from DM6PR07MB5529.namprd07.prod.outlook.com
 ([fe80::35cf:ffb3:3776:8362]) by DM6PR07MB5529.namprd07.prod.outlook.com
 ([fe80::35cf:ffb3:3776:8362%4]) with mapi id 15.20.3305.026; Wed, 26 Aug 2020
 04:04:01 +0000
From:   Pawel Laszczak <pawell@cadence.com>
To:     Peter Chen <peter.chen@nxp.com>, Roger Quadros <rogerq@ti.com>
CC:     "balbi@kernel.org" <balbi@kernel.org>,
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
Thread-Index: AQHWetduJTzcjYjglUaGSk5K6slNnalJuioAgAALt3A=
Date:   Wed, 26 Aug 2020 04:04:01 +0000
Message-ID: <DM6PR07MB5529A43AFDEB25993595DB59DD540@DM6PR07MB5529.namprd07.prod.outlook.com>
References: <20200825120059.12436-1-rogerq@ti.com>
 <20200825120059.12436-4-rogerq@ti.com> <20200826031948.GA7646@b29397-desktop>
In-Reply-To: <20200826031948.GA7646@b29397-desktop>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccGF3ZWxsXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctMmFiZmQ0NmUtZTc1MS0xMWVhLTg3NjktMWM0ZDcwMWRmYmE0XGFtZS10ZXN0XDJhYmZkNDcwLWU3NTEtMTFlYS04NzY5LTFjNGQ3MDFkZmJhNGJvZHkudHh0IiBzej0iNDUzMCIgdD0iMTMyNDI4ODgyMzkzOTEyODc2IiBoPSI3R0JleUQ2ODhOd0tvTkFjaWxJWE41QjNGL2M9IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-rorf: true
authentication-results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=cadence.com;
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 537956dc-ec1c-4ae0-0675-08d8497510bd
x-ms-traffictypediagnostic: DS7PR07MB7638:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DS7PR07MB7638FFDF32C7A54B9A7E0D58DD540@DS7PR07MB7638.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Llg6UcRnQL1nsdTV/Jur7ApxU8hhGEaqKFvRHWCpUeHZ1Uf3bOAviQr1f2QvCVDTIdK9ui+4eoDJlh5LMwSn4RMVtrciGjrXEmgtyU/UmqKCkJXvShYiSOaiNjzSFTXLcTK0EjBtyGUwFay1idtaRqk+R5VbCzl/0MuuzwENNZadQvW44x/Cf7hbqXc1vW5ZbgaTyjrifdgeNSS5goMmKWomh4jN7D6Gr4zo8xI5sWcaeEiNadX97Lrz/qmzEOAggg9Z1VF7+WgjuYqXBsSbBkyCs9qTU34BLuktHyC2k3bd5gBRCeVNav6zHXT4wtU9omv5AeBuy1+tWAeZf324Yos4lc7+x7GmGk65hpm0Q3ZrbKRRinHPGVj9yIZH5AXl
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR07MB5529.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39850400004)(346002)(376002)(136003)(396003)(366004)(36092001)(66946007)(86362001)(478600001)(33656002)(66476007)(76116006)(66446008)(26005)(66556008)(71200400001)(64756008)(83380400001)(6506007)(186003)(7696005)(8936002)(8676002)(4326008)(5660300002)(9686003)(55016002)(110136005)(2906002)(52536014)(54906003)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: /D1Tlv/d68we0EtxuhC2Gi8UmnA2BGrGVoaMvYnxEd8zUOkYD12f7MpydquNTLhlvSJA/uw7t2x914q0YKtNU1fVdBhx9BaSxoc6MYXamrc3qhiV6+l3WvwoBlDcxooRj9atdFru95YfOIQpqd4BGzrBrxtKANF0cntkbBKKshbyVWIaZIpXR43KMgRK0vb2XilbnOe8OP4XjAUP3jEOu9OD0C9b2Z/Ww3rN8U3kdFQA3t9DupiDJ0dc4zphfaWPjzADi+CIZlGjUFUt96vtpgbiEmL3Elh7zvuQM1Ew4dqa/IgDpLWg5OjWTFtc5WX7MIlCNNM3d8K4DahieiAuqdohyHNp8UuNkvDt5ho7LDvTUSv9K4R5O49G5s+1+1YvsW2lYF4AEArTCzjA3qXd6NrR94BDWZf2otXntGAZCFDVvEw7uW3HxxDuAGpiouTHPDdRXTgP1idMJChj6ZfxUhjagHAJ7EALcT78V9u3a4XBJlOYjfBe/MY/AuB2LF9ajN40/3qr5Tx/moxMYQT/MYP2E1gZQgE0/i2j3HBiFD12PJmA5BmL5idqgQn1P7yvBf3G/zV0DQFoXgse6gM0++YOlqa3XTQgUrPI2zrpKgxHwWG+7GnjDxCI0C0mefB18OflvDI6eafYjQxXDmhQAQ==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR07MB5529.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 537956dc-ec1c-4ae0-0675-08d8497510bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2020 04:04:01.2870
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dpEdDwwQKe2LOW4+idPwxQX2KWe3Sts6Xd4qZDe0PvCrJ30PeSQkMhJmgpBD43jMb7/TzjENb17mg3gBzAsHXsQhL1qjZHbHvKMoT84KKns=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR07MB7638
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-25_11:2020-08-25,2020-08-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 bulkscore=0
 adultscore=0 phishscore=0 impostorscore=0 lowpriorityscore=0
 mlxlogscore=999 spamscore=0 clxscore=1011 mlxscore=0 suspectscore=0
 malwarescore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2008260030
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>On 20-08-25 15:00:59, Roger Quadros wrote:
>> From: Pawel Laszczak <pawell@cadence.com>
>>
>> USB2.0 PHY hangs in Rx Compliance test when the incoming packet
>> amplitude is varied below and above the Squelch Level of
>> Receiver during the active packet multiple times.
>>
>> Version 1 of the controller allows PHY to be reset when RX fail conditio=
n
>> is detected to work around the above issue. This feature is
>> disabled by default and needs to be enabled using a bit from
>> the newly added PHYRST_CFG register. This patch enables the workaround.
>>
>> As there is no way to distinguish between the controller version
>> before the device controller is started we need to rely on a
>> DT property to decide when to apply the workaround.
>
>Pawel, it could know the controller version at cdns3_gadget_start,
>but the controller starts when it tries to bind gadget driver, at that
>time, it has already known the controller version.
>
>For me, the device controller starts is using USB_CONF.DEVEN (Device
>Enable) through usb_gadget_connect, I am not sure if it is the same
>with yours.
>

Yes in device mode driver knows controller version but this workaround=20
Must be enabled also in host mode. In host mode the controller=20
doesn't have access to device registers. The controller version is=20
placed in device register.

Pawel

>Peter
>
>
>>
>> Signed-off-by: Pawel Laszczak <pawell@cadence.com>
>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>> ---
>>  drivers/usb/cdns3/core.c |  2 ++
>>  drivers/usb/cdns3/core.h |  1 +
>>  drivers/usb/cdns3/drd.c  | 12 ++++++++++++
>>  drivers/usb/cdns3/drd.h  |  5 ++++-
>>  4 files changed, 19 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/usb/cdns3/core.c b/drivers/usb/cdns3/core.c
>> index 5c1586ec7824..34b36487682b 100644
>> --- a/drivers/usb/cdns3/core.c
>> +++ b/drivers/usb/cdns3/core.c
>> @@ -443,6 +443,8 @@ static int cdns3_probe(struct platform_device *pdev)
>>  		return -ENXIO;
>>  	}
>>
>> +	cdns->phyrst_a_enable =3D device_property_read_bool(dev, "cdns,phyrst-=
a-enable");
>> +
>>  	cdns->otg_res =3D *res;
>>
>>  	mutex_init(&cdns->mutex);
>> diff --git a/drivers/usb/cdns3/core.h b/drivers/usb/cdns3/core.h
>> index 1ad1f1fe61e9..24cf0f1b5726 100644
>> --- a/drivers/usb/cdns3/core.h
>> +++ b/drivers/usb/cdns3/core.h
>> @@ -76,6 +76,7 @@ struct cdns3 {
>>  #define CDNS3_CONTROLLER_V0	0
>>  #define CDNS3_CONTROLLER_V1	1
>>  	u32				version;
>> +	bool				phyrst_a_enable;
>>
>>  	int				otg_irq;
>>  	int				dev_irq;
>> diff --git a/drivers/usb/cdns3/drd.c b/drivers/usb/cdns3/drd.c
>> index 6234bcd6158a..b74803e9703d 100644
>> --- a/drivers/usb/cdns3/drd.c
>> +++ b/drivers/usb/cdns3/drd.c
>> @@ -42,6 +42,18 @@ int cdns3_set_mode(struct cdns3 *cdns, enum usb_dr_mo=
de mode)
>>  			reg =3D readl(&cdns->otg_v1_regs->override);
>>  			reg |=3D OVERRIDE_IDPULLUP;
>>  			writel(reg, &cdns->otg_v1_regs->override);
>> +
>> +			/*
>> +			 * Enable work around feature built into the
>> +			 * controller to address issue with RX Sensitivity
>> +			 * est (EL_17) for USB2 PHY. The issue only occures
>> +			 * for 0x0002450D controller version.
>> +			 */
>> +			if (cdns->phyrst_a_enable) {
>> +				reg =3D readl(&cdns->otg_v1_regs->phyrst_cfg);
>> +				reg |=3D PHYRST_CFG_PHYRST_A_ENABLE;
>> +				writel(reg, &cdns->otg_v1_regs->phyrst_cfg);
>> +			}
>>  		} else {
>>  			reg =3D readl(&cdns->otg_v0_regs->ctrl1);
>>  			reg |=3D OVERRIDE_IDPULLUP_V0;
>> diff --git a/drivers/usb/cdns3/drd.h b/drivers/usb/cdns3/drd.h
>> index 7e7cf7fa2dd3..f1ccae285a16 100644
>> --- a/drivers/usb/cdns3/drd.h
>> +++ b/drivers/usb/cdns3/drd.h
>> @@ -31,7 +31,7 @@ struct cdns3_otg_regs {
>>  	__le32 simulate;
>>  	__le32 override;
>>  	__le32 susp_ctrl;
>> -	__le32 reserved4;
>> +	__le32 phyrst_cfg;
>>  	__le32 anasts;
>>  	__le32 adp_ramp_time;
>>  	__le32 ctrl1;
>> @@ -153,6 +153,9 @@ struct cdns3_otg_common_regs {
>>  /* Only for CDNS3_CONTROLLER_V0 version */
>>  #define OVERRIDE_IDPULLUP_V0		BIT(24)
>>
>> +/* PHYRST_CFG - bitmasks */
>> +#define PHYRST_CFG_PHYRST_A_ENABLE     BIT(0)
>> +
>>  #define CDNS3_ID_PERIPHERAL		1
>>  #define CDNS3_ID_HOST			0
>>
>> --
>> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
>> Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
>>
>
>--
>
>Thanks,
>Peter Chen
