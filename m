Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B93CC2BA1A
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 23:28:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2B2D20753
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 23:28:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="hrsS9f0H";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="j21qbalm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726395AbgDFX2F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 19:28:05 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:8362 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726254AbgDFX2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 19:28:04 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 036MGtnO003796;
        Mon, 6 Apr 2020 15:21:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=proofpoint;
 bh=MNcSBIhmCTIftmQiPFgCaLyglA1gDCy+wCWF8yc2vxA=;
 b=hrsS9f0HNYc4zZgV3Q0Wytq3NwRJ9r2w9gAkK1rYLUV3B3XmvLpz+ikL9KY14x3DmTRZ
 2ydY+zibFTMC/NG6gzlMS8PzdVU0S5ycGJr+dpqr4xbNIjMoVZVx/86/NJHROXXm9PDV
 DUV8fJMOaWvT/uz5t3+76hdPoggMnWYwpAqzYiLQ1DEof9zWq4UNDtkPg/M6qBaIabnv
 jP0zKMXGaQs/ULM76g0+PDHw/mEiIWlqiKWBUBx/81uKoDxH0AMl6mwaG6ZyvPk6YCEx
 l1bYFLJG4bxUo/Z68N1lQ7pBOupa+mt3emR3RwnWRknOKCK7oGWHgJVNS+O/BXKHUuzR 5w== 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2108.outbound.protection.outlook.com [104.47.70.108])
        by mx0a-0014ca01.pphosted.com with ESMTP id 306psw07e9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Apr 2020 15:21:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mxnRac/RMDgHMddWxYgCM1tqi512TjOPMmootvAves7kN1yHhAm+X+RKdgFAlI6IOSLAEl5+oxa3muAScDxxNXul2+1O+hx/gFj4qIa/MvsbBjEt4Tmwj069TzxJkbL9yvI1IRDSV9jXr/uvnmeLmFJhHJ1S1C/puG4KjSaP7VhAmfiEONXCGCvaqiD4hYXpvSlvtDem3SEFGOOJjiLIhniDzQ4EIe5ZrZbS27XiLe7SsM6g1gV884NrvM/cnwBPkseX21ok0OsgQJYOg8Khh0vamonQaIhR7jOoIBtueQ7Ss6yQ38gdsH14IkNqiKYJjdvlV6J7C1RfoNHBZQgqKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MNcSBIhmCTIftmQiPFgCaLyglA1gDCy+wCWF8yc2vxA=;
 b=Rk2KmRZMU+du9FCJto21CcRQIzmdCOFL5TxNd2DrmuKig7MSuu32JKcqa3XmZjJhYKgLq4EMLoQ5l599tI5m0SH8jEDPAFBkhVUJlNNsWASmEG+wwKdKoMUsS85v2VBIO+8Mbcokxug5758nu4S8vXIDaHQvg/ASBbStDmJh5P1+Uzwm6ED85q6gPx+5U4GTJELf5wEZLKTbwuVMruwiQ5n521XFcHXr/MGxG585F8XwmizZjsWqw4kHWsMvK3xo9qUz0SUo72MqdS6/AKhE83ZOo5isy0V/yLGEugjOH/wjzZmJS69uybrJN5Y62uDYpblFKsMTjG++tQAmtXGlAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 199.43.4.23) smtp.rcpttodomain=synopsys.com smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MNcSBIhmCTIftmQiPFgCaLyglA1gDCy+wCWF8yc2vxA=;
 b=j21qbalm3yTL72IrvImwMuYByo8i0VlwOjLhmpw+S3NbROII6gQGk8IRUAfvXgFORJ8TWbaO5qf8yjT1KrUWxruUpS/1qd1edI9iIxrrkwIU/nrJyYCrWmxzVVsI3rgd1cnFsH+9y7dVb24bKjg4ue7wV8QVBBtlvhsbd7+6kOc=
