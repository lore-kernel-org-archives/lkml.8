Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75CE2C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 16:14:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35D502076E
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 16:14:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b="XRbcY4Gh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732686AbgFWQOx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 12:14:53 -0400
Received: from mx0b-00154904.pphosted.com ([148.163.137.20]:21754 "EHLO
        mx0b-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732182AbgFWQOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 12:14:53 -0400
Received: from pps.filterd (m0170395.ppops.net [127.0.0.1])
        by mx0b-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05NGBaXO013073;
        Tue, 23 Jun 2020 12:14:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=smtpout1; bh=Fv+Pog/9CSf2u7nGXJo8lLetagBewZlyF3mcN1ukZUM=;
 b=XRbcY4GhzLJkW60C70tG3twDoMURNQumuLiYpXaBWVA8IWcgIax/QmFe9dPueS5n/Olj
 VYjqsQjoYly7SVp8uSrSc6me6HzR/yd9jrgxfLh7ALZSRhSl4O4FVdldVcXLM0qqFCDO
 uhMfOi9Sn20vSbjr2ri+lAQSgyDn7Z/NhsiDEbbC3XqfAGv0HwbXQZOG26IYIH30UbQL
 1rVZGMartGKSaXlBiuxPU7LJXkIQLOjUemQe/4Z46cuxajZ3weXiFyAiixnE30QgO9fX
 CBzXAei0mL2BE05bvPdV7WBcBaO9YspY+xXwKxLn1JXvkQFte49IvWzrCHphr+MUpYWc WQ== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
        by mx0b-00154904.pphosted.com with ESMTP id 31uk5dgjkc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 Jun 2020 12:14:51 -0400
Received: from pps.filterd (m0142693.ppops.net [127.0.0.1])
        by mx0a-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05NG5V5D109532;
        Tue, 23 Jun 2020 12:14:51 -0400
Received: from ausc60pc101.us.dell.com (ausc60pc101.us.dell.com [143.166.85.206])
        by mx0a-00154901.pphosted.com with ESMTP id 31uk2ejqd2-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Jun 2020 12:14:50 -0400
X-LoopCount0: from 10.173.37.130
X-PREM-Routing: D-Outbound
X-IronPort-AV: E=Sophos;i="5.60,349,1549951200"; 
   d="scan'208";a="1568825312"
From:   Mario Limonciello <mario.limonciello@dell.com>
To:     Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        perry.yuan@dell.com, Mario Limonciello <mario.limonciello@dell.com>
Subject: [PATCH v3 0/2] Allow breaking up Thunderbolt/USB4 updates
Date:   Tue, 23 Jun 2020 11:14:27 -0500
Message-Id: <20200623161429.24214-1-mario.limonciello@dell.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-23_10:2020-06-23,2020-06-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 clxscore=1015 mlxscore=0 bulkscore=0 phishscore=0
 mlxlogscore=725 lowpriorityscore=0 adultscore=0 priorityscore=1501
 spamscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006120000 definitions=main-2006230120
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 spamscore=0
 bulkscore=0 mlxlogscore=778 adultscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006120000
 definitions=main-2006230120
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently updates to Thunderbolt and USB4 controllers are fully atomic
actions. When writing into the non-active NVM nothing gets flushed to
the hardware until authenticate is sent.

There has been some desire to improve the perceived performance of these
updates, particularly for userland that may perform the update upon
a performance sensitive time like logging out.

So allow userland to flush the image to hardware at runtime, and then
allow authenticating the image at another time.

For the Dell WD19TB some specific hardware capability exists that allows
extending this to automatically complete the update when unplugged.
Export that functionality to userspace as well.

Changes from v2 to v3:
 - Correct some whitespace and kernel-doc comments
 - Add another missing 'const'
 - For a quirk: (1<<1) -> BIT(0) 

Changes from v1 to v2:
 - Improve documentation
 - Drop tb-quirks.h
 - Adjust function and parameter names to Mika's preferences
 - Rebase onto thunderbolt.git/bleeding-edge to move on top of retimer work

Mario Limonciello (2):
  thunderbolt: Add support for separating the flush to SPI and
    authenticate
  thunderbolt: Add support for authenticate on disconnect

 .../ABI/testing/sysfs-bus-thunderbolt         | 24 +++++-
 drivers/thunderbolt/Makefile                  |  1 +
 drivers/thunderbolt/eeprom.c                  |  2 +
 drivers/thunderbolt/lc.c                      | 14 ++++
 drivers/thunderbolt/quirks.c                  | 38 +++++++++
 drivers/thunderbolt/switch.c                  | 81 +++++++++++++++----
 drivers/thunderbolt/tb-quirks.h               | 16 ++++
 drivers/thunderbolt/tb.h                      |  4 +
 drivers/thunderbolt/tb_regs.h                 |  1 +
 9 files changed, 162 insertions(+), 19 deletions(-)
 create mode 100644 drivers/thunderbolt/quirks.c
 create mode 100644 drivers/thunderbolt/tb-quirks.h

--
2.25.1

