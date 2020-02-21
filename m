Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4133BC35640
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 08:22:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A3282469C
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 08:22:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582273372;
	bh=Vo9ppF8tbSkSkbJ7l6Xs3X6/KUsvF3UdevzqhdqS7/Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1XH3ApIe0RgZGgcf14Mss6tE/wED2jWsdLDU/4buENppCSkk8+ASwcXBcb0hG2B02
	 7tT2W95KoIQOnATWYhzSjum79nqXWN8PkmpQfMi4JHgtYO5eYTher18/9QyCr16uAJ
	 IHDhnuld9b5RaSOKUmqeQPrQui68rbb6mXRPHex0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388374AbgBUIWu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 03:22:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:34506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388363AbgBUIWr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 03:22:47 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AF57D2467D;
        Fri, 21 Feb 2020 08:22:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582273367;
        bh=Vo9ppF8tbSkSkbJ7l6Xs3X6/KUsvF3UdevzqhdqS7/Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BuGGUvqUjsJmg5ifnLQr28KIyhUF26Wh9e59OvEdWMyOETeHWqeNmqUjSB3pcXdCs
         RswMfu8p0A6UR9dIRneRhEI6SUZonC1Tq0cfy3QUGnrkYgGqMkEsdmr3C5O0lWyVE+
         5r1PzpJfn9ocz+X6Z84tX8DeaC3epDPvHpDJD0m4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 145/191] btrfs: safely advance counter when looking up bio csums
Date:   Fri, 21 Feb 2020 08:41:58 +0100
Message-Id: <20200221072308.005607611@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200221072250.732482588@linuxfoundation.org>
References: <20200221072250.732482588@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Sterba <dsterba@suse.com>

[ Upstream commit 4babad10198fa73fe73239d02c2e99e3333f5f5c ]

Dan's smatch tool reports

  fs/btrfs/file-item.c:295 btrfs_lookup_bio_sums()
  warn: should this be 'count == -1'

which points to the while (count--) loop. With count == 0 the check
itself could decrement it to -1. There's a WARN_ON a few lines below
that has never been seen in practice though.

It turns out that the value of page_bytes_left matches the count (by
sectorsize multiples). The loop never reaches the state where count
would go to -1, because page_bytes_left == 0 is found first and this
breaks out.

For clarity, use only plain check on count (and only for positive
value), decrement safely inside the loop. Any other discrepancy after
the whole bio list processing should be reported by the exising
WARN_ON_ONCE as well.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/file-item.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
index 4cf2817ab1202..f9e280d0b44f3 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -275,7 +275,8 @@ found:
 		csum += count * csum_size;
 		nblocks -= count;
 next:
-		while (count--) {
+		while (count > 0) {
+			count--;
 			disk_bytenr += fs_info->sectorsize;
 			offset += fs_info->sectorsize;
 			page_bytes_left -= fs_info->sectorsize;
-- 
2.20.1



