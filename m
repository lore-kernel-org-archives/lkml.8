Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39296C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 18:11:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1ABD1206E2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 18:11:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591035082;
	bh=/ueERacqKCvBCeDX7uFQVBAHO7WaNeHHjAAedKNnKy0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=loJkqK1U1TvHn9TOPjbbhuzi3uRikA1o5pu+48UynbjqlrMB7pf2FdlMF/Iqys58v
	 tzonHrGeNtQm9jol8rj59eahGUG+bGqiIH6+VHmyrN76uPCCiHKMLYUiSe2R61oxA+
	 2MIXK12QZdBqYJm7duGz4JTPdqK/H55SUBPWVOT0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730625AbgFASLU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 14:11:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:58112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730157AbgFASLD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 14:11:03 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F01872065C;
        Mon,  1 Jun 2020 18:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591035062;
        bh=/ueERacqKCvBCeDX7uFQVBAHO7WaNeHHjAAedKNnKy0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NHfp623QL68eCP9ZvpVcRmERESZnIj+En0Z/SmfaLme8udD8q9+tq4s1EqsdN1qS0
         ENSklH2IdBw1LUoe7eNP9xnNr3ycS0Ca7PWp7ixHpwB20j3Ig3lCvrBky9hy3icBIn
         nmaCBtuyVqzxqyuUXlxgiubF9XtGaxbWkx9rBMTc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Ahern <dsahern@gmail.com>,
        Nikolay Aleksandrov <nikolay@cumulusnetworks.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.4 134/142] nexthop: Expand nexthop_is_multipath in a few places
Date:   Mon,  1 Jun 2020 19:54:52 +0200
Message-Id: <20200601174051.606199324@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200601174037.904070960@linuxfoundation.org>
References: <20200601174037.904070960@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Ahern <dsahern@gmail.com>

commit 0b5e2e39739e861fa5fc84ab27a35dbe62a15330 upstream.

I got too fancy consolidating checks on multipath type. The result
is that path lookups can access 2 different nh_grp structs as exposed
by Nik's torture tests. Expand nexthop_is_multipath within nexthop.h to
avoid multiple, nh_grp dereferences and make decisions based on the
consistent struct.

Only 2 places left using nexthop_is_multipath are within IPv6, both
only check that the nexthop is a multipath for a branching decision
which are acceptable.

Fixes: 430a049190de ("nexthop: Add support for nexthop groups")
Signed-off-by: David Ahern <dsahern@gmail.com>
Acked-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/net/nexthop.h |   41 +++++++++++++++++++++++++----------------
 1 file changed, 25 insertions(+), 16 deletions(-)

--- a/include/net/nexthop.h
+++ b/include/net/nexthop.h
@@ -137,21 +137,20 @@ static inline unsigned int nexthop_num_p
 {
 	unsigned int rc = 1;
 
-	if (nexthop_is_multipath(nh)) {
+	if (nh->is_group) {
 		struct nh_group *nh_grp;
 
 		nh_grp = rcu_dereference_rtnl(nh->nh_grp);
-		rc = nh_grp->num_nh;
+		if (nh_grp->mpath)
+			rc = nh_grp->num_nh;
 	}
 
 	return rc;
 }
 
 static inline
-struct nexthop *nexthop_mpath_select(const struct nexthop *nh, int nhsel)
+struct nexthop *nexthop_mpath_select(const struct nh_group *nhg, int nhsel)
 {
-	const struct nh_group *nhg = rcu_dereference_rtnl(nh->nh_grp);
-
 	/* for_nexthops macros in fib_semantics.c grabs a pointer to
 	 * the nexthop before checking nhsel
 	 */
@@ -186,12 +185,14 @@ static inline bool nexthop_is_blackhole(
 {
 	const struct nh_info *nhi;
 
-	if (nexthop_is_multipath(nh)) {
-		if (nexthop_num_path(nh) > 1)
-			return false;
-		nh = nexthop_mpath_select(nh, 0);
-		if (!nh)
+	if (nh->is_group) {
+		struct nh_group *nh_grp;
+
+		nh_grp = rcu_dereference_rtnl(nh->nh_grp);
+		if (nh_grp->num_nh > 1)
 			return false;
+
+		nh = nh_grp->nh_entries[0].nh;
 	}
 
 	nhi = rcu_dereference_rtnl(nh->nh_info);
@@ -217,10 +218,15 @@ struct fib_nh_common *nexthop_fib_nhc(st
 	BUILD_BUG_ON(offsetof(struct fib_nh, nh_common) != 0);
 	BUILD_BUG_ON(offsetof(struct fib6_nh, nh_common) != 0);
 
-	if (nexthop_is_multipath(nh)) {
-		nh = nexthop_mpath_select(nh, nhsel);
-		if (!nh)
-			return NULL;
+	if (nh->is_group) {
+		struct nh_group *nh_grp;
+
+		nh_grp = rcu_dereference_rtnl(nh->nh_grp);
+		if (nh_grp->mpath) {
+			nh = nexthop_mpath_select(nh_grp, nhsel);
+			if (!nh)
+				return NULL;
+		}
 	}
 
 	nhi = rcu_dereference_rtnl(nh->nh_info);
@@ -264,8 +270,11 @@ static inline struct fib6_nh *nexthop_fi
 {
 	struct nh_info *nhi;
 
-	if (nexthop_is_multipath(nh)) {
-		nh = nexthop_mpath_select(nh, 0);
+	if (nh->is_group) {
+		struct nh_group *nh_grp;
+
+		nh_grp = rcu_dereference_rtnl(nh->nh_grp);
+		nh = nexthop_mpath_select(nh_grp, 0);
 		if (!nh)
 			return NULL;
 	}


