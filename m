Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FF7DC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 19:19:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 107F520727
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 19:19:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b="jK1tOwcA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726275AbgEOTTW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 15:19:22 -0400
Received: from mx0a-00154904.pphosted.com ([148.163.133.20]:57940 "EHLO
        mx0a-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726023AbgEOTTW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 15:19:22 -0400
Received: from pps.filterd (m0170393.ppops.net [127.0.0.1])
        by mx0a-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04FJ2E1G009198;
        Fri, 15 May 2020 15:19:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=w1JgK4rbqOvIOtRWZu06erfuapJPkbsJ8S0JdANsSWI=;
 b=jK1tOwcAV206wsldnv7r1nAwgB/klqldLFpGqRogk833feBjQltiiArUR29i/3xvQVoa
 orzoYXwPxx3/3zwt3pIIdAKDjybuStlBkU/JJcNewMIbJsmg+Iw3EgGYXqPYKtUQEhhr
 owuTuJypucq6LzoJQ06i2ZdI/dZmj1+xnmVNOlkM8AmuCYxNVJZzO+obRF2/lJONHLda
 v3ulkcskMl26SzNtPTttI/TlS3+IUcRoo4LU1mIanTbpvM+DIb7fn10D4mv5Oq2tnz11
 /pPl0uPMJhSOeDuurZVLixCHQ/82tmEk3ulaOCReBZLvEYDde0Pz+NoY0T542XVO7IC7 AQ== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
        by mx0a-00154904.pphosted.com with ESMTP id 310v23pa1n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 May 2020 15:19:21 -0400
Received: from pps.filterd (m0090351.ppops.net [127.0.0.1])
        by mx0b-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04FJ32k9032193;
        Fri, 15 May 2020 15:19:21 -0400
Received: from ausxippc106.us.dell.com (AUSXIPPC106.us.dell.com [143.166.85.156])
        by mx0b-00154901.pphosted.com with ESMTP id 310v04pwcv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 May 2020 15:19:21 -0400
X-LoopCount0: from 10.166.132.130
X-PREM-Routing: D-Outbound
X-IronPort-AV: E=Sophos;i="5.60,349,1549951200"; 
   d="scan'208";a="549483479"
From:   <Mario.Limonciello@dell.com>
To:     <hdegoede@redhat.com>, <dvhart@infradead.org>, <andy@infradead.org>
CC:     <platform-driver-x86@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] platform/x86: intel-vbtn: Only blacklist SW_TABLET_MODE
 on the 9 / "Laptop" chasis-type
Thread-Topic: [PATCH] platform/x86: intel-vbtn: Only blacklist SW_TABLET_MODE
 on the 9 / "Laptop" chasis-type
