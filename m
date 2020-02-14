Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3FBAC2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 18:11:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C31A72168B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 18:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581703864;
	bh=udPBDdvdYkxFiN4/6jnqwJPzNWTrlv9XsXtSLkNELoA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=H94Zi+lWeo9O9PLBcPIUylHkYZlqQTXl5lfQC0ICqT4e+/uoapI/ujaSg7EWe72yC
	 Wmzta2GoOmtpN9Zzt9rPZo/m0t02CPKAF3VurzfyS1JjCjOU4TUewvymyysxE3kJfc
	 HrIJAUGxAH6vSRlMUp8Wyaf6/rR1FbY671wGd6fo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404101AbgBNSLE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 13:11:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:32876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731294AbgBNPxg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 10:53:36 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 630E6222C4;
        Fri, 14 Feb 2020 15:53:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581695616;
        bh=udPBDdvdYkxFiN4/6jnqwJPzNWTrlv9XsXtSLkNELoA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SE4QyeWRhwPZtTVMsFFDRsLkvxI2sQshbHKXS5D2sQyt1RnG96LmQD7oqR4cgJfhT
         0i6za+23+uztSKFh5ntAJeG+4PRkgQCg8UluB+GYKK6fZxwBEIotPZ9nRYo/Md2CSf
         YtWyQCS23wdb6eARpU3NWs7zv2JHQ6nzYOC9MVm8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@suse.de>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        bberg@redhat.com, ckellner@redhat.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        hdegoede@redhat.com, "H. Peter Anvin" <hpa@zytor.com>,
        Ingo Molnar <mingo@redhat.com>,
        linux-edac <linux-edac@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>, x86-ml <x86@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.5 216/542] x86/mce/therm_throt: Mark throttle_active_work() as __maybe_unused
Date:   Fri, 14 Feb 2020 10:43:28 -0500
Message-Id: <20200214154854.6746-216-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214154854.6746-1-sashal@kernel.org>
References: <20200214154854.6746-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit db1ae0314f47e88ae06679270adf17ffa245afd4 ]

throttle_active_work() is only called if CONFIG_SYSFS is set, otherwise
we get a harmless warning:

  arch/x86/kernel/cpu/mce/therm_throt.c:238:13: error: 'throttle_active_work' \
	  defined but not used [-Werror=unused-function]

Mark the function as __maybe_unused to avoid the warning.

Fixes: f6656208f04e ("x86/mce/therm_throt: Optimize notifications of thermal throttle")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: bberg@redhat.com
Cc: ckellner@redhat.com
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: hdegoede@redhat.com
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: linux-edac <linux-edac@vger.kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Tony Luck <tony.luck@intel.com>
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/20191210203925.3119091-1-arnd@arndb.de
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kernel/cpu/mce/therm_throt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/mce/therm_throt.c b/arch/x86/kernel/cpu/mce/therm_throt.c
index 6c3e1c92f1835..58b4ee3cda777 100644
--- a/arch/x86/kernel/cpu/mce/therm_throt.c
+++ b/arch/x86/kernel/cpu/mce/therm_throt.c
@@ -235,7 +235,7 @@ static void get_therm_status(int level, bool *proc_hot, u8 *temp)
 	*temp = (msr_val >> 16) & 0x7F;
 }
 
-static void throttle_active_work(struct work_struct *work)
+static void __maybe_unused throttle_active_work(struct work_struct *work)
 {
 	struct _thermal_state *state = container_of(to_delayed_work(work),
 						struct _thermal_state, therm_work);
-- 
2.20.1

