Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BC89C433E5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 10:24:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F23842075A
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 10:24:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tessares-net.20150623.gappssmtp.com header.i=@tessares-net.20150623.gappssmtp.com header.b="aK37klo/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728000AbgG0KYk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 06:24:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbgG0KYk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 06:24:40 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5255C0619D2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 03:24:39 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id i26so8413896edv.4
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 03:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ew/mvZaAa0MKQUJkHMxg0jxr2TRBwbh2Nmfpyl37I+I=;
        b=aK37klo/FRI+TgL6WW4qP8UtbBGyDnsRZUlfEJUAD/Zhb4ZYwL87atfbrsCS7sqOHB
         0mt9no0Ql7VZNC65lXXoAxUSUOZX4WIt+lhlzqWAjTZRpsdh1c+ZaD44a2+sG96s/doS
         QlKDuTFYIFOCDAgNZVaDF+5s3yBUUHDiIe5+jHKVuzs+OtHqq624tCaqInOIJ1neLFQi
         ACSQXNV7Xds9AVa9HI57xesgyYgY0EwLC02F44WnWY34gVLu0o4t9va9ejWDe3Yn6TMb
         ljKhcFx/NNkNkK1dwvMV0lpdJmuqfPihEAfTYO5v79EVFbhd0QoJAvGnfJXEz8BkLFXW
         HCcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ew/mvZaAa0MKQUJkHMxg0jxr2TRBwbh2Nmfpyl37I+I=;
        b=hO5PMHvUGO7zdpGJ026pI7Bqte4lztxskIUpX+zA2Jl1d4Ue/cKVUrBliXvaRvEZ3i
         vbB07QzVRpYpNvDFVnL7kjPtFEjxdoVs5TL5FsB/sx9u9jllxrRxMEmS8xB9Dq6Fm06q
         ZTBIyh6zWPSutzA0Hc3FKjhAoob0IUvWFYjsab4qTdF0s4XDHjG6OwJUxTKwW2paJk3y
         44rAYWc/DoiVP3rjk6HTyTUBItT7nslK7CFG7BA+BMKNufQK7A8b3Kp1OBwkvfkaWAw7
         mN2dMeX2yPvxqJHhfwk+tUjnP/bcinUdTME3P9OSznqDqRMh6qWZxy6kb2LmLqqglJQo
         eceg==
X-Gm-Message-State: AOAM532dOp7WbtKybyFXGcNEqYcTR5R2aRQb0YiROuMNKHskQ1qJpe73
        L4GqLnPxPzpAHbM5cli7fcdvdA==
X-Google-Smtp-Source: ABdhPJwACpz1Dt3WO295Cwmim5Oa3IRv/WSdlVIoUiactVYTBc/WgFp7/aZtBQlfVR+IHaJzlZulYQ==
X-Received: by 2002:aa7:cdd2:: with SMTP id h18mr13654178edw.387.1595845477601;
        Mon, 27 Jul 2020 03:24:37 -0700 (PDT)
Received: from tsr-vdi-mbaerts.nix.tessares.net (static.23.216.130.94.clients.your-server.de. [94.130.216.23])
        by smtp.gmail.com with ESMTPSA id i9sm1498756ejb.48.2020.07.27.03.24.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2020 03:24:37 -0700 (PDT)
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
To:     netdev@vger.kernel.org
Cc:     Matthieu Baerts <matthieu.baerts@tessares.net>,
        Mat Martineau <mathew.j.martineau@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, mptcp@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net] mptcp: fix joined subflows with unblocking sk
Date:   Mon, 27 Jul 2020 12:24:33 +0200
Message-Id: <20200727102433.3422117-1-matthieu.baerts@tessares.net>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unblocking sockets used for outgoing connections were not containing
inet info about the initial connection due to a typo there: the value of
"err" variable is negative in the kernelspace.

This fixes the creation of additional subflows where the remote port has
to be reused if the other host didn't announce another one. This also
fixes inet_diag showing blank info about MPTCP sockets from unblocking
sockets doing a connect().

Fixes: 41be81a8d3d0 ("mptcp: fix unblocking connect()")
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 net/mptcp/protocol.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 3980fbb6f31e..c0abe738e7d3 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1833,7 +1833,7 @@ static int mptcp_stream_connect(struct socket *sock, struct sockaddr *uaddr,
 	/* on successful connect, the msk state will be moved to established by
 	 * subflow_finish_connect()
 	 */
-	if (!err || err == EINPROGRESS)
+	if (!err || err == -EINPROGRESS)
 		mptcp_copy_inaddrs(sock->sk, ssock->sk);
 	else
 		inet_sk_state_store(sock->sk, inet_sk_state_load(ssock->sk));
-- 
2.27.0

