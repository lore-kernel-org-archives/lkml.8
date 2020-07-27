Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5015EC433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 14:20:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24BF7208E4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 14:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595859623;
	bh=UbrhK8raAGl/tgRM7NvsEH1DQh0Hx4h2ZnCsXset6dY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=upUUSB3iRusnwvQkD1tQ1b+SB3dNpnzEFemTofffYtOUIHPDDOXxWE0lzq1mKYSZg
	 COHCaLcfqMTr6fbMWxwcEzNGtg8pnRKZ3VBrf7ikvBAEBD+F+Sq9UKhat0iS4Fo5cZ
	 +H+EtMLvF2eROr9gMgEOpuKqSTPKU1JH56SdrYB8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731532AbgG0OUW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 10:20:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:48494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730983AbgG0OUT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 10:20:19 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 063B72070A;
        Mon, 27 Jul 2020 14:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595859619;
        bh=UbrhK8raAGl/tgRM7NvsEH1DQh0Hx4h2ZnCsXset6dY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=THfHzLVMSGiqdARziOxUMoZqpJFvfRvliUIvxN27TVrltCmAS8ztVf3gz8394H8+O
         ftlaEuQO2SVrU60utsHwAUHTuXjx2/qBNxnnX8Na4eBM8e8tVA79RU9gLinKSK54NY
         02VG13TVGhg3VH1eD43CdEr+wkv8Kl4JQI2gzw+Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Filipe Manana <fdmanana@suse.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Robbie Ko <robbieko@synology.com>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH 5.7 040/179] btrfs: fix page leaks after failure to lock page for delalloc
Date:   Mon, 27 Jul 2020 16:03:35 +0200
Message-Id: <20200727134934.628527557@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200727134932.659499757@linuxfoundation.org>
References: <20200727134932.659499757@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Robbie Ko <robbieko@synology.com>

commit 5909ca110b29aa16b23b52b8de8d3bb1035fd738 upstream.

When locking pages for delalloc, we check if it's dirty and mapping still
matches. If it does not match, we need to return -EAGAIN and release all
pages. Only the current page was put though, iterate over all the
remaining pages too.

CC: stable@vger.kernel.org # 4.14+
Reviewed-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: Nikolay Borisov <nborisov@suse.com>
Signed-off-by: Robbie Ko <robbieko@synology.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/btrfs/extent_io.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -1999,7 +1999,8 @@ static int __process_pages_contig(struct
 				if (!PageDirty(pages[i]) ||
 				    pages[i]->mapping != mapping) {
 					unlock_page(pages[i]);
-					put_page(pages[i]);
+					for (; i < ret; i++)
+						put_page(pages[i]);
 					err = -EAGAIN;
 					goto out;
 				}


