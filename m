Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A7CDC4BA1F
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 17:45:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 254F324680
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 17:45:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582739132;
	bh=3TsT+tD+GtcgqL8MwQtdZE5y4OI0Akgaxe+KP5Wf1jM=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=NTIMIMVooLkQ6mAe4w6Kjmsss5955uWfJGAN3mzxpDGxyo/o7phoP8r5fwSWACmBU
	 zeZ2Iht2pz32un0/z+aFQ/VikvEaeoOm1iyBbi2RWmu1uPMFhUUREVlrvsuGFuJ+2n
	 MHxG8G96QGinyLItbY0MJ5SjhPjDxxfZrw1M0IXc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726969AbgBZRpb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 12:45:31 -0500
Received: from conuserg-12.nifty.com ([210.131.2.79]:64470 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726151AbgBZRpb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 12:45:31 -0500
Received: from grover.flets-west.jp (softbank126093102113.bbtec.net [126.93.102.113]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id 01QHj1hX027457;
        Thu, 27 Feb 2020 02:45:02 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com 01QHj1hX027457
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1582739102;
        bh=wHYTdHTVndm1iEwuP4oVebWI1ltNgDzshUcclCf018M=;
        h=From:To:Cc:Subject:Date:From;
        b=MgzOC99AUCZ6ArR7yLjwwLfee5vjCC+VRrH2IzFcmisXKy+U0H430pjYvPWW6c1yH
         AOCnypfFN4cQnZBi1YQpK07pMLRk4aHvWHGB8DSXlV84zIIJPCk/xi9X25N7xumDPj
         oGsnf3HGZVwCsuLqQJwcEcGI/h6VFGt+BSxK/qbSjKqYYuJWD/y9taIuTj3Z7nnPpp
         tzlwFl3I1F1OA+0dZbSVLL/P1X/Fkaw85UBdgq7jRRVVoPtxZWTdHfZn9wbYQLLGe0
         oueGsoIe9LUdoW7timrxPtps3emEDi2pljNEIu+kRMTAsS3l4oYWnXo/M15ujecfJ9
         o8h6Xuk6bEVWw==
X-Nifty-SrcIP: [126.93.102.113]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-doc@vger.kernel.org
Subject: [PATCH] kbuild: get rid of trailing slash from subdir- example
Date:   Thu, 27 Feb 2020 02:44:58 +0900
Message-Id: <20200226174458.8115-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

obj-* needs a trailing slash for a directory, but subdir-* does not.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 Documentation/kbuild/makefiles.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/kbuild/makefiles.rst b/Documentation/kbuild/makefiles.rst
index 0e0eb2c8da7d..c9adfa1f9e21 100644
--- a/Documentation/kbuild/makefiles.rst
+++ b/Documentation/kbuild/makefiles.rst
@@ -765,7 +765,7 @@ is not sufficient this sometimes needs to be explicit.
 	Example::
 
 		#arch/x86/boot/Makefile
-		subdir- := compressed/
+		subdir- := compressed
 
 The above assignment instructs kbuild to descend down in the
 directory compressed/ when "make clean" is executed.
-- 
2.17.1

