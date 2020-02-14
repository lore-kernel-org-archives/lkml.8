Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23AAEC35242
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 20:49:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4636222C4
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 20:49:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UE6/SgkK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389101AbgBNUtG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 15:49:06 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54524 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388570AbgBNUs4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 15:48:56 -0500
Received: by mail-wm1-f67.google.com with SMTP id g1so11325607wmh.4
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2020 12:48:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qDX7xlEByvANKkjxM9Lv4JgW0Vs/V0JakfLRr2ITPLY=;
        b=UE6/SgkKeuTAsuXRIfdruwtL4gLAHWdQHQuDPd5zsch1GyoZc10regB3JX4ooDZQek
         F+O+w+/DnzDQLYkzk75nu2DfPcfeYKIHxpIqcJ9HJyZuD/QNCL/jtjeQTXZ1F6uEFTdE
         tieHtFiUclWWr8cHAxB0SroTyBhIdLMvdhML687x/jU75l3+8mxbXGVRTH92hEgVQbbb
         5xEl+rIoIcN+pM3bZoUuu4Zze1bzlTIOrqthuQ13+ktnHrCRsSPvMIfV/gBbIycUQtaB
         4vPx346JrOGgjPT1cA4jkoicTH3xDxL8loA6N/RN5p3RJZuYDDK8eGSPk27IRxzGPs4r
         mQoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qDX7xlEByvANKkjxM9Lv4JgW0Vs/V0JakfLRr2ITPLY=;
        b=qAXTRr1smkMp6HijC9JkNjFSSqQhxrSCDNf6CljQwaws43fSiednyYmPmMJa+isClD
         MqbdREvUw2QjKEPhFusaJ3QpAtJFbFgUtRhJ4KUCXZRm1e2BSbdC9TbLT4N+T+jePLer
         KfuvOUqDKg+ZaNYu6HVYkaJTfQR89p8LPosd91BFYqstqaNLkf+hn8KIItxvj7852Wwf
         E9F9qLW+mrM8GHDeFPeW9rRmG3wK6rSgC3YOo5B/o6ssgdck7znmfp/5Rkd/0mMvV9mK
         b48/kLvQUOKrRjnF9VvFLG1cl9yvsnoMecl0M3W55nOTAyMHGvkXh5vnb4RYNeNGWIeH
         eA5A==
X-Gm-Message-State: APjAAAUr7CSr9I7FSmXUGqDErBIUdbxZp2gY3L6jR+nJ+U5jMcucMAC7
        6NDitqn+Plja7vxR7kZM6imN5h9fNM9u
X-Google-Smtp-Source: APXvYqzoXyb89xSgE4kE0RZDERiRBX6lyzBCQyNYCuxlS2s9u42T5r477l4I+M6THkYEvsH3vBRzAQ==
X-Received: by 2002:a7b:c4c3:: with SMTP id g3mr6300205wmk.131.1581713333906;
        Fri, 14 Feb 2020 12:48:53 -0800 (PST)
Received: from ninjahost.lan (host-2-102-13-223.as13285.net. [2.102.13.223])
        by smtp.googlemail.com with ESMTPSA id y12sm8660782wmj.6.2020.02.14.12.48.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2020 12:48:53 -0800 (PST)
From:   Jules Irenge <jbi.octave@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     boqun.feng@gmail.com, Jules Irenge <jbi.octave@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH 18/30] driver core: Add missing annotation for device_links_write_lock()
Date:   Fri, 14 Feb 2020 20:47:29 +0000
Message-Id: <20200214204741.94112-19-jbi.octave@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200214204741.94112-1-jbi.octave@gmail.com>
References: <0/30>
 <20200214204741.94112-1-jbi.octave@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sparse reports a warning at device_links_write_lock()

warning: context imbalance in evice_links_write_lock()
	 - wrong count at exit

The root cause is the missing annotation at device_links_write_lock()
Add the missing __acquires(&device_links_srcu) annotation

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
---
 drivers/base/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 42a672456432..fc7f1b8746da 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -64,7 +64,7 @@ static inline void device_links_write_unlock(void)
 	mutex_unlock(&device_links_lock);
 }
 
-int device_links_read_lock(void)
+int device_links_read_lock(void) __acquires(&device_links_srcu)
 {
 	return srcu_read_lock(&device_links_srcu);
 }
-- 
2.24.1

