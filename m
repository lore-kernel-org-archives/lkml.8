Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13363C32771
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 22:37:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D16D922525
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 22:37:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MdhUeRZx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbgATWhw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 17:37:52 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52168 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726607AbgATWhv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 17:37:51 -0500
Received: by mail-wm1-f66.google.com with SMTP id d73so997478wmd.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jan 2020 14:37:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OADQyKE/ubXeK6XRyrfkTm/uQdcKdRz0U3P+emh+8jQ=;
        b=MdhUeRZxNnPuTdxRppiPAEKXp0Kuytm3biLQptgEfJNmVNibI0k100tyzDq9Nj3/JQ
         vRlc4pdQjDdNd5VqFS/j/UDrJYknaUZyMNH/A+yTik97p767QPrWJmJVSUSBc/RygzNs
         11zSqz/I13jJfTKDIxRjVi09oFvkJXrxwL7ARTAYr8j0qJcfrkby2OuVfPpVplULCNKe
         DFaH9zGA43TY962myAPt2/XJNLyZOC3oNZ9k2VAg6CwvUn1cO8K+VHQOswuXiI7SPYR6
         nKz7UMgQOLwzAiABo/LSnxgdgatxHO88jFCcfI5beXlMY8cCr0MtnuOCOBTX108hpmMl
         gQ7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OADQyKE/ubXeK6XRyrfkTm/uQdcKdRz0U3P+emh+8jQ=;
        b=dsPpMlnfrf968mpFcXgpnSVb5B7bFecNOC4MCrw0s+3yTs5Nh96e0/8uZISwqsmSzR
         dcDHl9sgIgSFqh/QtAURejLJBvb9Yrypv38GURWoTyeUxxpQ5OIXL+OhE4ticCjtOoBC
         EC9eJ0AGyQa6mc04lK0dYfErL6njTevIttMMGNoQs05M38B6NFNbHS9mjN/saW4L49jh
         1v+Xs3QEDv4NjMBKbHMVbKFf8Om96UiJBoVMKOufgLYdLy0HA1yBxk8HU9I5ZRbrJyZ6
         3yxK1Hp1Vpc9KvUPz8kzkv551cbn+5c6F6kb/RAD3LEe9C9K4lCdHGEk1tfxNkMFHvP4
         vevw==
X-Gm-Message-State: APjAAAVLb2njAz5aU118uksPxoUjJMFy3HyEBBFlMz3CXX4fhapXBW5v
        dTAnKVbwckr0UwsSVgIp8fHNoYWRrnwz
X-Google-Smtp-Source: APXvYqxhLw78EY+jdD3jPaEAv6Ha0Fhrmapb06Cy3XpsdEAq//HRGBi6Pimofx+G98YG80i8ng8mVw==
X-Received: by 2002:a7b:cb0a:: with SMTP id u10mr938794wmj.165.1579559869526;
        Mon, 20 Jan 2020 14:37:49 -0800 (PST)
Received: from ninjahost.lan (host-92-15-170-165.as43234.net. [92.15.170.165])
        by smtp.googlemail.com with ESMTPSA id y7sm1851569wmd.1.2020.01.20.14.37.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2020 14:37:49 -0800 (PST)
From:   Jules Irenge <jbi.octave@gmail.com>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, boqun.feng@gmail.com,
        Jules Irenge <jbi.octave@gmail.com>
Subject: [PATCH 1/5] irq: Add  missing annotation for __irq_put_desc_unlock()
Date:   Mon, 20 Jan 2020 22:37:34 +0000
Message-Id: <20200120223734.51425-1-jbi.octave@gmail.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sparse reports a warning at __irq_put_desc_unlock()

|warning: context imbalance in __irq_put_desc_unlock() - unexpected unlock.

To fix this, a __releases(&desc->lock) annotation is added.
Given that __irq_put_desc_unlock() does actually
call raw_spin_unlock_irqrestore(&desc->lock, flags)
This not only fixes the warning
but also improves on readability of the code.

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
---
 kernel/irq/irqdesc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index 5b8fdd659e54..98a5f10d1900 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -891,6 +891,7 @@ __irq_get_desc_lock(unsigned int irq, unsigned long *flags, bool bus,
 }
 
 void __irq_put_desc_unlock(struct irq_desc *desc, unsigned long flags, bool bus)
+	__releases(&desc->lock)
 {
 	raw_spin_unlock_irqrestore(&desc->lock, flags);
 	if (bus)
-- 
2.24.1

