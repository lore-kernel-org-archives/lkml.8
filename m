Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 454E0C352A1
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 19:46:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25D99218AC
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 19:46:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727398AbgBETqx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 14:46:53 -0500
Received: from andre.telenet-ops.be ([195.130.132.53]:42704 "EHLO
        andre.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727085AbgBETqw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 14:46:52 -0500
Received: from ramsan ([84.195.182.253])
        by andre.telenet-ops.be with bizsmtp
        id z7mq2100S5USYZQ017mqLj; Wed, 05 Feb 2020 20:46:51 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1izQdO-000127-Ou; Wed, 05 Feb 2020 20:46:50 +0100
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1izQdO-00089i-Lt; Wed, 05 Feb 2020 20:46:50 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] of: clk: Make <linux/of_clk.h> self-contained
Date:   Wed,  5 Feb 2020 20:46:49 +0100
Message-Id: <20200205194649.31309-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Depending on include order:

    include/linux/of_clk.h:11:45: warning: ‘struct device_node’ declared inside parameter list will not be visible outside of this definition or declaration
     unsigned int of_clk_get_parent_count(struct device_node *np);
						 ^~~~~~~~~~~
    include/linux/of_clk.h:12:43: warning: ‘struct device_node’ declared inside parameter list will not be visible outside of this definition or declaration
     const char *of_clk_get_parent_name(struct device_node *np, int index);
					       ^~~~~~~~~~~
    include/linux/of_clk.h:13:31: warning: ‘struct of_device_id’ declared inside parameter list will not be visible outside of this definition or declaration
     void of_clk_init(const struct of_device_id *matches);
				   ^~~~~~~~~~~~

Fix this by adding forward declarations for struct device_node and
struct of_device_id.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Noticed when cleaning up some platform code.
I am not aware of this being triggered in upstream, but this will become a
dependency for these cleanups.

 include/linux/of_clk.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/of_clk.h b/include/linux/of_clk.h
index b27da9f164cbd221..c86fcad23fc21725 100644
--- a/include/linux/of_clk.h
+++ b/include/linux/of_clk.h
@@ -6,6 +6,9 @@
 #ifndef __LINUX_OF_CLK_H
 #define __LINUX_OF_CLK_H
 
+struct device_node;
+struct of_device_id;
+
 #if defined(CONFIG_COMMON_CLK) && defined(CONFIG_OF)
 
 unsigned int of_clk_get_parent_count(struct device_node *np);
-- 
2.17.1

