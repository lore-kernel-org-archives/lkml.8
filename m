Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41754C433FE
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 14:16:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12C4E2070A
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 14:16:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595859360;
	bh=RgO0TP/iRYtNkeSLth77M7W8mnKYQYOlWQZEK7CcPqQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=u50PlGHo+QaLVHgy1XeXLrIDeipWBsdJTVhWhTWOhLsKBszZt5knroZ/fge1lw+H2
	 nkw04dymCjzBLfv+CcxkONFQERcnOIFEgUzC1wF0O1ibDpJ/TDwSOhXO7KZBr7nZE1
	 yFJwZYP46OKwxlVwdVsol+IIk++PPmConwfLF4MM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730776AbgG0OP6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 10:15:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:42602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730756AbgG0OPz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 10:15:55 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E4DB62070A;
        Mon, 27 Jul 2020 14:15:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595859355;
        bh=RgO0TP/iRYtNkeSLth77M7W8mnKYQYOlWQZEK7CcPqQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nSNlX+h1QWh5kXcM1wLNVdnBhX+FdgPSivB6AePnjGo1tFEOKDq/eBr8CN84SOHkb
         LiZtBH4sochgnT4TIMOFopAL3PkTOSLlhglaHeyuqRB27hT/UhNB007e8+YelLDRbJ
         2OVuECwyH/1HS5BtFdqYLHVGP8oAG82xuL8X9U2o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Filipe Manana <fdmanana@suse.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Robbie Ko <robbieko@synology.com>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH 5.4 035/138] btrfs: fix page leaks after failure to lock page for delalloc
Date:   Mon, 27 Jul 2020 16:03:50 +0200
Message-Id: <20200727134927.124861452@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200727134925.228313570@linuxfoundation.org>
References: <20200727134925.228313570@linuxfoundation.org>
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
@@ -1923,7 +1923,8 @@ static int __process_pages_contig(struct
 				if (!PageDirty(pages[i]) ||
 				    pages[i]->mapping != mapping) {
 					unlock_page(pages[i]);
-					put_page(pages[i]);
+					for (; i < ret; i++)
+						put_page(pages[i]);
 					err = -EAGAIN;
 					goto out;
 				}


