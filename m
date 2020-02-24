Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C09E1C35DE4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 23:31:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8546020732
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 23:31:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728645AbgBXXbz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 18:31:55 -0500
Received: from ozlabs.org ([203.11.71.1]:48109 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728316AbgBXXbx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 18:31:53 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 48RJHW2JVVz9sRN; Tue, 25 Feb 2020 10:31:51 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1582587111;
        bh=JzgZyPtOaifXii+bpzYFkorbOTXtLl84vde0igBpI0o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VutxjaFjIPCAC+QUqHa7de4fOg3E1IPiTsRhP98+0Mhi3erfRWlnTIyktEYg1pP3I
         dO4jtMOYodRk/ezMNRiyGocluiy1onVaAM/02hQjkuBZmwBttuynzhKQqZ4oAzDsFZ
         EAC9B/iw6rJahhmdaStmAlyv0ghqwcRjRXeNDK1rtS4fkWrYInSEyD3rOT5iA59C6S
         F3hm1OBSckNw04wf+XeEGS3QeQawLYhRVdBx0akLzZ7yacEBOVFEDDh3o7fUNUox3I
         Vm9+eWc0/QsMCf0E/b6Mzw7nSrh/owEbSOeV6XIMuNp9wgMzMrUP2NvXHPLEig1TUb
         zyNr6MQ8Jr6/w==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     linuxppc-dev@ozlabs.org
Cc:     linux-kernel@vger.kernel.org,
        Alistair Popple <alistair@popple.id.au>,
        Matt Porter <mporter@kernel.crashing.org>
Subject: [PATCH 4/8] powerpc: Mark 4xx as Orphan in MAINTAINERS
Date:   Tue, 25 Feb 2020 10:31:42 +1100
Message-Id: <20200224233146.23734-4-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200224233146.23734-1-mpe@ellerman.id.au>
References: <20200224233146.23734-1-mpe@ellerman.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 4xx platforms are no longer maintained.

Cc: Alistair Popple <alistair@popple.id.au>
Cc: Matt Porter <mporter@kernel.crashing.org>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 MAINTAINERS | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5c4f37c41188..939da2ac08db 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9645,11 +9645,8 @@ F:	arch/powerpc/platforms/512x/
 F:	arch/powerpc/platforms/52xx/
 
 LINUX FOR POWERPC EMBEDDED PPC4XX
-M:	Alistair Popple <alistair@popple.id.au>
-M:	Matt Porter <mporter@kernel.crashing.org>
-W:	http://www.penguinppc.org/
 L:	linuxppc-dev@lists.ozlabs.org
-S:	Maintained
+S:	Orphan
 F:	arch/powerpc/platforms/40x/
 F:	arch/powerpc/platforms/44x/
 
-- 
2.21.1

