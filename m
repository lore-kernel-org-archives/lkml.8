Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53115C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 15:36:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07B6E20E65
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 15:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598974592;
	bh=ruD5cWIY+Ek85uJXcD6i8enXVkymOXbsy4UrpvC6r1I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VRSWOvqBdu8uxpoAlKBR/FvfBIvWOYhwGaeA1vy5jw8B0jyx6aEJ6q+YCvd6E5EVS
	 cgRdjaF64kb48qNb0ttY9aodgbxV4UPLge+oGWr5PTh/jRzap9LUfpf1h93eB09tLl
	 fgaP72q7XT6aOGlRW+2RWJiqDPptlOQIxuq6h9Q0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731276AbgIAPg3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 11:36:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:40924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731218AbgIAPfT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 11:35:19 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DD30120E65;
        Tue,  1 Sep 2020 15:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598974516;
        bh=ruD5cWIY+Ek85uJXcD6i8enXVkymOXbsy4UrpvC6r1I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bJKqqXApW03dKnXsL99+4gumjQzAbCW1Nlk0CyYkY71QIXhGczmRdvSDMEI9TyA2m
         XEDj42BEglwqe+mInLPW1qVGSRVzQXqQ4eKpGP7rrjeuCJebnQUzD4Syt68IyZTKyA
         YC5dCymxIvJ21j4LAgMEghLJMLaH+WhK2o5v2HiE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Matthias Maennich <maennich@google.com>
Subject: [PATCH 5.4 207/214] kheaders: optimize header copy for in-tree builds
Date:   Tue,  1 Sep 2020 17:11:27 +0200
Message-Id: <20200901151002.845982333@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200901150952.963606936@linuxfoundation.org>
References: <20200901150952.963606936@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masahiro Yamada <yamada.masahiro@socionext.com>

commit ea79e5168be644fdaf7d4e6a73eceaf07b3da76a upstream.

This script copies headers by the cpio command twice; first from
srctree, and then from objtree. However, when we building in-tree,
we know the srctree and the objtree are the same. That is, all the
headers copied by the first cpio are overwritten by the second one.

Skip the first cpio when we are building in-tree.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Signed-off-by: Matthias Maennich <maennich@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/gen_kheaders.sh |   16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

--- a/kernel/gen_kheaders.sh
+++ b/kernel/gen_kheaders.sh
@@ -56,14 +56,16 @@ fi
 rm -rf $cpio_dir
 mkdir $cpio_dir
 
-pushd $srctree > /dev/null
-for f in $dir_list;
-	do find "$f" -name "*.h";
-done | cpio --quiet -pd $cpio_dir
-popd > /dev/null
+if [ "$building_out_of_srctree" ]; then
+	pushd $srctree > /dev/null
+	for f in $dir_list
+		do find "$f" -name "*.h";
+	done | cpio --quiet -pd $cpio_dir
+	popd > /dev/null
+fi
 
-# The second CPIO can complain if files already exist which can
-# happen with out of tree builds. Just silence CPIO for now.
+# The second CPIO can complain if files already exist which can happen with out
+# of tree builds having stale headers in srctree. Just silence CPIO for now.
 for f in $dir_list;
 	do find "$f" -name "*.h";
 done | cpio --quiet -pd $cpio_dir >/dev/null 2>&1


