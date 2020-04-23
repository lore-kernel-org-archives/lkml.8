Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FCCFC55186
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 23:21:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F23112077D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 23:21:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729558AbgDWXVh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 19:21:37 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:48500 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728188AbgDWXGc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 19:06:32 -0400
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1jRkvK-0004b3-Jp; Fri, 24 Apr 2020 00:06:26 +0100
Received: from ben by deadeye with local (Exim 4.93)
        (envelope-from <ben@decadent.org.uk>)
        id 1jRkvJ-00E6ho-Cx; Fri, 24 Apr 2020 00:06:25 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Arnd Bergmann" <arnd@arndb.de>, "David Sterba" <dsterba@suse.com>,
        "Ben Hutchings" <ben.hutchings@codethink.co.uk>
Date:   Fri, 24 Apr 2020 00:04:33 +0100
Message-ID: <lsq.1587683028.39784643@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 046/245] btrfs: tree-checker: use %zu format string
 for size_t
In-Reply-To: <lsq.1587683027.831233700@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.83-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

commit 7cfad65297bfe0aa2996cd72d21c898aa84436d9 upstream.

The return value of sizeof() is of type size_t, so we must print it
using the %z format modifier rather than %l to avoid this warning
on some architectures:

fs/btrfs/tree-checker.c: In function 'check_dir_item':
fs/btrfs/tree-checker.c:273:50: error: format '%lu' expects argument of type 'long unsigned int', but argument 5 has type 'u32' {aka 'unsigned int'} [-Werror=format=]

Fixes: 005887f2e3e0 ("btrfs: tree-checker: Add checker for dir item")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 fs/btrfs/tree-checker.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/btrfs/tree-checker.c
+++ b/fs/btrfs/tree-checker.c
@@ -223,7 +223,7 @@ static int check_dir_item(struct btrfs_r
 		/* header itself should not cross item boundary */
 		if (cur + sizeof(*di) > item_size) {
 			dir_item_err(root, leaf, slot,
-		"dir item header crosses item boundary, have %lu boundary %u",
+		"dir item header crosses item boundary, have %zu boundary %u",
 				cur + sizeof(*di), item_size);
 			return -EUCLEAN;
 		}

