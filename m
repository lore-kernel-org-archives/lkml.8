Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E915C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 22:47:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 651A320760
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 22:47:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rEOLNFv6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726813AbgFJWrb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 18:47:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726772AbgFJWr2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 18:47:28 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7082DC03E96B
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 15:47:26 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id j12so2432494lfh.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 15:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KjJQ7AInceOuwKMnEv1aGJR1QmBpJAJ+iEhekFI4YOg=;
        b=rEOLNFv6XQcfb7xLJzIhp9XT5z4Lsd50uXWDirUfWNZo98s911Rjc3L0OWraiLhvAL
         1Cdllv6PvB7q68J62VFAApFB5lG4rjemErSOsAy86mn7cJN8Alv9/QLcmq/NUHYMkDZu
         xhAgkq4I7zT0cmtBKwAL1mVGwdKISiNYHoFOHUOHQPIRamwfljcUiq5vC5IlOwd4FVoG
         yqQBd4q6iohrrM20ZUogXf1NUEwxNMYMzjNyfX3KM42BjOX1Ls+on8pLdIizrVg3oyWa
         Q39O9umQIUPkq+P0xbd/PXr34+BVFIS8Ygy8OmY7aR/v3M9ybGTksV1aMJV/9HKYHfV/
         wv9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KjJQ7AInceOuwKMnEv1aGJR1QmBpJAJ+iEhekFI4YOg=;
        b=M+4pmMb3ksMOcva62pgGAKx5H+as7JKVQV3QB9DuyfN/xGSGvXodxr6V7knijzWVvP
         +7GPLDGOyoFXoTiX9uagE9acNAxqMaIwVKeFKgvkuUfy52W/giW/N3R+AyFqno5VSmEC
         sam/uChX/EyJKd3DF7z1RLYjjQD12U+mrxMsdCEFqSsuIlAkzphoWs2P/1TfH1h9BwjS
         Mh0pjNLkVdiiq1XNW5WFgRwjF9I2LcbG1qpfM82Zn9johk8DZfSxbO+xFUhT4KmrpU+V
         NCFsvERz3iCVle20MPAPFHoflZ34AmC8SoU98VAYGyHha9QlPra9xq5mLnIYQSfIkicp
         MFGA==
X-Gm-Message-State: AOAM533NTYH1d94sCMTFxFSEAUXyF3HcMK5YgTLfs5O4Dy9U9/TplLmG
        HfrgieVYsMsWJ7vOvVaNK4uFXztiVlk=
X-Google-Smtp-Source: ABdhPJw3UGv8w0/qe06PdfsLi4k9BUjPJxa2QmVNgzGcGUxQS9/SEPNX7hsDdh/kOLJHU6Itd+LyPQ==
X-Received: by 2002:a19:bc4:: with SMTP id 187mr2848814lfl.211.1591829244300;
        Wed, 10 Jun 2020 15:47:24 -0700 (PDT)
Received: from localhost.localdomain (h-82-196-111-136.NA.cust.bahnhof.se. [82.196.111.136])
        by smtp.gmail.com with ESMTPSA id s17sm262506ljd.51.2020.06.10.15.47.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2020 15:47:23 -0700 (PDT)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: [PATCH 3/4] mei: hdcp: Constify struct mei_cl_device_id
Date:   Thu, 11 Jun 2020 00:47:03 +0200
Message-Id: <20200610224704.27082-4-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200610224704.27082-1-rikard.falkeborn@gmail.com>
References: <20200610224704.27082-1-rikard.falkeborn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mei_hdcp_tbl[] is never modified and can be made const to allow the
compiler to put it in read-only memory.

Before:
   text    data     bss     dec     hex filename
  15844    5416       0   21260    530c drivers/misc/mei/hdcp/mei_hdcp.o

After:
   text    data     bss     dec     hex filename
  16004    5256       0   21260    530c drivers/misc/mei/hdcp/mei_hdcp.o

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
 drivers/misc/mei/hdcp/mei_hdcp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/mei/hdcp/mei_hdcp.c b/drivers/misc/mei/hdcp/mei_hdcp.c
index 4c596c646ac0..e6c3dc595617 100644
--- a/drivers/misc/mei/hdcp/mei_hdcp.c
+++ b/drivers/misc/mei/hdcp/mei_hdcp.c
@@ -852,7 +852,7 @@ static int mei_hdcp_remove(struct mei_cl_device *cldev)
 #define MEI_UUID_HDCP GUID_INIT(0xB638AB7E, 0x94E2, 0x4EA2, 0xA5, \
 				0x52, 0xD1, 0xC5, 0x4B, 0x62, 0x7F, 0x04)
 
-static struct mei_cl_device_id mei_hdcp_tbl[] = {
+static const struct mei_cl_device_id mei_hdcp_tbl[] = {
 	{ .uuid = MEI_UUID_HDCP, .version = MEI_CL_VERSION_ANY },
 	{ }
 };
-- 
2.27.0

