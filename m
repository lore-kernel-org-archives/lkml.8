Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E6DCC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 19:24:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A440208D5
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 19:24:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H73cpLKr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388051AbgFSTYY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 15:24:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387633AbgFSTYX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 15:24:23 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04E8AC06174E;
        Fri, 19 Jun 2020 12:24:23 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id y9so5010427qvs.4;
        Fri, 19 Jun 2020 12:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=cWkMvejmWQwS+jXBTx0owfMKl2kp7YwzCYHM7vLrpdk=;
        b=H73cpLKrO/ZPNVmHWovgUxjS3P1lQoJSYQsORSDjq2GuKJEkUazqvFZPfC3bGgitnS
         xHUjbIsScQ47yPy58Xa/QsZWKrwu/iaRl+P0Dr35cfmDqZKG79Rxpv6pmdFmbV3u9rH0
         +cQiFbaCrtERnDmDvwhOd73+ZHoetXGCmj7hdYM44l5MlErfBorgc1PWlIS4d4Sk6x98
         7RgLFN0d6f0CT4Pi6EM7/kTg0rsfqnKvxcJ9HItadDBkU6mP8GSVH1lS1zjNp11BO8IU
         UV7FSV4URbH5+O3gDomF0IU4f0KnCP3NLNhV4ekKzdd4xJ2jR21DTclSYGS/iQpvdSV4
         QcfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=cWkMvejmWQwS+jXBTx0owfMKl2kp7YwzCYHM7vLrpdk=;
        b=LO0Cg76Efy9ZT3i0TZ9SBj9ozQyaOzmnPXV2iFbrtImzNaFfUJOZFEX95OonHSu2gX
         U+PzrcngBayf0Y0VzFLnXYuXQaixfGx2bvoRW+eTReqamosbfxilgYR+idIjIxNA2lQJ
         5tp6aHnOfQMnvdvijQfPH3IQjpyvVfLhHk+zpNiekGJs/XyPzaYapO9ebuptEWHzN2UQ
         dTzWh9BRGAlNNGBeJi8E5KW+6ZUiA1EfsJOwoNe9KwUZn435R63NKgCmSUIuskagw3mr
         Kx+F3dsU6of8mhpylGKrhvAS0loRPlngxwMN3iQ6/djm62nKhRtYYru7FBLy2SFvew8v
         aljg==
X-Gm-Message-State: AOAM5324vctaK/8PMnlkLECvG8TaBwqHQl3/bSStY7D+bE79MJg181Sw
        QuN40/wagDRBqxFri1XFvXU=
X-Google-Smtp-Source: ABdhPJxiJa5+i3KgoU8gJhSNFcNzddYm9wnmR/nl3PoCtQ4TurdBhDYG5UCM7fvP5I7v1Wngfqt2BQ==
X-Received: by 2002:ad4:4841:: with SMTP id t1mr10525591qvy.187.1592594662255;
        Fri, 19 Jun 2020 12:24:22 -0700 (PDT)
Received: from linux.home ([2604:2000:1344:41d:fda8:d752:6b93:379])
        by smtp.googlemail.com with ESMTPSA id e2sm2132296qkm.115.2020.06.19.12.24.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2020 12:24:21 -0700 (PDT)
From:   Gaurav Singh <gaurav1086@gmail.com>
To:     gaurav1086@gmail.com, Jamal Hadi Salim <jhs@mojatatu.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Jiri Pirko <jiri@resnulli.us>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        netdev@vger.kernel.org (open list:TC subsystem),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] [net/sched] Remove redundant skb null check
Date:   Fri, 19 Jun 2020 15:24:13 -0400
Message-Id: <20200619192414.22158-1-gaurav1086@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200618014328.28668-1-gaurav1086@gmail.com>
References: <20200618014328.28668-1-gaurav1086@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the redundant null check for skb.

Signed-off-by: Gaurav Singh <gaurav1086@gmail.com>
---
 net/sched/act_api.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sched/act_api.c b/net/sched/act_api.c
index 8ac7eb0a8309..90be8fe9128c 100644
--- a/net/sched/act_api.c
+++ b/net/sched/act_api.c
@@ -1475,7 +1475,7 @@ static int tc_ctl_action(struct sk_buff *skb, struct nlmsghdr *n,
 {
 	struct net *net = sock_net(skb->sk);
 	struct nlattr *tca[TCA_ROOT_MAX + 1];
-	u32 portid = skb ? NETLINK_CB(skb).portid : 0;
+	u32 portid = NETLINK_CB(skb).portid;
 	int ret = 0, ovr = 0;
 
 	if ((n->nlmsg_type != RTM_GETACTION) &&
-- 
2.17.1

