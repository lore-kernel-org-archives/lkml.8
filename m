Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDD2FC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 21:46:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C246B206F5
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 21:46:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RW1G+oga"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729960AbgEMVqs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 17:46:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729799AbgEMVqp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 17:46:45 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C7ACC061A0E
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 14:46:45 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id n5so15317527wmd.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 14:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qwEXZysR23CccmrNbp4oN3ldgqd9cJzH2UZSb4ihijw=;
        b=RW1G+ogaAUWg4GP/IAaKNDiWpKHIvYpQnbau/mVBhnk3xIed4Kf27YNjBWyThTty/b
         aa6RzDE2vVQpDzT4KYj0Hg1pX7a86XwH8Gkjh+dqN2ijY/Bh7VOGNBKaBvllUvvgTe7V
         JYtYdUkSr9CrVUUlGhGy0qMnqJzhlEs9Gg1WhRCbrsggDPN8rSk+V+Xjj/ZBwbDca1zn
         Zqxq/ucDBkApCW26k1BrUvDs0z4ynUSWmSjyaEkSz0+q23ekyBhQTXxIbOAkQi1qEUd3
         PJfBW7d+pq1xy7EbcafYMm7NFocw/Ek9E40OFAv8yotfqMA/LMU73/trnk1ziQrnvLwP
         0KLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qwEXZysR23CccmrNbp4oN3ldgqd9cJzH2UZSb4ihijw=;
        b=f+it13AJeJlnXIpX1Megs6xT5/1msegScfy1Tt3fiCloD9vtpuHrLAWBcPMBKb3lvc
         7I01GoeN3PXDMVc4ZwrhsC3O9z5j+3oCMFsrvJBRUGDID+aN2wLvSpteSxz4iKS6W7sZ
         ZAbbyM+LRLlXFgDNNta1KWj87jxI/vi1DfqPLYOcpMZQPjgT3WHbg5RTQxgLcKMaE9R5
         IyEzQFWD40Iab7NW+p9lExdmO5LdAIsj7bjIO4H9zg9rtCMcBRFCJUC2jpBtnaPMqh0x
         jwprqY58M7jkOUU12Ufos13or/ReRPMOd1y2MTIQHFQNFjZBnzOzow3LwkQgQitaZ1lH
         3WbA==
X-Gm-Message-State: AOAM531SAoMFfzh4MvxDoYKMUjxNLd4sVVyqTKpREUM5q8W4h15Ify/b
        BcC9WSaDA6resgLfFV26ow0Cg0c5
X-Google-Smtp-Source: ABdhPJyLIg3eccKezg4f5axysxo4mad1I/De7u6J1LU+oD/g9NIWVf+Zl8ski/Ae57u9v6OoYfDaPA==
X-Received: by 2002:a1c:e188:: with SMTP id y130mr9611614wmg.105.1589406403908;
        Wed, 13 May 2020 14:46:43 -0700 (PDT)
Received: from localhost.localdomain (cpc91192-cmbg18-2-0-cust374.5-4.cable.virginm.net. [80.6.113.119])
        by smtp.gmail.com with ESMTPSA id m23sm1699734wmg.45.2020.05.13.14.46.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2020 14:46:43 -0700 (PDT)
From:   Emil Velikov <emil.l.velikov@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     emil.l.velikov@gmail.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 06/11] powerpc/xmon: constify sysrq_key_op
Date:   Wed, 13 May 2020 22:43:46 +0100
Message-Id: <20200513214351.2138580-6-emil.l.velikov@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200513214351.2138580-1-emil.l.velikov@gmail.com>
References: <20200513214351.2138580-1-emil.l.velikov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With earlier commits, the API no longer discards the const-ness of the
sysrq_key_op. As such we can add the notation.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>
Cc: linux-kernel@vger.kernel.org
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Emil Velikov <emil.l.velikov@gmail.com>
---
Please keep me in the CC list, as I'm not subscribed to the list.

IMHO it would be better if this gets merged this via the tty tree.
---
 arch/powerpc/xmon/xmon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index 7af840c0fc93..0d8ca5c9f131 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -3842,7 +3842,7 @@ static void sysrq_handle_xmon(int key)
 		xmon_init(0);
 }
 
-static struct sysrq_key_op sysrq_xmon_op = {
+static const struct sysrq_key_op sysrq_xmon_op = {
 	.handler =	sysrq_handle_xmon,
 	.help_msg =	"xmon(x)",
 	.action_msg =	"Entering xmon",
-- 
2.25.1

