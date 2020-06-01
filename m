Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B693C433E1
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 18:19:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24E2C20842
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 18:19:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591035595;
	bh=DTZXf56xoqkdM1pDwpE3oN8ES3/B1f9WROuREZ/xyew=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QGqRZyq77bQ8pVwntXW84xbUi0+NYKkzceXsJUfz2YxHAmVp5rlp38JmLy/lTzXE+
	 7YWaQL+nKtjcTbdo/XHVd7ZwarWZ8/AUcuTjmXHcYhj90Nm3vSyKzsNDnkEXS3GOXY
	 WY+nLzSAv6OyMBkjy8EUv0+qQ3SojngH/zBkK3m4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731724AbgFASQg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 14:16:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:37276 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731712AbgFASQd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 14:16:33 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6C6232068D;
        Mon,  1 Jun 2020 18:16:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591035392;
        bh=DTZXf56xoqkdM1pDwpE3oN8ES3/B1f9WROuREZ/xyew=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FS8PEp23eKTSr+aCV19zfRnp3AcpQ0EbIodSdw60y7q8ipEh1wOKzan/WH7F7T3Os
         AqggVpQK5ol0I06MtT15SGW8qh95LJAAsCee7zx9cF1qjOY/Snpn2pYcWWwqyfB4G3
         DJ3FBJPPVc81Btne1M8aueOGwTFEzDA70GiUs/qg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+fd5332e429401bf42d18@syzkaller.appspotmail.com,
        Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 5.6 140/177] cfg80211: fix debugfs rename crash
Date:   Mon,  1 Jun 2020 19:54:38 +0200
Message-Id: <20200601174100.213877366@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200601174048.468952319@linuxfoundation.org>
References: <20200601174048.468952319@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

commit 0bbab5f0301587cad4e923ccc49bb910db86162c upstream.

Removing the "if (IS_ERR(dir)) dir = NULL;" check only works
if we adjust the remaining code to not rely on it being NULL.
Check IS_ERR_OR_NULL() before attempting to dereference it.

I'm not actually entirely sure this fixes the syzbot crash as
the kernel config indicates that they do have DEBUG_FS in the
kernel, but this is what I found when looking there.

Cc: stable@vger.kernel.org
Fixes: d82574a8e5a4 ("cfg80211: no need to check return value of debugfs_create functions")
Reported-by: syzbot+fd5332e429401bf42d18@syzkaller.appspotmail.com
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Link: https://lore.kernel.org/r/20200525113816.fc4da3ec3d4b.Ica63a110679819eaa9fb3bc1b7437d96b1fd187d@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/wireless/core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/wireless/core.c
+++ b/net/wireless/core.c
@@ -142,7 +142,7 @@ int cfg80211_dev_rename(struct cfg80211_
 	if (result)
 		return result;
 
-	if (rdev->wiphy.debugfsdir)
+	if (!IS_ERR_OR_NULL(rdev->wiphy.debugfsdir))
 		debugfs_rename(rdev->wiphy.debugfsdir->d_parent,
 			       rdev->wiphy.debugfsdir,
 			       rdev->wiphy.debugfsdir->d_parent, newname);


