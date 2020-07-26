Return-Path: <SRS0=7zi/=BF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FA35C433E3
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 17:51:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 886122065F
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 17:51:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbgGZRu7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jul 2020 13:50:59 -0400
Received: from smtprelay0063.hostedemail.com ([216.40.44.63]:44506 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725972AbgGZRu6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jul 2020 13:50:58 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 07A38181D337B;
        Sun, 26 Jul 2020 17:50:58 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: spot61_29121a526f5a
X-Filterd-Recvd-Size: 2105
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf09.hostedemail.com (Postfix) with ESMTPA;
        Sun, 26 Jul 2020 17:50:56 +0000 (UTC)
Message-ID: <fc092be37e970b0ec474e46e31c13ba1e1fae675.camel@perches.com>
Subject: Re: [PATCH] init/do_mounts: fix a coding style error
From:   Joe Perches <joe@perches.com>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        zhouchuangao <chuangaozhou@gmail.com>
Cc:     linux@dominikbrodowski.net, pc@cjr.nz, axboe@kernel.dk,
        dhowells@redhat.com, linux-kernel@vger.kernel.org,
        zhouchuangao <zhouchuangao@xiaomi.com>
Date:   Sun, 26 Jul 2020 10:50:55 -0700
In-Reply-To: <20200726172109.GV2786714@ZenIV.linux.org.uk>
References: <1594710178-27825-1-git-send-email-zhouchuangao@xiaomi.com>
         <20200726172109.GV2786714@ZenIV.linux.org.uk>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.3-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2020-07-26 at 18:21 +0100, Al Viro wrote:
> On Tue, Jul 14, 2020 at 03:02:58PM +0800, zhouchuangao wrote:
> > Fix code style errors reported by scripts/checkpatch.pl.
> 
> NAKed-because: excessive deference to checkpatch.pl
> 
> It's not a holy oracle than needs to be appeased, no questions
> asked.  Reference to it is absolutely insufficient reason for
> _anything_ - in effect your commit message could've been
> "just because" for all the information it contains.

Al is right.

Something that could useful is to avoid using printks without
a KERN_<LEVEL> or add KERN_CONT to some continuation printks.

Maybe:
---
diff --git a/init/do_mounts.c b/init/do_mounts.c
index 4f4ceb358055..3f37d859cf2a 100644
--- a/init/do_mounts.c
+++ b/init/do_mounts.c
@@ -468,8 +468,8 @@ void __init mount_block_root(char *name, int flags)
 	printk_all_partitions();
 	printk("No filesystem could mount root, tried: ");
 	for (p = fs_names; *p; p += strlen(p)+1)
-		printk(" %s", p);
-	printk("\n");
+		pr_cont(" %s", p);
+	pr_cont("\n");
 	panic("VFS: Unable to mount root fs on %s", b);
 out:
 	put_page(page);