Thread-Index: AQHWKugoWL5KWuDzakGq29JspYoi/6iphYEg
Date:   Fri, 15 May 2020 19:19:18 +0000
Message-ID: <2de269e40ca34597815ba7af05693e6a@AUSX13MPC105.AMER.DELL.COM>
References: <20200515183916.82919-1-hdegoede@redhat.com>
In-Reply-To: <20200515183916.82919-1-hdegoede@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Mario_Limonciello@Dell.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2020-05-15T19:19:08.2290680Z;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Name=External Public;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_ActionId=59f198eb-568b-4a04-b9e2-50feb09ad3be;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Extended_MSFT_Method=Manual
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [143.166.24.40]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-15_07:2020-05-15,2020-05-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 mlxscore=0 clxscore=1015 spamscore=0
 cotscore=-2147483648 mlxlogscore=999 malwarescore=0 suspectscore=0
 phishscore=0 impostorscore=0 priorityscore=1501 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005150159
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 phishscore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005150159
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Hans de Goede <hdegoede@redhat.com>
> Sent: Friday, May 15, 2020 1:39 PM
> To: Darren Hart; Andy Shevchenko
> Cc: Hans de Goede; Limonciello, Mario; platform-driver-x86@vger.kernel.or=
g;
> linux-kernel@vger.kernel.org
> Subject: [PATCH] platform/x86: intel-vbtn: Only blacklist SW_TABLET_MODE =
on the
> 9 / "Laptop" chasis-type
>=20
>=20
> [EXTERNAL EMAIL]
>=20
> The HP Stream x360 11-p000nd no longer report SW_TABLET_MODE state / even=
ts
> with recent kernels. This model reports a chassis-type of 10 / "Notebook"
> which is not on the recently introduced chassis-type whitelist
>=20
> Commit de9647efeaa9 ("platform/x86: intel-vbtn: Only activate tablet mode
> switch on 2-in-1's") added a chassis-type whitelist and only listed 31 /
> "Convertible" as being capable of generating valid SW_TABLET_MOD events.
>=20
> Commit 1fac39fd0316 ("platform/x86: intel-vbtn: Also handle tablet-mode
> switch on "Detachable" and "Portable" chassis-types") extended the
> whitelist with chassis-types 8 / "Portable" and 32 / "Detachable".
>=20
> And now we need to exten the whitelist again with 10 / "Notebook"...
>=20
> The issue original fixed by the whitelist is really a ACPI DSDT bug on
> the Dell XPS 9360 where it has a VGBS which reports it is in tablet mode
> even though it is not a 2-in-1 at all, but a regular laptop.
>=20
> So since this is a workaround for a DSDT issue on that specific model,
> instead of extending the whitelist over and over again, lets switch to
> a blacklist and only blacklist the chassis-type of the model for which
> the chassis-type check was added.
>=20
> Note this also fixes the current version of the code no longer checking
> if dmi_get_system_info(DMI_CHASSIS_TYPE) returns NULL.

Makes sense, thanks.

Reviewed-by: Mario Limonciello <Mario.limonciello@dell.com>

>=20
> Fixes: 1fac39fd0316 ("platform/x86: intel-vbtn: Also handle tablet-mode s=
witch
> on "Detachable" and "Portable" chassis-types")
> Cc: Mario Limonciello <mario.limonciello@dell.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> Note I can even see there being 2-in-1s using intel-vbtn to report
> SW_TABLET_MODE with a chassis-type of 9. So maybe we should make the
> quirk / blacklist stricter by combining it with a
> dmi_name_in_vendors("Dell") check ?
> ---
>  drivers/platform/x86/intel-vbtn.c | 19 ++++++++-----------
>  1 file changed, 8 insertions(+), 11 deletions(-)
>=20
> diff --git a/drivers/platform/x86/intel-vbtn.c b/drivers/platform/x86/int=
el-
> vbtn.c
> index ef92c1c3adbd..0487b606a274 100644
> --- a/drivers/platform/x86/intel-vbtn.c
> +++ b/drivers/platform/x86/intel-vbtn.c
> @@ -170,21 +170,18 @@ static bool intel_vbtn_has_buttons(acpi_handle hand=
le)
>  static bool intel_vbtn_has_switches(acpi_handle handle)
>  {
>  	const char *chassis_type =3D dmi_get_system_info(DMI_CHASSIS_TYPE);
> -	unsigned long chassis_type_int;
>  	unsigned long long vgbs;
>  	acpi_status status;
>=20
> -	if (kstrtoul(chassis_type, 10, &chassis_type_int))
> -		return false;
> -
> -	switch (chassis_type_int) {
> -	case  8: /* Portable */
> -	case 31: /* Convertible */
> -	case 32: /* Detachable */
> -		break;
> -	default:
> +	/*
> +	 * Some normal laptops have a VGBS method despite being non-convertible
> +	 * and their VGBS method always returns 0, causing detect_tablet_mode()
> +	 * to report SW_TABLET_MODE=3D1 to userspace, which causes issues.
> +	 * These laptops have a DMI chassis_type of 9 ("Laptop"), do not report
> +	 * switches on any devices with a DMI chassis_type of 9.
> +	 */
> +	if (chassis_type && strcmp(chassis_type, "9") =3D=3D 0)
>  		return false;
> -	}
>=20
>  	status =3D acpi_evaluate_integer(handle, "VGBS", NULL, &vgbs);
>  	return ACPI_SUCCESS(status);
> --
> 2.26.0

