Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF0D3C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 17:14:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88B75206FA
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 17:14:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597684487;
	bh=P6arwzrIw0WOUUAoc7OYWctn1HzcRdYuWCh63ElO2eA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pS/G9cmHtmesPwS6d/+ipyvJo8Dgyr9n5cSmgTFf84bjWzqtXaecM+zUBO40VHV2c
	 XVYV5qG2tY6xXDXp9XBE/70cFsTBHXmiNXxL/NnhIsT58byJMVAqFgs7Nfyq/Q7H1W
	 AgJnM6oO1kTj9euz3oyEIM6r8XhOru33OMEiZODA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389513AbgHQROg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 13:14:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:44988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388481AbgHQQMj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 12:12:39 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B30C720658;
        Mon, 17 Aug 2020 16:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597680759;
        bh=P6arwzrIw0WOUUAoc7OYWctn1HzcRdYuWCh63ElO2eA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Red8KpwD8yWEkLjVbvIHBpZNx9msMPXBrMtachVYWm3j0O++kanffaihrXCrjz6Ih
         WuwPRFcJQzaf6rYYGmWzQiP2ogJoGk4AINssr7bA8kCUPuyESw2L7edKxC6WfdN7qC
         QolUXG6gcvcv3SWtTkyjB2cOvHWY57BtBc5GvCIA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Bjorn Helgaas <bjorn@helgaas.com>,
        Bolarinwa Olayemi Saheed <refactormyself@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 046/168] iwlegacy: Check the return value of pcie_capability_read_*()
Date:   Mon, 17 Aug 2020 17:16:17 +0200
Message-Id: <20200817143736.059918755@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200817143733.692105228@linuxfoundation.org>
References: <20200817143733.692105228@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bolarinwa Olayemi Saheed <refactormyself@gmail.com>

[ Upstream commit 9018fd7f2a73e9b290f48a56b421558fa31e8b75 ]

On failure pcie_capability_read_dword() sets it's last parameter, val
to 0. However, with Patch 14/14, it is possible that val is set to ~0 on
failure. This would introduce a bug because (x & x) == (~0 & x).

This bug can be avoided without changing the function's behaviour if the
return value of pcie_capability_read_dword is checked to confirm success.

Check the return value of pcie_capability_read_dword() to ensure success.

Suggested-by: Bjorn Helgaas <bjorn@helgaas.com>
Signed-off-by: Bolarinwa Olayemi Saheed <refactormyself@gmail.com>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Link: https://lore.kernel.org/r/20200713175529.29715-3-refactormyself@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/intel/iwlegacy/common.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlegacy/common.c b/drivers/net/wireless/intel/iwlegacy/common.c
index e16f2597c2199..c1c1cf330de7f 100644
--- a/drivers/net/wireless/intel/iwlegacy/common.c
+++ b/drivers/net/wireless/intel/iwlegacy/common.c
@@ -4302,8 +4302,8 @@ il_apm_init(struct il_priv *il)
 	 *    power savings, even without L1.
 	 */
 	if (il->cfg->set_l0s) {
-		pcie_capability_read_word(il->pci_dev, PCI_EXP_LNKCTL, &lctl);
-		if (lctl & PCI_EXP_LNKCTL_ASPM_L1) {
+		ret = pcie_capability_read_word(il->pci_dev, PCI_EXP_LNKCTL, &lctl);
+		if (!ret && (lctl & PCI_EXP_LNKCTL_ASPM_L1)) {
 			/* L1-ASPM enabled; disable(!) L0S  */
 			il_set_bit(il, CSR_GIO_REG,
 				   CSR_GIO_REG_VAL_L0S_ENABLED);
-- 
2.25.1



