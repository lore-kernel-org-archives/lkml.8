Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53268C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 13:43:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1640720674
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 13:43:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597931027;
	bh=8gTAWMHmKWWQ19Ho78or6u9zEjW6IwLD3rcYFIbm1AE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vAef+4hYtRNFurrrV3BtIQoQ517xS058OLX8csTSJ8IccIKO2yzR/SFoSWsVvL/ns
	 HtoEXOp9f8AyNOgBHYxdW3QL32HYovhcKVopNZowhT7oJ4pBStg0M5nFjDoWeYvbbt
	 /jQaizZfE4gzMB8sns5Ff3Vel3WjJmo2cjvQGQ/0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730870AbgHTNm5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 09:42:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:39866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727854AbgHTJ3X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 05:29:23 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6AC4E22D07;
        Thu, 20 Aug 2020 09:29:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597915763;
        bh=8gTAWMHmKWWQ19Ho78or6u9zEjW6IwLD3rcYFIbm1AE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=doa3yl6MGZaQMt3UjWA6XQZWX8IplGmV/xcdJtB0EwpJ6uESWbTBvEmGmIk2wTIIJ
         fzikcVO3oyFIuWcrrGmWcuh2QjZnHYZr4ocL+0V/BofEN5kCrxxBYlVKsPXtrU0NAN
         /JDkzYBtDADVcrfhxcjQDOCMpce/SYqJbHiI5Q3E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        Patrick Donnelly <pdonnell@redhat.com>
Subject: [PATCH 5.8 096/232] ceph: handle zero-length feature mask in session messages
Date:   Thu, 20 Aug 2020 11:19:07 +0200
Message-Id: <20200820091617.478856293@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200820091612.692383444@linuxfoundation.org>
References: <20200820091612.692383444@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jeff Layton <jlayton@kernel.org>

commit 02e37571f9e79022498fd0525c073b07e9d9ac69 upstream.

Most session messages contain a feature mask, but the MDS will
routinely send a REJECT message with one that is zero-length.

Commit 0fa8263367db ("ceph: fix endianness bug when handling MDS
session feature bits") fixed the decoding of the feature mask,
but failed to account for the MDS sending a zero-length feature
mask. This causes REJECT message decoding to fail.

Skip trying to decode a feature mask if the word count is zero.

Cc: stable@vger.kernel.org
URL: https://tracker.ceph.com/issues/46823
Fixes: 0fa8263367db ("ceph: fix endianness bug when handling MDS session feature bits")
Signed-off-by: Jeff Layton <jlayton@kernel.org>
Reviewed-by: Ilya Dryomov <idryomov@gmail.com>
Tested-by: Patrick Donnelly <pdonnell@redhat.com>
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/ceph/mds_client.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -3279,8 +3279,10 @@ static void handle_session(struct ceph_m
 			goto bad;
 		/* version >= 3, feature bits */
 		ceph_decode_32_safe(&p, end, len, bad);
-		ceph_decode_64_safe(&p, end, features, bad);
-		p += len - sizeof(features);
+		if (len) {
+			ceph_decode_64_safe(&p, end, features, bad);
+			p += len - sizeof(features);
+		}
 	}
 
 	mutex_lock(&mdsc->mutex);


