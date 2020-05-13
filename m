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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F40EC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 21:47:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FC1420727
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 21:47:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rr+s2C7s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730149AbgEMVrB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 17:47:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729799AbgEMVqs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 17:46:48 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D484C061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 14:46:48 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id s8so1302199wrt.9
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 14:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xXwPehQJdO8W/RRFT9lpEbo/rwg/NqlvrsX9ydy+gUY=;
        b=rr+s2C7s3IetyBx7kdhC2xyGjmSTPhmqZhI5/PZ+FbS/2BORt8LIkjnLxdLspEASX0
         51sn7beVDeEo6rKv1MXsb0gx+hhHXvMtjVkSAXAscD3TvvRmb4hg/48XyNdRmyaAlqrx
         3HEH1yPjKSPvKuMRkSYDf4dG4oo0yAEmb0q6IFfTAFvN/fr9ekuEDG8UWgqUnxKtrxyk
         X17kJ375os2vhxJE6ezApRqMSgh8Yln4Zv5y8sltZTHJZaXqwrQDfpS+FMV1LSjKe/F7
         iymLY764L6GTLbeuBfI7gpkJRtxt42+ogtqXGM7bKsaGZj9xRX2EXol4NY+ywW8xCAON
         YbKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xXwPehQJdO8W/RRFT9lpEbo/rwg/NqlvrsX9ydy+gUY=;
        b=mARfip0FIyOR+728BNB4bzVUzNj84eTrtgzlQLd/06n9/TX4Ja+kyvO6WJ4V+p3EQH
         IhMhKixz3gAlgWHTCg7UyzVlbnaB24AiniODysq74w/cdYOvaHHMVWSAKDQpg7isAo60
         pN9Rs3MT4BRVeMTKcKC++8kEvi1iGw6Ivod8BWXvCgXdRh3Zo82TTmE4/EAoAhhMcyir
         NcdAoPl+//HS5W+r4iAIC9tnMLi8l2mUSxDpQxZjF/uY3x0lRvadcj0qzxmII4pjNuMO
         LL+LquqS4mXR9SQ7SU2sE4kMrUqV0FBz62PDKWvDkMPRuWatlxMA5FySXc4Z56j6kZ17
         NZUw==
X-Gm-Message-State: AOAM5302vFEc8JqIkvWii4LDGNCTc/b6GSHAQs/LK+1fFW8B7TjCpsl4
        8R7idJYQGqeQC1x/hB/evEc=
X-Google-Smtp-Source: ABdhPJw9XZ5u4qa2WDv17qZvd3SOounzZl47xyXJOSldxT3dsYn4CeJEqn0WOiupCTq6uTcy8reIZQ==
X-Received: by 2002:adf:e5c9:: with SMTP id a9mr1683725wrn.292.1589406407182;
        Wed, 13 May 2020 14:46:47 -0700 (PDT)
Received: from localhost.localdomain (cpc91192-cmbg18-2-0-cust374.5-4.cable.virginm.net. [80.6.113.119])
        by smtp.gmail.com with ESMTPSA id m23sm1699734wmg.45.2020.05.13.14.46.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2020 14:46:46 -0700 (PDT)
From:   Emil Velikov <emil.l.velikov@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     emil.l.velikov@gmail.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org,
        Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        kgdb-bugreport@lists.sourceforge.net
Subject: [PATCH 09/11] kdb: constify sysrq_key_op
Date:   Wed, 13 May 2020 22:43:49 +0100
Message-Id: <20200513214351.2138580-9-emil.l.velikov@gmail.com>
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
Cc: Jason Wessel <jason.wessel@windriver.com>
Cc: Daniel Thompson <daniel.thompson@linaro.org>
Cc: kgdb-bugreport@lists.sourceforge.net
Signed-off-by: Emil Velikov <emil.l.velikov@gmail.com>
---
Please keep me in the CC list, as I'm not subscribed to the list.

IMHO it would be better if this gets merged this via the tty tree.
---
 kernel/debug/debug_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/debug/debug_core.c b/kernel/debug/debug_core.c
index 2b7c9b67931d..355bea54ca0e 100644
--- a/kernel/debug/debug_core.c
+++ b/kernel/debug/debug_core.c
@@ -920,7 +920,7 @@ static void sysrq_handle_dbg(int key)
 	kgdb_breakpoint();
 }
 
-static struct sysrq_key_op sysrq_dbg_op = {
+static const struct sysrq_key_op sysrq_dbg_op = {
 	.handler	= sysrq_handle_dbg,
 	.help_msg	= "debug(g)",
 	.action_msg	= "DEBUG",
-- 
2.25.1

