Return-Path: <SRS0=SnAt=4L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 636C3C35673
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 23:20:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 376E920880
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 23:20:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WxJxvW7S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727260AbgBWXSB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Feb 2020 18:18:01 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36846 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727201AbgBWXR6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Feb 2020 18:17:58 -0500
Received: by mail-wm1-f68.google.com with SMTP id p17so7455460wma.1
        for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2020 15:17:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=m+LokEgk1OhCrIxCmqaU1nM/hbi0PMRKHeGZ/+qQiZ0=;
        b=WxJxvW7S7Tz2b6SBXdAVYnjRHLSfa7FbKJLMOZlTGVrI2g01Fgn1qfwPi31Tpvxz/F
         mtoIEApfsV+vV4P6AYC2imNjwiPxX6kR/eq+B/kav2hBTYR5oSKABqpmoyQ+lVmrSH4H
         gmIEShzOYsMb7vB12RlsHijOgSMF9BXmKF2kmVPa/BylY5BEhJSGihsBdZb64/TwOS4/
         zVcjeV9iHUfXWXFNF8JA7Ro20aRnz+nGYgEb7QNHoVj6FzDIfsWiJWTRsueCexqOUt4V
         lV4MeE9HuAoLj9oAbCXL8/3GSY6/+l8RzDyEKgSE2gaZFVg5X1z9CyJ0HpiGrNbgEP4s
         Sfkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=m+LokEgk1OhCrIxCmqaU1nM/hbi0PMRKHeGZ/+qQiZ0=;
        b=Ck2/X8GTEenHY8FSNHrCmQY5tQ7Krtyz96zErLQtg79d0qh9kiQIvanx6G99QibUiv
         R3iBBZXys6GnQAtwSFbvOsiJWCNbZo2Hr+hnVeD/yWzIiJCEhjkHR9vjOXwlIRLnudhD
         9gLLRT2qNYb82sSE0KxWkj86ZTEQ4oN9Y3bzne6mWw1q34nZsfDlSfjikVNc42J9GQmR
         AcgKBviyEuQrk7YasVVZFfGpkKCHFRdUnPcTfrxrZnB8DvGNi4x+nRiGw0UBSFhm3HQC
         iRH5jVASC1bHi2eQAAZGga2B2/jRPOZ0sm9+TerlOKJ4vGsjSAHsGX+krNjbSwj1cT+4
         zlqA==
X-Gm-Message-State: APjAAAUrT6T21OJYuXJRG7aQyDmbU317dHjZDMXlkEcJ9DPa7oERCe4p
        KdBgHmsSoyjWk3wHPk1tng==
X-Google-Smtp-Source: APXvYqx1xZoZd3Mg7blMfa6A8ZoF9XsfYVxAGm7/w6r4xbRVfj5XMCLb2k9zu8tiV2VMfYJA/cbBeA==
X-Received: by 2002:a1c:16:: with SMTP id 22mr18168884wma.8.1582499875389;
        Sun, 23 Feb 2020 15:17:55 -0800 (PST)
Received: from ninjahost.lan (host-2-102-13-223.as13285.net. [2.102.13.223])
        by smtp.googlemail.com with ESMTPSA id q6sm8968203wrf.67.2020.02.23.15.17.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Feb 2020 15:17:54 -0800 (PST)
From:   Jules Irenge <jbi.octave@gmail.com>
To:     boqun.feng@gmail.com
Cc:     jbi.octave@gmail.com, linux-kernel@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        linux-nvdimm@lists.01.org (open list:DEVICE DIRECT ACCESS (DAX))
Subject: [PATCH 02/30] dax: Add missing annotations ofr dax_read_lock() and dax_read_unlock()
Date:   Sun, 23 Feb 2020 23:16:43 +0000
Message-Id: <20200223231711.157699-3-jbi.octave@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200223231711.157699-1-jbi.octave@gmail.com>
References: <0/30>
 <20200223231711.157699-1-jbi.octave@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sparse reports warning at dax_read_lock() and at dax_read_unlock()

warning: context imbalance in dax_read_lock() - wrong count at exit
 warning: context imbalance in dax_read_unlock() - unexpected unlock

The root cause is the mnissing annotations at dax_read_lock()
	and dax_read_unlock()

Add the missing __acquires(&dax_srcu) notations to dax_read_lock()
Add the missing __releases(&dax_srcu) annotation to dax_read_unlock()

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
---
 drivers/dax/super.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dax/super.c b/drivers/dax/super.c
index 26a654dbc69a..f872a2fb98d4 100644
--- a/drivers/dax/super.c
+++ b/drivers/dax/super.c
@@ -28,13 +28,13 @@ static struct super_block *dax_superblock __read_mostly;
 static struct hlist_head dax_host_list[DAX_HASH_SIZE];
 static DEFINE_SPINLOCK(dax_host_lock);
 
-int dax_read_lock(void)
+int dax_read_lock(void) __acquires(&dax_srcu)
 {
 	return srcu_read_lock(&dax_srcu);
 }
 EXPORT_SYMBOL_GPL(dax_read_lock);
 
-void dax_read_unlock(int id)
+void dax_read_unlock(int id) __releases(&dax_srcu)
 {
 	srcu_read_unlock(&dax_srcu, id);
 }
-- 
2.24.1

