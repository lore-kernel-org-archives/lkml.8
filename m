Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0C1FC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 19:49:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9BB6220734
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 19:49:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b="dSojpgKT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731846AbgFITtV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 15:49:21 -0400
Received: from mx0a-00154904.pphosted.com ([148.163.133.20]:56208 "EHLO
        mx0a-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730918AbgFITtV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 15:49:21 -0400
Received: from pps.filterd (m0170390.ppops.net [127.0.0.1])
        by mx0a-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 059JfeNA023206;
        Tue, 9 Jun 2020 15:49:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=LA8kJqGFsrM+hk/cfVA663MEbYkoPCLV8kVR6EoxfRk=;
 b=dSojpgKTuCyHTASSRH3O2X12wC6VcIYi/IU68c5/DsZnxsV/UywGCURUo2+LGpyQDsXA
 OmxVqwMa14NIQLiC4jso9677ijZBo6UO/KNNbg3CyKM2YCvL6MM4rF/yMrAh06rQJprW
 tMqNvYdgRjkOs/tPSUWf4BcaU2LazfH235irT8ww3wOUEP7XsqS4E4onoiijcZFBtsIz
 Q2tphC58kklSZb+EAPGZPffTdfSuyWgQduGl4bOTn9GSgDm7K/NxuH5ZUTeXVdkE4w0W
 /oDZPigS9g/6RaR2NNaRqhZbQr+vmRHpmNXpZjS9VJ89+ChfZZLUN9T4ofZVwTKjEd6/ Cw== 
Received: from mx0b-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
        by mx0a-00154904.pphosted.com with ESMTP id 31g6742qfx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 Jun 2020 15:49:20 -0400
Received: from pps.filterd (m0090350.ppops.net [127.0.0.1])
        by mx0b-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 059JkJAq084806;
        Tue, 9 Jun 2020 15:49:20 -0400
Received: from ausxipps306.us.dell.com (AUSXIPPS306.us.dell.com [143.166.148.156])
        by mx0b-00154901.pphosted.com with ESMTP id 31jd8cuhcm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 09 Jun 2020 15:49:20 -0400
X-LoopCount0: from 10.166.132.132
X-PREM-Routing: D-Outbound
X-IronPort-AV: E=Sophos;i="5.73,493,1583215200"; 
   d="scan'208";a="476266035"
From:   <Mario.Limonciello@dell.com>
To:     <pali@kernel.org>, <rdunlap@infradead.org>
CC:     <y.linux@paritcher.com>, <linux-kernel@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>, <mjg59@srcf.ucam.org>
Subject: RE: [PATCH v2 3/3] platform/x86: dell-wmi: add new dmi keys to
 bios_to_linux_keycode
Thread-Topic: [PATCH v2 3/3] platform/x86: dell-wmi: add new dmi keys to
 bios_to_linux_keycode
Thread-Index: AQHWPelqfgxdvjwP/0a7+jtlxWF6SqjPsKgAgAAH0ACAAPg6kA==
Date:   Tue, 9 Jun 2020 19:49:18 +0000
Message-ID: <ced5832cfe984c68b27a577cac0f02f1@AUSX13MPC105.AMER.DELL.COM>
References: <cover.1591584631.git.y.linux@paritcher.com>
 <cover.1591656154.git.y.linux@paritcher.com>
 <d585d2a0f01a6b9480352530b571dec2d1afd79f.1591656154.git.y.linux@paritcher.com>
 <8053252a-83ad-bcaa-2830-ccfbca1b4152@infradead.org>
 <20200608235508.wthtgilgmifwfgz2@pali>
In-Reply-To: <20200608235508.wthtgilgmifwfgz2@pali>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Mario_Limonciello@Dell.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2020-06-09T19:49:07.3676331Z;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Name=External Public;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_ActionId=403f99b9-e736-4d01-8469-1b310f08c85a;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Extended_MSFT_Method=Manual
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [143.166.24.60]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-09_13:2020-06-09,2020-06-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 cotscore=-2147483648 priorityscore=1501 impostorscore=0 malwarescore=0
 adultscore=0 bulkscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999
 clxscore=1015 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006090150
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 mlxscore=0 bulkscore=0 spamscore=0 adultscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006090149
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>=20
> Looking at the last two lines... and for me it looks like that 0x00FF
> and 0xFFFF are just "placeholders" or special values for unknown /
> custom / unsupported / reserved / special / ... codes.
>=20
> It is really suspicious why first 38 values are defined, then there is
> gap, then one value 255 and then huge gap to 65535.
>=20
> Mario, this looks like some mapping table between internal Dell BIOS key
> code and standard Linux key code. Are you able to get access to some
> documentation which contains explanation of those Dell key numbers?
> It could really help us to understand these gaps and what is correct
> interpretation of these numbers.
>=20

The codes are actually 4 bytes in the table, but in practice nothing above =
the
first two bytes is used.

Those two called out are special though, here are their meanings:

0x00FF is user programmable function
0xFFFF is no function

For the purpose of memory consumption I think it's reasonable to ignore the
upper 2 bytes and special case these two.

> E.g. I remember that pressing Fn+Q or Fn+W on some Dell Latitude
> generates code 255, which could prove my thesis about "special codes"
> (which are probably not found in e.g. Windows or Linux mapping tables).
>=20
> > >  };
> > >
> > >  /*
> > > @@ -503,10 +504,7 @@ static void handle_dmi_entry(const struct
> dmi_header *dm, void *opaque)
> > >  					&table->keymap[i];
> > >
> > >  		/* Uninitialized entries are 0 aka KEY_RESERVED. */
> > > -		u16 keycode =3D (bios_entry->keycode <
> > > -			       ARRAY_SIZE(bios_to_linux_keycode)) ?
> > > -			bios_to_linux_keycode[bios_entry->keycode] :
> > > -			KEY_RESERVED;
> > > +		u16 keycode =3D bios_to_linux_keycode[bios_entry->keycode];
> > >
> > >  		/*
> > >  		 * Log if we find an entry in the DMI table that we don't
> > >
> >
> > Something like:
> >
> > 		u16 keycode;
> >
> > 		keycode =3D bios_entry->keycode =3D=3D 0xffff ? KEY_UNKNOWN :
> > 			(bios_entry->keycode <
> > 			       ARRAY_SIZE(bios_to_linux_keycode)) ?
> > 			bios_to_linux_keycode[bios_entry->keycode] :
> > 			KEY_RESERVED;
> >
> >
> >
> > Also please fix this:
> > (no To-header on input) <>
>=20
> Hint: specifying git send-email with '--to' argument instead of '--cc'
> should help.
>=20
> >
> > --
> > ~Randy
> >
