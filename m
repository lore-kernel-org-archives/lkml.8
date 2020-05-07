Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A15B6C38A2A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 20:11:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6BC7320575
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 20:11:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b="g7XBA4nl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728491AbgEGULz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 16:11:55 -0400
Received: from mx0a-00154904.pphosted.com ([148.163.133.20]:53852 "EHLO
        mx0a-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726367AbgEGULy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 16:11:54 -0400
Received: from pps.filterd (m0170391.ppops.net [127.0.0.1])
        by mx0a-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 047KBZR2011245;
        Thu, 7 May 2020 16:11:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=FutY7/PocSDquuLkq9+a9lv+L2OmOyTDQDb74IqLEkw=;
 b=g7XBA4nlgzOnb+1OrOxdo/xAxeOcyzOolRUkn9sZJie4he8Amp4JIg/Nbh5GIuTR81KD
 74m2/uzfuBaIN2ZXbcPAsN0YJz1NVnpTXMc4FQEEr4Fi/EkohyeAOo0ERsD96qirhGgM
 GWirN3EoUTUX2GZrFkLFPujyuoN3RtG08PVldnhBlUoUboRyLKWKPMUSwl8bn3E6exm4
 JFcXJ4+ZAjVKPecrJdlF2cMUdW0uU8VMI42jXi9e5TnatgmN1OCXqL/Gs8fb5tHHFfo8
 J1l/8VI9FIiDx903uONPIXpcOJKDP/qJZGkjySoMq0SBY2U2j5otxw+tUzzooG3Bc4qy 8A== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
        by mx0a-00154904.pphosted.com with ESMTP id 30sxjmdyve-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 May 2020 16:11:54 -0400
Received: from pps.filterd (m0134746.ppops.net [127.0.0.1])
        by mx0a-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 047Jqs87161869;
        Thu, 7 May 2020 16:11:53 -0400
Received: from ausc60pc101.us.dell.com (ausc60pc101.us.dell.com [143.166.85.206])
        by mx0a-00154901.pphosted.com with ESMTP id 30vq4ea7hh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 May 2020 16:11:53 -0400
X-LoopCount0: from 10.166.132.130
X-PREM-Routing: D-Outbound
X-IronPort-AV: E=Sophos;i="5.60,349,1549951200"; 
   d="scan'208";a="1553508669"
From:   <Mario.Limonciello@dell.com>
To:     <koba.ko@canonical.com>, <mjg59@srcf.ucam.org>,
        <pali.rohar@gmail.com>, <dvhart@infradead.org>,
        <andy@infradead.org>, <platform-driver-x86@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] platform/x86: dell-laptop: don't register
 platform::micmute if the related tokens don't exist.
Thread-Topic: [PATCH] platform/x86: dell-laptop: don't register
 platform::micmute if the related tokens don't exist.
Thread-Index: AQHWJGsTQDXbgVjQZ0WT0dgVnPhl9aidDRIA
Date:   Thu, 7 May 2020 20:11:08 +0000
Message-ID: <31e54254d233424f937ea767c5a26f57@AUSX13MPC101.AMER.DELL.COM>
References: <20200507122703.14617-1-koba.ko@canonical.com>
In-Reply-To: <20200507122703.14617-1-koba.ko@canonical.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Mario_Limonciello@Dell.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2020-05-07T20:11:05.4258848Z;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Name=External Public;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_ActionId=111805c0-2495-4ee0-882b-6de0026e11a1;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Extended_MSFT_Method=Manual
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [143.166.24.60]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-07_13:2020-05-07,2020-05-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 priorityscore=1501 phishscore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 impostorscore=0 malwarescore=0 bulkscore=0
 spamscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005070159
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 mlxscore=0
 malwarescore=0 adultscore=0 clxscore=1015 spamscore=0 priorityscore=1501
 phishscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005070160
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: koba.ko@canonical.com <koba.ko@canonical.com>
> Sent: Thursday, May 7, 2020 7:27 AM
> To: Matthew Garrett; Pali Roh=E1r; Darren Hart; Andy Shevchenko; platform=
-driver-
> x86@vger.kernel.org; linux-kernel@vger.kernel.org; Limonciello, Mario
> Subject: [PATCH] platform/x86: dell-laptop: don't register platform::micm=
ute if
> the related tokens don't exist.
>=20
>=20
> [EXTERNAL EMAIL]
>=20
> From: Koba Ko <koba.ko@canonical.com>
>=20
> During boot up, Error messge is issued,
> "platform::micmute: Setting an LED's brightness failed (-19)",
> but the device isn't presented.
>=20
> Get the related tokens of SMBIOS, GLOBAL_MIC_MUTE_DISABLE/ENABLE.
> If one of two tokens doesn't exist,
> don't call led_classdev_register() for platform::micmute.
> After that, you wouldn't see the platform::micmute in /sys/class/leds/,
> and the error message wouldn't see in dmesg.
>=20

Unless it's a pre-release platform, I think it's worth mentioning in commit
message what the hardware is.

If it's pre-release, then perhaps mention "pre-release vostro platform" her=
e.
This is useful information in case in the future something in this driver m=
ust
change for a full class/line of systems.

> Signed-off-by: Koba Ko <koba.ko@canonical.com>
> ---
>  drivers/platform/x86/dell-laptop.c | 17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/platform/x86/dell-laptop.c b/drivers/platform/x86/de=
ll-
> laptop.c
> index 74e988f839e8..e315185dbdd6 100644
> --- a/drivers/platform/x86/dell-laptop.c
> +++ b/drivers/platform/x86/dell-laptop.c
> @@ -2164,7 +2164,7 @@ static struct led_classdev micmute_led_cdev =3D {
>  static int __init dell_init(void)
>  {
>  	struct calling_interface_token *token;
> -	int max_intensity =3D 0;
> +	int max_intensity =3D 0, is_micmute_exist =3D 0;

As a nit, please declare variables on their own line and I don't like is_mi=
cmute_exist
as this is bad grammar.

Perhaps "micmute_exists" instead.

Also this variable can be a boolean type instead with it's usage.

>  	int ret;
>=20
>  	if (!dmi_check_system(dell_device_table))
> @@ -2204,10 +2204,14 @@ static int __init dell_init(void)
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
> +		is_micmute_exist =3D 1;
> +	}
>=20
>  	if (acpi_video_get_backlight_type() !=3D acpi_backlight_vendor)
>  		return 0;
> @@ -2254,7 +2258,8 @@ static int __init dell_init(void)
>  fail_get_brightness:
>  	backlight_device_unregister(dell_backlight_device);
>  fail_backlight:
> -	led_classdev_unregister(&micmute_led_cdev);
> +	if (is_micmute_exist)
> +		led_classdev_unregister(&micmute_led_cdev);
>  fail_led:
>  	dell_cleanup_rfkill();
>  fail_rfkill:
> --
> 2.25.1

