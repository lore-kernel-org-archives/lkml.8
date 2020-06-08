Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25CB1C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 20:38:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E73522076A
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 20:38:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b="HvaTBOez"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726740AbgFHUiQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 16:38:16 -0400
Received: from mx0b-00154904.pphosted.com ([148.163.137.20]:18900 "EHLO
        mx0b-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726427AbgFHUiN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 16:38:13 -0400
Received: from pps.filterd (m0170394.ppops.net [127.0.0.1])
        by mx0b-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 058KUkrp008047;
        Mon, 8 Jun 2020 16:38:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=Ttkvc89tF584X8CXS8IYMsA8buqz7fnUdduvexeWW3k=;
 b=HvaTBOez/0JkTwBtSm1DQ44I2CJNsQivRtzJ/pie1t3mRimWoH1Wj+eeFd2Flh5pwBlk
 gn5mcsoqrqFuOt8pGLSQma+LFrm0Su33gddFE3kDyCc56NDi+T0ElpE83tv8o4WitKSK
 KwxWeHQI4e/GnrHgO2NPyVL7osn1vWXj1FhoeYLBBDawiFBe0bq+t0r5bvvZTNEZ90Vd
 ObTVJt8TegA9tlnbae4BwyUEBJRYFqoCSjCLz1JEXf0+jViEscIXUZciXhQN1/dpmHNQ
 M1WoTFm/ez/p579VecTU569yacXmUdqqBI6mkwZE07Dv6c/qw4Ol03jplBKLTUDgkDYS Qw== 
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com [67.231.157.37])
        by mx0b-00154904.pphosted.com with ESMTP id 31g5q5p7tx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 Jun 2020 16:38:12 -0400
Received: from pps.filterd (m0134318.ppops.net [127.0.0.1])
        by mx0a-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 058Kc2iM145455;
        Mon, 8 Jun 2020 16:38:11 -0400
Received: from ausxipps306.us.dell.com (AUSXIPPS306.us.dell.com [143.166.148.156])
        by mx0a-00154901.pphosted.com with ESMTP id 31hsuka793-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 08 Jun 2020 16:38:11 -0400
X-LoopCount0: from 10.166.132.129
X-PREM-Routing: D-Outbound
X-IronPort-AV: E=Sophos;i="5.73,489,1583215200"; 
   d="scan'208";a="475909782"
From:   <Mario.Limonciello@dell.com>
To:     <pali@kernel.org>
CC:     <y.linux@paritcher.com>, <linux-kernel@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>, <mjg59@srcf.ucam.org>
Subject: RE: [PATCH 1/3] platform/x86: dell-wmi: add new backlight events
Thread-Topic: [PATCH 1/3] platform/x86: dell-wmi: add new backlight events
Thread-Index: AQHWPUx85gyioMYN202l2/4aacfOb6jOuKGAgAAgDRCAAKKfgP//rIcQgABaUQD//6yhAA==
Date:   Mon, 8 Jun 2020 20:38:09 +0000
Message-ID: <d0bd94b5d27949f2beccb2ebbfbfa137@AUSX13MPC105.AMER.DELL.COM>
References: <cover.1591584631.git.y.linux@paritcher.com>
 <7dbe4e9e5ed64e4704b1c4ae13ac84df644ccc13.1591584631.git.y.linux@paritcher.com>
 <20200608083503.l5g5iq52ezxkobvv@pali>
 <3e0d394545954ed79b8f883e1ac93338@AUSX13MPC105.AMER.DELL.COM>
 <e91bb21e-98fa-f469-cc24-abc9ae200e4d@paritcher.com>
 <14b9e7d3a3e842e991e4e5e271b447e7@AUSX13MPC105.AMER.DELL.COM>
 <20200608203618.dhpu6gsvigzdnecv@pali>
In-Reply-To: <20200608203618.dhpu6gsvigzdnecv@pali>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Mario_Limonciello@Dell.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2020-06-08T20:38:07.4636461Z;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Name=External Public;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_ActionId=63f10f01-469a-49ae-ba56-f84641b96311;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Extended_MSFT_Method=Manual
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [143.166.24.60]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-08_18:2020-06-08,2020-06-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 spamscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 cotscore=-2147483648 mlxlogscore=999 adultscore=0 phishscore=0
 clxscore=1015 bulkscore=0 impostorscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006080144
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 malwarescore=0 adultscore=0 phishscore=0 bulkscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006080144
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Pali Roh=E1r <pali@kernel.org>
> Sent: Monday, June 8, 2020 3:36 PM
> To: Limonciello, Mario
> Cc: y.linux@paritcher.com; linux-kernel@vger.kernel.org; platform-driver-
> x86@vger.kernel.org; mjg59@srcf.ucam.org
> Subject: Re: [PATCH 1/3] platform/x86: dell-wmi: add new backlight events
>=20
>=20
> [EXTERNAL EMAIL]
>=20
> On Monday 08 June 2020 20:14:15 Mario.Limonciello@dell.com wrote:
> > > >>> index c25a4286d766..0b4f72f923cd 100644
> > > >>> --- a/drivers/platform/x86/dell-wmi.c
> > > >>> +++ b/drivers/platform/x86/dell-wmi.c
> > > >>> @@ -252,6 +252,10 @@ static const struct key_entry
> > > >> dell_wmi_keymap_type_0010[] =3D {
> > > >>>  	/* Fn-lock switched to multimedia keys */
> > > >>>  	{ KE_IGNORE, 0x1, { KEY_RESERVED } },
> > > >>>
> > > >>> +	/* Backlight brightness level */
> > > >>> +	{ KE_KEY,    0x57, { KEY_BRIGHTNESSDOWN } },
> > > >>> +	{ KE_KEY,    0x58, { KEY_BRIGHTNESSUP } },
> > > >>> +
> > > >
> > > > For these particular events are they emitted by another interface a=
s
> well
> > > in this
> > > > platform?
> > > >
> > > > If so they should be KE_IGNORE so you don't end up with double
> > > notifications to
> > > > userspace.
> > > Thank you both for the review,
> > > This is my first patch so if i am doing something wrong please let me
> know.
> > >
> > > Both before and after this change they are only emitted once (verifie=
d
> via
> > > showkeys)
> > > this is because `dell_wmi_process_key()` calls
> > > `acpi_video_handles_brightness_key_presses()`
> > > for brightness events, and
> `acpi_video_handles_brightness_key_presses()`
> > > makes sure no duplicate acpi-video events are sent.
> >
> > That's good to hear that it also filters it, but my opinion is that del=
l-
> wmi.c
> > should also filter it.  So just change KE_KEY to KE_IGNORE like the oth=
er
> events.
>=20
> IIRC for other existing KEY_BRIGHTNESS* lines, KE_KEY/KE_IGNORE decision
> is there just because kernel can be configured if ACPI layer would
> handle them or not. And based on
> acpi_video_handles_brightness_key_presses()
> function we know if ACPI layer processed these keys or not.
>=20
> So in my opinion we should handle these new KEY_BRIGHTNESS* events in
> the same way. So dell-wmi should process these events, but only in case
> when ACPI layer did not processed them.

OK thanks, I wasn't aware of this decision elsewhere.
