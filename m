Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A97E6C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 14:31:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B8B6207BB
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 14:31:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728271AbgHTObG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 10:31:06 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:58954 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728146AbgHTOaz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 10:30:55 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 9D0C37F4FFE6FC5DCB0D;
        Thu, 20 Aug 2020 22:30:51 +0800 (CST)
Received: from DESKTOP-C3MD9UG.china.huawei.com (10.174.177.253) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.487.0; Thu, 20 Aug 2020 22:30:41 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Oliver O'Halloran <oohall@gmail.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Dave Jiang" <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH 0/4] clean up some functions in nvdimm/badrange.c and namespace_devs.c
Date:   Thu, 20 Aug 2020 22:30:23 +0800
Message-ID: <20200820143027.3241-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.177.253]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When I learned the code of drivers/nvdimm, I found some places can be improved.

Zhen Lei (4):
  libnvdimm: remove redundant list_empty() check in badrange.c
  libnvdimm: eliminate a meaningless spinlock operation
  libnvdimm: eliminate two unnecessary zero initializations in
    badrange.c
  libnvdimm: avoid unnecessary judgments in nvdimm_namespace_disk_name()

 drivers/nvdimm/badrange.c       | 36 ++++++++++--------------------------
 drivers/nvdimm/namespace_devs.c | 12 +++++-------
 2 files changed, 15 insertions(+), 33 deletions(-)

-- 
1.8.3


