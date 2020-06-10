Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AB6AC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 15:49:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71F1C206C3
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 15:49:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b="DhA1ji1D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730411AbgFJPty (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 11:49:54 -0400
Received: from mx0b-00154904.pphosted.com ([148.163.137.20]:32512 "EHLO
        mx0b-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730402AbgFJPtu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 11:49:50 -0400
Received: from pps.filterd (m0170398.ppops.net [127.0.0.1])
        by mx0b-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05AFnn2B023572;
        Wed, 10 Jun 2020 11:49:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=VxCtL6Suz5Xe3eL6d/IKoLVc/dKygQfzxziqffkwIwc=;
 b=DhA1ji1DOr9LVQIsCOKynz5/DmNhPVKofaU3c1Wivvw0u4Zzf9A620bLRnwQ8aRTf8Sa
 EHygcF6/u1x+bw4WA/ix4jIlG4pfl85ccMxduQbp4uWK7/T6SMPikb7hS89ymBLeOb1C
 ZwFq7wv2Ha1TjHkp0pYbc/7Yby3umbiBWjcJaxoshQ/libuRZXK6AUPhu36r1RPEo/mT
 p8RxPQzYdRq5BSo4QxZxokxw6k7kWcfiqFxF+AqwvmW0Ylo8lRtGFXhclfwoJFSbFvAO
 uDkYoOGlwMg2GwktY9WG2LI8D4i19UNMCNeEoxOicLEn6jEU631zJcwD6ZTPIADD8WIF 0A== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
        by mx0b-00154904.pphosted.com with ESMTP id 31jjrg3ekq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 Jun 2020 11:49:49 -0400
Received: from pps.filterd (m0133268.ppops.net [127.0.0.1])
        by mx0a-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05AFmZ5K008538;
        Wed, 10 Jun 2020 11:49:40 -0400
Received: from ausxipps310.us.dell.com (AUSXIPPS310.us.dell.com [143.166.148.211])
        by mx0a-00154901.pphosted.com with ESMTP id 31jv196qhv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Jun 2020 11:49:40 -0400
X-LoopCount0: from 10.166.132.132
X-PREM-Routing: D-Outbound
X-IronPort-AV: E=Sophos;i="5.60,349,1549951200"; 
   d="scan'208";a="510127678"
From:   <Mario.Limonciello@dell.com>
To:     <kai.heng.feng@canonical.com>, <alex.hung@canonical.com>
CC:     <dvhart@infradead.org>, <andy@infradead.org>,
        <platform-driver-x86@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] platform/x86: intel-hid: Use hp-wireless for rfkill on HP
 platforms
Thread-Topic: [PATCH] platform/x86: intel-hid: Use hp-wireless for rfkill on
 HP platforms
