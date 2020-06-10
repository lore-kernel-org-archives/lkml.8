Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2047C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 12:35:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8EAE4204EA
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 12:35:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b="sNkmY8+b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729087AbgFJMfP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 08:35:15 -0400
Received: from mx0a-00154904.pphosted.com ([148.163.133.20]:5734 "EHLO
        mx0a-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728896AbgFJMfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 08:35:12 -0400
Received: from pps.filterd (m0170393.ppops.net [127.0.0.1])
        by mx0a-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05ACITFl022909;
        Wed, 10 Jun 2020 08:35:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=MIYlMsiBONt6vwXwS++F44PeG9RazWr4EGbudVZyqy4=;
 b=sNkmY8+bYOtxKfzBb8HntaJzvHoqrrc5JGV016bD/rS/THPcllqkkYcKOar62lSQQAyU
 DPf/yh3UoLUqR/E9x/WmVVaOS6hHfIi03UJo5OSlckeZOWg22YLUP7UL2GFeREVoBbWs
 oe80wZhOjUfJphpMsNhsyykbHQ6IEiu1CY+ziZBCVoQfiFplV5MKILDLQJl5dczzTcfo
 8Zl6pWfdj12vAd8HAMKlTzyLC5vbGOg3QrZsEo1AJtw+3fqpOcio8eQhAYm2o1BHRIRm
 bnVRsmrzGHR2o4UtPKpU0wnW/ftgOtL84v/PBGowuggdqOpv87T/VQy/lonXSlHGj+Ob lQ== 
Received: from mx0a-00154901.pphosted.com (mx0b-00154901.pphosted.com [67.231.157.37])
        by mx0a-00154904.pphosted.com with ESMTP id 31jjr02hk1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 Jun 2020 08:35:11 -0400
Received: from pps.filterd (m0089484.ppops.net [127.0.0.1])
        by mx0b-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05ACJsNH011309;
        Wed, 10 Jun 2020 08:35:11 -0400
Received: from ausxippc101.us.dell.com (ausxippc101.us.dell.com [143.166.85.207])
        by mx0b-00154901.pphosted.com with ESMTP id 31jrj2q6qf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Jun 2020 08:35:10 -0400
X-LoopCount0: from 10.166.132.133
X-PREM-Routing: D-Outbound
X-IronPort-AV: E=Sophos;i="5.60,346,1549951200"; 
   d="scan'208";a="1396236591"
From:   <Mario.Limonciello@dell.com>
To:     <pali@kernel.org>
CC:     <rdunlap@infradead.org>, <y.linux@paritcher.com>,
        <linux-kernel@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>, <mjg59@srcf.ucam.org>
Subject: RE: [PATCH v2 3/3] platform/x86: dell-wmi: add new dmi keys to
 bios_to_linux_keycode
Thread-Topic: [PATCH v2 3/3] platform/x86: dell-wmi: add new dmi keys to
 bios_to_linux_keycode
Thread-Index: AQHWPelqfgxdvjwP/0a7+jtlxWF6SqjPsKgAgAAH0ACAAPg6kIABPt2A///ajtA=
Date:   Wed, 10 Jun 2020 12:35:09 +0000
Message-ID: <a7b5dd31dd32461aad51e08d38777edf@AUSX13MPC105.AMER.DELL.COM>
References: <cover.1591584631.git.y.linux@paritcher.com>
 <cover.1591656154.git.y.linux@paritcher.com>
 <d585d2a0f01a6b9480352530b571dec2d1afd79f.1591656154.git.y.linux@paritcher.com>
 <8053252a-83ad-bcaa-2830-ccfbca1b4152@infradead.org>
 <20200608235508.wthtgilgmifwfgz2@pali>
 <ced5832cfe984c68b27a577cac0f02f1@AUSX13MPC105.AMER.DELL.COM>
 <20200610094449.xltvs2y6kp7driyh@pali>
In-Reply-To: <20200610094449.xltvs2y6kp7driyh@pali>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Mario_Limonciello@Dell.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2020-06-10T12:35:07.3124973Z;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Name=External Public;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_ActionId=94347649-6c3a-4e27-83d3-a4029e761f90;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Extended_MSFT_Method=Manual
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [143.166.24.40]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-10_07:2020-06-10,2020-06-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 malwarescore=0
 mlxlogscore=999 clxscore=1015 impostorscore=0 adultscore=0
 cotscore=-2147483648 lowpriorityscore=0 bulkscore=0 phishscore=0
 spamscore=0 priorityscore=1501 mlxscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006100095
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 spamscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006100095
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: platform-driver-x86-owner@vger.kernel.org <platform-driver-x86-
> owner@vger.kernel.org> On Behalf Of Pali Roh=E1r
> Sent: Wednesday, June 10, 2020 4:45 AM
> To: Limonciello, Mario
> Cc: rdunlap@infradead.org; y.linux@paritcher.com; linux-
> kernel@vger.kernel.org; platform-driver-x86@vger.kernel.org;
> mjg59@srcf.ucam.org
> Subject: Re: [PATCH v2 3/3] platform/x86: dell-wmi: add new dmi keys to
> bios_to_linux_keycode
>=20
>=20
> [EXTERNAL EMAIL]
>=20
> On Tuesday 09 June 2020 19:49:18 Mario.Limonciello@dell.com wrote:
> > >
> > > Looking at the last two lines... and for me it looks like that 0x00FF
> > > and 0xFFFF are just "placeholders" or special values for unknown /
> > > custom / unsupported / reserved / special / ... codes.
> > >
> > > It is really suspicious why first 38 values are defined, then there i=
s
> > > gap, then one value 255 and then huge gap to 65535.
> > >
> > > Mario, this looks like some mapping table between internal Dell BIOS
> key
> > > code and standard Linux key code. Are you able to get access to some
> > > documentation which contains explanation of those Dell key numbers?
> > > It could really help us to understand these gaps and what is correct
> > > interpretation of these numbers.
> > >
> >
> > The codes are actually 4 bytes in the table, but in practice nothing
> above the
> > first two bytes is used.
> >
> > Those two called out are special though, here are their meanings:
> >
> > 0x00FF is user programmable function
> > 0xFFFF is no function
> >
> > For the purpose of memory consumption I think it's reasonable to ignore
> the
> > upper 2 bytes and special case these two.
>=20
> Thank you for information!
>=20
> So 0x00FF is "user programmable" button. Do I understand it correctly
> that Dell/BIOS does not explicitly provide meaning for these buttons,
> they do not have fixed functionality and therefore user should configure
> them as he want?

Correct

>=20
> And what does mean "no function"? I do not know what should I imagine if
> I receive key press marked as "no function".

It means no action is expected to occur, should behave like a no-op.  I thi=
nk
discarding it makes fine sense.

>=20
> > > E.g. I remember that pressing Fn+Q or Fn+W on some Dell Latitude
> > > generates code 255, which could prove my thesis about "special codes"
> > > (which are probably not found in e.g. Windows or Linux mapping tables=
).
> > >
> > > > >  };
> > > > >
> > > > >  /*
> > > > > @@ -503,10 +504,7 @@ static void handle_dmi_entry(const struct
> > > dmi_header *dm, void *opaque)
> > > > >  					&table->keymap[i];
> > > > >
> > > > >  		/* Uninitialized entries are 0 aka KEY_RESERVED. */
> > > > > -		u16 keycode =3D (bios_entry->keycode <
> > > > > -			       ARRAY_SIZE(bios_to_linux_keycode)) ?
> > > > > -			bios_to_linux_keycode[bios_entry->keycode] :
> > > > > -			KEY_RESERVED;
> > > > > +		u16 keycode =3D bios_to_linux_keycode[bios_entry->keycode];
> > > > >
> > > > >  		/*
> > > > >  		 * Log if we find an entry in the DMI table that we don't
> > > > >
> > > >
> > > > Something like:
> > > >
> > > > 		u16 keycode;
> > > >
> > > > 		keycode =3D bios_entry->keycode =3D=3D 0xffff ? KEY_UNKNOWN :
> > > > 			(bios_entry->keycode <
> > > > 			       ARRAY_SIZE(bios_to_linux_keycode)) ?
> > > > 			bios_to_linux_keycode[bios_entry->keycode] :
> > > > 			KEY_RESERVED;
> > > >
> > > >
> > > >
> > > > Also please fix this:
> > > > (no To-header on input) <>
> > >
> > > Hint: specifying git send-email with '--to' argument instead of '--cc=
'
> > > should help.
> > >
> > > >
> > > > --
> > > > ~Randy
> > > >
