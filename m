Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB1C4C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 15:30:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B159206D5
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 15:30:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b="Nph2Q8Mz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730253AbgFHPa6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 11:30:58 -0400
Received: from mx0b-00154904.pphosted.com ([148.163.137.20]:37816 "EHLO
        mx0b-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729580AbgFHPa5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 11:30:57 -0400
Received: from pps.filterd (m0170395.ppops.net [127.0.0.1])
        by mx0b-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 058FM2dt026415;
        Mon, 8 Jun 2020 11:30:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=lone3dSt+jzXsyAA4Bd5m0BH6st0hcr9OGHaRGUvGlQ=;
 b=Nph2Q8MzmSanbttb/XtCKlUxGHrxgCFD58YGfxvYhCVjGaBo66b3R1d/ZIXcRV7H8N3W
 LX0BVUHUHAOueaqbhDUP4Mg8I6nftI8YREs/57KjqJZ2leOBb6fmbB1yQRTpGarjyDJN
 QxqxqcSAsj6qFRCb6tsxup5DEMooH6IyGXzohRNA4IbF+peoW8Oy0sl94/e/auBgmzEW
 TYOawiT9dM95sJUrhGMuTkKkT7x2LdMzlBZVdogLEq7QatVZ/+sBJIAHmWy+YIIIKAIw
 7L4I6QNf9ENCvK12ICpOOgWyGPJNeCB16oPqsM5fB96WlEUSg2iBBF8TjsaQJz+3UaC3 wQ== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
        by mx0b-00154904.pphosted.com with ESMTP id 31gy5jk8eq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 Jun 2020 11:30:56 -0400
Received: from pps.filterd (m0134746.ppops.net [127.0.0.1])
        by mx0a-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 058FS9Xe173106;
        Mon, 8 Jun 2020 11:30:55 -0400
Received: from ausxipps310.us.dell.com (AUSXIPPS310.us.dell.com [143.166.148.211])
        by mx0a-00154901.pphosted.com with ESMTP id 31g50q2h3x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 08 Jun 2020 11:30:55 -0400
X-LoopCount0: from 10.166.132.129
X-PREM-Routing: D-Outbound
X-IronPort-AV: E=Sophos;i="5.60,349,1549951200"; 
   d="scan'208";a="509388503"
From:   <Mario.Limonciello@dell.com>
To:     <pali@kernel.org>, <y.linux@paritcher.com>
CC:     <linux-kernel@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>, <mjg59@srcf.ucam.org>
Subject: RE: [PATCH 1/3] platform/x86: dell-wmi: add new backlight events
Thread-Topic: [PATCH 1/3] platform/x86: dell-wmi: add new backlight events
Thread-Index: AQHWPUx85gyioMYN202l2/4aacfOb6jOuKGAgAAgDRA=
Date:   Mon, 8 Jun 2020 15:30:52 +0000
Message-ID: <3e0d394545954ed79b8f883e1ac93338@AUSX13MPC105.AMER.DELL.COM>
References: <cover.1591584631.git.y.linux@paritcher.com>
 <7dbe4e9e5ed64e4704b1c4ae13ac84df644ccc13.1591584631.git.y.linux@paritcher.com>
 <20200608083503.l5g5iq52ezxkobvv@pali>
In-Reply-To: <20200608083503.l5g5iq52ezxkobvv@pali>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Mario_Limonciello@Dell.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2020-06-08T15:30:50.0710000Z;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Name=External Public;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_ActionId=643673c9-6140-409c-bdf1-67b69fc156f3;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Extended_MSFT_Method=Manual
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [143.166.24.60]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-08_13:2020-06-08,2020-06-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 priorityscore=1501 mlxscore=0 bulkscore=0 clxscore=1015 suspectscore=0
 mlxlogscore=999 spamscore=0 impostorscore=0 lowpriorityscore=0
 cotscore=-2147483648 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006080114
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 spamscore=0 mlxscore=0 bulkscore=0 suspectscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006080114
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: platform-driver-x86-owner@vger.kernel.org <platform-driver-x86-
> owner@vger.kernel.org> On Behalf Of Pali Roh=E1r
> Sent: Monday, June 8, 2020 3:35 AM
> To: Y Paritcher
> Cc: linux-kernel@vger.kernel.org; platform-driver-x86@vger.kernel.org;
> Matthew Garrett
> Subject: Re: [PATCH 1/3] platform/x86: dell-wmi: add new backlight events
>=20
>=20
> [EXTERNAL EMAIL]
>=20
> On Monday 08 June 2020 00:22:24 Y Paritcher wrote:
> > Ignore events with a type of 0x0010 and a code of 0x57 / 0x58,
> > this silences the following messages being logged on a
> > Dell Inspiron 5593:
> >
> > dell_wmi: Unknown key with type 0x0010 and code 0x0057 pressed
> > dell_wmi: Unknown key with type 0x0010 and code 0x0058 pressed
> >
> > Signed-off-by: Y Paritcher <y.linux@paritcher.com>
> > ---
> >  drivers/platform/x86/dell-wmi.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/drivers/platform/x86/dell-wmi.c b/drivers/platform/x86/del=
l-
> wmi.c
> > index c25a4286d766..0b4f72f923cd 100644
> > --- a/drivers/platform/x86/dell-wmi.c
> > +++ b/drivers/platform/x86/dell-wmi.c
> > @@ -252,6 +252,10 @@ static const struct key_entry
> dell_wmi_keymap_type_0010[] =3D {
> >  	/* Fn-lock switched to multimedia keys */
> >  	{ KE_IGNORE, 0x1, { KEY_RESERVED } },
> >
> > +	/* Backlight brightness level */
> > +	{ KE_KEY,    0x57, { KEY_BRIGHTNESSDOWN } },
> > +	{ KE_KEY,    0x58, { KEY_BRIGHTNESSUP } },
> > +

For these particular events are they emitted by another interface as well i=
n this
platform?

If so they should be KE_IGNORE so you don't end up with double notification=
s to
userspace.

> >  	/* Keyboard backlight change notification */
> >  	{ KE_IGNORE, 0x3f, { KEY_RESERVED } },
>=20
> Please, keep codes sorted.
>=20
> >
> > --
> > 2.27.0
> >
