Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF5F2C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 15:46:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A591420774
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 15:46:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b="iwyEX1Ga"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730346AbgFHPqt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 11:46:49 -0400
Received: from mx0a-00154904.pphosted.com ([148.163.133.20]:39886 "EHLO
        mx0a-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725975AbgFHPqs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 11:46:48 -0400
Received: from pps.filterd (m0170391.ppops.net [127.0.0.1])
        by mx0a-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 058FkdtK010331;
        Mon, 8 Jun 2020 11:46:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=ZMYj7TjtbVR1Mk+mh5cxaOihOocRMaG8fRyEXRgeSLY=;
 b=iwyEX1Gar0oKAZE5sbG3hTQtGP8D9xH7CDRKvBEKjanpCxQICueMn6XHwqBFSQFarBC0
 CV4BKyN2wThSA2vN1s6IPKy6yP+M4jEiQgyFDYVtF8Iy2eYnE2Pb53tlk8qyKg2urTCK
 ti2O8Hz8IqUUhPh4zJlQFVWRtFlGuYS95SFt6V1zJiuYnegBYP8GQalL7XfpmGPn9zI2
 4KTliLSXjOIqQAOJMwWY+QAXd1Mv3pC5QF/GVIf5/6G5852Cb6ayaQhWo4lK26r+ZYOG
 V6S0FoG0iky5FFy4X03MzhNalOaLIKr4RUUaeHjrNsD38XhOP8aslqJ/Q5fXZkQQNwlj iw== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
        by mx0a-00154904.pphosted.com with ESMTP id 31g69wd5gf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 Jun 2020 11:46:47 -0400
Received: from pps.filterd (m0090351.ppops.net [127.0.0.1])
        by mx0b-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 058FhkWT014345;
        Mon, 8 Jun 2020 11:46:47 -0400
Received: from ausxippc106.us.dell.com (AUSXIPPC106.us.dell.com [143.166.85.156])
        by mx0b-00154901.pphosted.com with ESMTP id 31garqytct-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 08 Jun 2020 11:46:47 -0400
X-LoopCount0: from 10.166.132.132
X-PREM-Routing: D-Outbound
X-IronPort-AV: E=Sophos;i="5.60,349,1549951200"; 
   d="scan'208";a="556913000"
From:   <Mario.Limonciello@dell.com>
To:     <pali@kernel.org>, <y.linux@paritcher.com>
CC:     <linux-kernel@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>, <mjg59@srcf.ucam.org>
Subject: RE: [PATCH 3/3] platform/x86: dell-wmi: add keys to
 bios_to_linux_keycode
Thread-Topic: [PATCH 3/3] platform/x86: dell-wmi: add keys to
 bios_to_linux_keycode
Thread-Index: AQHWPUx9sFYF+BrpzUSmmNRF6qlL7KjOv66AgAAcqwA=
Date:   Mon, 8 Jun 2020 15:46:44 +0000
Message-ID: <8baab72e3d2e407792c3ffa1d9fffba8@AUSX13MPC105.AMER.DELL.COM>
References: <cover.1591584631.git.y.linux@paritcher.com>
 <13951508596a3f654c6d47f5380ddb4f38e2f6b5.1591584631.git.y.linux@paritcher.com>
 <20200608090017.4qgtbosz7oullex2@pali>
In-Reply-To: <20200608090017.4qgtbosz7oullex2@pali>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Mario_Limonciello@Dell.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2020-06-08T15:46:39.9699122Z;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Name=External Public;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_ActionId=58d103a6-2106-4aa6-b8cb-860aa202d4af;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Extended_MSFT_Method=Manual
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [143.166.24.60]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-08_14:2020-06-08,2020-06-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 mlxscore=0
 adultscore=0 cotscore=-2147483648 impostorscore=0 spamscore=0
 mlxlogscore=999 priorityscore=1501 malwarescore=0 bulkscore=0
 clxscore=1015 lowpriorityscore=0 phishscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006080114
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 phishscore=0
 spamscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006080115
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: platform-driver-x86-owner@vger.kernel.org <platform-driver-x86-
> owner@vger.kernel.org> On Behalf Of Pali Roh=E1r
> Sent: Monday, June 8, 2020 4:00 AM
> To: Y Paritcher
> Cc: linux-kernel@vger.kernel.org; platform-driver-x86@vger.kernel.org;
> Matthew Garrett
> Subject: Re: [PATCH 3/3] platform/x86: dell-wmi: add keys to
> bios_to_linux_keycode
>=20
>=20
> [EXTERNAL EMAIL]
>=20
> Hello!
>=20
> On Monday 08 June 2020 00:22:26 Y Paritcher wrote:
> > Increase length of bios_to_linux_keycode to 2 bytes to allow for a new
> > keycode 0xffff, this silences the following messages being logged at
> > startup on a Dell Inspiron 5593

Which event type?  Can you show the whole WMI buffer that came through?

> >
> > dell_wmi: firmware scancode 0x48 maps to unrecognized keycode 0xffff
> > dell_wmi: firmware scancode 0x50 maps to unrecognized keycode 0xffff
> >
> > Signed-off-by: Y Paritcher <y.linux@paritcher.com>
> > ---
> >  drivers/platform/x86/dell-wmi.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/platform/x86/dell-wmi.c b/drivers/platform/x86/del=
l-
> wmi.c
> > index f37e7e9093c2..5ef716e3034f 100644
> > --- a/drivers/platform/x86/dell-wmi.c
> > +++ b/drivers/platform/x86/dell-wmi.c
> > @@ -196,7 +196,7 @@ struct dell_dmi_results {
> >  };
> >
> >  /* Uninitialized entries here are KEY_RESERVED =3D=3D 0. */
> > -static const u16 bios_to_linux_keycode[256] =3D {
> > +static const u16 bios_to_linux_keycode[65536] =3D {
>=20
> This change dramatically increase memory usage. I guess other that
> maintainers would not like such change.
>=20
> >  	[0]	=3D KEY_MEDIA,
> >  	[1]	=3D KEY_NEXTSONG,
> >  	[2]	=3D KEY_PLAYPAUSE,
> > @@ -237,6 +237,7 @@ static const u16 bios_to_linux_keycode[256] =3D {
> >  	[37]	=3D KEY_UNKNOWN,
> >  	[38]	=3D KEY_MICMUTE,
> >  	[255]	=3D KEY_PROG3,
> > +	[65535]	=3D KEY_UNKNOWN,
>=20
> Also it seems that this change is not complete. It looks like that you
> map two different scancodes (0x48 and 0x50) to same keycodes, moreover
> both are unknown.
>=20
> Could you please describe which key presses (or events) generate
> delivering these WMI scancode events?
>=20
> Note that purpose of printing unknown/unrecognized keys messages is to
> inform that current pressed key was not processed or that it was
> ignored.
>=20
> For me it looks like this just just hide information that key was not
> processed correctly as this change does not implement correct processing
> of this key.
>=20
> Also, could you share documentation about these 0x48/0x50 events? Or it
> is under NDA?
>=20
> >  };
> >
> >  /*
> > --
> > 2.27.0
> >

I would actually question if there is value to lines in dell-wmi.c like thi=
s:

pr_info("Unknown WMI event type 0x%x\n", (int)buffer_entry[1]);

and

pr_info("Unknown key with type 0x%04x and code 0x%04x pressed\n", type, cod=
e);

In both of those cases the information doesn't actually help the user, by d=
efault it's
ignored by the driver anyway.  It just notifies the user it's something the=
 driver doesn't
comprehend.  I would think these are better suited to downgrade to debug.  =
And if
a key combination isn't doing something expected the user can use dyndbg to=
 turn it
back on and can be debugged what should be populated or "explicitly" ignore=
d.
