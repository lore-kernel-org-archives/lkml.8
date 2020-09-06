Return-Path: <SRS0=pQss=CP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BBBEC433E2
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Sep 2020 20:12:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C67BF208B3
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Sep 2020 20:12:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L4BXwmWD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbgIFUMS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Sep 2020 16:12:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726154AbgIFUMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Sep 2020 16:12:14 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DE29C061573
        for <linux-kernel@vger.kernel.org>; Sun,  6 Sep 2020 13:12:12 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id e33so7046262pgm.0
        for <linux-kernel@vger.kernel.org>; Sun, 06 Sep 2020 13:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fMygZrwawBCdGQ2bBFDMvJ3Y2e+cfl4sBDGo7UGztys=;
        b=L4BXwmWDvemqRJGMuLN9aM59ZoBRJbDiKherzXRYsVuFip8Ct5P0Xo8HzEgxOnEJLk
         fEyfQiKDUZOHF7XLgfXFHdnmZV23yYOSKwrO+2/N5ssNQqqzPcbIFZSzGkLgJkbe3i62
         jVEIcuIDzeDD26X5lY8scOfzlkXBvamq5dkXqjiDZFCv3RgLpISw25ly12G/Cwk6S48R
         MFu21cff5CVj4VjLwvZnL7yQqKjP2MNNMaf4lZ5rn4QRtDxvA3usHQiJiCMZMPGo5szU
         zEn3dnxBuKOgnQ72NzwoQBdCEQMXWuzfwh0XH5wGr5Hf4M0fWz1Xf8slBxWjg0Dedy/p
         lBQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fMygZrwawBCdGQ2bBFDMvJ3Y2e+cfl4sBDGo7UGztys=;
        b=rGZsi8NU3F8wT76Cos45ZdCxaeN9pFc4vRrg/WDucMFK7XYvMZx5qi3wM9sfFq3ZhS
         I5yNbqto5Eq3/ycMZo0Tmhf1sspRho8j3KlcKr3vtJAHKFw2Yk2RuQd6IRORZNtufxXn
         otSVwQ956IURPEjKL1wZR0L2FthMK0ZgnIMi6Z8LxsJFD/+ab55v/3M07gfqO+9bTNFp
         PabKa8nPmCow0JNiNJC6ItQBPGHySwgiJOe2jMWnpxTBaDsgmt76h4fCMQVGDMlpOcep
         0i+rEZUFRjKykh+UrqjakQPiatUGDxr+U/pnAGPUyEmwow/a4VpURQn2efUxu0LL7504
         Ksig==
X-Gm-Message-State: AOAM531EjSRGg5gM9SAeSREEI78UI+xAJletcJ5qJ/xw6E29ub+7duxr
        SJqHO9qw7pyjW0HFzV4VMLQ=
X-Google-Smtp-Source: ABdhPJwnui4bywCc/fybs+kbVubILOVIYNhTsWjZV7ufrjbUJTklHsHiivFQmhkzH7GUlBTPus5McA==
X-Received: by 2002:a62:5e04:: with SMTP id s4mr17619755pfb.67.1599423126651;
        Sun, 06 Sep 2020 13:12:06 -0700 (PDT)
Received: from localhost.localdomain ([49.207.209.246])
        by smtp.gmail.com with ESMTPSA id v12sm10705735pgk.81.2020.09.06.13.12.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2020 13:12:05 -0700 (PDT)
From:   Anant Thazhemadam <anant.thazhemadam@gmail.com>
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        Anant Thazhemadam <anant.thazhemadam@gmail.com>,
        syzbot+b8639c8dcb5ec4483d4f@syzkaller.appspotmail.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Saravana Kannan <saravanak@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Joerg Roedel <jroedel@suse.de>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-kernel@vger.kernel.org
Subject: [Linux-kernel-mentees] [PATCH] block : Fix use-after-free Read in delete_partition
Date:   Mon,  7 Sep 2020 01:41:56 +0530
Message-Id: <20200906201158.14014-1-anant.thazhemadam@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A use-after-free read of the kobject member being casted out to the
device structure containing it seems to be potentially possible
due to unsafe casting using container_of (since an edge case such
as when the ptr being casted might be NULL or problematic is not
accounted for).
Using container_of_safe resolves this issue, with no obvious tradeoffs
and without considerable expense.

Reported-by: syzbot+b8639c8dcb5ec4483d4f@syzkaller.appspotmail.com
Tested-by: syzbot+b8639c8dcb5ec4483d4f@syzkaller.appspotmail.com
Signed-off-by: Anant Thazhemadam <anant.thazhemadam@gmail.com>
---
 include/linux/device.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/device.h b/include/linux/device.h
index ca18da4768e3..aeb70b7a37e6 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -643,7 +643,7 @@ struct device_link {
 
 static inline struct device *kobj_to_dev(struct kobject *kobj)
 {
-	return container_of(kobj, struct device, kobj);
+	return container_of_safe(kobj, struct device, kobj);
 }
 
 /**
-- 
2.25.1

