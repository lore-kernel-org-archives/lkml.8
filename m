Return-Path: <SRS0=MDzn=5V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22487C2BA18
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 02:51:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFC322071C
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 02:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586055111;
	bh=+NLgm5b3eyOP1I2k6jVeL7oY8jKap22YLdwxpklTebg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2Gz17Yt0OtysLrmp62yr/Th37BG2ABmmAW3Er4nQ0EYZr808HjB5l8QKAhd4QWDpu
	 jaYjsnL6lRO6ucuekXpc0WBM4q+l1cwHk25cZujiDgg1cMvkG7roO+EVwxpthaApTd
	 FNB9aFuRX7hgZyybeLGHasObL/1N5Xqy3vcxaNGQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbgDECvt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Apr 2020 22:51:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:44818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726492AbgDECv2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Apr 2020 22:51:28 -0400
Received: from mail.kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4EEEC2078C;
        Sun,  5 Apr 2020 02:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586055088;
        bh=+NLgm5b3eyOP1I2k6jVeL7oY8jKap22YLdwxpklTebg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VNJx4hFJzKo1DXvVLN4Bx/zjmOG92oiqLIUR3e2dgco9nfigqtElpzoitvV/4cj2c
         Dd9c79OwbDJ0YHO1MnAFNWK/87XPdHN5renzrZI7DZiNl6MTyF/B4PSbciCLwYOroc
         pWE6k6NYWcXxD0tlJFaj151E8OhaxP/whOclAjoY=
From:   Stephen Boyd <sboyd@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Paul Burton <paulburton@kernel.org>,
        linux-mips@vger.kernel.org, chenhc@lemote.com
Subject: [PATCH 8/9] MIPS: Loongson64: Drop asm/clock.h include
Date:   Sat,  4 Apr 2020 19:51:22 -0700
Message-Id: <20200405025123.154688-9-sboyd@kernel.org>
X-Mailer: git-send-email 2.26.0.292.g33ef6b2f38-goog
In-Reply-To: <20200405025123.154688-1-sboyd@kernel.org>
References: <20200405025123.154688-1-sboyd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This include isn't used by this file, so just remove it.

Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: Paul Burton <paulburton@kernel.org>
Cc: <linux-mips@vger.kernel.org>
Cc: <chenhc@lemote.com>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---
 arch/mips/loongson64/smp.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/mips/loongson64/smp.c b/arch/mips/loongson64/smp.c
index de8e0741ce2d..b48d9c566c5a 100644
--- a/arch/mips/loongson64/smp.c
+++ b/arch/mips/loongson64/smp.c
@@ -14,7 +14,6 @@
 #include <linux/kexec.h>
 #include <asm/processor.h>
 #include <asm/time.h>
-#include <asm/clock.h>
 #include <asm/tlbflush.h>
 #include <asm/cacheflush.h>
 #include <loongson.h>
-- 
Sent by a computer, using git, on the internet

