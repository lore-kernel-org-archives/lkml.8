Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6B5BC433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 03:10:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 822D5206FA
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 03:10:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ijZeLYTp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbgHaDKA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Aug 2020 23:10:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726824AbgHaDJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 23:09:58 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C9D5C061573
        for <linux-kernel@vger.kernel.org>; Sun, 30 Aug 2020 20:09:58 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id x18so1137461pll.6
        for <linux-kernel@vger.kernel.org>; Sun, 30 Aug 2020 20:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=Ek7hruLtxB76iRKdwJF2urxOIR4x74OETrgZK41siV0=;
        b=ijZeLYTpvyBjf2S5CRg+g5IG7hSvOGPlMk3Ghz99t3ylauvRrSGiQ5ze0fdCWAzzh9
         Tz+tsAGWuMfcWi8rWztpw4LVsGSBjpqWV1uj/6KMgG8yyeeMhfPGjoURt2Y59O53bOe1
         zJY+5CRp5TtjddVH6xKs0PBovj+baOCQEzwnxZqHtDV1VQBsGScvFkg90BKpqk+n27ga
         buaCAPUHtQCslmUTzTaOGTjYdIqQ5FTP56m5ZFAwkvaADs69//2JqjDh1apTqlf3OiGV
         oiwTTUXc9YGIpKKsc7gqQySfo63lNaPrud4QDjbPBezgBme1Vtku7cZwK1X2j1Wd/yRc
         TDJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=Ek7hruLtxB76iRKdwJF2urxOIR4x74OETrgZK41siV0=;
        b=PMFpHVtS+qWpDoJyIgj9jrHQLe71fcDLrnuMltqPPHjISS7dRviMT2H9O+ybdJyDTC
         ebhNP9bzcxyvNoNSwqHVIED6lHh2tOZ8EIfuDK0oh2kw/OBNwjqyipYPbeRNOv9n3KuC
         cv6SVyLPp6PE+vYTAsgXNhG2XME5G383Fz1hqHZW323dSTG4gzVjnLinerG3eS9TlT6R
         N5qj020N97iK6u7SF3iC45Jlixy5WzO4NkZ0Nwd4GDM9TtSC1QYgjrl9naOREHhg8Zj2
         37hRki1AflPCGiwoA9wNJKG8jNCive6lhhWzI6e93+SCoaox42xHn1BXZiiT/yDUGGHr
         pmrw==
X-Gm-Message-State: AOAM5303x6hvHhJX9feGQ1e0oJyZLz8FJxtGi4/dopoHG4g2PJN+2Eyh
        fnjPBc1P+jRV5i+cUHrkX6FThQDWDvg=
X-Google-Smtp-Source: ABdhPJyuMrjNmRQ5yBv0rbAhfuM9sY6mLqHJNc3te6ViSs4syd/Fu3lJZl103u2a+CUtEI7qSNSzPw==
X-Received: by 2002:a17:902:8a93:: with SMTP id p19mr7257895plo.101.1598843397300;
        Sun, 30 Aug 2020 20:09:57 -0700 (PDT)
Received: from Kaladin ([49.207.213.50])
        by smtp.gmail.com with ESMTPSA id d23sm6546292pfq.36.2020.08.30.20.09.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 30 Aug 2020 20:09:56 -0700 (PDT)
Date:   Mon, 31 Aug 2020 08:39:53 +0530
From:   Sumera Priyadarsini <sylphrenadin@gmail.com>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH] bus: arm: Add of_node_put() before break statement
Message-ID: <20200831030953.GA8285@Kaladin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Every iteration of for_each_available_child_of_node() decrements the
reference count of the previous node, however when control is
transferred from the middle of the loop, as in the case of a
return or break or goto, there is no decrement thus ultimately
resulting in a memory leak.

Fix a potential memory leak in arm-cci.c by inserting
of_node_put() before a break statement.

Issue found with Coccinelle.

Signed-off-by: Sumera Priyadarsini <sylphrenadin@gmail.com>
---
 drivers/bus/arm-cci.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/bus/arm-cci.c b/drivers/bus/arm-cci.c
index b8184a903583..1f84a5528073 100644
--- a/drivers/bus/arm-cci.c
+++ b/drivers/bus/arm-cci.c
@@ -461,8 +461,10 @@ static int cci_probe_ports(struct device_node *np)
 
 		i = nb_ace + nb_ace_lite;
 
-		if (i >= nb_cci_ports)
+		if (i >= nb_cci_ports) {
+			of_node_put(cp);
 			break;
+		}
 
 		if (of_property_read_string(cp, "interface-type",
 					&match_str)) {
-- 
2.17.1

