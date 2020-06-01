Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9AABC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 18:56:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AADEA20679
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 18:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591037778;
	bh=oc9000K0Njl65rxCNw3uZQ0DDNTTXplezompeOn/yzQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yiy+5v8Z/I1PD5eA1z5aCUsPCmJ/A6mEE6+ZdRmWnyA/pAQadDVTb7G4ipI06+IIc
	 apNALQAAt3BYAigQi49kYQpt1AbUv5AZo2UtmoY8ZTj0W6Bd1T93EcAC6OB2Dtk/7c
	 5ixc/UFJ0g4jAtiSRPFZE/5gENcK0SmWoid8hn2M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729681AbgFASAj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 14:00:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:42874 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728837AbgFASAM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 14:00:12 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7DE71207DA;
        Mon,  1 Jun 2020 18:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591034412;
        bh=oc9000K0Njl65rxCNw3uZQ0DDNTTXplezompeOn/yzQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EysgoO2TkjIDFPP8CaoOb31z1Tr0iOznVl7P+h33MM0dYj7b2rQiEBnrN8ropmDp0
         qVj4UK4+SSYZODSO4+yJ5KYocdFwasJieYJyGLtJ441d0ZoECSYHwurYUFS8AxTmF2
         2KW6ODRTeE95BJACQHxjVFsRCcMXJWKo5dGxKOsg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jamal Hadi Salim <jhs@mojatatu.com>,
        Roman Mashak <mrv@mojatatu.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 05/77] net sched: fix reporting the first-time use timestamp
Date:   Mon,  1 Jun 2020 19:53:10 +0200
Message-Id: <20200601174017.398306482@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200601174016.396817032@linuxfoundation.org>
References: <20200601174016.396817032@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Roman Mashak <mrv@mojatatu.com>

[ Upstream commit b15e62631c5f19fea9895f7632dae9c1b27fe0cd ]

When a new action is installed, firstuse field of 'tcf_t' is explicitly set
to 0. Value of zero means "new action, not yet used"; as a packet hits the
action, 'firstuse' is stamped with the current jiffies value.

tcf_tm_dump() should return 0 for firstuse if action has not yet been hit.

Fixes: 48d8ee1694dd ("net sched actions: aggregate dumping of actions timeinfo")
Cc: Jamal Hadi Salim <jhs@mojatatu.com>
Signed-off-by: Roman Mashak <mrv@mojatatu.com>
Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/net/act_api.h |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/include/net/act_api.h
+++ b/include/net/act_api.h
@@ -69,7 +69,8 @@ static inline void tcf_tm_dump(struct tc
 {
 	dtm->install = jiffies_to_clock_t(jiffies - stm->install);
 	dtm->lastuse = jiffies_to_clock_t(jiffies - stm->lastuse);
-	dtm->firstuse = jiffies_to_clock_t(jiffies - stm->firstuse);
+	dtm->firstuse = stm->firstuse ?
+		jiffies_to_clock_t(jiffies - stm->firstuse) : 0;
 	dtm->expires = jiffies_to_clock_t(stm->expires);
 }
 


