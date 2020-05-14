Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02273C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 01:26:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0373E205CB
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 01:26:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b="NPXN95my"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728164AbgENB0Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 21:26:16 -0400
Received: from mx0a-00154904.pphosted.com ([148.163.133.20]:23608 "EHLO
        mx0a-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725925AbgENB0Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 21:26:16 -0400
Received: from pps.filterd (m0170390.ppops.net [127.0.0.1])
        by mx0a-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04E1M4kd000852;
        Wed, 13 May 2020 21:26:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=3WizmGW4J+5cCpHjPx+8L4kEw/KH/xKY6PYq4exd70o=;
 b=NPXN95myrqzW+O6wVKsGu2H8eIwflBlsdaT5ID4hlzT9NTgBZ3RYnmq/eCsXPVu++Sy1
 oOekCsXp0jB1LROqaFxUrM1eFGOagXDU7ZTMTshHM5v+ggMXBTBOpQkqiXQzYv2xkEAk
 w381DTe6qg1Qs3fyw4LvER/xK1Ugv2Jku5V0SNFh/006NSOedfVJolMzu75R/lxIrUbd
 MnMl0WuBeFGT4kDpG1E5MxIs3O+7FDou+pvDHiwOGHtfT7VFN8u2hKjUjeySZsxS69Si
 Jhauauwdiu0g3HlShsNGxgoWCcjHWoZYbVlhNrqqqcIbkoRUfdpJPyZkiuW04Ukr7Q7j Ow== 
Received: from mx0a-00154901.pphosted.com (mx0b-00154901.pphosted.com [67.231.157.37])
        by mx0a-00154904.pphosted.com with ESMTP id 310r9y0hkh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 May 2020 21:26:15 -0400
Received: from pps.filterd (m0089484.ppops.net [127.0.0.1])
        by mx0b-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04E1Jqgl013732;
        Wed, 13 May 2020 21:26:14 -0400
Received: from ausc60pc101.us.dell.com (ausc60pc101.us.dell.com [143.166.85.206])
        by mx0b-00154901.pphosted.com with ESMTP id 310t1phkq1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 May 2020 21:26:14 -0400
X-LoopCount0: from 10.166.132.128
X-PREM-Routing: D-Outbound
X-IronPort-AV: E=Sophos;i="5.60,349,1549951200"; 
   d="scan'208";a="1555477687"
From:   <Mario.Limonciello@dell.com>
To:     <koba.ko@canonical.com>, <mjg59@srcf.ucam.org>,
        <pali.rohar@gmail.com>, <dvhart@infradead.org>,
        <andy@infradead.org>, <platform-driver-x86@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] V2: platform/x86: dell-laptop: don't register
 platform::micmute if the related tokens don't exist.
Thread-Topic: [PATCH] V2: platform/x86: dell-laptop: don't register
 platform::micmute if the related tokens don't exist.
Thread-Index: AQHWJzXMujFpc2Vn3kCSXk0rEt48Sqimzstw
Date:   Thu, 14 May 2020 01:26:11 +0000
Message-ID: <135a804acc8247648ff8e811843f68ce@AUSX13MPC105.AMER.DELL.COM>
References: <20200511014456.5149-1-koba.ko@canonical.com>
In-Reply-To: <20200511014456.5149-1-koba.ko@canonical.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Mario_Limonciello@Dell.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2020-05-14T01:26:07.7014683Z;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Name=External Public;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_ActionId=e25616ff-1345-4e3d-8350-933663a7d7b1;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Extended_MSFT_Method=Manual
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [143.166.24.40]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-13_09:2020-05-13,2020-05-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 cotscore=-2147483648 bulkscore=0 mlxlogscore=999 impostorscore=0
 adultscore=0 lowpriorityscore=0 suspectscore=0 spamscore=0 malwarescore=0
 clxscore=1015 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2005140010
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 phishscore=0 mlxscore=0 suspectscore=0 adultscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2005140010
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: koba.ko@canonical.com <koba.ko@canonical.com>
> Sent: Sunday, May 10, 2020 8:45 PM
> To: Matthew Garrett; Pali Roh=E1r; Darren Hart; Andy Shevchenko; platform=
-driver-
> x86@vger.kernel.org; linux-kernel@vger.kernel.org; Limonciello, Mario
> Subject: [PATCH] V2: platform/x86: dell-laptop: don't register
> platform::micmute if the related tokens don't exist.
>=20
>=20
> [EXTERNAL EMAIL]
>=20
> From: Koba Ko <koba.ko@canonical.com>
>=20
> On dell G3-3590, error message is issued during boot up,
> "platform::micmute: Setting an LED's brightness failed (-19)",
> but there's no micmute led on the machine.
>=20
> Get the related tokens of SMBIOS, GLOBAL_MIC_MUTE_DISABLE/ENABLE.
> If one of two tokens doesn't exist,
> don't call led_classdev_register() for platform::micmute.
> After that, you wouldn't see the platform::micmute in /sys/class/leds/,
> and the error message wouldn't see in dmesg.
>=20
> Signed-off-by: Koba Ko <koba.ko@canonical.com>
> ---
> Changelog:
> 1. Refine the typo of comment.
> ---
>  drivers/platform/x86/dell-laptop.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/platform/x86/dell-laptop.c b/drivers/platform/x86/de=
ll-
> laptop.c
> index 1e46022fb2c5..afc1ded83e56 100644
> --- a/drivers/platform/x86/dell-laptop.c
> +++ b/drivers/platform/x86/dell-laptop.c
> @@ -2208,10 +2208,13 @@ static int __init dell_init(void)
>=20
>  	dell_laptop_register_notifier(&dell_laptop_notifier);
>=20
> -	micmute_led_cdev.brightness =3D ledtrig_audio_get(LED_AUDIO_MICMUTE);
> -	ret =3D led_classdev_register(&platform_device->dev, &micmute_led_cdev)=
;
> -	if (ret < 0)
> -		goto fail_led;
> +	if (dell_smbios_find_token(GLOBAL_MIC_MUTE_DISABLE) &&
> +	    dell_smbios_find_token(GLOBAL_MIC_MUTE_ENABLE)) {
> +		micmute_led_cdev.brightness =3D ledtrig_audio_get(LED_AUDIO_MICMUTE);
> +		ret =3D led_classdev_register(&platform_device->dev,
> &micmute_led_cdev);
> +		if (ret < 0)
> +			goto fail_led;
> +	}
>=20
>  	if (acpi_video_get_backlight_type() !=3D acpi_backlight_vendor)
>  		return 0;
> --
> 2.17.1

Reviewed-by: Mario Limonciello <Mario.limonciello@dell.com>

