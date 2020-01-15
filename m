Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5D45C32771
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 18:42:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 921C624671
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 18:42:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="c5tBQhDI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729263AbgAOSmE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 13:42:04 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:36304 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729037AbgAOSmB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 13:42:01 -0500
Received: by mail-lj1-f195.google.com with SMTP id r19so19720402ljg.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jan 2020 10:42:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FfinOLqwdFdhYZe1AnbIMe0/TNWIknzNIzj+1zq5Eyc=;
        b=c5tBQhDIunGNFn53pgP9Ti5dbFYSwr2pnlwoGuPfWRYEUCz17T/jT5iIKPP6I0x/YR
         GHEMtMSuEj777U2+bcIe4PSCm6PeQy7AuSL9KUQAWEm0N40IpP6QwOJ0niFhN9wEYXPs
         nJqtzCU3Z5UMrmuSYc8T8Y4qagLCyiR5lESU0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FfinOLqwdFdhYZe1AnbIMe0/TNWIknzNIzj+1zq5Eyc=;
        b=FG2A0190afWucNXSk9lcZbV4VoP8C8418oWDxDK0RSZqbh8DCTibwkrs3bw8VhcAZT
         pOaSO45kEKRpMxMoJyHwRGWSWDaU3QoADcQgXEiDE4I6usFrgQe+L8dgaMIgqbijESy7
         quMMMV21EsdkmZtMic/8Z8lgG1xE5164TGLfo0MaYkwlJ0eqdw7qox++X5hOMNQdJ+4i
         BmtUXmaRRRya5EKCRjAaeodb29TOx2Xkl07aVzVHfQuWH6XWVwJzEjD/3TUTFRUt4p7U
         mY4xk878S0Mi1njJnsQ53vkjmjkgLHj2H7ujhpnXS46CTENYvjKdfSGtgrRl44BOHuN+
         OKjg==
X-Gm-Message-State: APjAAAUUCMLhx+Pe0D2K1MgJaYMmhCueJkSOuXaCKJF2iiLiFzoQNTYt
        yO0wzEjY9fgVfV8djv4u1Sh3Bw==
X-Google-Smtp-Source: APXvYqxgnWV2ulnP7ByoOkUk7r48vUZ37yGOXuNvERXlvFyUeD2440D/Z+A/J5gDBR91SQS+oSmxSA==
X-Received: by 2002:a2e:95c4:: with SMTP id y4mr2760330ljh.38.1579113719632;
        Wed, 15 Jan 2020 10:41:59 -0800 (PST)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id 21sm9598631ljv.19.2020.01.15.10.41.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 10:41:59 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] devtmpfs: factor out setup part of devtmpfsd()
Date:   Wed, 15 Jan 2020 19:41:50 +0100
Message-Id: <20200115184154.3492-3-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200115184154.3492-1-linux@rasmusvillemoes.dk>
References: <20200115184154.3492-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Factor out the setup part of devtmpfsd() to make it a bit easier to
see that we always call setup_done() exactly once (provided of course
the kthread is succesfully created).

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/base/devtmpfs.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/base/devtmpfs.c b/drivers/base/devtmpfs.c
index ccb046fe12b7..963889331bb4 100644
--- a/drivers/base/devtmpfs.c
+++ b/drivers/base/devtmpfs.c
@@ -388,7 +388,7 @@ static int handle(const char *name, umode_t mode, kuid_t uid, kgid_t gid,
 		return handle_remove(name, dev);
 }
 
-static int devtmpfsd(void *p)
+static int devtmpfs_setup(void *p)
 {
 	int err;
 
@@ -400,7 +400,18 @@ static int devtmpfsd(void *p)
 		goto out;
 	ksys_chdir("/.."); /* will traverse into overmounted root */
 	ksys_chroot(".");
+out:
+	*(int *)p = err;
 	complete(&setup_done);
+	return err;
+}
+
+static int devtmpfsd(void *p)
+{
+	int err = devtmpfs_setup(p);
+
+	if (err)
+		return err;
 	while (1) {
 		spin_lock(&req_lock);
 		while (requests) {
@@ -421,10 +432,6 @@ static int devtmpfsd(void *p)
 		schedule();
 	}
 	return 0;
-out:
-	*(int *)p = err;
-	complete(&setup_done);
-	return err;
 }
 
 /*
-- 
2.23.0

