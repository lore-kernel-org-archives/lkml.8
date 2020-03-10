Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27068C10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 10:09:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4550222D9
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 10:09:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QQbeqMhe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbgCJKJC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 06:09:02 -0400
Received: from mail-pl1-f202.google.com ([209.85.214.202]:41693 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726244AbgCJKJC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 06:09:02 -0400
Received: by mail-pl1-f202.google.com with SMTP id u3so3524338plm.8
        for <linux-kernel@vger.kernel.org>; Tue, 10 Mar 2020 03:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=qgIz8ZXqxR+qL3nvVcdKU+rwgX72c7Lhu1jYDVFQ+gU=;
        b=QQbeqMhejQGLjzt6M3ysCxg/Kr0sB595VzRhzxXl1Qyg5zKnJoZVhIlwh37+vavyil
         83/8JvZT0fqzcjkaWOByFkuvWlIzxNDAUYUwvmlbNKoYUmavJoJJNvyyZjFscJ5KXAjo
         75irtwgv8v8foPo0mFf0/EjXqruZYB/MJFvg6aFl1s6bqF615/TI7e8njU1uYqrdfZ99
         ZMJGSgtji0wRcNyeB4kj7VHuDvUPYY6MkYZWsjPZ2rgYYmjMG5uocsW+go0mZ6asoKAC
         AjFfFRvJjIf2cKvyFzM4M2p8QS04LdABCKklWIWhC+WgsXJUxyyM0x+v2kG0Pkq9imDz
         qUfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=qgIz8ZXqxR+qL3nvVcdKU+rwgX72c7Lhu1jYDVFQ+gU=;
        b=TWsnL4fxKXVsgPsJp3E4MLF+E4RbdephCZmKjxMfONpc6xHLRrsw0X7txazUJOLBko
         rRGPpcoc2jKKHYfLtSXKNYS1dkQm/1AxPYpmYYDjAwC7GHVT5yMeleKYvCdDoWxKcTCK
         Dq3KXaTjQjHor79G4h/tU/aaRbIC/c3z+ozHXBVXNOxC0PN8Y/vulicvvta56JuRbOZW
         dbEq/37c8uOQJGgaLWZv7H0bLjplY35y7muYTa99ftLJDfk3KvM5YGFmRUoxl8/7J5XV
         jG4xzSY1+E/fK0YVB3z18bYdDLwAGPTEaMY+YoM5jFn0xZ2hK5JRquADDIPmJ1sZUA8e
         0HrQ==
X-Gm-Message-State: ANhLgQ07xt4Hnm4S8STlFwSFFbaVnO1HvLeVDeaeZR4rhs0kMiIVGsbV
        u8wanMse6+iB4x4ItXetdwea0llKa6j2rMCEhA==
X-Google-Smtp-Source: ADFU+vuz3HaWYBXcTimqnRcUDBF9dxFd4pjU5MyI1k3cXJJvIdcUkEfxqolA1dijJ5VKuTOLdcG8w5W6+bmEbeBoEg==
X-Received: by 2002:a17:90a:9908:: with SMTP id b8mr912701pjp.93.1583834941368;
 Tue, 10 Mar 2020 03:09:01 -0700 (PDT)
Date:   Tue, 10 Mar 2020 18:08:52 +0800
Message-Id: <20200310180642.Bluez.v1.1.I50b301a0464eb68e3d62721bf59e11ed2617c415@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801-goog
Subject: [Bluez PATCH v1] Bluetooth: L2CAP: handle l2cap config request during
 open state
From:   Howard Chung <howardchung@google.com>
To:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        Howard Chung <howardchung@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jakub Kicinski <kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to Core Spec Version 5.2 | Vol 3, Part A 6.1.5,
the incoming L2CAP_ConfigReq should be handled during
OPEN state.

Signed-off-by: Howard Chung <howardchung@google.com>

---

 net/bluetooth/l2cap_core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 697c0f7f2c1a..5e6e35ab44dd 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -4300,7 +4300,8 @@ static inline int l2cap_config_req(struct l2cap_conn *conn,
 		return 0;
 	}
 
-	if (chan->state != BT_CONFIG && chan->state != BT_CONNECT2) {
+	if (chan->state != BT_CONFIG && chan->state != BT_CONNECT2 &&
+	    chan->state != BT_CONNECTED) {
 		cmd_reject_invalid_cid(conn, cmd->ident, chan->scid,
 				       chan->dcid);
 		goto unlock;
-- 
2.25.1.481.gfbce0eb801-goog

