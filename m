Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E395C43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 07:26:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 967AA21741
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 07:26:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hNAVYHr5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727005AbgIIH0i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 03:26:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725772AbgIIH0d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 03:26:33 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7C6CC061573;
        Wed,  9 Sep 2020 00:26:32 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id d6so1371411pfn.9;
        Wed, 09 Sep 2020 00:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NB8HBUKnl+eWfZNHIQZWAbfkL9C5IcAO+9Z1lg426u8=;
        b=hNAVYHr5uxDesz7m8yBEg9nTrnbnzLgkuYvjloOejB/N6d8aae8dTdQu2xhhan0Vtl
         viJO7ZNo030PGxkXyTbUWpTLuecLUIQqkBS8LH3U7RamoG+oAkaDuHOi1A+4PZjSmPqi
         EoBVK7TpvxlDjdnHPXyH3Yt8wyrKOK8XGgzfYVPpmIKGXeE12M8psa9BW0zZQJ/aHR+4
         KF/ZtkQjl2s+FQdRkBIGBmzK0/R0Z4NYX3mb0hIpGiLpkbIV26/G31SgEorcqReRRZiM
         ikR/C5UVkQ4ft+STBWWOMXlnHbrPVrbPt6HloxfdmkPRVFO2/z1j6cGnR0nhUwxzeynF
         JkHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NB8HBUKnl+eWfZNHIQZWAbfkL9C5IcAO+9Z1lg426u8=;
        b=t12lx9coJGdoCnAhFce6SBCJ5KTJ+px911baX2lT8OOkEaJBI7YwISalcBHIRJnQPM
         1ghh+kbzWyfS1NOsc0f8HreEG+nesx+v3DOnEkoyCR2qF/JIrT6t+ImlHlMaA2hlGyvC
         OH4C6LOSjmFDHcnkLuiqol6/a5ue9ikaZuWj69QEOuMwshx1dwol/LhFJ8o09sD7sCA5
         ejd9FImKnhExzDMakc9ZQb7im3W4hXMA4oiePsnf3F5oiDJkZ9pXnRk6zrGS7acRBHc6
         TnsCsinPiS27wMv0a/UW1a/14y4RHlnv+lTef9jM0AWt5QB/JPVUPwg8alb6YrOVTTDP
         MWhA==
X-Gm-Message-State: AOAM533U9m8ANTHHsZQ7JFppywn+2ugCSnohk/6FKMLGGdTdZicbJnvd
        dMjhkviDCGu5N4Vx4//0ww==
X-Google-Smtp-Source: ABdhPJxgN58H3LqRJckQL6qJXd2ZuTLY65XPV2ud3K7OCYkyiqQA+x1vw7hC5sQIXpCuHOBgInDgkQ==
X-Received: by 2002:a17:902:c38a:: with SMTP id g10mr2551819plg.23.1599636392271;
        Wed, 09 Sep 2020 00:26:32 -0700 (PDT)
Received: from localhost.localdomain (n11212042027.netvigator.com. [112.120.42.27])
        by smtp.gmail.com with ESMTPSA id r10sm1129570pjp.49.2020.09.09.00.26.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 00:26:31 -0700 (PDT)
From:   Peilin Ye <yepeilin.cs@gmail.com>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     Peilin Ye <yepeilin.cs@gmail.com>,
        Miao-chen Chou <mcchou@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        syzkaller-bugs@googlegroups.com
Subject: [Linux-kernel-mentees] [PATCH v2] Bluetooth: Fix memory leak in read_adv_mon_features()
Date:   Wed,  9 Sep 2020 03:25:51 -0400
Message-Id: <20200909072551.1101031-1-yepeilin.cs@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200908200635.1099360-1-yepeilin.cs@gmail.com>
References: <20200908200635.1099360-1-yepeilin.cs@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

read_adv_mon_features() is leaking memory. Free `rp` before returning.

Fixes: e5e1e7fd470c ("Bluetooth: Add handler of MGMT_OP_READ_ADV_MONITOR_FEATURES")
Reported-and-tested-by: syzbot+f7f6e564f4202d8601c6@syzkaller.appspotmail.com
Link: https://syzkaller.appspot.com/bug?extid=f7f6e564f4202d8601c6
Signed-off-by: Peilin Ye <yepeilin.cs@gmail.com>
---
I forgot the "Link:" tag yesterday. Sorry about that.

Change in v2:
    - add a proper "Link:" tag.

 net/bluetooth/mgmt.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 5bbe71002fb9..f96251f818fc 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -4157,7 +4157,7 @@ static int read_adv_mon_features(struct sock *sk, struct hci_dev *hdev,
 {
 	struct adv_monitor *monitor = NULL;
 	struct mgmt_rp_read_adv_monitor_features *rp = NULL;
-	int handle;
+	int handle, err;
 	size_t rp_size = 0;
 	__u32 supported = 0;
 	__u16 num_handles = 0;
@@ -4192,9 +4192,13 @@ static int read_adv_mon_features(struct sock *sk, struct hci_dev *hdev,
 	if (num_handles)
 		memcpy(&rp->handles, &handles, (num_handles * sizeof(u16)));
 
-	return mgmt_cmd_complete(sk, hdev->id,
-				 MGMT_OP_READ_ADV_MONITOR_FEATURES,
-				 MGMT_STATUS_SUCCESS, rp, rp_size);
+	err = mgmt_cmd_complete(sk, hdev->id,
+				MGMT_OP_READ_ADV_MONITOR_FEATURES,
+				MGMT_STATUS_SUCCESS, rp, rp_size);
+
+	kfree(rp);
+
+	return err;
 }
 
 static int add_adv_patterns_monitor(struct sock *sk, struct hci_dev *hdev,
-- 
2.25.1

