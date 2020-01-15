Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18D2CC32771
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 18:42:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5AD724656
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 18:42:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="g35egtci"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729098AbgAOSmB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 13:42:01 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:40209 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728928AbgAOSmA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 13:42:00 -0500
Received: by mail-lf1-f65.google.com with SMTP id i23so13501972lfo.7
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jan 2020 10:41:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Rz0XCttZT2dPGNYd/FmheOpcsyFXLHj9mMq3+yWtVXQ=;
        b=g35egtciR297Lolg6uFOkfL4zMv/VVVf/HDn1W/yoQQPZIGssoXSTx6lvgv7NlAbgp
         NpVOk/FgbINfbeIeRmybTK0rs7U3E260vIiltSd2SqplkBnxRDUMuMnrFabDQoLhV6OC
         z8qnDyZbRjlOT0yXzIJECu/GIof2TeY1wWHFc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Rz0XCttZT2dPGNYd/FmheOpcsyFXLHj9mMq3+yWtVXQ=;
        b=LZc0wH4d28LbHK7qpO9cGF9PsBU9N62OqciqMRoj7iwE6rz3OszD7IyhqnyWj6VZvJ
         P4PpRT3ZvDV67qM6l8cSSk9gkZN+0IpCAFe4hxCZpShXhT6mPhoair1IWPqPqQ41hTeb
         7Ks1ZPSNG6KW8Dx9G4lACjF9lfuohY4IXOJ8FZQNlKWwf+CshEz+1PECw9PHvVN5+gnH
         HghM79PvCMYigZ+J+ouVuu6tYzjE4B3chnGSvg2BZuJPZC8C01SF8HGzMRZcBB3k6oUk
         lc9Gd78qSRly6dd+cofhLEqp+R9aN+8HXJeJhxlnZmS62/GQW1+AOXYXKM/MC01HLqeX
         +sMw==
X-Gm-Message-State: APjAAAX1PftcUBQf7FgIyCCkbdOe/vaU9mQ7xaAwKjcMoYfJE/areVqU
        qFGiMSFDlViT9W7WSF2nalGVFg==
X-Google-Smtp-Source: APXvYqxnOvuKgDfCEz4/aVYSW+748SBib8HCnYvfxgMpCDZiWaOWdvS/Bis9HSvff0jLp+V8Kabn9w==
X-Received: by 2002:a19:7401:: with SMTP id v1mr156338lfe.129.1579113718512;
        Wed, 15 Jan 2020 10:41:58 -0800 (PST)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id 21sm9598631ljv.19.2020.01.15.10.41.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 10:41:57 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] devtmpfs: fix theoretical stale pointer deref in devtmpfsd()
Date:   Wed, 15 Jan 2020 19:41:49 +0100
Message-Id: <20200115184154.3492-2-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200115184154.3492-1-linux@rasmusvillemoes.dk>
References: <20200115184154.3492-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After complete(&setup_done), devtmpfs_init proceeds and may actually
return, invalidating the *err pointer, before devtmpfsd() proceeds to
reading back *err.

This is of course completely theoretical since the error conditions
never trigger in practice, and even if they did, nobody cares about
the exit value from a kernel thread, so it doesn't matter if we happen
to read back some garbage from some other stack frame. Still, this
isn't a pattern that should be copy-pasted, so fix it.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/base/devtmpfs.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/base/devtmpfs.c b/drivers/base/devtmpfs.c
index 6cdbf1531238..ccb046fe12b7 100644
--- a/drivers/base/devtmpfs.c
+++ b/drivers/base/devtmpfs.c
@@ -390,12 +390,13 @@ static int handle(const char *name, umode_t mode, kuid_t uid, kgid_t gid,
 
 static int devtmpfsd(void *p)
 {
-	int *err = p;
-	*err = ksys_unshare(CLONE_NEWNS);
-	if (*err)
+	int err;
+
+	err = ksys_unshare(CLONE_NEWNS);
+	if (err)
 		goto out;
-	*err = do_mount("devtmpfs", "/", "devtmpfs", MS_SILENT, NULL);
-	if (*err)
+	err = do_mount("devtmpfs", "/", "devtmpfs", MS_SILENT, NULL);
+	if (err)
 		goto out;
 	ksys_chdir("/.."); /* will traverse into overmounted root */
 	ksys_chroot(".");
@@ -421,8 +422,9 @@ static int devtmpfsd(void *p)
 	}
 	return 0;
 out:
+	*(int *)p = err;
 	complete(&setup_done);
-	return *err;
+	return err;
 }
 
 /*
-- 
2.23.0

