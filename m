Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BDE1C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 19:23:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 758332070B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 19:23:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b="NWLrIjTZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730213AbgFJTXB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 15:23:01 -0400
Received: from mx0b-00154904.pphosted.com ([148.163.137.20]:33358 "EHLO
        mx0b-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726567AbgFJTXA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 15:23:00 -0400
Received: from pps.filterd (m0170394.ppops.net [127.0.0.1])
        by mx0b-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05AJL4BL005183;
        Wed, 10 Jun 2020 15:22:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=/B2C+W6R7eOOIWQ0ywM0+IA3i4O69t8RI+3h7CerFfY=;
 b=NWLrIjTZkzXJukIT27eH3072enHMSiK6JP1Rc9exwUvVlPjg9UOwT4mSCbYQTkbhqT6Q
 okBI3oD3pvWZoymZv62yGMNConzVBGKCi24DsyVxHoUcNTwuZoK5GoqOyIHNYsKJDw8x
 dYsv/YB1jBSp5fZqR5sahLrRRQKPXXnpnWan24gUGNYvK9ngB3hkWr8GF+GbYX96VxHm
 K04d3yBlIjCK/0yAXlJTUb5Mu9Rc+oX3v+ZjauJuubZThb00gUuvIFR4FFC8FjATrAXy
 cSlW6PcWaFtaztQezmUsOz7B33ZfjYk+/Q4VhjXCB7J97NpGTPHVoSdjTRLQsvhxtynP lg== 
Received: from mx0a-00154901.pphosted.com (mx0b-00154901.pphosted.com [67.231.157.37])
        by mx0b-00154904.pphosted.com with ESMTP id 31jjr7v7pj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 Jun 2020 15:22:58 -0400
Received: from pps.filterd (m0089484.ppops.net [127.0.0.1])
        by mx0b-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05AJJjo9117592;
        Wed, 10 Jun 2020 15:22:58 -0400
Received: from ausxippc110.us.dell.com (AUSXIPPC110.us.dell.com [143.166.85.200])
        by mx0b-00154901.pphosted.com with ESMTP id 31k4x7gky2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Jun 2020 15:22:58 -0400
X-LoopCount0: from 10.166.132.129
X-PREM-Routing: D-Outbound
X-IronPort-AV: E=Sophos;i="5.60,349,1549951200"; 
   d="scan'208";a="951923579"
From:   <Mario.Limonciello@dell.com>
To:     <andy@infradead.org>, <dvhart@infradead.org>
CC:     <linux-kernel@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>, <mjg59@srcf.ucam.org>,
        <y.linux@paritcher.com>, <pali@kernel.org>
Subject: RE: [PATCH v4 0/3] platform/x86: dell-wmi: new keys
Thread-Topic: [PATCH v4 0/3] platform/x86: dell-wmi: new keys
Thread-Index: AQHWP1CeLzY2jL9vCkK7qCtmqxbT+KjSOJug
Date:   Wed, 10 Jun 2020 19:22:56 +0000
Message-ID: <7fb650f568b44eb78e37aa8a534a69d7@AUSX13MPC105.AMER.DELL.COM>
References: <cover.1591584631.git.y.linux@paritcher.com>
 <cover.1591811549.git.y.linux@paritcher.com>
In-Reply-To: <cover.1591811549.git.y.linux@paritcher.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Mario_Limonciello@Dell.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2020-06-10T19:22:55.1265301Z;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Name=External Public;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_ActionId=4024a96b-2eeb-4dcb-9b3a-e465d0399de9;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Extended_MSFT_Method=Manual
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [143.166.24.60]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-10_12:2020-06-10,2020-06-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 clxscore=1015 priorityscore=1501 impostorscore=0 mlxscore=0
 suspectscore=0 bulkscore=0 spamscore=0 phishscore=0 malwarescore=0
 cotscore=-2147483648 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006100143
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 suspectscore=0
 phishscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006100143
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Y Paritcher <y.linux@paritcher.com>
> Sent: Wednesday, June 10, 2020 12:57 PM
> To: Pali Roh=E1r
> Cc: linux-kernel@vger.kernel.org; platform-driver-x86@vger.kernel.org;
> Matthew Garrett; Limonciello, Mario
> Subject: [PATCH v4 0/3] platform/x86: dell-wmi: new keys
>=20
>=20
> [EXTERNAL EMAIL]
>=20
> change since v3:
>     No code changes.
>     Update commit message to reflect info given by Mario at dell.
>=20
> Is there anything more i have to do for the patches that were reviewed
> or will they be picked up by the maintainers?
> Thanks
>=20
> Y Paritcher (3):
>   platform/x86: dell-wmi: add new backlight events
>   platform/x86: dell-wmi: add new keymap type 0x0012
>   platform/x86: dell-wmi: add new dmi mapping for keycode 0xffff
>=20
>  drivers/platform/x86/dell-wmi.c | 28 +++++++++++++++++++++++++---
>  1 file changed, 25 insertions(+), 3 deletions(-)
>=20
> --
> 2.27.0

Andy,

The whole series looks good to me now.  You can put this on the patches
when they're swooped up.

Reviewed-by: Mario Limonciello <mario.limonciello@dell.com>

However I would like to note there was a comment that you had a direct ques=
tion
asked by Pali that probably got lost in the thread.  This was on patch 3/3 =
on v3.
I think it's worth answering as it could dictate a follow up patch to chang=
e behavior.

The summary of my argument which led to his is nested somewhere in the thre=
ad was that
to most users this isn't useful since they can't act on it.  IE they can't =
use something
like setkeycodes and go on their merry way.  The user who could act on it b=
y coming
to upstream and submitting questions and patches is more technical and havi=
ng them
use dyndbg to turn on the messages about unknown shouldn't be a big deal.

> I'm not sure, but I thought that
> throwing warning or info message is the correct solution. Driver cannot
> handle something, so it inform about it, instead of silently dropping
> event. Same behavior I'm seeing in other kernel drivers.

> But looks like that you and Mario have opposite opinion, that kernel
> should not log unknown events and rather should drop them.

> I would like to have behavior of dell-wmi same as in other drivers for
> consistency, so the best would be to ask WMI/platform maintainers. They
> could have opinion how to handle these problem globally.

> ...

> Darren & Andy, could you please say something to this, what do you think
> about silently dropping events/actions which are currently unknown for
> dell-wmi driver? It is better to log them or not? Currently we are
> logging them.

Can you please advise which way you would rather have the subsystem go?

