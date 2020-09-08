Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CC29C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 19:33:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A2352137B
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 19:33:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599593605;
	bh=RGMU6u9awNtR7uD988/rffJ2BkQdiyK7XwLpHaGK2xQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Ji9RyBAHOy7JObB6avGKd4ioCaQsZ6uc9ADp5wQy4CDWm0iGwlstxqhvIcjkwRr8S
	 9iV4Gj54sbEVRn9YmjctaNTRGGgQ9p/pvQ4O/8qm8nXUOw4D4Q7hi6QbHN0g0IQhYN
	 usUoiNtBQNkW2VniWq+Vb2n7rGvcTw7fYSO42Ofk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731894AbgIHTdJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 15:33:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:47748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731015AbgIHP6F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 11:58:05 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D1D53224DE;
        Tue,  8 Sep 2020 15:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599579432;
        bh=RGMU6u9awNtR7uD988/rffJ2BkQdiyK7XwLpHaGK2xQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZYFKQ1OV6f5woOu2SCjzkPWsOhTtR/qbwlFOhs6bzz8HyRtrZIDXeIk/IRUGbGd9g
         mbMMLcQftCAEu+V7Ffw84imjA7W/XyOqL3ZqW6UIIrXP3J5SCmP3SjB8D5o976gAWf
         o4hdwxU4Tchy/4DNw+3uGLQzQi5SldJu241WxW2k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Sandeen <sandeen@redhat.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@lst.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.8 074/186] xfs: fix boundary test in xfs_attr_shortform_verify
Date:   Tue,  8 Sep 2020 17:23:36 +0200
Message-Id: <20200908152245.236842373@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200908152241.646390211@linuxfoundation.org>
References: <20200908152241.646390211@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Sandeen <sandeen@redhat.com>

[ Upstream commit f4020438fab05364018c91f7e02ebdd192085933 ]

The boundary test for the fixed-offset parts of xfs_attr_sf_entry in
xfs_attr_shortform_verify is off by one, because the variable array
at the end is defined as nameval[1] not nameval[].
Hence we need to subtract 1 from the calculation.

This can be shown by:

# touch file
# setfattr -n root.a file

and verifications will fail when it's written to disk.

This only matters for a last attribute which has a single-byte name
and no value, otherwise the combination of namelen & valuelen will
push endp further out and this test won't fail.

Fixes: 1e1bbd8e7ee06 ("xfs: create structure verifier function for shortform xattrs")
Signed-off-by: Eric Sandeen <sandeen@redhat.com>
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/xfs/libxfs/xfs_attr_leaf.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/xfs/libxfs/xfs_attr_leaf.c b/fs/xfs/libxfs/xfs_attr_leaf.c
index 2f7e89e4be3e3..4eb2ecd31b0d2 100644
--- a/fs/xfs/libxfs/xfs_attr_leaf.c
+++ b/fs/xfs/libxfs/xfs_attr_leaf.c
@@ -996,8 +996,10 @@ xfs_attr_shortform_verify(
 		 * struct xfs_attr_sf_entry has a variable length.
 		 * Check the fixed-offset parts of the structure are
 		 * within the data buffer.
+		 * xfs_attr_sf_entry is defined with a 1-byte variable
+		 * array at the end, so we must subtract that off.
 		 */
-		if (((char *)sfep + sizeof(*sfep)) >= endp)
+		if (((char *)sfep + sizeof(*sfep) - 1) >= endp)
 			return __this_address;
 
 		/* Don't allow names with known bad length. */
-- 
2.25.1



