Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77BE5C35646
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 13:22:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56360206D7
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 13:22:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728496AbgBUNWN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 08:22:13 -0500
Received: from smtprelay0081.hostedemail.com ([216.40.44.81]:41198 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727053AbgBUNWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 08:22:12 -0500
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave01.hostedemail.com (Postfix) with ESMTP id B0CA21802ED70;
        Fri, 21 Feb 2020 13:22:11 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id B5B61182CED34;
        Fri, 21 Feb 2020 13:22:10 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: badge02_300193163bd5e
X-Filterd-Recvd-Size: 1390
Received: from XPS-9350.home (unknown [47.151.143.254])
        (Authenticated sender: joe@perches.com)
        by omf18.hostedemail.com (Postfix) with ESMTPA;
        Fri, 21 Feb 2020 13:22:09 +0000 (UTC)
Message-ID: <862518f826b35cd010a2e46f64f6f4cfa0d44582.camel@perches.com>
Subject: [trivial PATCH] cifs: Use #define in cifs_dbg
From:   Joe Perches <joe@perches.com>
To:     Steve French <sfrench@samba.org>
Cc:     linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Fri, 21 Feb 2020 05:20:45 -0800
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All other uses of cifs_dbg use defines so change this one.

Signed-off-by: Joe Perches <joe@perches.com>
---
 fs/cifs/inode.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/cifs/inode.c b/fs/cifs/inode.c
index b5e663..cd95e0 100644
--- a/fs/cifs/inode.c
+++ b/fs/cifs/inode.c
@@ -653,8 +653,8 @@ cifs_all_info_to_fattr(struct cifs_fattr *fattr, FILE_ALL_INFO *info,
 		 */
 		if ((fattr->cf_nlink < 1) && !tcon->unix_ext &&
 		    !info->DeletePending) {
-			cifs_dbg(1, "bogus file nlink value %u\n",
-				fattr->cf_nlink);
+			cifs_dbg(VFS, "bogus file nlink value %u\n",
+				 fattr->cf_nlink);
 			fattr->cf_flags |= CIFS_FATTR_UNKNOWN_NLINK;
 		}
 	}


