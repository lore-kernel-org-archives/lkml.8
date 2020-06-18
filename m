Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7ACFC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 02:15:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D1B62070A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 02:15:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592446532;
	bh=4pn36Y7hkSY+/+kQrByDd8A/Tpv/cBw3K6A/TBsRsAw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=szvGybUayds4vd2YbbGdGQG0Ka8v0ro3BLCaD1qHCGSlwPi4/tihMiVzeU7+mg93b
	 nrAY17PNz3nOrr496eZLpOqj+lbX77qkTGtFdbrVf48tJybQ+dy0Eh2BN0bgan31LW
	 FEyP3ISL5Pnd+MQAVIED+MKhwyiOG7jgZYaL5Sos=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731286AbgFRCPb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 22:15:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:52720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729585AbgFRBUc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 21:20:32 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DE26720776;
        Thu, 18 Jun 2020 01:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592443232;
        bh=4pn36Y7hkSY+/+kQrByDd8A/Tpv/cBw3K6A/TBsRsAw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CSJHJ9K8pMYAnJ54s1ysqgOq+TG9ZQHWcfgpULBegKB4neZRGn1ckOR7KUMlRwNjH
         qbds9VTXQIngWZi4rtZZcmBwuTPVfwbAK0C5Gf8a7y9Lggy8KQs9On5sxDDqYttJv+
         9JRux7VRzbt0MKI3qwW5j3IBq0vhWauEyeub610I=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Borislav Petkov <bp@suse.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.4 185/266] x86/apic: Make TSC deadline timer detection message visible
Date:   Wed, 17 Jun 2020 21:15:10 -0400
Message-Id: <20200618011631.604574-185-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618011631.604574-1-sashal@kernel.org>
References: <20200618011631.604574-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

[ Upstream commit de308d1815c9e8fe602a958c5c76142ff6501d75 ]

The commit

  c84cb3735fd5 ("x86/apic: Move TSC deadline timer debug printk")

removed the message which said that the deadline timer was enabled.
It added a pr_debug() message which is issued when deadline timer
validation succeeds.

Well, issued only when CONFIG_DYNAMIC_DEBUG is enabled - otherwise
pr_debug() calls get optimized away if DEBUG is not defined in the
compilation unit.

Therefore, make the above message pr_info() so that it is visible in
dmesg.

Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20200525104218.27018-1-bp@alien8.de
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kernel/apic/apic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index 25b8c45467fc..fce94c799f01 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -2099,7 +2099,7 @@ void __init init_apic_mappings(void)
 	unsigned int new_apicid;
 
 	if (apic_validate_deadline_timer())
-		pr_debug("TSC deadline timer available\n");
+		pr_info("TSC deadline timer available\n");
 
 	if (x2apic_mode) {
 		boot_cpu_physical_apicid = read_apic_id();
-- 
2.25.1

