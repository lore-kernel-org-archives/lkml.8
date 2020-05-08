Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D295AC47247
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 12:23:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B338A21582
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 12:23:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="H0viADmU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbgEHMX3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 08:23:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727094AbgEHMXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 08:23:25 -0400
Received: from forwardcorp1j.mail.yandex.net (forwardcorp1j.mail.yandex.net [IPv6:2a02:6b8:0:1619::183])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B10DC05BD43
        for <linux-kernel@vger.kernel.org>; Fri,  8 May 2020 05:23:25 -0700 (PDT)
Received: from mxbackcorp1g.mail.yandex.net (mxbackcorp1g.mail.yandex.net [IPv6:2a02:6b8:0:1402::301])
        by forwardcorp1j.mail.yandex.net (Yandex) with ESMTP id 38F662E0DD7;
        Fri,  8 May 2020 15:23:24 +0300 (MSK)
Received: from myt5-70c90f7d6d7d.qloud-c.yandex.net (myt5-70c90f7d6d7d.qloud-c.yandex.net [2a02:6b8:c12:3e2c:0:640:70c9:f7d])
        by mxbackcorp1g.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id CwfcYZS86f-NNAWclZ0;
        Fri, 08 May 2020 15:23:24 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1588940604; bh=fE5H5nxfbTVPsDYqy95Pi0qrqxG0n44r6YkokVlYuxs=;
        h=In-Reply-To:Message-ID:References:Date:To:From:Subject:Cc;
        b=H0viADmU8Q1pZpdoq3gUEj+1k51lST+hEaXaQzaspjNPreBUobGD5qFJJFWjDTZGp
         qlxY2mfOF2tOueZPJ4/OWPOMlUWZTHdSiJAtumhD0dek8Lrtd2BO77fiuVy2fciQPS
         vEFgofTlKQcoOtSbRFNqyibCu/ALHX0go6vjdkiE=
Authentication-Results: mxbackcorp1g.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-vpn.dhcp.yndx.net (dynamic-vpn.dhcp.yndx.net [2a02:6b8:b080:7008::1:4])
        by myt5-70c90f7d6d7d.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id fhizLjzH9z-NNWe0AWK;
        Fri, 08 May 2020 15:23:23 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
Subject: [PATCH RFC 4/8] fsnotify: stop walking child dentries if remaining
 tail is negative
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Waiman Long <longman@redhat.com>
Date:   Fri, 08 May 2020 15:23:23 +0300
Message-ID: <158894060308.200862.2000400345829882905.stgit@buzz>
In-Reply-To: <158893941613.200862.4094521350329937435.stgit@buzz>
References: <158893941613.200862.4094521350329937435.stgit@buzz>
User-Agent: StGit/0.22-32-g6a05
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When notification starts/stops listening events from inode's children it
have to update dentry->d_flags of all positive child dentries. Scanning
may took a long time if directory has a lot of negative child dentries.

This is main beneficiary of sweeping cached negative dentries to the end.

Before patch:

nr_dentry = 24172597	24.2M
nr_buckets = 8388608	2.9 avg
nr_unused = 24158110	99.9%
nr_negative = 24142810	99.9%

inotify time: 0.507182 seconds

After patch:

nr_dentry = 24562747    24.6M
nr_buckets = 8388608    2.9 avg
nr_unused = 24548714    99.9%
nr_negative = 24543867  99.9%

inotify time: 0.000010 seconds

Negative dentries no longer slow down inotify op at parent directory.

Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
---
 fs/notify/fsnotify.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
index 72d332ce8e12..072974302950 100644
--- a/fs/notify/fsnotify.c
+++ b/fs/notify/fsnotify.c
@@ -127,8 +127,12 @@ void __fsnotify_update_child_dentry_flags(struct inode *inode)
 		 * original inode) */
 		spin_lock(&alias->d_lock);
 		list_for_each_entry(child, &alias->d_subdirs, d_child) {
-			if (!child->d_inode)
+			if (!child->d_inode) {
+				/* all remaining children are negative */
+				if (d_is_tail_negative(child))
+					break;
 				continue;
+			}
 
 			spin_lock_nested(&child->d_lock, DENTRY_D_LOCK_NESTED);
 			if (watched)

