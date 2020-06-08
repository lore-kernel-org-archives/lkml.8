Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29DF7C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 20:58:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1BD520774
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 20:58:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b="UMfkHMbj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbgFHU6n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 16:58:43 -0400
Received: from mx0a-00154904.pphosted.com ([148.163.133.20]:63082 "EHLO
        mx0a-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726750AbgFHU6m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 16:58:42 -0400
Received: from pps.filterd (m0170389.ppops.net [127.0.0.1])
        by mx0a-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 058KuZY3020602;
        Mon, 8 Jun 2020 16:58:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=2nZgjQrVfoK+jNvV4hyQm+SOy45OnTuBnWHMUl8mNQY=;
 b=UMfkHMbjuFIWVDbzfBHLEv3VOkTe1Xdh7xJn7VMjK3+vrZpbNZlB82hvkPPr/Ijc3fA8
 m+Z09NESRqBdBXcdElIEHPFL1W1EDi8ZZghg0FzprRFXM3DD2YHfY6Y0HuNXoBZPK1eM
 UVumAbDC1Dl2wJW6qItlc2XGP20IUqFt+oprkODOJnYBh+Tw1ntz8qJtrVc9ilwq71L2
 uWUXY5sIJtKlbbDYTrBOuM7PoiRc5CYNEStMSxIXhNahFc9h4Jm1Wbf3q1aP0TwY1Vd9
 Yc7uk4TQ0mZv1qdXJLUEP9XI1/hjuVj1NNvomlpNHjwP3X2XQyltEV8EEtI3kxpSnykH hw== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
        by mx0a-00154904.pphosted.com with ESMTP id 31hb58uj1q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 Jun 2020 16:58:41 -0400
Received: from pps.filterd (m0133268.ppops.net [127.0.0.1])
        by mx0a-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 058KrCX0001675;
        Mon, 8 Jun 2020 16:58:41 -0400
Received: from ausxipps301.us.dell.com (ausxipps301.us.dell.com [143.166.148.223])
        by mx0a-00154901.pphosted.com with ESMTP id 31ga9bv7bt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 08 Jun 2020 16:58:41 -0400
X-LoopCount0: from 10.166.132.130
X-PREM-Routing: D-Outbound
X-IronPort-AV: E=Sophos;i="5.60,349,1549951200"; 
   d="scan'208";a="497434910"
From:   <Mario.Limonciello@dell.com>
To:     <pali@kernel.org>
CC:     <y.linux@paritcher.com>, <linux-kernel@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>, <mjg59@srcf.ucam.org>
Subject: RE: [PATCH 3/3] platform/x86: dell-wmi: add keys to
 bios_to_linux_keycode
Thread-Topic: [PATCH 3/3] platform/x86: dell-wmi: add keys to
 bios_to_linux_keycode
Thread-Index: AQHWPUx9sFYF+BrpzUSmmNRF6qlL7KjOv66AgAAcqwCAAKkwAP//rmlw
Date:   Mon, 8 Jun 2020 20:58:38 +0000
Message-ID: <f7ab352f27954bbb88bafb41d6b17fe1@AUSX13MPC105.AMER.DELL.COM>
References: <cover.1591584631.git.y.linux@paritcher.com>
 <13951508596a3f654c6d47f5380ddb4f38e2f6b5.1591584631.git.y.linux@paritcher.com>
 <20200608090017.4qgtbosz7oullex2@pali>
 <8baab72e3d2e407792c3ffa1d9fffba8@AUSX13MPC105.AMER.DELL.COM>
 <20200608204826.kb7x5mh6hzj2hxcz@pali>
In-Reply-To: <20200608204826.kb7x5mh6hzj2hxcz@pali>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Mario_Limonciello@Dell.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2020-06-08T20:58:13.2682354Z;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Name=External Public;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_ActionId=01cd3207-5cda-4e26-b0a1-035c348d8cbe;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Extended_MSFT_Method=Manual
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [143.166.24.60]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-08_18:2020-06-08,2020-06-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 adultscore=0 priorityscore=1501 clxscore=1015 phishscore=0 mlxlogscore=999
 spamscore=0 impostorscore=0 malwarescore=0 mlxscore=0 lowpriorityscore=0
 cotscore=-2147483648 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006080145
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 phishscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006080146
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: platform-driver-x86-owner@vger.kernel.org <platform-driver-x86-
> owner@vger.kernel.org> On Behalf Of Pali Roh=E1r
> Sent: Monday, June 8, 2020 3:48 PM
> To: Limonciello, Mario
> Cc: y.linux@paritcher.com; linux-kernel@vger.kernel.org; platform-driver-
> x86@vger.kernel.org; mjg59@srcf.ucam.org
> Subject: Re: [PATCH 3/3] platform/x86: dell-wmi: add keys to
> bios_to_linux_keycode
>=20
>=20
> [EXTERNAL EMAIL]
>=20
> On Monday 08 June 2020 15:46:44 Mario.Limonciello@dell.com wrote:
> > I would actually question if there is value to lines in dell-wmi.c like
> this:
> >
> > pr_info("Unknown WMI event type 0x%x\n", (int)buffer_entry[1]);
> >
> > and
> >
> > pr_info("Unknown key with type 0x%04x and code 0x%04x pressed\n", type,
> code);
> >
> > In both of those cases the information doesn't actually help the user, =
by
> default it's
> > ignored by the driver anyway.  It just notifies the user it's something
> the driver doesn't
> > comprehend.  I would think these are better suited to downgrade to debu=
g.
> And if
> > a key combination isn't doing something expected the user can use dyndb=
g
> to turn it
> > back on and can be debugged what should be populated or "explicitly"
> ignored.
>=20
> My motivation for these messages was to provide information to user that
> kernel received event, but was not able to process it as it do not
> understand it.
>=20
> It could help in situation when user press special key and nothing is
> delivered to userspace. But he could see that something happened in log.
>=20

But does a user know what to do with this information?  From time to time
coming to kernel mailing list, but that's it.

I think same person who would know to come to kernel mailing list for a key
not working can likely also hand turning on dyndbg to get the info.

> Similar message is also printed by PS/2 keyboard driver atkbd.c:
>=20
> 	case ATKBD_KEY_UNKNOWN:
> 		dev_warn(&serio->dev,
> 			 "Unknown key %s (%s set %d, code %#x on %s).\n",
> 			 atkbd->release ? "released" : "pressed",
> 			 atkbd->translated ? "translated" : "raw",
> 			 atkbd->set, code, serio->phys);
> 		dev_warn(&serio->dev,
> 			 "Use 'setkeycodes %s%02x <keycode>' to make it known.\n",
> 			 code & 0x80 ? "e0" : "", code & 0x7f);
> 		input_sync(dev);
> 		break;

I think the difference here is that user can actually do something from use=
rland
to do with `setkeycodes` for PS2.

