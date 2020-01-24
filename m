Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 925D9C35242
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 09:51:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 603F6208C4
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 09:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579859461;
	bh=aD3H0FtupQxqsi31u8yjQoUbwHdwwGlUk6t0ny3LogA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zIV3YHTPgtBbYcCwV/TSB/s8168iI16d81yNmPxR2jHxAMhYdXD/7FSTcBu31+3JV
	 Yw18HOy1062sFLzc5PHFb9RIo1DwEgpxAUh9C55kZKBz9OJEdNpYOUxKFiKBb+bD3Y
	 +xQ1KPeRyuZL1e2YefAWjtKej0S23Vn1W7eUAd8E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387977AbgAXJvA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 04:51:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:51976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730738AbgAXJu7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 04:50:59 -0500
Received: from localhost (unknown [145.15.244.15])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 811292070A;
        Fri, 24 Jan 2020 09:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579859459;
        bh=aD3H0FtupQxqsi31u8yjQoUbwHdwwGlUk6t0ny3LogA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LdL+AZDqYqlDgN6MiBP5+drJ6UQMi7N81UXgcjC98Ua1UCdmtCsawWpHB0uIyfgtm
         UfYyfBL6jVkgaukd5ROM4LC+V/ql/o0+wa32J6ueb3Apr7uHLpAhP7CBeQG/aRMiyR
         0TviXTPX50NOmKQpJDZ0OLvgdCSac+dMpwoiiCo4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Howells <dhowells@redhat.com>,
        James Morris <james.morris@microsoft.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 107/343] keys: Timestamp new keys
Date:   Fri, 24 Jan 2020 10:28:45 +0100
Message-Id: <20200124092934.150623545@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200124092919.490687572@linuxfoundation.org>
References: <20200124092919.490687572@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Howells <dhowells@redhat.com>

[ Upstream commit 7c1857bdbdf1e4c541e45eab477ee23ed4333ea4 ]

Set the timestamp on new keys rather than leaving it unset.

Fixes: 31d5a79d7f3d ("KEYS: Do LRU discard in full keyrings")
Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: James Morris <james.morris@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 security/keys/key.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/security/keys/key.c b/security/keys/key.c
index 87172f99f73e0..17244f5f54c69 100644
--- a/security/keys/key.c
+++ b/security/keys/key.c
@@ -297,6 +297,7 @@ struct key *key_alloc(struct key_type *type, const char *desc,
 	key->gid = gid;
 	key->perm = perm;
 	key->restrict_link = restrict_link;
+	key->last_used_at = ktime_get_real_seconds();
 
 	if (!(flags & KEY_ALLOC_NOT_IN_QUOTA))
 		key->flags |= 1 << KEY_FLAG_IN_QUOTA;
-- 
2.20.1



