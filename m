Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B0D8C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 18:32:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9CFB20758
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 18:32:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aCJD4nhs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727968AbgIBSc0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 14:32:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:29700 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726821AbgIBScV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 14:32:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599071539;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=gKQVxnmrdXoDRcqTsKCqsePqQgbOzr2qN7RR0j1e0AI=;
        b=aCJD4nhsg4nBQFZTqS2eQvkd4FWu43uYp7OFHV5Mx4ODwMSKXuMdvfV+jKi0NdcwDX6nrw
        l0jJqJHPD8UhglNX0JnDGvY1xzjjbVmNb3KeZzqJcvAxPZu3jLZY+jNYZnE2cnM/l6wv0c
        Y59OqsL0WW/w746vyHlp9w12amkDu5U=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-466--l5gKsoyOXWV_dO3QvWPvQ-1; Wed, 02 Sep 2020 14:32:17 -0400
X-MC-Unique: -l5gKsoyOXWV_dO3QvWPvQ-1
Received: by mail-io1-f71.google.com with SMTP id v10so357402iot.6
        for <linux-kernel@vger.kernel.org>; Wed, 02 Sep 2020 11:32:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=gKQVxnmrdXoDRcqTsKCqsePqQgbOzr2qN7RR0j1e0AI=;
        b=qMF9UeCgSGpOzELhFSi8C2iS4zSP+OFvfT4cdazX9Ji2f+NY+Vn4fNrADIDE4XVEQM
         OxB8oyP2BXKjvu2b/4H/0Sc1PIOSjigyauUv29lpLbF/oLv21bU12WobTD3b/RGoXk1U
         6MuBjejFlNhgXV+u6Ijcwo/txopR10UoSUI267EsDbTnLeXDY9i54UEvVM3HGtzh30tM
         JrqVxKX7rjyVyXWk2vBE7QuSoATAIc7fJtfY4wHcYQB5+58+e6I+w8P5ADvCOA3RYQev
         EE1uE0TonBZmMz0jNfch5n3L0Z+tls1bCSut2G5+i8G6sCytw6bGHtFkREVYrXH2+pt6
         BwQQ==
X-Gm-Message-State: AOAM531JPO0G5UkHBlRVczSg1Sf1rjfwZnHvI9a3LNnPbnvA0/ij7lo7
        ru2nRhAQ0ZebnqP8kiMF5wbogH8T/DreZiEAkplsDCjd++CpT1wY3Isgfm81Vo5TKXHEraxiDu3
        83T3556ccpKezIxlQVfgLqyT4
X-Received: by 2002:a92:79ca:: with SMTP id u193mr4424870ilc.185.1599071537171;
        Wed, 02 Sep 2020 11:32:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxbsSh65NZyl23MQQOOAFCbv5TIj4Q3cfW9MNhhkXAXwk+L+YzhAPkdEYtz/FbZR1w9HlhA8g==
X-Received: by 2002:a92:79ca:: with SMTP id u193mr4424848ilc.185.1599071536926;
        Wed, 02 Sep 2020 11:32:16 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id o17sm162399ila.35.2020.09.02.11.32.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2020 11:32:16 -0700 (PDT)
From:   trix@redhat.com
To:     matrandg@cisco.com, mchehab@kernel.org, hans.verkuil@cisco.com
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] media: tc358743: cleanup tc358743_cec_isr
Date:   Wed,  2 Sep 2020 11:32:12 -0700
Message-Id: <20200902183212.4928-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

tc358743_cec_isr is misnammed, it is not the main isr.
So rename it to be consistent with its siblings,
tc358743_cec_handler.

It also does not check if its input parameter 'handled' is
is non NULL like its siblings, so add a check.

Fixes: a0ec8d1dc42e ("media: tc358743: add CEC support")
Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/media/i2c/tc358743.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/media/i2c/tc358743.c b/drivers/media/i2c/tc358743.c
index c724bd1591de..831b5b54fd78 100644
--- a/drivers/media/i2c/tc358743.c
+++ b/drivers/media/i2c/tc358743.c
@@ -919,8 +919,8 @@ static const struct cec_adap_ops tc358743_cec_adap_ops = {
 	.adap_monitor_all_enable = tc358743_cec_adap_monitor_all_enable,
 };
 
-static void tc358743_cec_isr(struct v4l2_subdev *sd, u16 intstatus,
-			     bool *handled)
+static void tc358743_cec_handler(struct v4l2_subdev *sd, u16 intstatus,
+				 bool *handled)
 {
 	struct tc358743_state *state = to_state(sd);
 	unsigned int cec_rxint, cec_txint;
@@ -953,7 +953,8 @@ static void tc358743_cec_isr(struct v4l2_subdev *sd, u16 intstatus,
 			cec_transmit_attempt_done(state->cec_adap,
 						  CEC_TX_STATUS_ERROR);
 		}
-		*handled = true;
+		if (handled)
+			*handled = true;
 	}
 	if ((intstatus & MASK_CEC_RINT) &&
 	    (cec_rxint & MASK_CECRIEND)) {
@@ -968,7 +969,8 @@ static void tc358743_cec_isr(struct v4l2_subdev *sd, u16 intstatus,
 			msg.msg[i] = v & 0xff;
 		}
 		cec_received_msg(state->cec_adap, &msg);
-		*handled = true;
+		if (handled)
+			*handled = true;
 	}
 	i2c_wr16(sd, INTSTATUS,
 		 intstatus & (MASK_CEC_RINT | MASK_CEC_TINT));
@@ -1432,7 +1434,7 @@ static int tc358743_isr(struct v4l2_subdev *sd, u32 status, bool *handled)
 
 #ifdef CONFIG_VIDEO_TC358743_CEC
 	if (intstatus & (MASK_CEC_RINT | MASK_CEC_TINT)) {
-		tc358743_cec_isr(sd, intstatus, handled);
+		tc358743_cec_handler(sd, intstatus, handled);
 		i2c_wr16(sd, INTSTATUS,
 			 intstatus & (MASK_CEC_RINT | MASK_CEC_TINT));
 		intstatus &= ~(MASK_CEC_RINT | MASK_CEC_TINT);
-- 
2.18.1

