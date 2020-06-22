Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2921C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 16:41:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADA952073E
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 16:41:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b="EuGxZy2R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729673AbgFVQlk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 12:41:40 -0400
Received: from mx0b-00154904.pphosted.com ([148.163.137.20]:34102 "EHLO
        mx0b-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729260AbgFVQlk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 12:41:40 -0400
Received: from pps.filterd (m0170396.ppops.net [127.0.0.1])
        by mx0b-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05MGd6o0016079;
        Mon, 22 Jun 2020 12:41:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=4e+uAadAxNl4v/JYwxLIt5dRfZPmx+iTuQ4DcVgTcKY=;
 b=EuGxZy2RZn5poUwXKew27UpIv/YlDXjP5+amZIvGUWfjC8r7lcXeKfJkY4hM9NO8yL86
 lzb86UR+MeCE4OOr7XoP5wRMBxAGAy4obhSbL8rZdJqGWmIA2HjQwhW0QJjgr4FAFlVw
 1mIb4NlWUe7QGLeLnoiiVlwzyvbFjxd1oaKf90dCBiqY4kqWgNYqwy1oZPpd8+Pknnmw
 S1RGI2T9s/yBDek5ZNp/SL1O17/qI22ZBjtmYeGV0fORKVUR0xS1mETe4H8klqEKZzmD
 m8Zm5OJPH2z7KSB1J2C9x76w3DFsPCDA62bF3oQSDz2uopH9ONkQq3y8uJ0p8dOXlnIg dw== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
        by mx0b-00154904.pphosted.com with ESMTP id 31sng6cxqf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 Jun 2020 12:41:38 -0400
Received: from pps.filterd (m0090351.ppops.net [127.0.0.1])
        by mx0b-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05MGcAhd004826;
        Mon, 22 Jun 2020 12:41:38 -0400
Received: from ausxipps310.us.dell.com (AUSXIPPS310.us.dell.com [143.166.148.211])
        by mx0b-00154901.pphosted.com with ESMTP id 31setf2nc8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Jun 2020 12:41:38 -0400
X-LoopCount0: from 10.166.132.130
X-PREM-Routing: D-Outbound
X-IronPort-AV: E=Sophos;i="5.60,349,1549951200"; 
   d="scan'208";a="513734637"
From:   <Mario.Limonciello@dell.com>
To:     <mika.westerberg@linux.intel.com>
CC:     <andreas.noever@gmail.com>, <michael.jamet@intel.com>,
        <YehezkelShB@gmail.com>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 0/2] Allow breaking up Thunderbolt/USB4 updates
Thread-Topic: [PATCH 0/2] Allow breaking up Thunderbolt/USB4 updates
Thread-Index: AQHWSKG0WEYrvhtkREWS32dBR5sml6jlKYQA//+s3rA=
Date:   Mon, 22 Jun 2020 16:41:35 +0000
Message-ID: <1d2d1c3e753d42ed86cf89a6ed926a67@AUSX13MPC105.AMER.DELL.COM>
References: <20200622143035.25327-1-mario.limonciello@dell.com>
 <20200622163756.GV2795@lahna.fi.intel.com>
In-Reply-To: <20200622163756.GV2795@lahna.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Mario_Limonciello@Dell.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2020-06-22T16:41:34.0868671Z;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Name=External Public;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_ActionId=3e926db7-959d-4eef-bc57-387d1dcc0b64;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Extended_MSFT_Method=Manual
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [143.166.24.40]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-22_10:2020-06-22,2020-06-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 suspectscore=0 clxscore=1015 mlxscore=0 adultscore=0 malwarescore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 priorityscore=1501
 cotscore=-2147483648 mlxlogscore=662 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006220118
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 malwarescore=0
 phishscore=0 bulkscore=0 mlxlogscore=705 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006220118
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Mika Westerberg <mika.westerberg@linux.intel.com>
> Sent: Monday, June 22, 2020 11:38 AM
> To: Limonciello, Mario
> Cc: Andreas Noever; Michael Jamet; Yehezkel Bernat; linux-usb@vger.kernel=
.org;
> linux-kernel@vger.kernel.org
> Subject: Re: [PATCH 0/2] Allow breaking up Thunderbolt/USB4 updates
>=20
>=20
> [EXTERNAL EMAIL]
>=20
> Hi Mario,
>=20
> On Mon, Jun 22, 2020 at 09:30:33AM -0500, Mario Limonciello wrote:
> > Currently updates to Thunderbolt and USB4 controllers are fully atomic
> > actions. When writing into the non-active NVM nothing gets flushed to
> > the hardware until authenticate is sent.
> >
> > There has been some desire to improve the perceived performance of thes=
e
> > updates, particularly for userland that may perform the update upon
> > a performance sensitive time like logging out.
> >
> > So allow userland to flush the image to hardware at runtime, and then
> > allow authenticating the image at another time.
> >
> > For the Dell WD19TB some specific hardware capability exists that allow=
s
> > extending this to automatically complete the update when unplugged.
> > Export that functionality to userspace as well.
> >
> > This patch series is done relative thunderbolt.git/next.
>=20
> Thanks for the patch series. I wonder if you could base this on top of
> my "retimer NVM upgrade" series here (you are also Cc'd):
>=20
>   https://lore.kernel.org/linux-usb/20200616135617.85752-1-
> mika.westerberg@linux.intel.com/
>=20
> That series moves some of the common NVM functionality into a separate
> file (nvm.c).

Sure thing.  Do you by chance already have that on a public branch somewher=
e
that I can easily rebase it?

>=20
> > Mario Limonciello (2):
> >   thunderbolt: Add support for separating the flush to SPI and
> >     authenticate
> >   thunderbolt: Add support for authenticate on disconnect
> >
> >  .../ABI/testing/sysfs-bus-thunderbolt         | 24 +++++-
> >  drivers/thunderbolt/Makefile                  |  1 +
> >  drivers/thunderbolt/eeprom.c                  |  2 +
> >  drivers/thunderbolt/lc.c                      | 14 ++++
> >  drivers/thunderbolt/quirks.c                  | 38 +++++++++
> >  drivers/thunderbolt/switch.c                  | 81 +++++++++++++++----
> >  drivers/thunderbolt/tb-quirks.h               | 16 ++++
> >  drivers/thunderbolt/tb.h                      |  4 +
> >  drivers/thunderbolt/tb_regs.h                 |  1 +
> >  9 files changed, 162 insertions(+), 19 deletions(-)
> >  create mode 100644 drivers/thunderbolt/quirks.c
> >  create mode 100644 drivers/thunderbolt/tb-quirks.h
> >
> > --
> > 2.25.1
