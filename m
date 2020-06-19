Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F205C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:11:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 601E32168B
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592583064;
	bh=BswtJRKHutJLb0chTOqQLF44TaQNCFggqTRlWcKon54=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ou2NDTi7aazxJsg3xTjOZHNg7UYBBnrAqlYAzTpI6dHk3eXyDMqfcJ5o0S8QOIzha
	 vGHWNr5tW2Tfp198DnTVILz7laLhcGwpntifTxLhNYTAUtsrH/gG7swryYAuKZ8sY8
	 qxuGS5o9vbwdxlDqRVZM06I+XJUycBhUQHvKJb4U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394341AbgFSQLC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 12:11:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:35294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391409AbgFSPGP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 11:06:15 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 90A5521974;
        Fri, 19 Jun 2020 15:06:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592579175;
        bh=BswtJRKHutJLb0chTOqQLF44TaQNCFggqTRlWcKon54=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vX2I66Xp7hqcfGnCGSEO1/Otbnn5QnYNJlB02TBxvLpRKXFzpLrSD/m8dXt217g2g
         buJPzRfR6/xpgGIAre7d6xsxFUU9GvxElAkKoyu0Zq6qrXgvDHA45QcSgDHk0ukp9g
         S1KaihWrzs9xPM4juBEbUMjRElBfwAjQ4Qz38Z2M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Douglas Anderson <dianders@chromium.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 036/261] kgdb: Disable WARN_CONSOLE_UNLOCKED for all kgdb
Date:   Fri, 19 Jun 2020 16:30:47 +0200
Message-Id: <20200619141651.643978819@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619141649.878808811@linuxfoundation.org>
References: <20200619141649.878808811@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Douglas Anderson <dianders@chromium.org>

[ Upstream commit 202164fbfa2b2ffa3e66b504e0f126ba9a745006 ]

In commit 81eaadcae81b ("kgdboc: disable the console lock when in
kgdb") we avoided the WARN_CONSOLE_UNLOCKED() yell when we were in
kgdboc.  That still works fine, but it turns out that we get a similar
yell when using other I/O drivers.  One example is the "I/O driver"
for the kgdb test suite (kgdbts).  When I enabled that I again got the
same yells.

Even though "kgdbts" doesn't actually interact with the user over the
console, using it still causes kgdb to print to the consoles.  That
trips the same warning:
  con_is_visible+0x60/0x68
  con_scroll+0x110/0x1b8
  lf+0x4c/0xc8
  vt_console_print+0x1b8/0x348
  vkdb_printf+0x320/0x89c
  kdb_printf+0x68/0x90
  kdb_main_loop+0x190/0x860
  kdb_stub+0x2cc/0x3ec
  kgdb_cpu_enter+0x268/0x744
  kgdb_handle_exception+0x1a4/0x200
  kgdb_compiled_brk_fn+0x34/0x44
  brk_handler+0x7c/0xb8
  do_debug_exception+0x1b4/0x228

Let's increment/decrement the "ignore_console_lock_warning" variable
all the time when we enter the debugger.

This will allow us to later revert commit 81eaadcae81b ("kgdboc:
disable the console lock when in kgdb").

Signed-off-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
Link: https://lore.kernel.org/r/20200507130644.v4.1.Ied2b058357152ebcc8bf68edd6f20a11d98d7d4e@changeid
Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/debug/debug_core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/debug/debug_core.c b/kernel/debug/debug_core.c
index f76d6f77dd5e..d0d557c0ceff 100644
--- a/kernel/debug/debug_core.c
+++ b/kernel/debug/debug_core.c
@@ -634,6 +634,8 @@ return_normal:
 	if (kgdb_skipexception(ks->ex_vector, ks->linux_regs))
 		goto kgdb_restore;
 
+	atomic_inc(&ignore_console_lock_warning);
+
 	/* Call the I/O driver's pre_exception routine */
 	if (dbg_io_ops->pre_exception)
 		dbg_io_ops->pre_exception();
@@ -706,6 +708,8 @@ cpu_master_loop:
 	if (dbg_io_ops->post_exception)
 		dbg_io_ops->post_exception();
 
+	atomic_dec(&ignore_console_lock_warning);
+
 	if (!kgdb_single_step) {
 		raw_spin_unlock(&dbg_slave_lock);
 		/* Wait till all the CPUs have quit from the debugger. */
-- 
2.25.1



