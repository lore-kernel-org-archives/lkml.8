Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 808EEC35677
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 13:40:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57ECC24692
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 13:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582810821;
	bh=HJS9UFbR8ju5fqaxIE7LfFVdi9AUqyogj5i0guOvO50=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=t0em1mnDfL7RqAh5+Obn7ipXd1q2pQLhcnfHkg1Dvsi7Rtzu7d56YruPGTKF/SX4k
	 6zmoq30KoDb2Q+7zZEcLLPqKIfD9C+XCAH/wDBhYKZTE0XX2LvozpEHgNyRuTM27I8
	 dk24BuOA4vXdMja68FLK5x7lcntln8vkI1BwRLq8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729202AbgB0NkU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 08:40:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:34574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729030AbgB0NkT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 08:40:19 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A1FBF2469F;
        Thu, 27 Feb 2020 13:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582810819;
        bh=HJS9UFbR8ju5fqaxIE7LfFVdi9AUqyogj5i0guOvO50=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uIWphGIvo/4gM9ZYsbEKrX7SXN4uXaUun0SNjpNUUdUY/XnruqI0mMq312Yvvm8pv
         G8DkrMDcsVNOZzDM8HD6pkTUrga7fOBvXupwGRkIQTP+vmAGM4wx/1QcLuSoufMNkS
         4UCTE/5ZMC+MzY1ouv4BpHBdkPaGHYHMNm0UR+Oc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Anand Jain <anand.jain@oracle.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH 4.4 010/113] btrfs: log message when rw remount is attempted with unclean tree-log
Date:   Thu, 27 Feb 2020 14:35:26 +0100
Message-Id: <20200227132213.378746014@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200227132211.791484803@linuxfoundation.org>
References: <20200227132211.791484803@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Sterba <dsterba@suse.com>

commit 10a3a3edc5b89a8cd095bc63495fb1e0f42047d9 upstream.

A remount to a read-write filesystem is not safe when there's tree-log
to be replayed. Files that could be opened until now might be affected
by the changes in the tree-log.

A regular mount is needed to replay the log so the filesystem presents
the consistent view with the pending changes included.

CC: stable@vger.kernel.org # 4.4+
Reviewed-by: Anand Jain <anand.jain@oracle.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/btrfs/super.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -1702,6 +1702,8 @@ static int btrfs_remount(struct super_bl
 		}
 
 		if (btrfs_super_log_root(fs_info->super_copy) != 0) {
+			btrfs_warn(fs_info,
+		"mount required to replay tree-log, cannot remount read-write");
 			ret = -EINVAL;
 			goto restore;
 		}


