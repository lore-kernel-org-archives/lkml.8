Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 824A7C2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 06:16:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5627420663
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 06:16:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="edZ+cFRG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726222AbgCQGQQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 02:16:16 -0400
Received: from mail-wm1-f47.google.com ([209.85.128.47]:38628 "EHLO
        mail-wm1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbgCQGQQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 02:16:16 -0400
Received: by mail-wm1-f47.google.com with SMTP id t13so14194997wmi.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Mar 2020 23:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4uKrmSwHk8ZXHwztJyPdkY9OYtglcBK8wm4ihe7B9yo=;
        b=edZ+cFRGN2iBYT1vsyYbuS9LXVvpxNczEkabaQnHKLyqLRAiWjGPtue+ijG7hF4eoC
         dTZaQglxFWMlXwwLSg9GbreZxdbBcVKU2XNO53icNbvnmoYk488WTwJMGdz9DvSrstBc
         K40wQwu21togqlxyxPOPRFrkqhzMe6M189l7Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4uKrmSwHk8ZXHwztJyPdkY9OYtglcBK8wm4ihe7B9yo=;
        b=kCfja7ZSIzxsSBjX7rWXBb+VvWs+0EUyor5QkEutY9MpWLqPnCi6YXeb5E3TxS9HNK
         63QWzCy0UI9N9SOuN+HR1ppjXoiL9juOygaAnAERUUub/5YJ0hTd5z+L9cyF+qeHMfF4
         DwyN8eDXmv9kysMmluKsIFsdLm/RhcqJDQFmEtAYazIe8UeD9gS4IIyfz0DZ89qun9Fv
         zef4Xd4T5aTEDc7KBfIFL1KzByXlhof5+NJ70LUorpxkqzVtyRQYHEkKZ8zl1MxcHEUg
         7dE1PG+Q9Jz5/HylMa5txIVl2rTyDR//dwF+FznGgUGT5dQ2BrrzZqm8HzDuY1AoJqqh
         Z/sQ==
X-Gm-Message-State: ANhLgQ0theVj7Mk6/DH+4daUlxaTV8ILa0tA0KWSDrqwpAwlAI3AeS1q
        adkhuOCq1moLk0mnZp9+R+vrSg==
X-Google-Smtp-Source: ADFU+vv3I+pZXNLA27hOfYt3/0t6qaLgBb8Bl8cWgp6DAdvo4NskNfv8o19kHNC1PsRZD8Uh0bfkGQ==
X-Received: by 2002:a1c:f214:: with SMTP id s20mr3169425wmc.57.1584425774187;
        Mon, 16 Mar 2020 23:16:14 -0700 (PDT)
Received: from rayagonda.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id o5sm2658096wmb.8.2020.03.16.23.16.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2020 23:16:13 -0700 (PDT)
From:   Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Allison Randal <allison@lohutok.net>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
Subject: [PATCH v1 2/2] async_tx: fix possible negative array indexing
Date:   Tue, 17 Mar 2020 11:45:22 +0530
Message-Id: <20200317061522.12685-3-rayagonda.kokatanur@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200317061522.12685-1-rayagonda.kokatanur@broadcom.com>
References: <20200317061522.12685-1-rayagonda.kokatanur@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix possible negative array index read in __2data_recov_5() function.

Signed-off-by: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
---
 crypto/async_tx/async_raid6_recov.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/crypto/async_tx/async_raid6_recov.c b/crypto/async_tx/async_raid6_recov.c
index 33f2a8f8c9f4..9cd016cb2d09 100644
--- a/crypto/async_tx/async_raid6_recov.c
+++ b/crypto/async_tx/async_raid6_recov.c
@@ -206,7 +206,7 @@ __2data_recov_5(int disks, size_t bytes, int faila, int failb,
 		good_srcs++;
 	}
 
-	if (good_srcs > 1)
+	if ((good_srcs > 1) || (good < 0))
 		return NULL;
 
 	p = blocks[disks-2];
-- 
2.17.1

