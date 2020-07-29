Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6962C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 17:50:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8700F2075D
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 17:50:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="it3ps2+c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727792AbgG2RuT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 13:50:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbgG2RuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 13:50:17 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 458BDC061794
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 10:50:17 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id m22so14648305pgv.9
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 10:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XOFOBg7cBb4oehrnTDCb9xOdyBwFJ4COpuNMHWHXBjA=;
        b=it3ps2+cGfi5Ga7sDZ5AL5gGWr9ZJ9AdKwPWeqiSy6hvwG2DEkj0naR2f8QP0/7Bbz
         b8kkEEDYqh57Ca18OTWWLz67pieseOvJY4XSTdGyCXnJ1syvWJmwf0D36OwyHEna8x6+
         7ew4LrePQx2RdR5NOeflNrxgjtilm21KSciOM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XOFOBg7cBb4oehrnTDCb9xOdyBwFJ4COpuNMHWHXBjA=;
        b=sV8UTWGmFAMYnjtJsR6KH5KDPodIWF8pF6gSKnMgiNGOQ2UliuEwWlbPtkQ+xEFYtv
         pt+RNJ0PAMMxiHdNKQnydbfwRxHPoO04paeIx8jZKAyRLKtm1n3xITL9cjAZ/+WpwWXk
         w7YdDaA6Gp/SLHudafK0CFyh7kISYtObMQnpVb7x+PhytfgKCVo7L+a5TFwE+bCsPALY
         cOBMI0PkTGsiO8Xvj5aNsqYoppy/TG5ifhDZbdMHs1FBp4mUT52ueGjuxdM1dO87qTq5
         d9Rq719MmAYQp0cwrunQ0rTf6xC2cImAPXLxdwIX1XeTepIOR/zlJFr8DSb1d5MaZWIg
         pAlA==
X-Gm-Message-State: AOAM530o2hTd0bXsA6jGefh0pMCrMy1LO2YGWb+HNFHFyQEVKY/NE9IM
        P782MIqQpsu0rTnS2vGHpNE2zQ==
X-Google-Smtp-Source: ABdhPJyevtmlqH1MdtEvbTRG4+iprYKWvuh0jEFDY7GOxBx+aUAJGHNQm6DbVDWB05k8If7J1uJWMw==
X-Received: by 2002:a62:37c6:: with SMTP id e189mr30263119pfa.207.1596045016859;
        Wed, 29 Jul 2020 10:50:16 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:f693:9fff:fef4:e70a])
        by smtp.gmail.com with ESMTPSA id k12sm2788502pjp.38.2020.07.29.10.50.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jul 2020 10:50:16 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Evan Green <evgreen@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH] interconnect: Show bandwidth for disabled paths as zero in debugfs
Date:   Wed, 29 Jul 2020 10:50:12 -0700
Message-Id: <20200729104933.1.If8e80e4c0c7ddf99056f6e726e59505ed4e127f3@changeid>
X-Mailer: git-send-email 2.28.0.rc0.142.g3c755180ce-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For disabled paths the 'interconnect_summary' in debugfs currently shows
the orginally requested bandwidths. This is confusing, since the bandwidth
requests aren't active. Instead show the bandwidths for disabled
paths/requests as zero.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---

 drivers/interconnect/core.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
index 609e206bf598..3491175304d1 100644
--- a/drivers/interconnect/core.c
+++ b/drivers/interconnect/core.c
@@ -55,12 +55,18 @@ static int icc_summary_show(struct seq_file *s, void *data)
 
 			icc_summary_show_one(s, n);
 			hlist_for_each_entry(r, &n->req_list, req_node) {
+				u32 avg_bw = 0, peak_bw = 0;
+
 				if (!r->dev)
 					continue;
 
+				if (r->enabled) {
+					avg_bw = r->avg_bw;
+					peak_bw = r->peak_bw;
+				}
+
 				seq_printf(s, "  %-27s %12u %12u %12u\n",
-					   dev_name(r->dev), r->tag, r->avg_bw,
-					   r->peak_bw);
+					   dev_name(r->dev), r->tag, avg_bw, peak_bw);
 			}
 		}
 	}
-- 
2.28.0.rc0.142.g3c755180ce-goog

