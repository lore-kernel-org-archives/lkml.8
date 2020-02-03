Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5375C35247
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 19:02:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B3772051A
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 19:02:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="ZhvyRhZd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726924AbgBCTCT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 14:02:19 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:45566 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbgBCS4s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 13:56:48 -0500
Received: by mail-qt1-f193.google.com with SMTP id d9so12250947qte.12
        for <linux-kernel@vger.kernel.org>; Mon, 03 Feb 2020 10:56:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=VwnXekGQXSa7uk8525c/XCF18A7jAwffbm1SfA/XcX4=;
        b=ZhvyRhZdwPSk7E9iCxSIx3EugvYG564eEnnAlJ/ouVluCpK2VPQykwpEsqeRNgUitR
         W/BuFusZ27zSDBT+/jYTFFymspJ3dERHirQZvBgZVrPNxvcQm66owTyXKCVV1yAM+Sxc
         Bc3MKo0HUrcNJ72m8XBBipQotrgt+vwcAEYdeU7BYEaU8lMCQPv6JYIiTQF4Soit1oRW
         lqzcMVDoNq4Du3f4O9oS0xAciHWKOnCi07fTyMVmG8psBJbz6t/3KtdULlIkacbymLvz
         b9KRuLJfKpSWd+C74YlFiOGFUD9mabLukExPKGdNs58NJOCldOOgwEQ5mRN7wA9RbOl/
         ettg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=VwnXekGQXSa7uk8525c/XCF18A7jAwffbm1SfA/XcX4=;
        b=CqKCMMX268XphVojm/olFtbY3KakUnY5mh661hOBu7XExlsTJbMtawfH2ZOnlVMVoH
         8w0OYaf9AAAssAr3ily5nR+iwit2U4G9d6lcbEr2S+rtFiDF+0qyvhAdJnjnJKDxRckp
         WeLlgZQ8yoUKk3CVsyeuDOzVNbtDZWFX0tJeFrBdPu9vtNLjji1jhliQuNM+2esu0XaX
         cWYtRswg/tzBvrllsXaLPmLEmzkavpzBhCGGgQBbLTgpYsGW91V0yL94o19EP3zJ52I4
         MMS/Zpse7qZOoSjXM1AccoFrDbEH/6stNASCaWlxWOgh6PJ0R21OLWXXr9LADmg8USnV
         zmSg==
X-Gm-Message-State: APjAAAU8xFg7CGMIi0S54a+l9vwEKsrvjeS5Ju8BWSOuVNCbU9O4F6KW
        tQIhrHtoUeIMhmfxgOQlyZPvPA==
X-Google-Smtp-Source: APXvYqwPf1/ipGCfx3eQPpZLwPLV0xEziSVZYePbcGHclQRptnOnIRJbIK+DKn9LkhEgbFE/x02lNg==
X-Received: by 2002:ac8:4b6f:: with SMTP id g15mr24999365qts.196.1580756205793;
        Mon, 03 Feb 2020 10:56:45 -0800 (PST)
Received: from qcai.nay.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id v18sm9694220qkg.67.2020.02.03.10.56.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Feb 2020 10:56:44 -0800 (PST)
From:   Qian Cai <cai@lca.pw>
To:     davem@davemloft.net
Cc:     kuba@kernel.org, elver@google.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>
Subject: [PATCH] skbuff: fix a data race in skb_queue_len()
Date:   Mon,  3 Feb 2020 13:56:30 -0500
Message-Id: <1580756190-3541-1-git-send-email-cai@lca.pw>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sk_buff.qlen can be accessed concurrently as noticed by KCSAN,

 BUG: KCSAN: data-race in __skb_try_recv_from_queue / unix_dgram_sendmsg

 read to 0xffff8a1b1d8a81c0 of 4 bytes by task 5371 on cpu 96:
  unix_dgram_sendmsg+0x9a9/0xb70 include/linux/skbuff.h:1821
				 net/unix/af_unix.c:1761
  ____sys_sendmsg+0x33e/0x370
  ___sys_sendmsg+0xa6/0xf0
  __sys_sendmsg+0x69/0xf0
  __x64_sys_sendmsg+0x51/0x70
  do_syscall_64+0x91/0xb47
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

 write to 0xffff8a1b1d8a81c0 of 4 bytes by task 1 on cpu 99:
  __skb_try_recv_from_queue+0x327/0x410 include/linux/skbuff.h:2029
  __skb_try_recv_datagram+0xbe/0x220
  unix_dgram_recvmsg+0xee/0x850
  ____sys_recvmsg+0x1fb/0x210
  ___sys_recvmsg+0xa2/0xf0
  __sys_recvmsg+0x66/0xf0
  __x64_sys_recvmsg+0x51/0x70
  do_syscall_64+0x91/0xb47
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Since only the read is operating as lockless, it could introduce a logic
bug in unix_recvq_full() due to the load tearing. Fix it by adding
a READ_ONCE() there.

Signed-off-by: Qian Cai <cai@lca.pw>
---
 include/linux/skbuff.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 3d13a4b717e9..4b5157164f3e 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -1818,7 +1818,7 @@ static inline struct sk_buff *skb_peek_tail(const struct sk_buff_head *list_)
  */
 static inline __u32 skb_queue_len(const struct sk_buff_head *list_)
 {
-	return list_->qlen;
+	return READ_ONCE(list_->qlen);
 }
 
 /**
-- 
1.8.3.1

