Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C450C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 23:25:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6574F2078D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 23:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591658727;
	bh=nuRbWw5Kchm3ShfLDintiliZPeou6jAUSjOoxaq8Y2A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wx/aXBHB8WdbxARh56bOfw1EDrKxp8udbgCl+4IHXDQ0Ncw54vqBvrKoN2PYKjxbE
	 MFwa+4Xdu/3VR+fgUvrAJwo9euIFEhFg1GkhTvFs3BHs8frIN+D6kJ53onEWPWicXF
	 R3tiMUP/czg3YO0zfdrLPxIIaQ11dqgk/I6VS+4c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731146AbgFHXZ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 19:25:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:43988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730959AbgFHXUZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 19:20:25 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8F9042089D;
        Mon,  8 Jun 2020 23:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591658424;
        bh=nuRbWw5Kchm3ShfLDintiliZPeou6jAUSjOoxaq8Y2A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CDftZJXTZfP1ikd9xCSdQpu0ZlcO1SJ1fsuPDjGBgas9mwk6PPIGAFsMqnPzTd02g
         LJrh8a+ie2ixaCgbZOuu0JXf7xsl4lqSFALzTNBxKKZ4ymqfmv8JKBq7hpO9qi+L4z
         qPVg+YedNpqyRH9JRt+MDU445oKqlsYU/0IGPqf0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Aaron Brown <aaron.f.brown@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <sashal@kernel.org>,
        intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: [PATCH AUTOSEL 5.4 070/175] e1000: Distribute switch variables for initialization
Date:   Mon,  8 Jun 2020 19:17:03 -0400
Message-Id: <20200608231848.3366970-70-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200608231848.3366970-1-sashal@kernel.org>
References: <20200608231848.3366970-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kees Cook <keescook@chromium.org>

[ Upstream commit a34c7f5156654ebaf7eaace102938be7ff7036cb ]

Variables declared in a switch statement before any case statements
cannot be automatically initialized with compiler instrumentation (as
they are not part of any execution flow). With GCC's proposed automatic
stack variable initialization feature, this triggers a warning (and they
don't get initialized). Clang's automatic stack variable initialization
(via CONFIG_INIT_STACK_ALL=y) doesn't throw a warning, but it also
doesn't initialize such variables[1]. Note that these warnings (or silent
skipping) happen before the dead-store elimination optimization phase,
so even when the automatic initializations are later elided in favor of
direct initializations, the warnings remain.

To avoid these problems, move such variables into the "case" where
they're used or lift them up into the main function body.

drivers/net/ethernet/intel/e1000/e1000_main.c: In function ‘e1000_xmit_frame’:
drivers/net/ethernet/intel/e1000/e1000_main.c:3143:18: warning: statement will never be executed [-Wswitch-unreachable]
 3143 |     unsigned int pull_size;
      |                  ^~~~~~~~~

[1] https://bugs.llvm.org/show_bug.cgi?id=44916

Signed-off-by: Kees Cook <keescook@chromium.org>
Tested-by: Aaron Brown <aaron.f.brown@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/e1000/e1000_main.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/e1000/e1000_main.c b/drivers/net/ethernet/intel/e1000/e1000_main.c
index 86493fea56e4..f93ed70709c6 100644
--- a/drivers/net/ethernet/intel/e1000/e1000_main.c
+++ b/drivers/net/ethernet/intel/e1000/e1000_main.c
@@ -3140,8 +3140,9 @@ static netdev_tx_t e1000_xmit_frame(struct sk_buff *skb,
 		hdr_len = skb_transport_offset(skb) + tcp_hdrlen(skb);
 		if (skb->data_len && hdr_len == len) {
 			switch (hw->mac_type) {
+			case e1000_82544: {
 				unsigned int pull_size;
-			case e1000_82544:
+
 				/* Make sure we have room to chop off 4 bytes,
 				 * and that the end alignment will work out to
 				 * this hardware's requirements
@@ -3162,6 +3163,7 @@ static netdev_tx_t e1000_xmit_frame(struct sk_buff *skb,
 				}
 				len = skb_headlen(skb);
 				break;
+			}
 			default:
 				/* do nothing */
 				break;
-- 
2.25.1

