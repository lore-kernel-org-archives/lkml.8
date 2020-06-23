Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD97DC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 02:51:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C2C720786
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 02:51:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gUr2V660"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731816AbgFWCvM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 22:51:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731434AbgFWCvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 22:51:12 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE6B1C061573;
        Mon, 22 Jun 2020 19:51:10 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id d12so9024847qvn.0;
        Mon, 22 Jun 2020 19:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=K1NdNwivojm00tbD3TZ+M3WB1qk+zryixny/eiXVT2U=;
        b=gUr2V660lI3zkXJIGZ8oGhul7oVjZ1zm+u7Ll8qL29EO+vGhfp9Qmc9I9IA0KddVZQ
         lfJXXIzps+vBMQmaMMjCstZYUsumZ05tNYgZESSZW0I6EXy0KI2skraR2idFNhxne9NP
         ymzIoLb4ttVkJgPA1/wstWth9RLPsXzziJIs3L8huaiuVJMnxFw4DK5foJV9qJALbUp3
         J5c6QHOHlY9AFr/y6ZcwTrA1/9YBiW4Ebuj+Poh4RFR4BRhXNzMCwafg17aUlxkJdtw2
         6p9haOuCapqjAsrmsXDtNqrRIShbhah4YnJ7gnMlH4his1tlv773/yVCDqvvS3GXc9vl
         ho0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=K1NdNwivojm00tbD3TZ+M3WB1qk+zryixny/eiXVT2U=;
        b=o1jDpEHuVYYWgcvrxeKpgQCcvwmRA0jbzO9X5naxuZjrgn5hoQI7HxeeN2lNDzt0ax
         FD/ZIXV7wCh59sNlRmwLUj3mwM+mv8XJ27Zd3H0QLUgS5hd3koMbgDh2gV5+0NFQxTRg
         P1K9/9Fq7L0OucmpDuG7HR25AAGbIYk4b+H4BAC29WIgeZDCDJD9K4Y4v8rddPAGn9E/
         LF3aKW32yGx/OZ+qbGMNCjtFFwIR4fYtgYnEgGGI4PnRNnxbIWkCbDxIS3J2CwvKHW/Z
         7MASIHKgc9LFMb8abwy9ENHto0qTWGuyfnLW2CoHgtqyByoYWb6RELDJZn38wnNHZ50E
         E3Ng==
X-Gm-Message-State: AOAM532+coMryXK2541j3Q37dTDM64p/vATcpJ1jyHerAOwWaIEBIioT
        0lHSuoc1/GqiBSqUMylURPA=
X-Google-Smtp-Source: ABdhPJy79/acBhQH3Gz5PEAvTUYTQcr4dblMkJ909SGn4aG595IUOShVjWRF/+IgEvukX1bcuWBgAQ==
X-Received: by 2002:a05:6214:848:: with SMTP id dg8mr23044701qvb.152.1592880670025;
        Mon, 22 Jun 2020 19:51:10 -0700 (PDT)
Received: from linux.home ([2604:2000:1344:41d:316f:dfd5:1aaf:37b3])
        by smtp.googlemail.com with ESMTPSA id p22sm17121176qtc.7.2020.06.22.19.51.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 19:51:09 -0700 (PDT)
From:   Gaurav Singh <gaurav1086@gmail.com>
To:     gaurav1086@gmail.com, "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        netdev@vger.kernel.org (open list:NETWORKING [GENERAL]),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] [net] dcb_doit: remove redundant skb check
Date:   Mon, 22 Jun 2020 22:50:39 -0400
Message-Id: <20200623025057.20348-1-gaurav1086@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200621165657.9814-1-gaurav1086@gmail.com>
References: <20200621165657.9814-1-gaurav1086@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

skb cannot be NULL here since its already being accessed
before: sock_net(skb->sk). Remove the redundant null check.

Signed-off-by: Gaurav Singh <gaurav1086@gmail.com>
---
 net/dcb/dcbnl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/dcb/dcbnl.c b/net/dcb/dcbnl.c
index d2a4553bcf39..84dde5a2066e 100644
--- a/net/dcb/dcbnl.c
+++ b/net/dcb/dcbnl.c
@@ -1736,7 +1736,7 @@ static int dcb_doit(struct sk_buff *skb, struct nlmsghdr *nlh,
 	struct net_device *netdev;
 	struct dcbmsg *dcb = nlmsg_data(nlh);
 	struct nlattr *tb[DCB_ATTR_MAX + 1];
-	u32 portid = skb ? NETLINK_CB(skb).portid : 0;
+	u32 portid = NETLINK_CB(skb).portid;
 	int ret = -EINVAL;
 	struct sk_buff *reply_skb;
 	struct nlmsghdr *reply_nlh = NULL;
-- 
2.17.1

