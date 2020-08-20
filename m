Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01384C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 12:43:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C67012224D
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 12:43:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597927420;
	bh=hKw4VeEPTvlU9LP6XXahCcYoetS6SUJD6tZ/nSvmgRE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=05zFDVBEJ+IOPAvznf+NHP4I73dDmGPxvu4/NRVb+PUythGbhyixlVBvjBWZbZqpB
	 6tupgFSUGOnPSZr5oW/rqMUQYFXeOUvFBbYAHYHBCTtZD6sovEMLxflsKfgw2UE1Hh
	 lNvn9Vet4RWeFLfsogeUyvmGvhoJEMUCOM1y9C0Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730416AbgHTMnj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 08:43:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:48054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729173AbgHTJqJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 05:46:09 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0C86422B43;
        Thu, 20 Aug 2020 09:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597916768;
        bh=hKw4VeEPTvlU9LP6XXahCcYoetS6SUJD6tZ/nSvmgRE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ifofEWdQGFn0QjImxRDDB+JyhgfBg3Y1f3wCT2YnV0QsSkJxsbjO7T1zEbBFXvuWP
         1lMjGZluCnZuMxSTTCKnbLLKHvuqpUTp5wCcwxJAvKThc4w7veiGVJ0XM15s4qg1TV
         2A6T/pFBMbH44t0uDxs3LL8hWC5ub7kXBdtk6Sys=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tom Rix <trix@redhat.com>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH 5.4 012/152] btrfs: ref-verify: fix memory leak in add_block_entry
Date:   Thu, 20 Aug 2020 11:19:39 +0200
Message-Id: <20200820091554.266984251@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200820091553.615456912@linuxfoundation.org>
References: <20200820091553.615456912@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

commit d60ba8de1164e1b42e296ff270c622a070ef8fe7 upstream.

clang static analysis flags this error

fs/btrfs/ref-verify.c:290:3: warning: Potential leak of memory pointed to by 're' [unix.Malloc]
                kfree(be);
                ^~~~~

The problem is in this block of code:

	if (root_objectid) {
		struct root_entry *exist_re;

		exist_re = insert_root_entry(&exist->roots, re);
		if (exist_re)
			kfree(re);
	}

There is no 'else' block freeing when root_objectid is 0. Add the
missing kfree to the else branch.

Fixes: fd708b81d972 ("Btrfs: add a extent ref verify tool")
CC: stable@vger.kernel.org # 4.19+
Signed-off-by: Tom Rix <trix@redhat.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/btrfs/ref-verify.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/fs/btrfs/ref-verify.c
+++ b/fs/btrfs/ref-verify.c
@@ -286,6 +286,8 @@ static struct block_entry *add_block_ent
 			exist_re = insert_root_entry(&exist->roots, re);
 			if (exist_re)
 				kfree(re);
+		} else {
+			kfree(re);
 		}
 		kfree(be);
 		return exist;


