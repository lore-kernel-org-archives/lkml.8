Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFA20C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 14:39:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A09212071A
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 14:39:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b="ZN/h8BfL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729049AbgFVOjl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 10:39:41 -0400
Received: from mx0a-00154904.pphosted.com ([148.163.133.20]:60122 "EHLO
        mx0a-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728293AbgFVOjk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 10:39:40 -0400
Received: from pps.filterd (m0170391.ppops.net [127.0.0.1])
        by mx0a-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05MEWIkN017799;
        Mon, 22 Jun 2020 10:39:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=Zmo24u4p/1crh0ITR00I5bmHid3/aReF1yBHjLYrIC0=;
 b=ZN/h8BfLejs+wYCWuDXYGbYLQgMT4o2yI/K8a3VxavFeoDjWxGnjymLelo0zpe4iy3gk
 NRjN13+D5vFCk1qpaAutme682B7P7fnm92mPKfDAdr6bYkCKJQ0Ebd6XFGUNyIpZmL6E
 0GDQtQsHrXv0iYTzXPOznVtGccu0MsqFPTNgMM9DSrrxz8VQF8RNsUiC6zk3QpdNLwsC
 rql24wm7XNBwDEEhvxybgnr/2TFBfXb8YP2zLFgBLNm8LH03zN+ehhh032462E0hmOTq
 bSPkfzv9s60tPZnP7j37+BSLKSZoVNFv0E8t01BlJEoStu3rSt/hZxC5uQwRiSdsK5zc ug== 
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com [67.231.157.37])
        by mx0a-00154904.pphosted.com with ESMTP id 31sdkwvxrp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 Jun 2020 10:39:40 -0400
Received: from pps.filterd (m0134318.ppops.net [127.0.0.1])
        by mx0a-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05MEYW5k147525;
        Mon, 22 Jun 2020 10:39:39 -0400
Received: from ausxippc106.us.dell.com (AUSXIPPC106.us.dell.com [143.166.85.156])
        by mx0a-00154901.pphosted.com with ESMTP id 31sd3e9kmb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Jun 2020 10:39:39 -0400
X-LoopCount0: from 10.166.132.131
X-PREM-Routing: D-Outbound
X-IronPort-AV: E=Sophos;i="5.60,349,1549951200"; 
   d="scan'208";a="561518633"
From:   <Mario.Limonciello@dell.com>
To:     <andreas.noever@gmail.com>, <michael.jamet@intel.com>,
        <mika.westerberg@linux.intel.com>, <YehezkelShB@gmail.com>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 0/2] Allow breaking up Thunderbolt/USB4 updates
Thread-Topic: [PATCH 0/2] Allow breaking up Thunderbolt/USB4 updates
Thread-Index: AQHWSKG0WEYrvhtkREWS32dBR5sml6jktGsQ
Date:   Mon, 22 Jun 2020 14:39:36 +0000
Message-ID: <40e7c39346244df283859ffa90e26a0d@AUSX13MPC105.AMER.DELL.COM>
References: <20200622143035.25327-1-mario.limonciello@dell.com>
In-Reply-To: <20200622143035.25327-1-mario.limonciello@dell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Mario_Limonciello@Dell.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2020-06-22T14:39:30.6035426Z;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Name=External Public;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_ActionId=f8f769ef-5cb1-4710-9355-eee5b8f64610;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Extended_MSFT_Method=Manual
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [143.166.24.40]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-22_08:2020-06-22,2020-06-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 cotscore=-2147483648 malwarescore=0 phishscore=0 suspectscore=0
 impostorscore=0 clxscore=1011 mlxlogscore=999 lowpriorityscore=0
 priorityscore=1501 adultscore=0 mlxscore=0 bulkscore=0 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006220111
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 phishscore=0 spamscore=0 bulkscore=0 adultscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006220111
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Limonciello, Mario <Mario_Limonciello@Dell.com>
> Sent: Monday, June 22, 2020 9:31 AM
> To: Andreas Noever; Michael Jamet; Mika Westerberg; Yehezkel Bernat
> Cc: linux-usb@vger.kernel.org; linux-kernel@vger.kernel.org; Limonciello,
> Mario
> Subject: [PATCH 0/2] Allow breaking up Thunderbolt/USB4 updates
>=20
> Currently updates to Thunderbolt and USB4 controllers are fully atomic
> actions. When writing into the non-active NVM nothing gets flushed to
> the hardware until authenticate is sent.
>=20
> There has been some desire to improve the perceived performance of these
> updates, particularly for userland that may perform the update upon
> a performance sensitive time like logging out.
>=20
> So allow userland to flush the image to hardware at runtime, and then
> allow authenticating the image at another time.
>=20
> For the Dell WD19TB some specific hardware capability exists that allows
> extending this to automatically complete the update when unplugged.
> Export that functionality to userspace as well.
>=20
> This patch series is done relative thunderbolt.git/next.
>=20
> Mario Limonciello (2):
>   thunderbolt: Add support for separating the flush to SPI and
>     authenticate
>   thunderbolt: Add support for authenticate on disconnect
>=20
>  .../ABI/testing/sysfs-bus-thunderbolt         | 24 +++++-
>  drivers/thunderbolt/Makefile                  |  1 +
>  drivers/thunderbolt/eeprom.c                  |  2 +
>  drivers/thunderbolt/lc.c                      | 14 ++++
>  drivers/thunderbolt/quirks.c                  | 38 +++++++++
>  drivers/thunderbolt/switch.c                  | 81 +++++++++++++++----
>  drivers/thunderbolt/tb-quirks.h               | 16 ++++
>  drivers/thunderbolt/tb.h                      |  4 +
>  drivers/thunderbolt/tb_regs.h                 |  1 +
>  9 files changed, 162 insertions(+), 19 deletions(-)
>  create mode 100644 drivers/thunderbolt/quirks.c
>  create mode 100644 drivers/thunderbolt/tb-quirks.h
>=20
> --
> 2.25.1

Just to connect the dots, here is the matching userspace changes for this
change: https://github.com/fwupd/fwupd/pull/2204

