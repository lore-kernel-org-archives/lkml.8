Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31618C35E15
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:03:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AEBE21D7E
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:03:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582812203;
	bh=hothXiVroBMjSQtLbfartgEN01sSBKIrotloJ+pKrb0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gxmAvaa6QDtSNdTwipKPXNm0uPj5zssIoOWYyRtIs6unnljjzXEhhmEp/+Do36KFn
	 /t8DXBU5A5YuMHHne22JeYqgFVwcGEOQo/ekXcWMs8swAdEuBL/yWq0E1+R13hez6b
	 shElSdJ96IBHW+ET3j1/3pGuBH3SEB8+7FJSwc2w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387410AbgB0ODV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 09:03:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:38458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733312AbgB0ODT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 09:03:19 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5377A20801;
        Thu, 27 Feb 2020 14:03:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582812198;
        bh=hothXiVroBMjSQtLbfartgEN01sSBKIrotloJ+pKrb0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=t9tAuHoYqXVMbqIL6QEzt3yc2S7nyCLk7QjgaIBinq4W36bXGVpLxlVpUPWS2BmNl
         5waowKYm8EpHtg7KXJ1vZBcK5qs31+pLijciKeeKiCsEEbsk/YJneIf7Ogl9U3V9Qb
         J3s79bmrHEZ2b8h5lYYLKrIrNnrdMo9yEeGz7CNM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Wenwen Wang <wenwen@cs.uga.edu>,
        Tyler Hicks <tyhicks@canonical.com>
Subject: [PATCH 4.19 06/97] ecryptfs: fix a memory leak bug in parse_tag_1_packet()
Date:   Thu, 27 Feb 2020 14:36:14 +0100
Message-Id: <20200227132215.620415637@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200227132214.553656188@linuxfoundation.org>
References: <20200227132214.553656188@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wenwen Wang <wenwen@cs.uga.edu>

commit fe2e082f5da5b4a0a92ae32978f81507ef37ec66 upstream.

In parse_tag_1_packet(), if tag 1 packet contains a key larger than
ECRYPTFS_MAX_ENCRYPTED_KEY_BYTES, no cleanup is executed, leading to a
memory leak on the allocated 'auth_tok_list_item'. To fix this issue, go to
the label 'out_free' to perform the cleanup work.

Cc: stable@vger.kernel.org
Fixes: dddfa461fc89 ("[PATCH] eCryptfs: Public key; packet management")
Signed-off-by: Wenwen Wang <wenwen@cs.uga.edu>
Signed-off-by: Tyler Hicks <tyhicks@canonical.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/ecryptfs/keystore.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/ecryptfs/keystore.c
+++ b/fs/ecryptfs/keystore.c
@@ -1318,7 +1318,7 @@ parse_tag_1_packet(struct ecryptfs_crypt
 		printk(KERN_WARNING "Tag 1 packet contains key larger "
 		       "than ECRYPTFS_MAX_ENCRYPTED_KEY_BYTES\n");
 		rc = -EINVAL;
-		goto out;
+		goto out_free;
 	}
 	memcpy((*new_auth_tok)->session_key.encrypted_key,
 	       &data[(*packet_size)], (body_size - (ECRYPTFS_SIG_SIZE + 2)));


