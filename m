Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 197B8C433E5
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 12:06:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DFBBE20897
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 12:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598443600;
	bh=XFf6WD/mS3WUjtPuRD+AuZx4AOOaYLXdV+Z07SqZ1wE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=en7rg+joDjsxfLp5UbDrxid0xm1roeSbCvvxsIaD+EeYeg8jtp6Y8FWxssmSmHQZh
	 WUX5wbV5vpKfIWavSbjoxqpwWq+sNzkClympOAvGMQ2U+QONG2rmWxxaybQ0/lJoJf
	 LJGY83PUOU4GaF1LlmcDHRJchiicx01oybX9V9iw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729737AbgHZMGj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 08:06:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:38612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729521AbgHZMDb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 08:03:31 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7F6AC20B1F;
        Wed, 26 Aug 2020 12:03:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598443411;
        bh=XFf6WD/mS3WUjtPuRD+AuZx4AOOaYLXdV+Z07SqZ1wE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HHqn7Zn2QIXZyPsX+BSLQ77zSPv+GExF4MMu/XxlI792/R+GkQeJShNKmDde0WxBw
         f16OSMqaubwkAvJhJBP+aCErUYRQkLulFoYpln02F8qAESBdIE/+YYfTtGITNvi+9a
         HClJmmkIeuEhK8t3t7vS27Cv/vKlIN6xzTmnDxhY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Johannes Berg <johannes.berg@intel.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.8 14/16] netlink: fix state reallocation in policy export
Date:   Wed, 26 Aug 2020 14:02:51 +0200
Message-Id: <20200826114911.918676140@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200826114911.216745274@linuxfoundation.org>
References: <20200826114911.216745274@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

[ Upstream commit d1fb55592909ea249af70170c7a52e637009564d ]

Evidently, when I did this previously, we didn't have more than
10 policies and didn't run into the reallocation path, because
it's missing a memset() for the unused policies. Fix that.

Fixes: d07dcf9aadd6 ("netlink: add infrastructure to expose policies to userspace")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/netlink/policy.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/net/netlink/policy.c
+++ b/net/netlink/policy.c
@@ -51,6 +51,9 @@ static int add_policy(struct nl_policy_d
 	if (!state)
 		return -ENOMEM;
 
+	memset(&state->policies[state->n_alloc], 0,
+	       flex_array_size(state, policies, n_alloc - state->n_alloc));
+
 	state->policies[state->n_alloc].policy = policy;
 	state->policies[state->n_alloc].maxtype = maxtype;
 	state->n_alloc = n_alloc;


