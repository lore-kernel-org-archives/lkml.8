Return-Path: <SRS0=SnAt=4L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A76FC35673
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 23:20:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1EE720880
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 23:20:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ne0ORNqT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727986AbgBWXUE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Feb 2020 18:20:04 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40234 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727228AbgBWXSA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Feb 2020 18:18:00 -0500
Received: by mail-wm1-f66.google.com with SMTP id t14so7446662wmi.5;
        Sun, 23 Feb 2020 15:17:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/CARPq6Rx4M0QkZy9yfp02dz/1hPE7n1aRAR3+33T8o=;
        b=Ne0ORNqTPVSAJEg0AsCd2tNIKwEsrr+t1mduNCkvQZZ2W3YYRCdk+38h7fmWJ5/bfl
         /Pmqo7PItFTHvAyKn5UJQehAjYWz9wYqAGSz8X7Mmpgdppc1X7DDm1tJeM+RQXb2pvkD
         hcJ1J2nGiCtP6ycFmbE5B7otjueLorYatqQBm9R/db1GnUvCUm7J3sAFXrcU0ccu/1Nt
         lUR0CBOqRsjxtJDe5VJ789bg0f0dgk+QVV1nvKS2fddWZ7gyz590HnNefX50pC83A+0d
         zYgGpx61P5DLFgFqEUCMH1Be76UqymOO6UqHajZLhYvFdVX7XiMxxy7pdYsEu6EB42Z0
         XCeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/CARPq6Rx4M0QkZy9yfp02dz/1hPE7n1aRAR3+33T8o=;
        b=eQalb1ae4UtMXba3YdXPOS8LmqkUB7Kir7r3AoPGf7iVxDxg17n2t0iX7o0zq9y1eG
         0egEbMXD2EGStkhCF3/4dM3WMi3u/jNonTi2Sky/EsgN9lNpcgr27UNVudQjS2iVNh9P
         xv3DY4lSREbTi09dWmYIEeJY9yWzbRX34kvkJT6SdlwkbzPDCB12aC/cUfYnUPHvNt5S
         iCHEJPu/rO7BarbyLqVZKYEaFTBMqlYAjVJCoD71QZFdZFalDIkEc1lDuGV01kPBZsUt
         E9YONjW6mbmSenHiV2oQ77z7jCmZLZawUJz+MWScQfAfqsddTeQ9dJr9n1N9nNbL9Ymn
         MDlA==
X-Gm-Message-State: APjAAAW7+YTY3Z58O5bz4PHny7elPLBzm4bWUuU8jdY3OoQi9oelLI6S
        jSzNmKYSjZD5hNGT3RWGWnOC18wzznhS
X-Google-Smtp-Source: APXvYqxw6l5JluB8eO/7r06GVsaOMqh026PREAzJXNRgSwNjd/ag01CwbERbb1XJgx4s3RYjo6UDqg==
X-Received: by 2002:a05:600c:114d:: with SMTP id z13mr17896219wmz.105.1582499878574;
        Sun, 23 Feb 2020 15:17:58 -0800 (PST)
Received: from ninjahost.lan (host-2-102-13-223.as13285.net. [2.102.13.223])
        by smtp.googlemail.com with ESMTPSA id q6sm8968203wrf.67.2020.02.23.15.17.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Feb 2020 15:17:58 -0800 (PST)
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
Subject: [PATCH 05/30] sctp: Add missing annotation for sctp_transport_walk_start()
Date:   Sun, 23 Feb 2020 23:16:46 +0000
Message-Id: <20200223231711.157699-6-jbi.octave@gmail.com>
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

Sparse reports a warning at sctp_transport_walk_start()

warning: context imbalance in sctp_transport_walk_start
	- wrong count at exit

The root cause is the missing annotation at sctp_transport_walk_start()
Add the missing __acquires(RCU) annotation

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
---
 net/sctp/socket.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sctp/socket.c b/net/sctp/socket.c
index 1b56fc440606..05be67bb0474 100644
--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -5333,7 +5333,7 @@ int sctp_get_sctp_info(struct sock *sk, struct sctp_association *asoc,
 EXPORT_SYMBOL_GPL(sctp_get_sctp_info);
 
 /* use callback to avoid exporting the core structure */
-void sctp_transport_walk_start(struct rhashtable_iter *iter)
+void sctp_transport_walk_start(struct rhashtable_iter *iter) __acquires(RCU)
 {
 	rhltable_walk_enter(&sctp_transport_hashtable, iter);
 
-- 
2.24.1

