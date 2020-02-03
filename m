Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65681C35247
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 16:21:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39EDF21582
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 16:21:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580746884;
	bh=FfBsWZw1sJedskaDXizxipvqH71jaH4qadEjwglJN0w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zqlN+QVnYv4AmQzb2wNhFpKpvgAJ6xKFPYIkuiLW57HjgeMkd3C1iJdpX8QtD5VeP
	 itwhzXqxfG7IC7/7lKXi+jDKZ1krvIOS6JjZWCkXejkhAStcB0nI1lNw5F4juh91k0
	 zny7HDjbsmil2No5fGjo3K6HxUHW5dcpR6Q4dnDM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729152AbgBCQVX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 11:21:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:33174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728245AbgBCQVU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 11:21:20 -0500
Received: from localhost (unknown [104.132.45.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 718AB20838;
        Mon,  3 Feb 2020 16:21:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580746878;
        bh=FfBsWZw1sJedskaDXizxipvqH71jaH4qadEjwglJN0w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gWqUhC7rXSeF9Qq4aoX94L7mhC5B/uWEsub0gNiIGC288DKMd54k+EaPvtOdESrWq
         Yv6LdbiL8c2JmVWwjUE9+t5ArHjvU9aeLHfn6TkyVqsecvo/1zNQy6WfyAtRZIiUFw
         l3MRc1cQGHow0qPRz86s5G3LmGahxOoVyP+uGx34=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Shahed Shaikh <shshaikh@marvell.com>,
        Yonggen Xu <Yonggen.Xu@dell.com>,
        Manish Chopra <manishc@marvell.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 45/53] qlcnic: Fix CPU soft lockup while collecting firmware dump
Date:   Mon,  3 Feb 2020 16:19:37 +0000
Message-Id: <20200203161910.807035095@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200203161902.714326084@linuxfoundation.org>
References: <20200203161902.714326084@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Manish Chopra <manishc@marvell.com>

[ Upstream commit 22e984493a41bf8081f13d9ed84def3ca8cfd427 ]

Driver while collecting firmware dump takes longer time to
collect/process some of the firmware dump entries/memories.
Bigger capture masks makes it worse as it results in larger
amount of data being collected and results in CPU soft lockup.
Place cond_resched() in some of the driver flows that are
expectedly time consuming to relinquish the CPU to avoid CPU
soft lockup panic.

Signed-off-by: Shahed Shaikh <shshaikh@marvell.com>
Tested-by: Yonggen Xu <Yonggen.Xu@dell.com>
Signed-off-by: Manish Chopra <manishc@marvell.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_83xx_init.c | 1 +
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_minidump.c  | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_83xx_init.c b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_83xx_init.c
index bf892160dd5f0..26263a192a77e 100644
--- a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_83xx_init.c
+++ b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_83xx_init.c
@@ -2047,6 +2047,7 @@ static void qlcnic_83xx_exec_template_cmd(struct qlcnic_adapter *p_dev,
 			break;
 		}
 		entry += p_hdr->size;
+		cond_resched();
 	}
 	p_dev->ahw->reset.seq_index = index;
 }
diff --git a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_minidump.c b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_minidump.c
index cda9e604a95f6..e5ea8e972b915 100644
--- a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_minidump.c
+++ b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_minidump.c
@@ -703,6 +703,7 @@ static u32 qlcnic_read_memory_test_agent(struct qlcnic_adapter *adapter,
 		addr += 16;
 		reg_read -= 16;
 		ret += 16;
+		cond_resched();
 	}
 out:
 	mutex_unlock(&adapter->ahw->mem_lock);
@@ -1383,6 +1384,7 @@ int qlcnic_dump_fw(struct qlcnic_adapter *adapter)
 		buf_offset += entry->hdr.cap_size;
 		entry_offset += entry->hdr.offset;
 		buffer = fw_dump->data + buf_offset;
+		cond_resched();
 	}
 
 	fw_dump->clr = 1;
-- 
2.20.1



