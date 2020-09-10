Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B0BFC43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 21:19:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2749221E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 21:19:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ehl5Lsnv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727080AbgIJVTD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 17:19:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726879AbgIJVOz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 17:14:55 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F3B7C0617A4;
        Thu, 10 Sep 2020 14:14:30 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id g4so8760451wrs.5;
        Thu, 10 Sep 2020 14:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o3yHx9N5iW7pCL36Ov0mzI7ConRKQlz/EE+o5necxAA=;
        b=ehl5Lsnv/t+cfJqfYiKWlu96+/SSpr17qPIeHONde3L4VUkDbv+/pni4ukcuHhqOVB
         b930b28AUg7sM54SOlZepxtnsG3ikbu5AQnhJ2L722WthXFe5uJytvJI6xVQGhrYohBc
         nLT4ymMkQpjv2o5Xp0+3J/wJ2/17wQV+9D9SvJmhRa87pgTOpwk+uKEZoSljwv18OCqw
         9PjdyLnwdCCv7+9rlOMvJsk6NUXolgVDVQfhzyv1+Xnq/J+HR1VZnS+pBghbP7eKRDOs
         4o2MKyQpIdUwXaPI/6As1D3bXrwFgWwA8CrCcoV+IkB6zKBuBr+mZ0gHQcBSYB5zfluu
         ls3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o3yHx9N5iW7pCL36Ov0mzI7ConRKQlz/EE+o5necxAA=;
        b=K8hu3jVRpuKEa+HFbg0z0QVNKGcsBtY6bM9RCRPBiVHeZsbU5M+dP+tmAssL/n6YqN
         pZo0IfUUYHidoFhwFPY38AwKBgid8/vQh+9YrhP0NS3fRAkH7F78IAY/Nc6OWuhVq9o+
         ZYINyoe0U1q2P4w5xtzEVWDQs/EV/naJFwNCg3lZdn91XpLZmiPV62bnOK+V1pZtfxtW
         3tAX7nfJD803Mk+Xpo29JDkEFndf6C3Mk1znefBUrskQTsvepTc/HGq/BBJCySyz7k1t
         LYOXwqfzDgjB4wra8FMBhlTnkVBmct5ytjaz4tsXLWW2issFPK3BxKLlPKqVk2jJ0Pow
         ocXA==
X-Gm-Message-State: AOAM5300Kti/gxN9nt8yGJDoD7KhaPX3FOCvxCE3yhksBSvR/2RC44Oh
        ZZC+r7efqv+hsZy+GG6u4Lo=
X-Google-Smtp-Source: ABdhPJzYfpc8fOYPYu0i23K+bvAv9Wb5c47c/86tQ6e0UCp7vsosugff9C0XMZeRaRfNSwKDFkVmWw==
X-Received: by 2002:a5d:4388:: with SMTP id i8mr10888670wrq.365.1599772468422;
        Thu, 10 Sep 2020 14:14:28 -0700 (PDT)
Received: from localhost.localdomain ([170.253.60.68])
        by smtp.googlemail.com with ESMTPSA id l10sm111502wru.59.2020.09.10.14.14.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 14:14:27 -0700 (PDT)
From:   Alejandro Colomar <colomar.6.4.3@gmail.com>
To:     mtk.manpages@gmail.com
Cc:     linux-man@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alejandro Colomar <colomar.6.4.3@gmail.com>
Subject: [PATCH 17/24] get_phys_pages.3: Write 'long' instead of 'long int'
Date:   Thu, 10 Sep 2020 23:13:38 +0200
Message-Id: <20200910211344.3562-18-colomar.6.4.3@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200910211344.3562-1-colomar.6.4.3@gmail.com>
References: <20200910211344.3562-1-colomar.6.4.3@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For consistency.

Most man pages use 'long' instead of 'long int'.

Signed-off-by: Alejandro Colomar <colomar.6.4.3@gmail.com>
---
 man3/get_phys_pages.3 | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/man3/get_phys_pages.3 b/man3/get_phys_pages.3
index 4a9177dfd..97ba625b7 100644
--- a/man3/get_phys_pages.3
+++ b/man3/get_phys_pages.3
@@ -30,8 +30,8 @@ page counts
 .nf
 .B "#include <sys/sysinfo.h>"
 .PP
-.B long int get_phys_pages(void);
-.B long int get_avphys_pages(void);
+.B long get_phys_pages(void);
+.B long get_avphys_pages(void);
 .fi
 .SH DESCRIPTION
 The function
-- 
2.28.0

