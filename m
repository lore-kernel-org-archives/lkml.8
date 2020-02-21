Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C41BC35647
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 11:44:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDB6E24656
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 11:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582285459;
	bh=NCvkpzqOanbsDIfiwp010XRE/+mm3uHCUTkAtp3xw4Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YbP3uq+9WKwtxx1yE1LPvgH2gRf+SzEXaQLBDgpKDzLdmUXH5D/sVn3Vv2LE2zG+8
	 VgHXt+6eQ9IE19qkbQNZi6JqHe7tvkp4iD6fldT625vVFPKKvKoWSAMqwixVHCzDDP
	 jgEsp/JIXWYz9WpfAMWlqRn/jqZya9JtQxjg3Txo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727489AbgBULoS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 06:44:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:42882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726909AbgBULoQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 06:44:16 -0500
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DA33E24653;
        Fri, 21 Feb 2020 11:44:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582285455;
        bh=NCvkpzqOanbsDIfiwp010XRE/+mm3uHCUTkAtp3xw4Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JfBJUj0KI9PxGqfGdxuEfXOr1KBVRAA9JnI7eLT+q7WCJXJqcTJXNWVIJZtMdf9om
         JEMCV+11Pltkh8iNc2iuxdpx+iZx32hzSwAUdCiz8JAHudH7IDhhcTAMUyT71gsbOH
         BiHeEEXLputCOdTExwfVajWtkeQaTphCFB56hJMM=
From:   Will Deacon <will@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@android.com, akpm@linux-foundation.org,
        Will Deacon <will@kernel.org>,
        "K . Prasad" <prasad@linux.vnet.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Quentin Perret <qperret@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH 1/3] samples/hw_breakpoint: Drop HW_BREAKPOINT_R when reporting writes
Date:   Fri, 21 Feb 2020 11:44:02 +0000
Message-Id: <20200221114404.14641-2-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200221114404.14641-1-will@kernel.org>
References: <20200221114404.14641-1-will@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Given the name of a kernel symbol, the 'data_breakpoint' test claims to
"report any write operations on the kernel symbol". However, it creates
the breakpoint using both HW_BREAKPOINT_W and HW_BREAKPOINT_R, which
menas it also fires for read access.

Drop HW_BREAKPOINT_R from the breakpoint attributes.

Cc: K.Prasad <prasad@linux.vnet.ibm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Frederic Weisbecker <frederic@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Quentin Perret <qperret@google.com>
Signed-off-by: Will Deacon <will@kernel.org>
---
 samples/hw_breakpoint/data_breakpoint.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/samples/hw_breakpoint/data_breakpoint.c b/samples/hw_breakpoint/data_breakpoint.c
index c58504774118..469b36f93696 100644
--- a/samples/hw_breakpoint/data_breakpoint.c
+++ b/samples/hw_breakpoint/data_breakpoint.c
@@ -45,7 +45,7 @@ static int __init hw_break_module_init(void)
 	hw_breakpoint_init(&attr);
 	attr.bp_addr = kallsyms_lookup_name(ksym_name);
 	attr.bp_len = HW_BREAKPOINT_LEN_4;
-	attr.bp_type = HW_BREAKPOINT_W | HW_BREAKPOINT_R;
+	attr.bp_type = HW_BREAKPOINT_W;
 
 	sample_hbp = register_wide_hw_breakpoint(&attr, sample_hbp_handler, NULL);
 	if (IS_ERR((void __force *)sample_hbp)) {
-- 
2.25.0.265.gbab2e86ba0-goog

