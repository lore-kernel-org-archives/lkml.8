Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E99D2C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 14:30:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2CE6206D4
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 14:30:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b="klVAMNY5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729247AbgFVOam (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 10:30:42 -0400
Received: from mx0a-00154904.pphosted.com ([148.163.133.20]:25980 "EHLO
        mx0a-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729153AbgFVOam (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 10:30:42 -0400
Received: from pps.filterd (m0170391.ppops.net [127.0.0.1])
        by mx0a-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05MEMHUD005592;
        Mon, 22 Jun 2020 10:30:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=smtpout1; bh=vdMlEL1e4onKMymyvUHY3C7AdlJdIdimM5Jv4bOvNJo=;
 b=klVAMNY5vmNUQUP6MdLDrtZELmMY0MURtVOa2rgOmqds0PH/CGlKoCmM+qxQQEnN5ziI
 mrfIAJWM+/3hhYgREpncm45Ib3EUUmTk9RkqEO3nTcatA6oq6R3PI7ZTld2FuwVLo2GG
 N37XniZhABBtMDG7g33bffCt3cYyI6bTV8EwyKnZ9AyIUOW9OIidr6b296DmWhz0q3LA
 2THjuUi5n21uptm4xWWKrhimrhZB70CRyqTqDCXVc5JldLSE1FqCw+YRlztnGfai0toy
 17oj7c0pD9rh9uEbjvfdVgcuBhSQe4Dabrat93nzEp5AfDtAkTYCoccyq8yghOaoTBEK zw== 
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com [67.231.157.37])
        by mx0a-00154904.pphosted.com with ESMTP id 31sdkwvweu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 Jun 2020 10:30:41 -0400
Received: from pps.filterd (m0144104.ppops.net [127.0.0.1])
        by mx0b-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05MESgwG074354;
        Mon, 22 Jun 2020 10:30:40 -0400
Received: from ausxipps310.us.dell.com (AUSXIPPS310.us.dell.com [143.166.148.211])
        by mx0b-00154901.pphosted.com with ESMTP id 31sbqgt7s6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Jun 2020 10:30:40 -0400
X-LoopCount0: from 10.173.37.130
X-PREM-Routing: D-Outbound
X-IronPort-AV: E=Sophos;i="5.60,349,1549951200"; 
   d="scan'208";a="513697117"
From:   Mario Limonciello <mario.limonciello@dell.com>
To:     Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mario Limonciello <mario.limonciello@dell.com>
Subject: [PATCH 0/2] Allow breaking up Thunderbolt/USB4 updates
Date:   Mon, 22 Jun 2020 09:30:33 -0500
Message-Id: <20200622143035.25327-1-mario.limonciello@dell.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-22_08:2020-06-22,2020-06-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 impostorscore=0 cotscore=-2147483648 lowpriorityscore=0 mlxlogscore=475
 phishscore=0 suspectscore=0 bulkscore=0 priorityscore=1501 clxscore=1011
 adultscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006220110
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=530 malwarescore=0
 phishscore=0 spamscore=0 bulkscore=0 adultscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006220110
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

This patch series is done relative thunderbolt.git/next.

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

