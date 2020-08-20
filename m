Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D10BFC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 13:59:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0D5320738
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 13:59:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597931957;
	bh=6TE7FFTve3v8uF7YgQQfnuQC/0K3ZNMVPhrYhtJvlkc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tNQkliTnRFGZjSUlnprfUntcpi7NnRWbDER+A4pz9L/J1p8jE8QM1d/7S3ep8yY98
	 hXPCL/r6JIgKNAzHeRSmrJipKqfxHJoD7eXecz/46c3NcX46sM2bG/+cVai/4WbhhD
	 D9Tjczq0NqXasXriEgoe9EFHPRSBlhckRNeV3WUU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731125AbgHTN5v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 09:57:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:33620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727093AbgHTJZP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 05:25:15 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 53D3022CB2;
        Thu, 20 Aug 2020 09:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597915514;
        bh=6TE7FFTve3v8uF7YgQQfnuQC/0K3ZNMVPhrYhtJvlkc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GxMBba+irKEAzfm67wa0hjX6luxwCRIyKREZ4cRkTYDpTTrsL6JVPi0NDGJ3XSRaO
         jOgaU3lMCYubC8IhnMb7agmFQ3iR8NAVTP2VMtPisssjJsaae6CV0t9LhC9T+lbUnc
         1X1anDG6Kdr0f+VyRaspaGIOzfvqtRrEJltzwhSU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nikolay Borisov <nborisov@suse.com>,
        Qu Wenruo <wqu@suse.com>, Boleyn Su <boleynsu@google.com>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH 5.8 041/232] btrfs: check correct variable after allocation in btrfs_backref_iter_alloc
Date:   Thu, 20 Aug 2020 11:18:12 +0200
Message-Id: <20200820091614.771086747@linuxfoundation.org>
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

From: Boleyn Su <boleynsu@google.com>

commit c15c2ec07a26b251040943a1a9f90d3037f041e5 upstream.

The `if (!ret)` check will always be false and it may result in
ret->path being dereferenced while it is a NULL pointer.

Fixes: a37f232b7b65 ("btrfs: backref: introduce the skeleton of btrfs_backref_iter")
CC: stable@vger.kernel.org # 5.8+
Reviewed-by: Nikolay Borisov <nborisov@suse.com>
Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Boleyn Su <boleynsu@google.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/btrfs/backref.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/btrfs/backref.c
+++ b/fs/btrfs/backref.c
@@ -2303,7 +2303,7 @@ struct btrfs_backref_iter *btrfs_backref
 		return NULL;
 
 	ret->path = btrfs_alloc_path();
-	if (!ret) {
+	if (!ret->path) {
 		kfree(ret);
 		return NULL;
 	}


