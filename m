Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF1AEC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 15:40:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96B0B2076C
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 15:40:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b="WGEwpOnh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730308AbgFHPk6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 11:40:58 -0400
Received: from mx0a-00154904.pphosted.com ([148.163.133.20]:21762 "EHLO
        mx0a-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729580AbgFHPk5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 11:40:57 -0400
Received: from pps.filterd (m0170393.ppops.net [127.0.0.1])
        by mx0a-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 058FcOCv015382;
        Mon, 8 Jun 2020 11:40:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=GdjjV04uTj4plvDmQK2ebOIYWApFMwZa482V7H0OgvE=;
 b=WGEwpOnhBAZWt0CCtMkK3Cf2Cy6WOOQU/x9PCaud+MBeBCLGPLf/dG/56rilYKwp668i
 D48My8MNUNfM0+GSlsG/NMqOPczC3Yzv6uGS45TthyYzNYn3fdGSSTz5P2EfSpHmdMUV
 tbYCK4FFpq/wH10QyjuRtm3ipGXdT5bspGOP4D6cceDlDYE63ETbnx1E1fvwQUKwyf1S
 lkOesh7zLv403u7wRj3S31g9veMBfgx9aoHbTPZsVfe1wgVd+zQcBnefhSj8qCOqnqPI
 nI8y3T7p0upgU/63wGgnqr3WvPhxHDCb2q49JkqDe4H6ZqdnWkWrCflqmbEBs4utLJzh ow== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
        by mx0a-00154904.pphosted.com with ESMTP id 31g6fhn42b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 Jun 2020 11:40:56 -0400
Received: from pps.filterd (m0142693.ppops.net [127.0.0.1])
        by mx0a-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 058FesCp143383;
        Mon, 8 Jun 2020 11:40:56 -0400
Received: from ausxipps306.us.dell.com (AUSXIPPS306.us.dell.com [143.166.148.156])
        by mx0a-00154901.pphosted.com with ESMTP id 31gb77ysft-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 08 Jun 2020 11:40:56 -0400
X-LoopCount0: from 10.166.132.127
X-PREM-Routing: D-Outbound
X-IronPort-AV: E=Sophos;i="5.73,487,1583215200"; 
   d="scan'208";a="475823595"
From:   <Mario.Limonciello@dell.com>
To:     <y.linux@paritcher.com>
CC:     <linux-kernel@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>, <mjg59@srcf.ucam.org>,
        <pali@kernel.org>
Subject: RE: [PATCH 2/3] platform/x86: dell-wmi: add new keymap type 0x0012
Thread-Topic: [PATCH 2/3] platform/x86: dell-wmi: add new keymap type 0x0012
Thread-Index: AQHWPUx5kZ6BCWcrZkepA13uOwTuTKjO2RsQ
Date:   Mon, 8 Jun 2020 15:40:53 +0000
Message-ID: <83fe431cacbc4708962767668ac8f06f@AUSX13MPC105.AMER.DELL.COM>
References: <cover.1591584631.git.y.linux@paritcher.com>
 <0dc191a3d16f0e114f6a8976433e248018e10c43.1591584631.git.y.linux@paritcher.com>
In-Reply-To: <0dc191a3d16f0e114f6a8976433e248018e10c43.1591584631.git.y.linux@paritcher.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Mario_Limonciello@Dell.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2020-06-08T15:40:51.2535670Z;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Name=External Public;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_ActionId=1b012f6a-8a0c-4e0d-bcbe-2b951b660378;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Extended_MSFT_Method=Manual
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [143.166.24.60]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-08_14:2020-06-08,2020-06-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=0
 adultscore=0 malwarescore=0 phishscore=0 impostorscore=0
 lowpriorityscore=0 mlxlogscore=999 priorityscore=1501 mlxscore=0
 clxscore=1015 bulkscore=0 cotscore=-2147483648 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006080114
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 spamscore=0 malwarescore=0 adultscore=0 phishscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006080114
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: platform-driver-x86-owner@vger.kernel.org <platform-driver-x86-
> owner@vger.kernel.org> On Behalf Of Y Paritcher
> Sent: Sunday, June 7, 2020 11:22 PM
> Cc: linux-kernel@vger.kernel.org; platform-driver-x86@vger.kernel.org;
> Matthew Garrett; Pali Roh=E1r
> Subject: [PATCH 2/3] platform/x86: dell-wmi: add new keymap type 0x0012
>=20
>=20
> [EXTERNAL EMAIL]
>=20
> Ignore events with a type of 0x0012 and a code of 0xe035,
> this silences the following messages being logged when
> pressing the Fn-lock key on a Dell Inspiron 5593:
>=20
> dell_wmi: Unknown WMI event type 0x12
> dell_wmi: Unknown key with type 0x0012 and code 0xe035 pressed

Event type 0x12 is for "System Events".  This is the type of events that
you typically would see come in for things "like" the wrong power adapter
being plugged in on Windows or stuff about plugging a Thunderbolt dock into
a port that doesn't support Thunderbolt.

A message might look something like (paraphrased)
"Your system requires a 180W power adapter to charge effectively, but you
plugged in a 60W adapter."

There often is extended data with these events.  As such I don't believe al=
l
information in event type 0x0012 should be treated like scan codes like tho=
se in
0x10 or 0x11.

I would guess that Fn-lock on this machine probably has extended data in th=
e next
showing whether it was turned on and off.  If it does, perhaps it makes sen=
se to
send this information to userspace as an evdev switch instead.

>=20
> Signed-off-by: Y Paritcher <y.linux@paritcher.com>
> ---
>  drivers/platform/x86/dell-wmi.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>=20
> diff --git a/drivers/platform/x86/dell-wmi.c b/drivers/platform/x86/dell-
> wmi.c
> index 0b4f72f923cd..f37e7e9093c2 100644
> --- a/drivers/platform/x86/dell-wmi.c
> +++ b/drivers/platform/x86/dell-wmi.c
> @@ -334,6 +334,14 @@ static const struct key_entry
> dell_wmi_keymap_type_0011[] =3D {
>  	{ KE_IGNORE, KBD_LED_AUTO_100_TOKEN, { KEY_RESERVED } },
>  };
>=20
> +/*
> + * Keymap for WMI events of type 0x0012
> + */
> +static const struct key_entry dell_wmi_keymap_type_0012[] =3D {
> +	/* Fn-lock button pressed */
> +	{ KE_IGNORE, 0xe035, { KEY_RESERVED } },
> +};
> +
>  static void dell_wmi_process_key(struct wmi_device *wdev, int type, int
> code)
>  {
>  	struct dell_wmi_priv *priv =3D dev_get_drvdata(&wdev->dev);
> @@ -425,6 +433,7 @@ static void dell_wmi_notify(struct wmi_device *wdev,
>  			break;
>  		case 0x0010: /* Sequence of keys pressed */
>  		case 0x0011: /* Sequence of events occurred */
> +		case 0x0012: /* Sequence of events occurred */
>  			for (i =3D 2; i < len; ++i)
>  				dell_wmi_process_key(wdev, buffer_entry[1],
>  						     buffer_entry[i]);
> @@ -556,6 +565,7 @@ static int dell_wmi_input_setup(struct wmi_device
> *wdev)
>  			 ARRAY_SIZE(dell_wmi_keymap_type_0000) +
>  			 ARRAY_SIZE(dell_wmi_keymap_type_0010) +
>  			 ARRAY_SIZE(dell_wmi_keymap_type_0011) +
> +			 ARRAY_SIZE(dell_wmi_keymap_type_0012) +
>  			 1,
>  			 sizeof(struct key_entry), GFP_KERNEL);
>  	if (!keymap) {
> @@ -600,6 +610,13 @@ static int dell_wmi_input_setup(struct wmi_device
> *wdev)
>  		pos++;
>  	}
>=20
> +	/* Append table with events of type 0x0012 */
> +	for (i =3D 0; i < ARRAY_SIZE(dell_wmi_keymap_type_0012); i++) {
> +		keymap[pos] =3D dell_wmi_keymap_type_0012[i];
> +		keymap[pos].code |=3D (0x0012 << 16);
> +		pos++;
> +	}
> +
>  	/*
>  	 * Now append also table with "legacy" events of type 0x0000. Some of
>  	 * them are reported also on laptops which have scancodes in DMI.
> --
> 2.27.0

