Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 478B7C433EB
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 17:29:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20C0A2067D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 17:29:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RUBQfUgm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729334AbgGPR3o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 13:29:44 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:60320 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726986AbgGPR3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 13:29:43 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06GHMCCs108201;
        Thu, 16 Jul 2020 17:29:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to; s=corp-2020-01-29;
 bh=ZkLmXaQi9ugUcPGIWCmMgZ6iQMhcjVJkBMoXeOQwmyM=;
 b=RUBQfUgmGKChbgMYUmEvIcVT3+aJZYhwqkHWUKpO5rPrQkilijpWXETaWT4LmQ96BF7y
 P/oKa+3s6SFsI7CYFSlnZRD/x9AVlbiugk+uKy4Ry8kt7WtR+aQai9iIO4jC7DtJl+nn
 HLXPSAGelTdcbvi3LLlduGK4hxHTOObWVHxs731Sz64ppe9UaW/V53mFmddjReVQ0R1n
 akCk8xVzPJF9UjkAW9t0vyjd8Vo5koDzZa6q+UkTP+WAY1yXOTVPZRnX8ROBN0CM41iU
 PDOgoL08ydnGbrdA5iPFyB/T1MKQp/O+1FRVP1IhrnS2BRpSG1rilgv92WJoNmHfN0ON qg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 3274urjv5v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 16 Jul 2020 17:29:37 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06GHHlFm071570;
        Thu, 16 Jul 2020 17:29:37 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 32akr3qw0r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Jul 2020 17:29:36 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 06GHTZVM019031;
        Thu, 16 Jul 2020 17:29:35 GMT
Received: from paddy.uk.oracle.com (/10.175.173.87)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 16 Jul 2020 10:29:35 -0700
From:   Joao Martins <joao.m.martins@oracle.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-nvdimm@lists.01.org, Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Jason Zeng <jason.zeng@intel.com>
Subject: [PATCH v1 0/4] device-dax: Further improvements to subdivision
Date:   Thu, 16 Jul 2020 18:29:09 +0100
Message-Id: <20200716172913.19658-1-joao.m.martins@oracle.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <159457116473.754248.7879464730875147365.stgit@dwillia2-desk3.amr.corp.intel.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9684 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 suspectscore=0 mlxlogscore=999 spamscore=0 mlxscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007160126
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9684 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 impostorscore=0
 suspectscore=0 phishscore=0 spamscore=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 priorityscore=1501 adultscore=0 bulkscore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007160126
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey,

Here's a small set of improvements that I was hoping you would consider as part
of your Soft-Reserved series[0]; should you think they make sense. It does the
following:

  Patch 1-2: Add an align sysfs attribute, as opposed to being limited to 2M.
  This brings parity to static dax regions, which support 1G.

  Patch 3. Add a module parameter to hmem, to initialize the region as idle
  with full available_size for child devices. When the region is gonna be
  partiotined by default and assigned to guests, doesn't help to
  initialize the region. Also if the majority of the region starts
  non-idle and it's a region which memmap is bigger than System-Ram,
  then there not be enough space for the device to be probed successfully.

  Patch 4: Add an sysfs attribute for range allocation. It is a single entry
  where you pass a range <start>-<end> and where the ordering plus range
  length designate the page_offset. It is meant for recreate the same
  mappings after kexec (retaining the GPA->HPA association), but could
  also allow application to implement their own allocation strategy.

I will submit a separate daxctl counterpart shortly, to help visualize its use.

[0] https://lore.kernel.org/linux-mm/159457116473.754248.7879464730875147365.stgit@dwillia2-desk3.amr.corp.intel.com

	Joao

Joao Martins (4):
  device-dax: Make align a per-device property
  device-dax: Add an 'align' attribute
  dax/hmem: Introduce dax_hmem.region_idle parameter
  device-dax: Add a range mapping allocation attribute

 drivers/dax/bus.c         | 166 +++++++++++++++++++++++++++++++++++---
 drivers/dax/dax-private.h |   1 +
 drivers/dax/device.c      |  35 ++++----
 drivers/dax/hmem/hmem.c   |   5 +-
 4 files changed, 177 insertions(+), 30 deletions(-)

-- 
2.17.1

