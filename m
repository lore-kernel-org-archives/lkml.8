Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7617C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:17:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B71C421707
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:17:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592583420;
	bh=ZHm2e9kSWCE/+gbErOovveJIiw92+SIMeDzUp+xvYz0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iWabVl/5aObEwkFl2FWdAIl8994zQIcjGUZuNg5JcVAw8x1BHHjqwQi2xMKR53ajn
	 XjR3gKGZG4Q7Knp1kyR7iBVebjrjPW4FKveSid+A3HYjY91J3lujR7gM0hL93SfWi6
	 50V79c1ylIy59h4WDTG53qc04ShDOc+wbcuYYeD4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390919AbgFSQQ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 12:16:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:59682 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390906AbgFSPCz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 11:02:55 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C79BD206DB;
        Fri, 19 Jun 2020 15:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592578975;
        bh=ZHm2e9kSWCE/+gbErOovveJIiw92+SIMeDzUp+xvYz0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=e2BcyR7u7zaaMrsnasLQSNZSuUhUnLjuxsokrnZw50Iebpyv/DA/vnQ4WyB33w1Q5
         osETVg9xu9BB/O/Cv9cveGvcnHaoENHBNXOPgc5cLMVfzvljcpYnJSdKWW47fJs2K8
         /u8oQLD9/xyTWTqTifryxMGrGQMeQMleF1nHVayA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Filipe Manana <fdmanana@suse.com>,
        David Sterba <dsterba@suse.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 229/267] btrfs: fix wrong file range cleanup after an error filling dealloc range
Date:   Fri, 19 Jun 2020 16:33:34 +0200
Message-Id: <20200619141659.700007592@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619141648.840376470@linuxfoundation.org>
References: <20200619141648.840376470@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

[ Upstream commit e2c8e92d1140754073ad3799eb6620c76bab2078 ]

If an error happens while running dellaloc in COW mode for a range, we can
end up calling extent_clear_unlock_delalloc() for a range that goes beyond
our range's end offset by 1 byte, which affects 1 extra page. This results
in clearing bits and doing page operations (such as a page unlock) outside
our target range.

Fix that by calling extent_clear_unlock_delalloc() with an inclusive end
offset, instead of an exclusive end offset, at cow_file_range().

Fixes: a315e68f6e8b30 ("Btrfs: fix invalid attempt to free reserved space on failure to cow range")
CC: stable@vger.kernel.org # 4.14+
Signed-off-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/inode.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index b4f295a058d8..887f9ebc2bc2 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1136,8 +1136,8 @@ static noinline int cow_file_range(struct inode *inode,
 	 */
 	if (extent_reserved) {
 		extent_clear_unlock_delalloc(inode, start,
-					     start + cur_alloc_size,
-					     start + cur_alloc_size,
+					     start + cur_alloc_size - 1,
+					     start + cur_alloc_size - 1,
 					     locked_page,
 					     clear_bits,
 					     page_ops);
-- 
2.25.1



