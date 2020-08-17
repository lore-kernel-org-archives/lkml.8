Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68369C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 18:17:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 248E420716
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 18:17:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597688249;
	bh=DVs1MWtGNgV0jc7anKzqFiims4vOYd3zokIsthntDXA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aTOVCEQo7xXvXQf0PODyuhBs0f07o9c5TJU0WaLKRMibbznAuahGu2TXiBTwRi2Ho
	 5BmGf7sny12r5o6tlw2EpRivJioEA8Oz7ftToUelUZyv5qSLCrwstLEvWa8E9gN3xy
	 f50kLYEJiAe38EpOOaaPfV+kNq0brutHHreBO1Yc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390519AbgHQSRW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 14:17:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:53234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388379AbgHQQFs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 12:05:48 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0E86E20760;
        Mon, 17 Aug 2020 16:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597680341;
        bh=DVs1MWtGNgV0jc7anKzqFiims4vOYd3zokIsthntDXA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W6+H5A5m22Q5OReajIE9wC4fbLQKU7M4rhg9AU8LdzprqFu/+qz8Hfn36tO1Gq7EK
         bnfbM5KudhVvo6oRCbEJM8zJNx4l7ST7LGg9F4Z6iLfj/S+j1UNkrtmfX8F3AWe8wY
         EqLSMQA15ljsCQ5SsARUFAQ5TxNek+aH1NOt1H8w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 148/270] PCI/ASPM: Add missing newline in sysfs policy
Date:   Mon, 17 Aug 2020 17:15:49 +0200
Message-Id: <20200817143803.181914108@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200817143755.807583758@linuxfoundation.org>
References: <20200817143755.807583758@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiongfeng Wang <wangxiongfeng2@huawei.com>

[ Upstream commit 3167e3d340c092fd47924bc4d23117a3074ef9a9 ]

When I cat ASPM parameter 'policy' by sysfs, it displays as follows.  Add a
newline for easy reading.  Other sysfs attributes already include a
newline.

  [root@localhost ~]# cat /sys/module/pcie_aspm/parameters/policy
  [default] performance powersave powersupersave [root@localhost ~]#

Fixes: 7d715a6c1ae5 ("PCI: add PCI Express ASPM support")
Link: https://lore.kernel.org/r/1594972765-10404-1-git-send-email-wangxiongfeng2@huawei.com
Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/pcie/aspm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 4a0ec34062d60..7624c71011c6e 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -1157,6 +1157,7 @@ static int pcie_aspm_get_policy(char *buffer, const struct kernel_param *kp)
 			cnt += sprintf(buffer + cnt, "[%s] ", policy_str[i]);
 		else
 			cnt += sprintf(buffer + cnt, "%s ", policy_str[i]);
+	cnt += sprintf(buffer + cnt, "\n");
 	return cnt;
 }
 
-- 
2.25.1



