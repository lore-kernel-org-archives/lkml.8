Return-Path: <SRS0=SnAt=4L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47054C35670
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 23:18:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B876217F4
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 23:18:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PEOc+u7F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727159AbgBWXSK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Feb 2020 18:18:10 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35760 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727247AbgBWXSB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Feb 2020 18:18:01 -0500
Received: by mail-wm1-f68.google.com with SMTP id b17so7457668wmb.0;
        Sun, 23 Feb 2020 15:18:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gkM2+ezKKrc7LrYNLVS4ghnKI3fIkVnMRghoo0Y2WuI=;
        b=PEOc+u7FIAVXO7BKIcV6zHe3q3+RFTrdKqBnrtlyXEp1P/r1Rut12oLnsUASVr3X74
         YglPSHeqfj84I5v/WMBknfai/b259SxGLmK4Jf9+5ZILgx/+moon/UE4aYSQqLmnvFHv
         ByQNkn2YQA4h8kPSEOrpL9RTES31Qn3XmYRpB1J1KIDtP6Hma15IVnnLdyyfCSvLaGeK
         BFW/xiBFiIKmgbE4A3xJUhgNajFeCJTPDe4ANxN8xpqsCw1Z5d9RxJUIlPcxEbzG5xcP
         YfAGBrscbUThXg8vFjaJlsmMi/Se0zddjydzxs2AsZTVF53C9usQ5GJ/hOvmUG5J7An3
         by5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gkM2+ezKKrc7LrYNLVS4ghnKI3fIkVnMRghoo0Y2WuI=;
        b=TjGG+S4S8QdPAhLAbaMjrIJqNpsQUAHpWNBbYujULQB4MYNTFSFu8YY8ejl6z3Wj1x
         umWx0gvPJw/2ePnDcQASY41zutp0i9YTkDxw9kyO6PEm0/74sA9ySngOwcFE4Rv8vAvC
         46qpjinsV3inRKv1qxGVZDSZFDyc5AFbDjymACg/XhQc6cRaIQl6TamcqcCgs2kfEDW2
         yWvwjrR6IFmilnjeBkXYyzfKQUyi3yYM/TMdhSINqN3G4j/kLvNPtqxyRtXznkIbohE2
         /k6m6goLoUIcbkp0t5YPWQi70LyrzJumb6WuqSKHQiqi0KBVFCcGLSNSLn+4bornMHkH
         oSsA==
X-Gm-Message-State: APjAAAU3qi+snzyUqB63Xy1sL57+aa87JaqUBdSCqErbCBDI0KSCr+9F
        SFr+htBScHOcwzLj/ukFOA==
X-Google-Smtp-Source: APXvYqwShrScZYzv0lvvdMcwt14yJXJBlj28RJ7igSEUidVNr7+txovFEVl8SNbE5bhcmh8h1VGGGw==
X-Received: by 2002:a05:600c:1007:: with SMTP id c7mr17748695wmc.158.1582499879662;
        Sun, 23 Feb 2020 15:17:59 -0800 (PST)
Received: from ninjahost.lan (host-2-102-13-223.as13285.net. [2.102.13.223])
        by smtp.googlemail.com with ESMTPSA id q6sm8968203wrf.67.2020.02.23.15.17.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Feb 2020 15:17:59 -0800 (PST)
From:   Jules Irenge <jbi.octave@gmail.com>
To:     boqun.feng@gmail.com
Cc:     jbi.octave@gmail.com, linux-kernel@vger.kernel.org,
        Vlad Yasevich <vyasevich@gmail.com>,
        Neil Horman <nhorman@tuxdriver.com>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        linux-sctp@vger.kernel.org (open list:SCTP PROTOCOL),
        netdev@vger.kernel.org (open list:NETWORKING [GENERAL])
Subject: [PATCH 06/30] sctp: Add missing annotation for sctp_transport_walk_stop()
Date:   Sun, 23 Feb 2020 23:16:47 +0000
Message-Id: <20200223231711.157699-7-jbi.octave@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200223231711.157699-1-jbi.octave@gmail.com>
References: <0/30>
 <20200223231711.157699-1-jbi.octave@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sparse reports a warning at sctp_transport_walk_stop()

warning: context imbalance in sctp_transport_walk_stop
	- wrong count at exit

The root cause is the missing annotation at sctp_transport_walk_stop()
Add the missing __releases(RCU) annotation

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
---
 net/sctp/socket.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sctp/socket.c b/net/sctp/socket.c
index 05be67bb0474..fed26a1e9518 100644
--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -5340,7 +5340,7 @@ void sctp_transport_walk_start(struct rhashtable_iter *iter) __acquires(RCU)
 	rhashtable_walk_start(iter);
 }
 
-void sctp_transport_walk_stop(struct rhashtable_iter *iter)
+void sctp_transport_walk_stop(struct rhashtable_iter *iter) __releases(RCU)
 {
 	rhashtable_walk_stop(iter);
 	rhashtable_walk_exit(iter);
-- 
2.24.1

