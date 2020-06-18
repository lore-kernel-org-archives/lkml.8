Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B93A3C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 02:04:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 913A12220B
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 02:04:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vJ0sBkcP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387420AbgFRCED (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 22:04:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730942AbgFRBXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 21:23:16 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD57BC06174E;
        Wed, 17 Jun 2020 18:23:16 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id g28so4101839qkl.0;
        Wed, 17 Jun 2020 18:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=BZBgHUVMyHOS5LkbKYVWmY+yNcbuO83zhN+iu0CwYNg=;
        b=vJ0sBkcPdJNP09wXYtA7B0xFDcm40SusuxCDfIYdpPeW1mkWa366T+HPTlH5lJOQo5
         FNw8MvINaEJ6FZNhGzqCKF0xs1JV1IQFfq9nyXuyPG3fZAQnODVefycSTDV1r+SUjNON
         +E3Or+8cImgImGSzKxQaedsTpVV9HwcXBV8rb6+lo6l1zQlBy5FyEXS0Qr5CYYSQ+cea
         YZgo6FOKrJSNs7tU0b9V8Q/K7gyHFKqaC17Yj++vnjUP/SxuHSsRqK/Vag+NJulLUkmU
         cO70mV6yFp16hySaGJgAvkfaGUmHRmQb0eIpVTuedJyrE0XdT+hxK5KhStYqdevAbcnG
         JWZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=BZBgHUVMyHOS5LkbKYVWmY+yNcbuO83zhN+iu0CwYNg=;
        b=FsDpau7IhRaVHlVsipLFTGT2XGdA+vN5Jj0yBqZB9xv6XxntRcyXOhQKa9oas0N8mH
         CXROXLiJjw/EvaBRwpm6NcpXU2Rk9FerkH23m6RUFAI/g+soihgUCiwNN6cw5cOUr/BF
         LUSOIeTBfy5Y49AuHyza0puJLtHGC6TpvaySiml3PO/2Go4VkRWpDVyHIEaaAWHdgk+n
         sAve680ScM8AEv3/IU/TCeV0ykaUIK8N7DkIp4A6InBgfkuoN92fNYy0tqO6afi4JPLp
         8gD3erm1mbNEr39qqA5x4dgj3XzACQbIpMGzm25+m9DlQ8rfehWF1mKFYSGZpbJQU+ze
         xLvQ==
X-Gm-Message-State: AOAM533JXBJOzpoXpVR6b5yxUd+giyJISH9h83g0i70A56oj1+eyFlhC
        bOG9Ve7ZrRyNE8F0GrVnHlQ=
X-Google-Smtp-Source: ABdhPJwXGwPPUSeXPP8vcV1ZCnKPq9yu6Ou1HYbydddgtXmlbYDDBPg/gVGKEmGJXXQZ4nXkwrjAQg==
X-Received: by 2002:a37:2c05:: with SMTP id s5mr1505148qkh.379.1592443396150;
        Wed, 17 Jun 2020 18:23:16 -0700 (PDT)
Received: from linux.home ([2604:2000:1344:41d:9c3:b47c:c995:4853])
        by smtp.googlemail.com with ESMTPSA id f13sm1634777qka.52.2020.06.17.18.23.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 18:23:15 -0700 (PDT)
From:   Gaurav Singh <gaurav1086@gmail.com>
To:     gaurav1086@gmail.com, Jamal Hadi Salim <jhs@mojatatu.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Jiri Pirko <jiri@resnulli.us>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        netdev@vger.kernel.org (open list:TC subsystem),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] [net/sched]: Remove redundant condition in qdisc_graft
Date:   Wed, 17 Jun 2020 21:23:08 -0400
Message-Id: <20200618012308.28153-1-gaurav1086@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200618005526.27101-1-gaurav1086@gmail.com>
References: <20200618005526.27101-1-gaurav1086@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Gaurav Singh <gaurav1086@gmail.com>

Fix build errors

Signed-off-by: Gaurav Singh <gaurav1086@gmail.com>
---
 net/sched/sch_api.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
index 9a3449b56bd6..be93ebcdb18d 100644
--- a/net/sched/sch_api.c
+++ b/net/sched/sch_api.c
@@ -1094,7 +1094,7 @@ static int qdisc_graft(struct net_device *dev, struct Qdisc *parent,
 
 		/* Only support running class lockless if parent is lockless */
 		if (new && (new->flags & TCQ_F_NOLOCK) &&
-		    parent && !(parent->flags & TCQ_F_NOLOCK))
+			!(parent->flags & TCQ_F_NOLOCK))
 			qdisc_clear_nolock(new);
 
 		if (!cops || !cops->graft)
-- 
2.17.1

