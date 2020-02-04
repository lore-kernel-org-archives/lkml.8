Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CC62C2D0B1
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 13:07:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D87C62087E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 13:07:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fKrvzJxr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727247AbgBDNHz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 08:07:55 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:34313 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727149AbgBDNHy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 08:07:54 -0500
Received: by mail-pl1-f194.google.com with SMTP id j7so7274942plt.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Feb 2020 05:07:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MCWG8R9hWDU9xx10VsmvZMYnvw0WNin8rkugXJrWgvI=;
        b=fKrvzJxrWRRh57lk/58/Pidsr/bNv2BW5qoFMF/nhRGTLF2bX2zA6ouG+kHVWYAJxe
         4+Exq/JKTzFZW91FIX71uGlg5d9dzeC7af4ND7bK/I/2u1mmPJWkpBvUDMZdfjAnodeo
         91rRqTvHaWjTojdXwoKRXpqWV6x3AS99JPo/zGmJRao2xy2N3wJew93EcLcbw5P3+M9F
         KYYxD9F8W3pr5G6psbAbI+7gU5ZI1MmzU/NMM1+mgqgnkMvtMuJx8mDcuXhfjP8HdPEI
         UgLM4rvJudxZGhCeEh8cpf7e2QTHFWVtnJb22f7loRAQy45w5Pvyq/CFziOzgA5+4gt0
         Y2YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MCWG8R9hWDU9xx10VsmvZMYnvw0WNin8rkugXJrWgvI=;
        b=giGmY4Uiqyo3ASUzi4N3Yv8aMATRZZYTMNWDDBrKZG+jOHEFfKc5uBcCuDlZnKyFZt
         ptUtPkIJ6o+gKL/jlWa9Wc1/UDkLw+euAc8xCYyTLcx73+8/OI/qBp4Cml4sYfAdOBUz
         T4leoT8GO36lJQ78dlP0jQEnpY868X+2J0qpKm4gnqg6qaNFSuROQpDikJ/BJ4I2mpye
         cF46K67N0iIfUhUKKGOGImOh7iulUkqUdFoocjnO/78AQl+dq1E131kn1Al0uOkdlRfj
         qBBUWL5Le+TWj6h5dUeFgF1bEs2zNjYnSdNx2ugnNaGT3mz8xePYWvqI8JAiDcJckIJ6
         QYlA==
X-Gm-Message-State: APjAAAVOQtvQGsiA6Xe4qeiQSpIEPRlFqzV/wswD4zxbzQNpE8ZxGokd
        y+a8v9HV14OuL7wG+F02h5kYqaG0gz4=
X-Google-Smtp-Source: APXvYqzLZ0FcUdu0Tkgz1ySgVt/2411q/2O0EoBAVQhNx6U8B+i9/ZbUfysCnAlfUGMib4QBo827AA==
X-Received: by 2002:a17:90a:f0c8:: with SMTP id fa8mr6349269pjb.136.1580821673313;
        Tue, 04 Feb 2020 05:07:53 -0800 (PST)
Received: from localhost ([43.224.245.179])
        by smtp.gmail.com with ESMTPSA id q17sm16150261pfg.123.2020.02.04.05.07.52
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 04 Feb 2020 05:07:52 -0800 (PST)
From:   qiwuchen55@gmail.com
To:     keescook@chromium.org, anton@enomsg.org, ccross@android.com,
        tony.luck@intel.com
Cc:     linux-kernel@vger.kernel.org, chenqiwu <chenqiwu@xiaomi.com>
Subject: [PATCH 2/2] pstore/ram: remove unnecessary ramoops_unregister_dummy()
Date:   Tue,  4 Feb 2020 21:07:14 +0800
Message-Id: <1580821634-15246-2-git-send-email-qiwuchen55@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1580821634-15246-1-git-send-email-qiwuchen55@gmail.com>
References: <1580821634-15246-1-git-send-email-qiwuchen55@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: chenqiwu <chenqiwu@xiaomi.com>

Remove unnecessary ramoops_unregister_dummy() if ramoops
platform device register failed.

Signed-off-by: chenqiwu <chenqiwu@xiaomi.com>
---
 fs/pstore/ram.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/pstore/ram.c b/fs/pstore/ram.c
index 013486b..7956221 100644
--- a/fs/pstore/ram.c
+++ b/fs/pstore/ram.c
@@ -963,7 +963,6 @@ static void __init ramoops_register_dummy(void)
 		pr_info("could not create platform device: %ld\n",
 			PTR_ERR(dummy));
 		dummy = NULL;
-		ramoops_unregister_dummy();
 	}
 }
 
-- 
1.9.1

