Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 050F9C52D29
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:21:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C686C246A0
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:21:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582813297;
	bh=Oy04ncDpOudFb1TIC7QExOQuLz3jaGRTEN1jhP1o1ao=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wzm8PvatydO54+hvWugSj7RMrJ1d40ThwvQOg8smcz9lwK46FRJAKZWjE6U1ZUFPO
	 2Pl7GAe3j7bq72Cj3k8TtjxK48EGRxRKbmBbVd2VbZuekHk4s2yj/JkxUMSUIWw8XT
	 BSajjPAte0MRQBFrzwD7fCOLgf0dN4nVlNVSPBeo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389241AbgB0OQg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 09:16:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:56730 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389532AbgB0OQd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 09:16:33 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 83A1820801;
        Thu, 27 Feb 2020 14:16:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582812993;
        bh=Oy04ncDpOudFb1TIC7QExOQuLz3jaGRTEN1jhP1o1ao=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gcd0Zcvp2QL6zyWdpgHkxvFOM+RpkWDANk2jCETxTtl1/PNbSFUCkiVAowH+o2Ww9
         NbQZ45FWrjmtiexoQBUamDt7BtARGs3RtSViXWliBhqatSN28aDhDolL4I/y9V9D1g
         pJvqVm4qPHL3ahCzyTu0osWMfQzD8TMUps5QO9qk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jan Kara <jack@suse.cz>,
        Theodore Tso <tytso@mit.edu>, stable@kernel.org
Subject: [PATCH 5.5 094/150] ext4: fix mount failure with quota configured as module
Date:   Thu, 27 Feb 2020 14:37:11 +0100
Message-Id: <20200227132246.714631224@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200227132232.815448360@linuxfoundation.org>
References: <20200227132232.815448360@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jan Kara <jack@suse.cz>

commit 9db176bceb5c5df4990486709da386edadc6bd1d upstream.

When CONFIG_QFMT_V2 is configured as a module, the test in
ext4_feature_set_ok() fails and so mount of filesystems with quota or
project features fails. Fix the test to use IS_ENABLED macro which
works properly even for modules.

Link: https://lore.kernel.org/r/20200221100835.9332-1-jack@suse.cz
Fixes: d65d87a07476 ("ext4: improve explanation of a mount failure caused by a misconfigured kernel")
Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Cc: stable@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/ext4/super.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -2989,7 +2989,7 @@ static int ext4_feature_set_ok(struct su
 		return 0;
 	}
 
-#if !defined(CONFIG_QUOTA) || !defined(CONFIG_QFMT_V2)
+#if !IS_ENABLED(CONFIG_QUOTA) || !IS_ENABLED(CONFIG_QFMT_V2)
 	if (!readonly && (ext4_has_feature_quota(sb) ||
 			  ext4_has_feature_project(sb))) {
 		ext4_msg(sb, KERN_ERR,