Thread-Index: AQHWPz3dlpIDtGIT702KohBct4fb0ajR/puQ
Date:   Wed, 10 Jun 2020 15:49:37 +0000
Message-ID: <4d0714fe5e2548b6b638ea447ad19490@AUSX13MPC105.AMER.DELL.COM>
References: <20200610153747.27040-1-kai.heng.feng@canonical.com>
In-Reply-To: <20200610153747.27040-1-kai.heng.feng@canonical.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Mario_Limonciello@Dell.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2020-06-10T15:49:24.9564126Z;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Name=External Public;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_ActionId=96e5f15a-fc2b-4f05-8df2-8e4fcacff05d;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Extended_MSFT_Method=Manual
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [143.166.24.40]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-10_10:2020-06-10,2020-06-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 impostorscore=0 suspectscore=0 mlxlogscore=999 clxscore=1015 mlxscore=0
 bulkscore=0 adultscore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501
 phishscore=0 cotscore=-2147483648 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006100119
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 phishscore=0
 bulkscore=0 suspectscore=0 spamscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006100119
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: platform-driver-x86-owner@vger.kernel.org <platform-driver-x86-
> owner@vger.kernel.org> On Behalf Of Kai-Heng Feng
> Sent: Wednesday, June 10, 2020 10:38 AM
> To: alex.hung@canonical.com
> Cc: Kai-Heng Feng; Darren Hart; Andy Shevchenko; open list:INTEL HID EVEN=
T
> DRIVER; open list
> Subject: [PATCH] platform/x86: intel-hid: Use hp-wireless for rfkill on H=
P
> platforms
>=20
>=20
> [EXTERNAL EMAIL]
>=20
> Wireless hotkey on HP platforms can trigger two events, if both
> hp-wireless and intel-hid are supported. Two events at the same time
> renders wireless hotkey useless.
>=20
> HP confirmed that hp-wireless (HPQ6001) should always be the canonical
> source of wireless hotkey event, so skip registering rfkill hotkey if
> HPQ6001 is present.
>=20
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
>  drivers/platform/x86/intel-hid.c | 31 ++++++++++++++++++++++++++++++-
>  1 file changed, 30 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/platform/x86/intel-hid.c b/drivers/platform/x86/inte=
l-
> hid.c
> index 9ee79b74311c..31091c8faf70 100644
> --- a/drivers/platform/x86/intel-hid.c
> +++ b/drivers/platform/x86/intel-hid.c
> @@ -25,6 +25,8 @@ static const struct acpi_device_id intel_hid_ids[] =3D =
{
>  };
>  MODULE_DEVICE_TABLE(acpi, intel_hid_ids);
>=20
> +static bool hp_wireless_present;
> +
>  /* In theory, these are HID usages. */
>  static const struct key_entry intel_hid_keymap[] =3D {
>  	/* 1: LSuper (Page 0x07, usage 0xE3) -- unclear what to do */
> @@ -49,6 +51,29 @@ static const struct key_entry intel_hid_keymap[] =3D {
>  	{ KE_END },
>  };
>=20
> +static const struct key_entry intel_hid_no_rfkill_keymap[] =3D {
> +	/* 1: LSuper (Page 0x07, usage 0xE3) -- unclear what to do */
> +	/* 2: Toggle SW_ROTATE_LOCK -- easy to implement if seen in wild */
> +	{ KE_KEY, 3, { KEY_NUMLOCK } },
> +	{ KE_KEY, 4, { KEY_HOME } },
> +	{ KE_KEY, 5, { KEY_END } },
> +	{ KE_KEY, 6, { KEY_PAGEUP } },
> +	{ KE_KEY, 7, { KEY_PAGEDOWN } },
> +	/* 8: rfkill -- use hp-wireless instead */
> +	{ KE_KEY, 9, { KEY_POWER } },
> +	{ KE_KEY, 11, { KEY_SLEEP } },
> +	/* 13 has two different meanings in the spec -- ignore it. */
> +	{ KE_KEY, 14, { KEY_STOPCD } },
> +	{ KE_KEY, 15, { KEY_PLAYPAUSE } },
> +	{ KE_KEY, 16, { KEY_MUTE } },
> +	{ KE_KEY, 17, { KEY_VOLUMEUP } },
> +	{ KE_KEY, 18, { KEY_VOLUMEDOWN } },
> +	{ KE_KEY, 19, { KEY_BRIGHTNESSUP } },
> +	{ KE_KEY, 20, { KEY_BRIGHTNESSDOWN } },
> +	/* 27: wake -- needs special handling */
> +	{ KE_END },
> +};
> +
>  /* 5 button array notification value. */
>  static const struct key_entry intel_array_keymap[] =3D {
>  	{ KE_KEY,    0xC2, { KEY_LEFTMETA } },                /* Press */
> @@ -317,7 +342,8 @@ static int intel_hid_input_setup(struct platform_devi=
ce
> *device)
>  	if (!priv->input_dev)
>  		return -ENOMEM;
>=20
> -	ret =3D sparse_keymap_setup(priv->input_dev, intel_hid_keymap, NULL);
> +	ret =3D sparse_keymap_setup(priv->input_dev, hp_wireless_present ?
> +			intel_hid_no_rfkill_keymap : intel_hid_keymap, NULL);
>  	if (ret)
>  		return ret;
>=20
> @@ -575,6 +601,9 @@ check_acpi_dev(acpi_handle handle, u32 lvl, void
> *context, void **rv)
>  			dev_info(&dev->dev,
>  				 "intel-hid: created platform device\n");
>=20
> +	if (!strcmp(acpi_device_hid(dev), "HPQ6001"))
> +		hp_wireless_present =3D true;

Just having the ACPI device present doesn't actually mean that the user
has a kernel compiled with hp-wireless or that it has finished initializing=
.

I would think this needs a better handshake in case hp-wireless was unloade=
d
or not present so the event could still come through intel-hid in this
circumstance.

> +
>  	return AE_OK;
>  }
>=20
> --
> 2.17.1

