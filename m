Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBFCAC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 05:29:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C47E820838
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 05:29:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b+eEs2mg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726529AbgFLF3o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 01:29:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726497AbgFLF3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 01:29:43 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 637D8C03E96F;
        Thu, 11 Jun 2020 22:29:43 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id jz3so3207313pjb.0;
        Thu, 11 Jun 2020 22:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=2+MyiVOMMMRwCJqg3ClQFi3RZVFZ8+7mEhIcP3WjEUk=;
        b=b+eEs2mgpae7TC1YLRnFT4tXHrHiVUP4VDvK1d+AdG1vZrD0NUKtqywnoAkRjBUNPS
         z7r+axDnSGUocAmq0Nsha1WzrGEoTJg6e5dF4Ubpmam7lk+0wF7/cyWmJpnTkcFJ0gNw
         PpXcnB6b9I1NEavki35eoU8jnWmniUmfgOI8NfnuaL3LMmK2vlGJVxQmgXCmUuL/lgSr
         R9JRrXs/d6PQy4qARIKLAtDeryVTnXPRR9nJi76l5PVIOqEzFyecvUVapNl/XJHnuGKE
         WWo6LhTkBFgcm8d072/ORsfuA89pm1a1hrKDzbulSYEzNAX5GvXXmBzM4BkQ1uwMlzHb
         5tRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=2+MyiVOMMMRwCJqg3ClQFi3RZVFZ8+7mEhIcP3WjEUk=;
        b=r/fpieUuL+vT3EQ0C5GjdxYzbEA0kHaxINqjY3QlKWhDt05q/Gx8/pIwX4VhMiFUnA
         RqHBmc75epn0eDdKU7aD5V7eLangZWe+5NgJ3NjYYB7wb757xh3P30B4NE2wakKXqBIH
         iGdeu/QqXUVISkBgQBD7rXsYiqsUFOq84CVBpI6ikkgASq3NnyVv6i1PrwPNs+EXz00o
         QAtMo+IVoIqAqwKkwQ19jF4k21pVeJ9BhPgkye84bF33XKBj+OXDvcgVkLjOAhUVJcct
         pyzs06jW0aFxInrRmUNEnODYabn+MGGWYeGQPr+yXFlv7tA7OpxcGKg1IwVdmZgPTU54
         4k3g==
X-Gm-Message-State: AOAM5317ZLy3DZAk3akulUrgiKfmUu4fxr6LJp/QDBq2Rv0M3K+Ml61p
        HBelZkctL8Sjrli2M75Y88A=
X-Google-Smtp-Source: ABdhPJwitUwH3g0GPbo61bxPYJG68fSV41vlCANyUbkhTCoXBNZo59EfMXBska5JJMRHPO2YFCgpMA==
X-Received: by 2002:a17:90a:d244:: with SMTP id o4mr11248313pjw.186.1591939782964;
        Thu, 11 Jun 2020 22:29:42 -0700 (PDT)
Received: from localhost ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id i3sm4110162pjv.1.2020.06.11.22.29.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Jun 2020 22:29:42 -0700 (PDT)
From:   Geliang Tang <geliangtang@gmail.com>
To:     Mat Martineau <mathew.j.martineau@linux.intel.com>,
        Matthieu Baerts <matthieu.baerts@tessares.net>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     Geliang Tang <geliangtang@gmail.com>, netdev@vger.kernel.org,
        mptcp@lists.01.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mptcp: unify MPTCP_PM_MAX_ADDR and MPTCP_PM_ADDR_MAX
Date:   Fri, 12 Jun 2020 13:27:28 +0800
Message-Id: <463f48a4f92aa403453d30a801259c68fda15387.1591939496.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unify these two duplicate macros into 8.

Signed-off-by: Geliang Tang <geliangtang@gmail.com>
---
 net/mptcp/pm_netlink.c | 2 --
 net/mptcp/protocol.h   | 2 +-
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index b78edf237ba0..b694f13caba8 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -41,8 +41,6 @@ struct pm_nl_pernet {
 	unsigned int		next_id;
 };
 
-#define MPTCP_PM_ADDR_MAX	8
-
 static bool addresses_equal(const struct mptcp_addr_info *a,
 			    struct mptcp_addr_info *b, bool use_port)
 {
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 809687d3f410..86d265500cf6 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -135,7 +135,7 @@ static inline __be32 mptcp_option(u8 subopt, u8 len, u8 nib, u8 field)
 		     ((nib & 0xF) << 8) | field);
 }
 
-#define MPTCP_PM_MAX_ADDR	4
+#define MPTCP_PM_ADDR_MAX	8
 
 struct mptcp_addr_info {
 	sa_family_t		family;
-- 
2.17.1

