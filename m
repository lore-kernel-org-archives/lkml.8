Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46069C32771
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 01:24:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D9AC2467E
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 01:24:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SJwnin5n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730054AbgAPBY3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 20:24:29 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46616 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729504AbgAPBYY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 20:24:24 -0500
Received: by mail-pf1-f196.google.com with SMTP id n9so9356857pff.13
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jan 2020 17:24:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=46Z0N6nNFPIgM2OuwNgkHRjYe659IsqNoWw8FG0hdrY=;
        b=SJwnin5nMwZBKrhpnWtYLNNA2XESjaBA5OMZZUiC+dLBovxajhmbEreGNQuSCGlJwg
         rzwLtTnueeZeF9mo1NZWc/UG++85l/gf4xMNaTD7Mi65olwyiNctPjj7SEzVTf8lz6JY
         y2wkfmtBIGevOe/HcrOjcNSuIe8PF7VSzsSEI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=46Z0N6nNFPIgM2OuwNgkHRjYe659IsqNoWw8FG0hdrY=;
        b=Z+w4li/s9q8ttQVk6pQqy4PZOg5yJndGgS9FXv/3DP85Dc+kDgH5Nugny1BUDhr+eh
         J+oNqFvns2WqFKHCDIT0hKbt6h54w4aM6OgtimLJC1V4lgL5z+f4KfOJyyrBKiQ5xEoE
         wjAgzZICyBYnzFND3Q2E47Eg480IrjEcrp4Oz/LHaPZZritfoCSPcY5x3j0fO97YhIlR
         cqPbwX8ott6Y6fwjMpA9dXLxsK5I37FhR7YY0dgbvTXC5HBdEaKeBq9AU5jD0RpsV9ZK
         HnmGok+zb9JYZDLcViQct4TEq+pIRVjlb9ldebF5oGKY3BYFsSt6F6zC68mCtD6o6cZK
         n27A==
X-Gm-Message-State: APjAAAUKYIypANi1Fp1Nq3jhS2h+dUHayorQyIfc07V5AHZrRPSruqLV
        gWhX5CBRjQtvh58B8XuC3Zzw8A==
X-Google-Smtp-Source: APXvYqxsGknX6bnO/GaSkj5DHw5Et7M+pO9sTANSMwjDnHU91axQ6Z/1Fsl4MvtQ189Vh73/ukEWVg==
X-Received: by 2002:aa7:9816:: with SMTP id e22mr35105862pfl.229.1579137863425;
        Wed, 15 Jan 2020 17:24:23 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d20sm1058272pjs.2.2020.01.15.17.24.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 17:24:18 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Elena Petrova <lenaptr@google.com>,
        Alexander Potapenko <glider@google.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com,
        syzkaller@googlegroups.com
Subject: [PATCH v3 4/6] ubsan: Check panic_on_warn
Date:   Wed, 15 Jan 2020 17:23:19 -0800
Message-Id: <20200116012321.26254-5-keescook@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116012321.26254-1-keescook@chromium.org>
References: <20200116012321.26254-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Syzkaller expects kernel warnings to panic when the panic_on_warn
sysctl is set. More work is needed here to have UBSan reuse the WARN
infrastructure, but for now, just check the flag manually.

Link: https://lore.kernel.org/lkml/CACT4Y+bsLJ-wFx_TaXqax3JByUOWB3uk787LsyMVcfW6JzzGvg@mail.gmail.com
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 lib/ubsan.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/lib/ubsan.c b/lib/ubsan.c
index 7b9b58aee72c..429663eef6a7 100644
--- a/lib/ubsan.c
+++ b/lib/ubsan.c
@@ -156,6 +156,17 @@ static void ubsan_epilogue(void)
 		"========================================\n");
 
 	current->in_ubsan--;
+
+	if (panic_on_warn) {
+		/*
+		 * This thread may hit another WARN() in the panic path.
+		 * Resetting this prevents additional WARN() from panicking the
+		 * system on this thread.  Other threads are blocked by the
+		 * panic_mutex in panic().
+		 */
+		panic_on_warn = 0;
+		panic("panic_on_warn set ...\n");
+	}
 }
 
 static void handle_overflow(struct overflow_data *data, void *lhs,
-- 
2.20.1

