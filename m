Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86115C2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 13:35:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56BA822203
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 13:35:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587044135;
	bh=BPSeji/5rBgzwaTVCfmVbyooIkcfuSMSKuaHhiTaEeI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jlLPzRcKahF8HfMTW9/t4YL0okF/zXkyxWym1A7rCWP4wRQjAZwW17zot5NqVcXJ+
	 u56Keq1BDUL0LujIRe5neFWX9orBDEgi/fNHQmYsVfLJ6X/Z/7Oqjo5pon7TR3Itj9
	 Nakyxkq/fXKmfR0I+Y55Ry7+IdSBjTAnqAF+KO8c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2897157AbgDPNfb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 09:35:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:39216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2896011AbgDPN3Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 09:29:24 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6FECB20767;
        Thu, 16 Apr 2020 13:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587043763;
        bh=BPSeji/5rBgzwaTVCfmVbyooIkcfuSMSKuaHhiTaEeI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c/p4AvkRDXY4QXgF7b+eGraNgsKDDlQTvQl8lcKPNgQyGc9ni0XanYWaTD/y9U3aP
         2bgZavOTJjGCGEzM/63ET4HEQPDuhlbOS+OnfaeG8+op/nE1GjFpNUY62kzmWSLAkC
         v821eEPa/C3dQpK44wgZoxEnzMJqGzAJuco9ns5A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Qu Wenruo <wqu@suse.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH 4.19 091/146] btrfs: drop block from cache on error in relocation
Date:   Thu, 16 Apr 2020 15:23:52 +0200
Message-Id: <20200416131255.206577543@linuxfoundation.org>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200416131242.353444678@linuxfoundation.org>
References: <20200416131242.353444678@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Josef Bacik <josef@toxicpanda.com>

commit 8e19c9732ad1d127b5575a10f4fbcacf740500ff upstream.

If we have an error while building the backref tree in relocation we'll
process all the pending edges and then free the node.  However if we
integrated some edges into the cache we'll lose our link to those edges
by simply freeing this node, which means we'll leak memory and
references to any roots that we've found.

Instead we need to use remove_backref_node(), which walks through all of
the edges that are still linked to this node and free's them up and
drops any root references we may be holding.

CC: stable@vger.kernel.org # 4.9+
Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/btrfs/relocation.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -1141,7 +1141,7 @@ out:
 			free_backref_node(cache, lower);
 		}
 
-		free_backref_node(cache, node);
+		remove_backref_node(cache, node);
 		return ERR_PTR(err);
 	}
 	ASSERT(!node || !node->detached);


