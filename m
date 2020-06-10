Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21DFBC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 20:33:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9B682078D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 20:33:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="cABCKH2x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726316AbgFJUdX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 16:33:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726134AbgFJUdW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 16:33:22 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AAB5C03E96B
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 13:33:22 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id t16so1408454plo.7
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 13:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=Vsa1hMUPNb5WCHvsXvWB/06k71eACWwpCirDs+9Q+FM=;
        b=cABCKH2xY/5m+HB+J5wdt32ctH/anKH8qbucZqqdDAF1yt0SO3TLAqxYkmDuCPkXDp
         2p9nYKQeYePorQSVI2AZdF9aLMGDTbcBdseOqIahf0OZkIhiqq1U872YMfVXacnEywd3
         OD2owJMMD644tyy37Nh1FqyL6/T31RgvlvZCg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Vsa1hMUPNb5WCHvsXvWB/06k71eACWwpCirDs+9Q+FM=;
        b=qjeJxEtC1LJDueJRJYNJqhS6e8BtrsE+IzPr/Dnx2j3DTjh+lXwytJYms2pBz/dsFZ
         9iesDqvVCew3ODOpSbMWqtVSg2Mekju6gkiob1zQER1BQkC0YY99Irjv3t5YbW2JCv8Q
         m0y6+PEctUPayRID2uU70J5jimDimE1xPi6I4XxFBgyh5LAhfYRzRMq5GVyQFbozx7BG
         yegvhFRPSD/QrBYWhLUhZ11PCwxzgJRqWHVG5493CQdWy5mkG0EkPn4ZqQTPLxY3mBaE
         t+BXYTEFVvY9QwlUxvkE15o2B65jQWi503h0Adyk9Dt0tzotmi9LTa0ZIHorjNsQFRf9
         5YYg==
X-Gm-Message-State: AOAM533Mz1KYAo92NZt3VzzhTB6W26AAmk2MgxLpVWlbo1OcUAdmXn/l
        OkanR0su4aCzechxW8Qv8UVUSw5s8dGqNx7X
X-Google-Smtp-Source: ABdhPJzDOQUOheeFJU5QyKNl72qiIt95tCuX6Jjl0D8dBPyKMY4iJAD3w5tH2To0fTr3i/2PJNQmJA==
X-Received: by 2002:a17:90b:3d1:: with SMTP id go17mr4594186pjb.114.1591821201738;
        Wed, 10 Jun 2020 13:33:21 -0700 (PDT)
Received: from lbrmn-lnxub113.broadcom.net ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id x1sm576136pju.3.2020.06.10.13.33.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2020 13:33:20 -0700 (PDT)
From:   Scott Branden <scott.branden@broadcom.com>
To:     Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>
Cc:     BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        linux-kernel@vger.kernel.org,
        Scott Branden <scott.branden@broadcom.com>
Subject: [PATCH] checkpatch: ignore CamelCase for inttypes.h format specifiers
Date:   Wed, 10 Jun 2020 13:33:07 -0700
Message-Id: <20200610203307.9344-1-scott.branden@broadcom.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ignore CamelCase for inttypes.h for fixed integer types format specifiers.
(ex. PRIx32 for uint32_t).

Signed-off-by: Scott Branden <scott.branden@broadcom.com>
---
 scripts/checkpatch.pl | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 899e380782c0..9fa90457b270 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -5157,6 +5157,8 @@ sub process {
 			    $var =~ /[A-Z][a-z]|[a-z][A-Z]/ &&
 #Ignore Page<foo> variants
 			    $var !~ /^(?:Clear|Set|TestClear|TestSet|)Page[A-Z]/ &&
+#Ignore inttypes.h scanf/printf format specifiers for fixed size integer types
+			    $var !~ /^(?:PRI|SCN)[dxoui](8|16|32|64|PTR|MAX)?$/ &&
 #Ignore SI style variants like nS, mV and dB
 #(ie: max_uV, regulator_min_uA_show, RANGE_mA_VALUE)
 			    $var !~ /^(?:[a-z0-9_]*|[A-Z0-9_]*)?_?[a-z][A-Z](?:_[a-z0-9_]+|_[A-Z0-9_]+)?$/ &&
-- 
2.17.1

