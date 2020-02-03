Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99A91C35247
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 16:26:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C47D2086A
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 16:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580747214;
	bh=w/V+7udM5IAnQfSftwDRwG0pQYmXYZVEWGB5lGKibik=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MKqF7ODmjCg6HR+gS5ljdKgnrLNxCmB3J4YaoRnUupAQ2js6dgmIWOZcy9LOAX394
	 JFxzKzEKnbXZYKHpXMIdkvp60Sjxz5hVTy6stYwULz9U7sACSzQdQ9SbDSvaZyPXWX
	 66mJgcr6+LNYDr86wppWi3hwtUwZjs5koZSmxp2A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726272AbgBCQ0x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 11:26:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:37940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729292AbgBCQ0u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 11:26:50 -0500
Received: from localhost (unknown [104.132.45.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0D1052051A;
        Mon,  3 Feb 2020 16:26:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580747210;
        bh=w/V+7udM5IAnQfSftwDRwG0pQYmXYZVEWGB5lGKibik=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vTZHXJcJP+50/c3ZKjDjCbdS0PpYGO+8dLLhI1mI+yT+/Rja95n/IGDXjQM/Os9l5
         ikvs3JJy78x0YSgYGkb6ENmxHHaYWKsW9ydzUM6jb1EPjd0RTuq35GWTCT0zN1EeC2
         Tnaa79muwPJUNJhf+D2ggK3+j3nVyn8I+3gFhoWY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Shahed Shaikh <shshaikh@marvell.com>,
        Yonggen Xu <Yonggen.Xu@dell.com>,
        Manish Chopra <manishc@marvell.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 58/68] qlcnic: Fix CPU soft lockup while collecting firmware dump
Date:   Mon,  3 Feb 2020 16:19:54 +0000
Message-Id: <20200203161914.482173732@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200203161904.705434837@linuxfoundation.org>
References: <20200203161904.705434837@linuxfoundation.org>
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
index a496390b8632f..07f9067affc65 100644
--- a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_83xx_init.c
+++ b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_83xx_init.c
@@ -2043,6 +2043,7 @@ static void qlcnic_83xx_exec_template_cmd(struct qlcnic_adapter *p_dev,
 			break;
 		}
 		entry += p_hdr->size;
+		cond_resched();
 	}
 	p_dev->ahw->reset.seq_index = index;
 }
diff --git a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_minidump.c b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_minidump.c
index 0844b7c757670..5174e0bd75d1e 100644
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



