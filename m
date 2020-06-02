Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53BC8C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 16:28:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29EE52077D
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 16:28:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727826AbgFBQ2U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 12:28:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727113AbgFBQ2U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 12:28:20 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C35B9C05BD1E;
        Tue,  2 Jun 2020 09:28:19 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.93 #3 (Red Hat Linux))
        id 1jg9lp-0021Yj-0I; Tue, 02 Jun 2020 16:28:09 +0000
Date:   Tue, 2 Jun 2020 17:28:08 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     butt3rflyh4ck <butterflyhuangxx@gmail.com>
Cc:     namjae.jeon@samsung.com, sj1557.seo@samsung.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller <syzkaller@googlegroups.com>
Subject: Re: memory leak in exfat_parse_param
Message-ID: <20200602162808.GK23230@ZenIV.linux.org.uk>
References: <CAFcO6XPVo-u0CkBxy0Ox+FPfqgPUwmo0pnVYrLCP6EM05Sd6-A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFcO6XPVo-u0CkBxy0Ox+FPfqgPUwmo0pnVYrLCP6EM05Sd6-A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 02, 2020 at 01:03:05PM +0800, butt3rflyh4ck wrote:
> I report a bug (in linux-5.7.0-rc7) found by syzkaller.
> 
> kernel config: https://github.com/butterflyhack/syzkaller-fuzz/blob/master/config-v5.7.0-rc7
> 
> and can reproduce.
> 
> A param->string held by exfat_mount_options.

Humm...

	First of all, exfat_free() ought to call exfat_free_upcase_table().
What's more, WTF bother with that kstrdup(), anyway?  Just steal the string
and be done with that...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
diff --git a/fs/exfat/super.c b/fs/exfat/super.c
index 0565d5539d57..01cd7ed1614d 100644
--- a/fs/exfat/super.c
+++ b/fs/exfat/super.c
@@ -259,9 +259,8 @@ static int exfat_parse_param(struct fs_context *fc, struct fs_parameter *param)
 		break;
 	case Opt_charset:
 		exfat_free_iocharset(sbi);
-		opts->iocharset = kstrdup(param->string, GFP_KERNEL);
-		if (!opts->iocharset)
-			return -ENOMEM;
+		opts->iocharset = param->string;
+		param->string = NULL;
 		break;
 	case Opt_errors:
 		opts->errors = result.uint_32;
@@ -611,7 +610,10 @@ static int exfat_get_tree(struct fs_context *fc)
 
 static void exfat_free(struct fs_context *fc)
 {
-	kfree(fc->s_fs_info);
+	struct exfat_sb_info *sbi = fc->s_fs_info;
+
+	exfat_free_iocharset(sbi);
+	kfree(sbi);
 }
 
 static const struct fs_context_operations exfat_context_ops = {
