Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D629CC33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:01:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A829221D56
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:01:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579194083;
	bh=jfKaQK6oorn73ILJscVNgFsNVYW8RJniFtv+6mkiZ2w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ilMV5OEkJH+Y4pbXRP7+79KAcSs52VPQCcX4SIe928lydbJ8k+UYcaqohcUGDoguE
	 wjI9Dt5JCr1PvnexV3XNY6D5gUJMCuo+TPZKUvoL6JfZPi1RVEsGGnaLT0axQP1NyH
	 +Hu7aw8zXsLEk4TJ++mlLUJNnnJ01UEvnMfsWxIs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388081AbgAPRBW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 12:01:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:52090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388052AbgAPRBQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:01:16 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6253D21582;
        Thu, 16 Jan 2020 17:01:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579194076;
        bh=jfKaQK6oorn73ILJscVNgFsNVYW8RJniFtv+6mkiZ2w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WECuV9odcAcD28DRWmR4ehhVcSg6BpbxLUGCw+bIJQkz0LsGGXBU4obG9ZlSlXfxK
         j52qJeEll7hTKxFzu+dqM/Uxfcv5JP5spkyiP96MVjx1j8l9/wuCdYE6bPhIPNx4/o
         qRF5LeRWmjrKdU8VuZPAbM/rklzagX4KWbtF9bpw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     David Howells <dhowells@redhat.com>,
        James Morris <james.morris@microsoft.com>,
        Sasha Levin <sashal@kernel.org>, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 183/671] keys: Timestamp new keys
Date:   Thu, 16 Jan 2020 11:51:32 -0500
Message-Id: <20200116165940.10720-66-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116165940.10720-1-sashal@kernel.org>
References: <20200116165940.10720-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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
index 249a6da4d277..749a5cf27a19 100644
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

