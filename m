Return-Path: <SRS0=uMsS=BS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90825C433DF
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 23:37:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5EAB820791
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 23:37:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596929853;
	bh=xfYaG1bsvUo5UvyrUtAI4ovzdgEKIRkl9oapADRDFIg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nzY3NjtTQjuLECDJF74IUDzwgbfwzm+cqpNUhH1j/keWwP6UBk58EdHOt76d3XIRO
	 2wwbqGKV7GFxt0SEKsLbEoNxg8muYWUXyWf7ov25T4dLunTCWy8VwuV4TA6JYEHf+Y
	 KoqH0Y+HSWFVde2qZTrjmO2n9Oz1X+u+9HuYhQyk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727987AbgHHXhc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Aug 2020 19:37:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:50480 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727968AbgHHXh1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Aug 2020 19:37:27 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B6E372073E;
        Sat,  8 Aug 2020 23:37:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596929847;
        bh=xfYaG1bsvUo5UvyrUtAI4ovzdgEKIRkl9oapADRDFIg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RTc1w1vs7ynS+jp7sZGYRtf4wBwrok+j8mnBA21n+tbFqAcZbNZPwrKIwdOqhhAn1
         S9VO/5GlTe/biiSXnF0deyxCxMbaOExrjNKG53Tts6MJX0X69PRMVaogSOcDmKIPdt
         HKJ+b+uT3ZU3alOhFrRyaBcpnvVTCtFtI/0ajtQQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Zhenzhong Duan <zhenzhong.duan@gmail.com>,
        Borislav Petkov <bp@suse.de>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        Sasha Levin <sashal@kernel.org>, linux-edac@vger.kernel.org
Subject: [PATCH AUTOSEL 5.7 02/58] x86/mce/inject: Fix a wrong assignment of i_mce.status
Date:   Sat,  8 Aug 2020 19:36:28 -0400
Message-Id: <20200808233724.3618168-2-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200808233724.3618168-1-sashal@kernel.org>
References: <20200808233724.3618168-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhenzhong Duan <zhenzhong.duan@gmail.com>

[ Upstream commit 5d7f7d1d5e01c22894dee7c9c9266500478dca99 ]

The original code is a nop as i_mce.status is or'ed with part of itself,
fix it.

Fixes: a1300e505297 ("x86/ras/mce_amd_inj: Trigger deferred and thresholding errors interrupts")
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@gmail.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Yazen Ghannam <yazen.ghannam@amd.com>
Link: https://lkml.kernel.org/r/20200611023238.3830-1-zhenzhong.duan@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kernel/cpu/mce/inject.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/mce/inject.c b/arch/x86/kernel/cpu/mce/inject.c
index 3413b41b8d55f..dc28a615e340f 100644
--- a/arch/x86/kernel/cpu/mce/inject.c
+++ b/arch/x86/kernel/cpu/mce/inject.c
@@ -511,7 +511,7 @@ static void do_inject(void)
 	 */
 	if (inj_type == DFR_INT_INJ) {
 		i_mce.status |= MCI_STATUS_DEFERRED;
-		i_mce.status |= (i_mce.status & ~MCI_STATUS_UC);
+		i_mce.status &= ~MCI_STATUS_UC;
 	}
 
 	/*
-- 
2.25.1

