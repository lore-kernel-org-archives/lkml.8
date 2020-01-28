Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E2BAC2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:19:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A41D24696
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:19:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580221163;
	bh=S8RUh6caaVmUQTWFOdyGCO7xCLkl7xkIopaXRG2sUqg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=03Ajx9Ku3rLxs3MBbT+L2IEVnGmVVhNlIotHg8dulZMrTUT7YVJFqgucsMV1+VGKm
	 oIhVFLJP9tGCg3VEN00TZokGdVgaG8rx/hc1iDnC4A77/jvtaopX9rQh2RRDA99OX5
	 amrW4KcYFSfcNjqc2dazD3Dc6ezbE/Mvpdo8Wx60=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730866AbgA1OTW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 09:19:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:43628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730443AbgA1OTR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 09:19:17 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5C3ED2468E;
        Tue, 28 Jan 2020 14:19:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580221156;
        bh=S8RUh6caaVmUQTWFOdyGCO7xCLkl7xkIopaXRG2sUqg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VCWOAvi2rjExyoXXjvs6cM+p4Ay0ewaCoeRbh7ajdZIOqG4V+OWDYrwE+CPutLiQt
         LxDS1KOElCdhsDtb8t6TBjn9Zpit8uodoADvZ/VLRUEDWRxVAfuq1vsGE6n1qrtndy
         6+FhhKar2Gkam1TF3vgnLo5uUAxZcx53NKHtykr0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Howells <dhowells@redhat.com>,
        James Morris <james.morris@microsoft.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 074/271] keys: Timestamp new keys
Date:   Tue, 28 Jan 2020 15:03:43 +0100
Message-Id: <20200128135858.082424709@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200128135852.449088278@linuxfoundation.org>
References: <20200128135852.449088278@linuxfoundation.org>
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
index 7276d1a009d49..280b4feccdc00 100644
--- a/security/keys/key.c
+++ b/security/keys/key.c
@@ -296,6 +296,7 @@ struct key *key_alloc(struct key_type *type, const char *desc,
 	key->gid = gid;
 	key->perm = perm;
 	key->restrict_link = restrict_link;
+	key->last_used_at = ktime_get_real_seconds();
 
 	if (!(flags & KEY_ALLOC_NOT_IN_QUOTA))
 		key->flags |= 1 << KEY_FLAG_IN_QUOTA;
-- 
2.20.1



