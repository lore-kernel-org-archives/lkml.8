Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A4E3C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 15:32:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D5642071A
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 15:32:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YyhrYJdx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404180AbgEYPcF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 11:32:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404117AbgEYPcE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 11:32:04 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A82A2C08C5C0
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 08:32:02 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id z7so17608126ybn.21
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 08:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=1aPJAz4aiRZJLGo9Zppdv6l/2UMHYuCErqh9nEDAlVw=;
        b=YyhrYJdxW7Th9HHCMfEcljW9TMcq6yqlKP+g09M04H46XosgqxYKIuqivVkfRagJGi
         4HTa7IJEqMafGxMXU3Q8BuJ1IhHwNQWzWXkQ2iuDaRO8GUQaddO29sVikEIflBpLPrpm
         8TFsfR9ugSx6M5yULIhqDrhkDrTTrYvx7ImnKAAf8qsyYAnw+mNMpt4KHO976WzlVF2b
         pAXf4hJESkFxemlW/aqX1fdCYU5gr06w4Np2N9F3Y3l2yuQo//qtxTZZ79w4GOeszwHk
         Mt2rUdbpQcGYj89Af9cnHInj8RHz2Bx/HS4SJv4H37vQZWE+OVxeCz6XtAktkzty70jk
         d5lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=1aPJAz4aiRZJLGo9Zppdv6l/2UMHYuCErqh9nEDAlVw=;
        b=PgCNiPaed0NsjR8CdcXir7CC4kNjmRY6w/ZLcsNhULizQojRgRjOrbbIQOZ7viOAim
         o1pigCOW3JVYmL/A7/eNdap12XsZiDdvq/p/8PcDN4b/SSWNv4IeC93jE6ZPop8AFM2m
         VIFWiF0m9goIQRkVu8BYg1EHhgN/vJDYKxEDJ6Fae8NCmb7kvFdmq2skyWIAfjg7tVli
         XxPjFso8G1TUWJbdm09rKCi6z67H4XsMbxbne4TbOejaECcuB/G7qQFo1hRYXfItjN/G
         nDl/7cvXD+t+Q6UGulCEeRl3mep4U63e67r1cpn0wUe46NDa5nCdRGasFCLkSliX7DBk
         ZYww==
X-Gm-Message-State: AOAM5302HAb9Fmbn9/1Jq3F+ZlL3z1jwwUSwmF64YGC1jTEbEyBJAyvh
        oOZMXdlV8uzSv7FOB186WyS8MNo/f5NT
X-Google-Smtp-Source: ABdhPJya/2GUziXPBk3NUocIvSMoZVWhlGIJuvfXIr49RmOkgaE3thIWHR39GaNnOmRGCJdlKCJr2u4JSiWD
X-Received: by 2002:a5b:5c6:: with SMTP id w6mr44787174ybp.339.1590420721796;
 Mon, 25 May 2020 08:32:01 -0700 (PDT)
Date:   Mon, 25 May 2020 17:31:58 +0200
Message-Id: <20200525153158.247394-1-dvyukov@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.27.0.rc0.183.gde8f92d652-goog
Subject: [PATCH] net/smc: mark smc_pnet_policy as const
From:   Dmitry Vyukov <dvyukov@google.com>
To:     ubraun@linux.ibm.com, kgraul@linux.ibm.com,
        linux-s390@vger.kernel.org
Cc:     netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
        linux-kernel@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Netlink policies are generally declared as const.
This is safer and prevents potential bugs.

Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
---
 net/smc/smc_pnet.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/smc/smc_pnet.c b/net/smc/smc_pnet.c
index 2a5ed47c3e08..45d5ea570293 100644
--- a/net/smc/smc_pnet.c
+++ b/net/smc/smc_pnet.c
@@ -32,7 +32,7 @@
 
 static struct net_device *pnet_find_base_ndev(struct net_device *ndev);
 
-static struct nla_policy smc_pnet_policy[SMC_PNETID_MAX + 1] = {
+static const struct nla_policy smc_pnet_policy[SMC_PNETID_MAX + 1] = {
 	[SMC_PNETID_NAME] = {
 		.type = NLA_NUL_STRING,
 		.len = SMC_MAX_PNETID_LEN
-- 
2.27.0.rc0.183.gde8f92d652-goog

