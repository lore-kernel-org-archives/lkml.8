Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2540EC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 06:26:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF5E520787
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 06:26:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VCMH9aJZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728500AbgE0G0q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 02:26:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728003AbgE0G0p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 02:26:45 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96FA3C061A0F
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 23:26:45 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id e11so10437229pfn.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 23:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5F8AuAdD6vIH5WTUv671XyQbSMrH4wURkSBRo5DqQ6I=;
        b=VCMH9aJZEMUKwdWpD907O6d8TMaPjL4JJT4vpgHMwChl2TQh+0cIkUtMSXgS2ZH6aN
         bvMDRnH156mxfIHNj/zo6p7qGmmMeqaaUhEVvaFikc4qGaCK1koc7PLRxw5tNNHdY2Mb
         jtIwF/7tRuPFWH5QwPRZ7KyTU+s9nBN9h2e0GSy3ObZyqPkqHNmMHICCJQ42Jlcj9xLI
         8lgYj2RjFBgVwqk7nyzvyNNZb8S8eNqrKSf52wkkVDL0c+AlKll1IyK77BFOPAYYWyTC
         YgMZz2JkmOl42xHfxOV7PDWHf9Elfa3KofSAP08d2xpMV9jDgUlNFwAn4bjEc3bcOEhO
         cFsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5F8AuAdD6vIH5WTUv671XyQbSMrH4wURkSBRo5DqQ6I=;
        b=LfJ0X/VGMVrRrBmEaw26j9tf9U3D0OTZbYJpWJZXzPSrgsoERxlmon3Ir+GDaPbve4
         wihcsbv0oL4im1GO5l+J8E+3XyyiWsLdGavSQqncSe3fwN5N9/xzieUQLjxjQ6S2+rQE
         NOokeJfWKP2YyWpi3gBfAux9oDtz7U1JaOEsr+pkZQ62TYWlqobr2tMIDsygJ/f/Hnsb
         ts6csNj7PyRK9FR0FExW0DcMeKYAFsqAn3kToGAsJfNysHRIjj6M2RdoNutY10cOZKTZ
         CFCmHY/kWUQ1ZUvSWcD2L60DVLiLqOFQSJuw+kUgLVC2TN1RJUxRFGxZN2Lcwj2EE9PQ
         EjUA==
X-Gm-Message-State: AOAM531M3XbZSEPH8eoABuNum7IzoH3qFooEZSWUX/p4K7+v32SlEdBv
        VDD8EZDEvMUKhU/5CpYhPbPHsg==
X-Google-Smtp-Source: ABdhPJyeT+KxjyC94j5N+rfQfDyWTDiqqHSfAO3JO/MYUToUrCmwpPVeBGCcFCYe1rG45lq2kx/2Tw==
X-Received: by 2002:a63:689:: with SMTP id 131mr2278235pgg.401.1590560805099;
        Tue, 26 May 2020 23:26:45 -0700 (PDT)
Received: from localhost.localdomain ([117.252.68.136])
        by smtp.gmail.com with ESMTPSA id m12sm1239121pjs.41.2020.05.26.23.26.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 May 2020 23:26:44 -0700 (PDT)
From:   Sumit Garg <sumit.garg@linaro.org>
To:     daniel.thompson@linaro.org
Cc:     kgdb-bugreport@lists.sourceforge.net, jason.wessel@windriver.com,
        dianders@chromium.org, pmladek@suse.com,
        sergey.senozhatsky@gmail.com, linux-kernel@vger.kernel.org,
        Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v3 2/4] kdb: Check status of console prior to invoking handlers
Date:   Wed, 27 May 2020 11:55:57 +0530
Message-Id: <1590560759-21453-3-git-send-email-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1590560759-21453-1-git-send-email-sumit.garg@linaro.org>
References: <1590560759-21453-1-git-send-email-sumit.garg@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Check if a console is enabled prior to invoking corresponding write
handler.

Suggested-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---
 kernel/debug/kdb/kdb_io.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/debug/kdb/kdb_io.c b/kernel/debug/kdb/kdb_io.c
index f6b4d47..349dfcc 100644
--- a/kernel/debug/kdb/kdb_io.c
+++ b/kernel/debug/kdb/kdb_io.c
@@ -564,6 +564,8 @@ static void kdb_msg_write(char *msg, int msg_len)
 		kdb_io_write(msg, msg_len, dbg_io_ops->write_char);
 
 	for_each_console(c) {
+		if (!(c->flags & CON_ENABLED))
+			continue;
 		c->write(c, msg, msg_len);
 		touch_nmi_watchdog();
 	}
-- 
2.7.4

