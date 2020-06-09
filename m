Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DD56C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 16:02:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8D9B2072F
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 16:02:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b="iP8V2/Wv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731075AbgFIQCe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 12:02:34 -0400
Received: from mx0b-00154904.pphosted.com ([148.163.137.20]:63624 "EHLO
        mx0b-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728888AbgFIQCc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 12:02:32 -0400
Received: from pps.filterd (m0170394.ppops.net [127.0.0.1])
        by mx0b-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 059G0xkQ012756;
        Tue, 9 Jun 2020 12:02:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=U6N+TzAmWKQjj3h7+PuFl112p0HEZr29XppJBd7yFas=;
 b=iP8V2/WvbBcFA5PpIT9N0UEK5pnCIxPr3ZhMxrKGxpsi89BnZfrk69SpdnLSdiEdhj3A
 YKs8GGUx9f5/R1gG5Fyeemm4XQurjUNEGKl+XcjQ/fZ4tl6kipkT1VBlb6qiQXUcm7Du
 iOxcb6p3e2yURq/YpPLqYlcY1FW/u4HQeNz1nKmJ5yPpkt1WILWAvbW8jmxe+Nnd+axz
 Vdn/M/8EGQX3DJIL6Kc8loz7RXgu+JgEWscUGuA/0RA3Xv2Iv2+A20q+aiX/t8gZv8iS
 u+W+92Nb2gKyW/S8D8ZI7rr6p4v0viV9xcUDvCIxzPO6oymZIbpKBO0St/ccZdKAXCCG mg== 
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com [67.231.157.37])
        by mx0b-00154904.pphosted.com with ESMTP id 31g5q5st1g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 Jun 2020 12:02:31 -0400
Received: from pps.filterd (m0134318.ppops.net [127.0.0.1])
        by mx0a-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 059FwCro150426;
        Tue, 9 Jun 2020 12:02:31 -0400
Received: from ausxippc110.us.dell.com (AUSXIPPC110.us.dell.com [143.166.85.200])
        by mx0a-00154901.pphosted.com with ESMTP id 31jbqe2p86-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 09 Jun 2020 12:02:31 -0400
X-LoopCount0: from 10.166.132.131
X-PREM-Routing: D-Outbound
X-IronPort-AV: E=Sophos;i="5.60,349,1549951200"; 
   d="scan'208";a="951522519"
From:   <Mario.Limonciello@dell.com>
To:     <y.linux@paritcher.com>, <pali@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>, <mjg59@srcf.ucam.org>
Subject: RE: [PATCH v3 1/3] platform/x86: dell-wmi: add new backlight events
Thread-Topic: [PATCH v3 1/3] platform/x86: dell-wmi: add new backlight events
Thread-Index: AQHWPhGJPOp+TcXPeEephfzyP1MhbqjQcnIw
Date:   Tue, 9 Jun 2020 16:02:28 +0000
Message-ID: <29f57822df4e45f192b72c6151f4697c@AUSX13MPC105.AMER.DELL.COM>
References: <cover.1591584631.git.y.linux@paritcher.com>
 <cover.1591673143.git.y.linux@paritcher.com>
 <50885a0c51c6fb31d20ddeb7434572448f1453be.1591673143.git.y.linux@paritcher.com>
In-Reply-To: <50885a0c51c6fb31d20ddeb7434572448f1453be.1591673143.git.y.linux@paritcher.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Mario_Limonciello@Dell.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2020-06-09T16:02:15.5982214Z;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Name=External Public;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_ActionId=6d82cfdf-b66e-4bb6-b9dd-68e72214b874;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Extended_MSFT_Method=Manual
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [143.166.24.40]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-09_10:2020-06-09,2020-06-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 bulkscore=0 cotscore=-2147483648 mlxscore=0
 mlxlogscore=999 spamscore=0 malwarescore=0 phishscore=0 adultscore=0
 impostorscore=0 clxscore=1015 lowpriorityscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006090121
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 malwarescore=0 adultscore=0 phishscore=0 bulkscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006090121
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Y Paritcher <y.linux@paritcher.com>
> Sent: Monday, June 8, 2020 10:53 PM
> To: Pali Roh=E1r
> Cc: linux-kernel@vger.kernel.org; platform-driver-x86@vger.kernel.org;
> Matthew Garrett; Limonciello, Mario
> Subject: [PATCH v3 1/3] platform/x86: dell-wmi: add new backlight events
>=20
>=20
> [EXTERNAL EMAIL]
>=20
> Add events with a type of 0x0010 and a code of 0x57 / 0x58,
> this silences the following messages being logged on a
> Dell Inspiron 5593:
>=20
> dell_wmi: Unknown key with type 0x0010 and code 0x0057 pressed
> dell_wmi: Unknown key with type 0x0010 and code 0x0058 pressed
>=20
> These are brightness events and will be handled by acpi-video
>=20
> Signed-off-by: Y Paritcher <y.linux@paritcher.com>

Reviewed-by: Mario Limonciello <mario.limonciello@dell.com>

> ---
>  drivers/platform/x86/dell-wmi.c | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/drivers/platform/x86/dell-wmi.c b/drivers/platform/x86/dell-
> wmi.c
> index c25a4286d766..0b2edfe2767d 100644
> --- a/drivers/platform/x86/dell-wmi.c
> +++ b/drivers/platform/x86/dell-wmi.c
> @@ -255,6 +255,10 @@ static const struct key_entry
> dell_wmi_keymap_type_0010[] =3D {
>  	/* Keyboard backlight change notification */
>  	{ KE_IGNORE, 0x3f, { KEY_RESERVED } },
>=20
> +	/* Backlight brightness level */
> +	{ KE_KEY,    0x57, { KEY_BRIGHTNESSDOWN } },
> +	{ KE_KEY,    0x58, { KEY_BRIGHTNESSUP } },
> +
>  	/* Mic mute */
>  	{ KE_KEY, 0x150, { KEY_MICMUTE } },
>=20
> --
> 2.27.0

