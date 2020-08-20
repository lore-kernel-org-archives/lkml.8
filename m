Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29633C433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 10:19:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F091820658
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 10:19:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597918743;
	bh=dLSZoe0U68+XiHw2ZjmLR1zZjUunThM8XsBc5V+pY8I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OA+QEvOegb4ndQyd/L+g5T5+UwaNZPPRLGblTNsThEMqWUUOfvr4lddo7r4Wjsmzh
	 zSc6NmMDAmCORNLU+ph+/9sCv+wg66EcvQrBrhtdVyV0vdkj2orj1u/+ZCTjPKyuVc
	 Ygt+zV+p15JjszJv3oiwZtcelGRy1kaRB7slxvkA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731321AbgHTKTB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 06:19:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:39314 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731369AbgHTKRq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 06:17:46 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4CC5020658;
        Thu, 20 Aug 2020 10:17:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597918665;
        bh=dLSZoe0U68+XiHw2ZjmLR1zZjUunThM8XsBc5V+pY8I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EiVq4kBqo9EvpB7OT6o7jy0vjYu4Gd6niDfUlvzcHwn5afeY6zj58HV31/fS4WP5r
         eJWVMQSHt1T3N/U4UgtN5ANS0Su/i+47YM7IA/Pj47XbzAA2KyTDFXXmVYhVX/oEaC
         t+60aYpOR2nsdinGyuDhH/Y8/wYt2IzU97b7yoks=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Navid Emamdoost <navid.emamdoost@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 005/149] ath9k: release allocated buffer if timed out
Date:   Thu, 20 Aug 2020 11:21:22 +0200
Message-Id: <20200820092125.952949273@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200820092125.688850368@linuxfoundation.org>
References: <20200820092125.688850368@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Navid Emamdoost <navid.emamdoost@gmail.com>

[ Upstream commit 728c1e2a05e4b5fc52fab3421dce772a806612a2 ]

In ath9k_wmi_cmd, the allocated network buffer needs to be released
if timeout happens. Otherwise memory will be leaked.

Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/ath9k/wmi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/ath/ath9k/wmi.c b/drivers/net/wireless/ath/ath9k/wmi.c
index 8f14897ae5a33..f100533eb7adc 100644
--- a/drivers/net/wireless/ath/ath9k/wmi.c
+++ b/drivers/net/wireless/ath/ath9k/wmi.c
@@ -340,6 +340,7 @@ int ath9k_wmi_cmd(struct wmi *wmi, enum wmi_cmd_id cmd_id,
 		ath_dbg(common, WMI, "Timeout waiting for WMI command: %s\n",
 			wmi_cmd_to_name(cmd_id));
 		mutex_unlock(&wmi->op_mutex);
+		kfree_skb(skb);
 		return -ETIMEDOUT;
 	}
 
-- 
2.25.1



