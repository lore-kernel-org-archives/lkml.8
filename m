Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B014DC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 17:29:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F5892053B
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 17:29:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b="o+5DqX7y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389939AbgEMR3O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 13:29:14 -0400
Received: from mx0a-00154904.pphosted.com ([148.163.133.20]:52900 "EHLO
        mx0a-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732731AbgEMR3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 13:29:14 -0400
Received: from pps.filterd (m0170393.ppops.net [127.0.0.1])
        by mx0a-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04DHRtbd028625;
        Wed, 13 May 2020 13:29:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=GX5YiRg/XzPDU36/WqAG9JH8yimm4qRaDdHGa1EX1y0=;
 b=o+5DqX7y+WkUX3gieAA24OwhbiHhy1PqLHE5iMh+b0sTE75tMpLJ0UtdbihBBSt0mHi5
 kEHQ11QD4M3QEN25etBKcluC+1GFCO2WelL7SLXYAcH0EGTbqFj3VrNdVyfzQy1Mz6DN
 +2IXrDeMnfLmYPNp9zC6N2mq+2+eplFAHwou/NnNQSzA/Bck2y/KOkW+T44RZ6GvpuFN
 L1i0zDbi4A9vrVkGsq0chCEpzErGiZrdbLca8mjzV4cLD8rzBTiMbQiQOwEtrQgFM5ps
 ry+EZqHpAuLaYp6H/NoMMB9OiIQKyhPesv2WCRyq7S7kR+VH0nXqK4TDObLm5rT17p19 DQ== 
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com [67.231.157.37])
        by mx0a-00154904.pphosted.com with ESMTP id 3100ydbbad-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 May 2020 13:29:13 -0400
Received: from pps.filterd (m0144102.ppops.net [127.0.0.1])
        by mx0b-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04DHINi8141306;
        Wed, 13 May 2020 13:29:12 -0400
Received: from ausxippc101.us.dell.com (ausxippc101.us.dell.com [143.166.85.207])
        by mx0b-00154901.pphosted.com with ESMTP id 310g2ywqrh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 May 2020 13:29:12 -0400
X-LoopCount0: from 10.166.132.132
X-PREM-Routing: D-Outbound
X-IronPort-AV: E=Sophos;i="5.60,346,1549951200"; 
   d="scan'208";a="1387297546"
From:   <Mario.Limonciello@dell.com>
To:     <hdegoede@redhat.com>, <dvhart@infradead.org>,
        <andy@infradead.org>, <pali@kernel.org>, <mjg59@srcf.ucam.org>
CC:     <platform-driver-x86@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] platform/x86: dell-wmi: Ignore keyboard attached /
 detached events
Thread-Topic: [PATCH] platform/x86: dell-wmi: Ignore keyboard attached /
 detached events
Thread-Index: AQHWKSdAVCuB+c4MP0SyuKY4d5/aeaimNMyA
Date:   Wed, 13 May 2020 17:29:11 +0000
Message-ID: <5242ea25f5c94a06beda838dba8c06ef@AUSX13MPC105.AMER.DELL.COM>
References: <20200513130544.90243-1-hdegoede@redhat.com>
In-Reply-To: <20200513130544.90243-1-hdegoede@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Mario_Limonciello@Dell.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2020-05-13T16:29:25.4413278Z;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Name=External Public;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_ActionId=5ae63eab-315c-4547-ba7e-203ae6867181;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Extended_MSFT_Method=Manual
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [143.166.24.60]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-13_08:2020-05-13,2020-05-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 clxscore=1015 cotscore=-2147483648 impostorscore=0
 mlxscore=0 phishscore=0 spamscore=0 priorityscore=1501 suspectscore=0
 bulkscore=0 adultscore=0 mlxlogscore=999 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005130150
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 mlxscore=0 spamscore=0
 bulkscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0 mlxlogscore=999
 phishscore=0 suspectscore=0 cotscore=-2147483648 clxscore=1015
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2005130151
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Hans de Goede <hdegoede@redhat.com>
> Sent: Wednesday, May 13, 2020 8:06 AM
> To: Darren Hart; Andy Shevchenko; Pali Roh=E1r; Matthew Garrett
> Cc: Hans de Goede; Limonciello, Mario; platform-driver-x86@vger.kernel.or=
g;
> linux-kernel@vger.kernel.org
> Subject: [PATCH] platform/x86: dell-wmi: Ignore keyboard attached / detac=
hed
> events
>=20
>=20
> [EXTERNAL EMAIL]
>=20
> Ignore events with a type of 0x0011 and a code of 0xfff2 / 0xfff3,
> this silences the following messages being logged when the keyboard is
> detached / attached on a Dell Venue 11 Pro 7130:
>=20
> [   63.621953] dell_wmi: Unknown key with type 0x0011 and code 0xfff2 pre=
ssed
> [   70.240558] dell_wmi: Unknown key with type 0x0011 and code 0xfff3 pre=
ssed
>=20
> Note SW_TABLET_MODE is already reported through the intel_vbtn driver on
> this and other Dell devices, so dell_wmi should not report this too,
> to avoid duplicate events.

If they didn't also come through on intel-vbtn I would have proposed that w=
e
should have a separate tablet mode switch coming from dell-wmi too.

As a general note the reason for these is that the WMI architecture on Wind=
ows
differs in that applications typically directly receive the events and do t=
hings
with them.

>=20
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/platform/x86/dell-wmi.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>=20
> diff --git a/drivers/platform/x86/dell-wmi.c b/drivers/platform/x86/dell-=
wmi.c
> index 86e8dd6a8b33..c25a4286d766 100644
> --- a/drivers/platform/x86/dell-wmi.c
> +++ b/drivers/platform/x86/dell-wmi.c
> @@ -310,6 +310,16 @@ static const struct key_entry dell_wmi_keymap_type_0=
011[]
> =3D {
>  	/* Battery inserted */
>  	{ KE_IGNORE, 0xfff1, { KEY_RESERVED } },
>=20
> +	/*
> +	 * Detachable keyboard detached / undocked
> +	 * Note SW_TABLET_MODE is already reported through the intel_vbtn
> +	 * driver for this, so we ignore it.
> +	 */
> +	{ KE_IGNORE, 0xfff2, { KEY_RESERVED } },
> +
> +	/* Detachable keyboard attached / docked */
> +	{ KE_IGNORE, 0xfff3, { KEY_RESERVED } },
> +
>  	/* Keyboard backlight level changed */
>  	{ KE_IGNORE, KBD_LED_OFF_TOKEN,      { KEY_RESERVED } },
>  	{ KE_IGNORE, KBD_LED_ON_TOKEN,       { KEY_RESERVED } },
> --
> 2.26.0

Reviewed-by: Mario Limonciello <Mario.limonciello@dell.com>
