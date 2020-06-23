Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F4B6C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:23:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1911520738
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:23:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592947418;
	bh=CvsfPdG/ATsZOu/+MpQV9rjJuabT7A6GDEwGA3TImnw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oIZ7OVZYdXDILIqaA242Mca7JeBeb8QMnAFtH6HJxUe+bIWE6uXYI7iKtAFJgxJTl
	 toeXD8TLp7690qdWVeFOQUs60ab6Jyj1B+jx/+dwprWLmIONe7J3olxHT0wa7c/k3k
	 k/zp3rBwzwLFR1egsle1K7z3+WRK2pvb/d6wTKF8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393467AbgFWVXg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 17:23:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:38436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388743AbgFWUU6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 16:20:58 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1932520723;
        Tue, 23 Jun 2020 20:20:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592943657;
        bh=CvsfPdG/ATsZOu/+MpQV9rjJuabT7A6GDEwGA3TImnw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZEHOjb5vE1QEmeU+UV52RNEdFEgUKU8wk9t8hlemtce8oXdembrkezq2NLRlCN0AE
         Rq3YpNk+620bKElg7AAuD1d4jB1LmyFVA9NE+gXijvoUIBc1SENBVWvPWyt5KZ8zkp
         gv7YSoiBEuLuTqn9GXaokoYEV7z5yMUBoP4jCHRM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mike Dillinger <miked@softtalker.com>,
        Stefano Brivio <sbrivio@redhat.com>, Phil Sutter <phil@nwl.cc>,
        Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [PATCH 5.7 469/477] netfilter: nft_set_rbtree: Dont account for expired elements on insertion
Date:   Tue, 23 Jun 2020 21:57:46 +0200
Message-Id: <20200623195429.715962046@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200623195407.572062007@linuxfoundation.org>
References: <20200623195407.572062007@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefano Brivio <sbrivio@redhat.com>

commit 33d077996a87175b155fe88030e8fec7ca76327e upstream.

While checking the validity of insertion in __nft_rbtree_insert(),
we currently ignore conflicting elements and intervals only if they
are not active within the next generation.

However, if we consider expired elements and intervals as
potentially conflicting and overlapping, we'll return error for
entries that should be added instead. This is particularly visible
with garbage collection intervals that are comparable with the
element timeout itself, as reported by Mike Dillinger.

Other than the simple issue of denying insertion of valid entries,
this might also result in insertion of a single element (opening or
closing) out of a given interval. With single entries (that are
inserted as intervals of size 1), this leads in turn to the creation
of new intervals. For example:

  # nft add element t s { 192.0.2.1 }
  # nft list ruleset
  [...]
     elements = { 192.0.2.1-255.255.255.255 }

Always ignore expired elements active in the next generation, while
checking for conflicts.

It might be more convenient to introduce a new macro that covers
both inactive and expired items, as this type of check also appears
quite frequently in other set back-ends. This is however beyond the
scope of this fix and can be deferred to a separate patch.

Other than the overlap detection cases introduced by commit
7c84d41416d8 ("netfilter: nft_set_rbtree: Detect partial overlaps
on insertion"), we also have to cover the original conflict check
dealing with conflicts between two intervals of size 1, which was
introduced before support for timeout was introduced. This won't
return an error to the user as -EEXIST is masked by nft if
NLM_F_EXCL is not given, but would result in a silent failure
adding the entry.

Reported-by: Mike Dillinger <miked@softtalker.com>
Cc: <stable@vger.kernel.org> # 5.6.x
Fixes: 8d8540c4f5e0 ("netfilter: nft_set_rbtree: add timeout support")
Fixes: 7c84d41416d8 ("netfilter: nft_set_rbtree: Detect partial overlaps on insertion")
Signed-off-by: Stefano Brivio <sbrivio@redhat.com>
Acked-by: Phil Sutter <phil@nwl.cc>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/netfilter/nft_set_rbtree.c |   21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

--- a/net/netfilter/nft_set_rbtree.c
+++ b/net/netfilter/nft_set_rbtree.c
@@ -271,12 +271,14 @@ static int __nft_rbtree_insert(const str
 
 			if (nft_rbtree_interval_start(new)) {
 				if (nft_rbtree_interval_end(rbe) &&
-				    nft_set_elem_active(&rbe->ext, genmask))
+				    nft_set_elem_active(&rbe->ext, genmask) &&
+				    !nft_set_elem_expired(&rbe->ext))
 					overlap = false;
 			} else {
 				overlap = nft_rbtree_interval_end(rbe) &&
 					  nft_set_elem_active(&rbe->ext,
-							      genmask);
+							      genmask) &&
+					  !nft_set_elem_expired(&rbe->ext);
 			}
 		} else if (d > 0) {
 			p = &parent->rb_right;
@@ -284,9 +286,11 @@ static int __nft_rbtree_insert(const str
 			if (nft_rbtree_interval_end(new)) {
 				overlap = nft_rbtree_interval_end(rbe) &&
 					  nft_set_elem_active(&rbe->ext,
-							      genmask);
+							      genmask) &&
+					  !nft_set_elem_expired(&rbe->ext);
 			} else if (nft_rbtree_interval_end(rbe) &&
-				   nft_set_elem_active(&rbe->ext, genmask)) {
+				   nft_set_elem_active(&rbe->ext, genmask) &&
+				   !nft_set_elem_expired(&rbe->ext)) {
 				overlap = true;
 			}
 		} else {
@@ -294,15 +298,18 @@ static int __nft_rbtree_insert(const str
 			    nft_rbtree_interval_start(new)) {
 				p = &parent->rb_left;
 
-				if (nft_set_elem_active(&rbe->ext, genmask))
+				if (nft_set_elem_active(&rbe->ext, genmask) &&
+				    !nft_set_elem_expired(&rbe->ext))
 					overlap = false;
 			} else if (nft_rbtree_interval_start(rbe) &&
 				   nft_rbtree_interval_end(new)) {
 				p = &parent->rb_right;
 
-				if (nft_set_elem_active(&rbe->ext, genmask))
+				if (nft_set_elem_active(&rbe->ext, genmask) &&
+				    !nft_set_elem_expired(&rbe->ext))
 					overlap = false;
-			} else if (nft_set_elem_active(&rbe->ext, genmask)) {
+			} else if (nft_set_elem_active(&rbe->ext, genmask) &&
+				   !nft_set_elem_expired(&rbe->ext)) {
 				*ext = &rbe->ext;
 				return -EEXIST;
 			} else {


