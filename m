Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E52CC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 08:53:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F8F42075A
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 08:53:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sbg59xCd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730038AbgHDIxx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 04:53:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729856AbgHDIxw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 04:53:52 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C077C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  4 Aug 2020 01:53:52 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id p8so5632141pgn.13
        for <linux-kernel@vger.kernel.org>; Tue, 04 Aug 2020 01:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=o9Ep8t67feK0FtP9v8mC1FGfhAiiqQxSlfYKwuHkNOc=;
        b=Sbg59xCdc6NrHKwuaLzcY0oPYY8C6pOWWjJFJd8ycCRJ6yWWMYBjSOxLV/lXi/+2Eq
         hjHysWEr1QlmTv674WNTGQDSGKDFOIVHww1FbJAMS32VT0O2eWd4aQOPFZqCHFKE+fs8
         SW8aR8oDcOf9RfxqvcGrIbk/NvI0mQMritXZ3KtfTZyUINxX2BDDmX404gwJvZgjiGFz
         3KuV+UU16nQM+km7zGUku0kMfxVY5cu9P1usIhahXug79VxBNxL3O7TvJXAG58YaXTS0
         yZ2yMJzO/UbvAQZsojjG9MwqiSx/hpnljZ7U0cRueZv7q8VK6JmddOEbOCmEO6aEoC3m
         DRBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=o9Ep8t67feK0FtP9v8mC1FGfhAiiqQxSlfYKwuHkNOc=;
        b=CFwvBFhwd8AZhVF9poOVC0NjqtHwbST14nc1LVjtW3CNI2dj371QEQ93IvoPo+S+cs
         oIy4dGGN0iDzkoiFb8EQmoEiEnRI9Jw2xslWLAizCFHKz437IKi9owXWqwrCQ7R01uA3
         MR7ezQE01cCD6VDUhgCE7gsVRBnDx8LH6KDblwktjkZVx0cDgKMf1CQ6GNoU1k8EjlaX
         oVSb6w40JfXNMF8/uOa51tGYv9wbsd1PlUmSkGu4nu2txJIyLpYBMf2Hv6A9YowBJ+nw
         X5N4IjhwFy8kGgrCVffz2BxK/KnXuImoWJyhSTPxp9sJO2P524RM528uSQTDFNusgpLX
         pykA==
X-Gm-Message-State: AOAM530V6CVryX1H0Gx87urbGixebukOzx6OU14ki6qEmIM6A3F/61Su
        epU/imRj8ZyqFVHOXOdoESX/kzKq
X-Google-Smtp-Source: ABdhPJywvsGkVQDCxQG3ThWBoe6ufW6SQVc71wWsdgv0xhACRD2ZqAQewuZ+t2MGfaNOEsme4mE4uw==
X-Received: by 2002:a62:57:: with SMTP id 84mr18980990pfa.141.1596531231607;
        Tue, 04 Aug 2020 01:53:51 -0700 (PDT)
Received: from huyue2.ccdomain.com ([103.29.143.67])
        by smtp.gmail.com with ESMTPSA id y72sm5907847pfg.58.2020.08.04.01.53.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Aug 2020 01:53:50 -0700 (PDT)
From:   Yue Hu <zbestahu@gmail.com>
To:     catalin.marinas@arm.com, will@kernel.org, james.morse@arm.com,
        Dave.Martin@arm.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        huyue2@yulong.com, zbestahu@163.com
Subject: [PATCH] arm64: traps: Add str of description to panic() in die()
Date:   Tue,  4 Aug 2020 16:53:47 +0800
Message-Id: <20200804085347.10720-1-zbestahu@gmail.com>
X-Mailer: git-send-email 2.19.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yue Hu <huyue2@yulong.com>

Currently, there are different description strings in die() such as
die("Oops",,), die("Oops - BUG",,). And panic() called by die() will
always show "Fatal exception" or "Fatal exception in interrupt".

Note that panic() will run any panic handler via panic_notifier_list.
And the string above will be formatted and placed in static buf[]
which will be passed to handler.

So panic handler can not distinguish which Oops it is from the buf if
we want to do some things like reserve the string in memory or panic
statistics. It's not benefit to debug. We need to add more codes to
troubleshoot. Let's utilize existing resource to make debug much simpler.

Signed-off-by: Yue Hu <huyue2@yulong.com>
---
 arch/arm64/kernel/traps.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index 47f651d..5582d3e 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -200,9 +200,9 @@ void die(const char *str, struct pt_regs *regs, int err)
 	oops_exit();
 
 	if (in_interrupt())
-		panic("Fatal exception in interrupt");
+		panic("%s: Fatal exception in interrupt", str);
 	if (panic_on_oops)
-		panic("Fatal exception");
+		panic("%s: Fatal exception", str);
 
 	raw_spin_unlock_irqrestore(&die_lock, flags);
 
-- 
1.9.1

