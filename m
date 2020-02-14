Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F7B7C35242
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 20:49:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B1AC24670
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 20:49:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aBz47RZs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389488AbgBNUtW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 15:49:22 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35726 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389194AbgBNUtJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 15:49:09 -0500
Received: by mail-wm1-f66.google.com with SMTP id b17so12169464wmb.0;
        Fri, 14 Feb 2020 12:49:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PTi1iwWIZalb8+tOHd0befKZim7rmRMoPGjdQ/H1Q4s=;
        b=aBz47RZsGbC65WLFj4UNgoX+CZnmJ+02b40cXyyAt5/0efODmVSzZReT1/cZZygB4S
         +Zw7120wmSpkRCNLq/u19JU/y1m1pUPmIGvluelBVso3C2afSC7Wv/Ys0C8sgkIS1uNE
         IAB1BTzTJETZMNm8FrLUaS1s3CHDsrhskPcHx215hkJqrwXPCI0Ar+1epSEnEOsiCWjR
         xvHbIQLvMvSwGKHJn6tjScl0HI7QVxO8toDjNuHYAGv6u4dDF4iQ46uTMyfQYqhem0uf
         nCB1H+UHnNtcdVI0lHuwBGtdkdlb9FS9fJKXiHOSklQGBPr4+Y76Ga+2Jqxd8WZT4iaN
         g0ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PTi1iwWIZalb8+tOHd0befKZim7rmRMoPGjdQ/H1Q4s=;
        b=HfdLDeNbJ1jYSyej3WztXkBv5MKFnNz0ysjmBSL9+d87vbUvRCQvit3Fr0S9JiKeZD
         fTKOQIR8BF2cX2D57coEoBEFMh4K8kBGtWcZDzKfhzrvu/vkuzIIoZ6WUNdBak9X4n6u
         9XnWgRcMkq9/4uHdISS73GBCLqttmM2vjWQ9i7gp1U79kG6qt60Hd+XgF0SDnwzhlpgQ
         G1zj9sG9bXeQEMMdV71OlQV3to5OWP/8CT1rtmtZPHQpCccBwHq0SixGddfGj1vqjbnH
         aHR7i7YnPlra1wka4zR8tH3wiOv3aGm2xSiGuYyI6x+DY/wrxSf26O4FMTBox+y88qq1
         CUyg==
X-Gm-Message-State: APjAAAUiROv003qy3eyD5MF5GKKqdokEXdvCSsx8tv15SLgBkc7rGEb9
        ig3d8EHknKKXpMpiubUSimsMa5WBMLgT
X-Google-Smtp-Source: APXvYqxi2KBCae3Dxf2mX14FJDOPJM+QTqas8Nrf96PI3OidEUW3tVuaFxFc6BWfINBkxqVk3ujmLA==
X-Received: by 2002:a7b:c392:: with SMTP id s18mr6435207wmj.169.1581713346958;
        Fri, 14 Feb 2020 12:49:06 -0800 (PST)
Received: from ninjahost.lan (host-2-102-13-223.as13285.net. [2.102.13.223])
        by smtp.googlemail.com with ESMTPSA id y12sm8660782wmj.6.2020.02.14.12.49.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2020 12:49:06 -0800 (PST)
From:   Jules Irenge <jbi.octave@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     boqun.feng@gmail.com, Jules Irenge <jbi.octave@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Patrick Talbert <ptalbert@redhat.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Taehee Yoo <ap420073@gmail.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Li RongQing <lirongqing@baidu.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        netdev@vger.kernel.org (open list:NETWORKING [GENERAL])
Subject: [PATCH 29/30] net: Add missing annotation for netlink_walk_start()
Date:   Fri, 14 Feb 2020 20:47:40 +0000
Message-Id: <20200214204741.94112-30-jbi.octave@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200214204741.94112-1-jbi.octave@gmail.com>
References: <0/30>
 <20200214204741.94112-1-jbi.octave@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sparse reports a warning at netlink_walk_start()

warning: context imbalance in netlink_walk_start()
	 - wrong count at exit

The root cause is the missing annotation at netlink_walk_start()
A close look at rhashtable_walk_start_check()
shows that an __acquires(RCU) is needed here.

Add the missing __acquires(RCU) annotation

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
---
 net/netlink/af_netlink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
index 4e31721e7293..a3fddc845538 100644
--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -2539,7 +2539,7 @@ struct nl_seq_iter {
 	int link;
 };
 
-static void netlink_walk_start(struct nl_seq_iter *iter)
+static void netlink_walk_start(struct nl_seq_iter *iter) __acquires(RCU)
 {
 	rhashtable_walk_enter(&nl_table[iter->link].hash, &iter->hti);
 	rhashtable_walk_start(&iter->hti);
-- 
2.24.1