Received: from BN6PR21CA0012.namprd21.prod.outlook.com (2603:10b6:404:8e::22)
 by DM6PR07MB6714.namprd07.prod.outlook.com (2603:10b6:5:1cc::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.15; Mon, 6 Apr
 2020 22:20:58 +0000
Received: from BN8NAM12FT005.eop-nam12.prod.protection.outlook.com
 (2603:10b6:404:8e:cafe::ec) by BN6PR21CA0012.outlook.office365.com
 (2603:10b6:404:8e::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.9 via Frontend
 Transport; Mon, 6 Apr 2020 22:20:57 +0000
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 199.43.4.23 as permitted sender) receiver=protection.outlook.com;
 client-ip=199.43.4.23; helo=rmmaillnx1.cadence.com;
Received: from rmmaillnx1.cadence.com (199.43.4.23) by
 BN8NAM12FT005.mail.protection.outlook.com (10.13.182.167) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2878.9 via Frontend Transport; Mon, 6 Apr 2020 22:20:55 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 036MKpaN026351
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Mon, 6 Apr 2020 18:20:53 -0400
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Tue, 7 Apr 2020 00:20:50 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Tue, 7 Apr 2020 00:20:50 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 036MKoaP008193;
        Tue, 7 Apr 2020 00:20:50 +0200
Received: (from pthombar@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 036MKm9O008168;
        Tue, 7 Apr 2020 00:20:48 +0200
From:   Parshuram Thombare <pthombar@cadence.com>
To:     <bbrezillon@kernel.org>, <vitor.soares@synopsys.com>
CC:     <pgaj@cadence.com>, <linux-i3c@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <mparab@cadence.com>,
        Parshuram Thombare <pthombar@cadence.com>
Subject: [PATCH v1 0/3] I3C mastership handover support
Date:   Tue, 7 Apr 2020 00:20:45 +0200
Message-ID: <1586211645-8065-1-git-send-email-pthombar@cadence.com>
X-Mailer: git-send-email 2.2.2
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:199.43.4.23;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:rmmaillnx1.cadence.com;PTR:InfoDomainNonexistent;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(396003)(39850400004)(376002)(346002)(136003)(36092001)(46966005)(81156014)(356004)(54906003)(478600001)(110136005)(107886003)(81166006)(70586007)(82740400003)(86362001)(8676002)(6666004)(70206006)(36756003)(26826003)(5660300002)(4326008)(316002)(336012)(47076004)(2906002)(186003)(426003)(26005)(2616005)(8936002)(42186006);DIR:OUT;SFP:1101;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5d715910-658c-422c-bfa4-08d7da78c63e
X-MS-TrafficTypeDiagnostic: DM6PR07MB6714:
X-Microsoft-Antispam-PRVS: <DM6PR07MB67143EDC2C4D3806946BCAF6C1C20@DM6PR07MB6714.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0365C0E14B
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ll+Us5ZuHoZPEhj8LPsTtzcm5ZtcyRAXelBrkc+h0A0QtnNzrpQArsbseOFscLf8MsSaiVCAjoXwPKzG8ZnjJHKwpz350QB9TKvagU0bPbvRYbR+7KEaay1AOOZFvJPEbLiq/YZ6r5KxVIcfTO60sCCANz1w+I70zy5JrBoFovfbG/08Dh8Hoc55ZIucfJ44oTNEONnDU81j4ExmKvQUIQEaKP5spenndVTVGEU5T1TbGCBZXBjBkg8ayX58ZYCSpTq4vRp1zecWwRv9TagN1kcelN261ZETIaY+yDx0N9tSLBgwqyU2zyHnqBZ6V3HA9e4Zf7we/7XN7LJEySItv0VVmlQjplO+aHpeEL3JDVSs+P7H8tk2XYDMfG5dIuXPN2lrqNC/tdLjgX7uUsh9OVgePAgaQCZm1xyewosI4Pv/UQzjexds+xn5r7FksVE79rsF5bsq3s7TLP+Ht07zEVfCXYEewSgS4qCkiLVeKR/Bvf+rJQfb6xMnbT5s8SDmdnMfpGRzRBvnWfPdByHSs08L+JEfaJIfVkkxzuBQGDk=
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2020 22:20:55.2836
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d715910-658c-422c-bfa4-08d7da78c63e
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[199.43.4.23];Helo=[rmmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR07MB6714
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-06_10:2020-04-06,2020-04-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 bulkscore=0
 spamscore=0 clxscore=1011 adultscore=0 impostorscore=0 malwarescore=0
 lowpriorityscore=0 phishscore=0 mlxlogscore=979 mlxscore=0 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004060169
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch series is to enable mastership handover feature in I3C
master subsystem and Cadence's I3C controller driver.


[PATCH 1/3]
i3c: master: split bus_init callback into bus_init and master_set_info
There are 2 reasons for this split
Currently bus_init callback is involved in
a. Controller specific settings such as clock prescalar, enabling
   different functionalities and finally enabling the controller.
b. Allocating address to the main master and calling 
   i3c_master_set_info, which basically create a I3C device for master
   and add it to system. This is fine for main master, but for
   secondary master this should be deferred until controller actually
   owns the bus/mastership.
   
Another reason is, to support secondary master initialization without
board info, controller specific bus mode setting need to be done twice
First with pure bus mode and second time when actual bus mode is known
based on data received through DEFSLVS, whereas master set info is
supposed to be done only once.
	      
[PATCH 2/3]
i3c: add mastership handover support to i3c master subsystem
This patch add mastership handover support as per MIPI I3C
spec v1.0. Main master and secondary masters starts in pure
bus mode to allow enumeration (DAA) to happen in same bus mode.
Secondary masters are not required to have information about
other devices connected on the bus through board info, this
information is derived from DEFSLVS received from main
master. While acquiring mastership, requesting master always
make sure that it has active dynamic address, and received
DEFSLVS at least once. Mastership request state machine
make sure that any pending DEFSLVS is processed, so that
when device become master it always have correct view
of the bus.

[PATCH 3/3]
i3c: master: add mastership handover support to cdns i3c master driver
This patch adds mastership handover support to the Cadence
I3C controller driver. Basically, this include necessary
callbacks for mastership request.

Regards,
Parshuram Thombare

Parshuram Thombare (3):
  i3c: master: split bus_init callback into bus_init and master_set_info
  i3c: add mastership handover support to i3c master subsystem
  i3c: master: add mastership handover support to cdns i3c master driver

 drivers/i3c/master.c                 | 490 ++++++++++++++++++++++++---
 drivers/i3c/master/dw-i3c-master.c   |  29 +-
 drivers/i3c/master/i3c-master-cdns.c | 385 ++++++++++++++++++---
 include/linux/i3c/master.h           |  47 ++-
 4 files changed, 854 insertions(+), 97 deletions(-)

-- 
2.17.1

