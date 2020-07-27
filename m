Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F3B6C433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 14:35:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33DBD21883
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 14:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595860517;
	bh=9fi20TPI1MFfdKm2wcuihBn1I4F7kSBAr/fE6EhADck=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YHSJXpwJmiRoFi164e18VC89GnipnqxPglWp4OIdPv0H4PmxmMIn+WxagniBJ6mJI
	 HSTOiQoXHKi53kMxnZc9KnwBL26OBLwehTB5571yT1tsMOIa5A4+PE9EZMTeFeqGm2
	 JoyBuorSZjgoFzW41FB6KeqVEdlCKgcpjiUJRrBk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730700AbgG0OfP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 10:35:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:41658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730690AbgG0OPU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 10:15:20 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C639D2078E;
        Mon, 27 Jul 2020 14:15:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595859320;
        bh=9fi20TPI1MFfdKm2wcuihBn1I4F7kSBAr/fE6EhADck=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=byHQNdf6U/Cm8zEYBp0gT8eoyYv7ufm5K1T3rBg/twoB6xaPTULWkIiOvcOSNpc7x
         CqMbPlr8qS87kG7waO02CL2zaxEjE1NK+k4eVxYV3axIE4lov0cRV1NWpWMDTCI+7T
         ASzWyYoOCzam1U2V9pwDDTdepFdStEk8hN23ZgGo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, NeilBrown <neilb@suse.de>,
        "J. Bruce Fields" <bfields@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 062/138] nfsd4: fix NULL dereference in nfsd/clients display code
Date:   Mon, 27 Jul 2020 16:04:17 +0200
Message-Id: <20200727134928.512290568@linuxfoundation.org>
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

From: J. Bruce Fields <bfields@redhat.com>

[ Upstream commit 9affa435817711861d774f5626c393c80f16d044 ]

We hold the cl_lock here, and that's enough to keep stateid's from going
away, but it's not enough to prevent the files they point to from going
away.  Take fi_lock and a reference and check for NULL, as we do in
other code.

Reported-by: NeilBrown <neilb@suse.de>
Fixes: 78599c42ae3c ("nfsd4: add file to display list of client's opens")
Reviewed-by: NeilBrown <neilb@suse.de>
Signed-off-by: J. Bruce Fields <bfields@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfsd/nfs4state.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 9af9b673f2923..68cf116607645 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -506,6 +506,17 @@ find_any_file(struct nfs4_file *f)
 	return ret;
 }
 
+static struct nfsd_file *find_deleg_file(struct nfs4_file *f)
+{
+	struct nfsd_file *ret = NULL;
+
+	spin_lock(&f->fi_lock);
+	if (f->fi_deleg_file)
+		ret = nfsd_file_get(f->fi_deleg_file);
+	spin_unlock(&f->fi_lock);
+	return ret;
+}
+
 static atomic_long_t num_delegations;
 unsigned long max_delegations;
 
@@ -2378,6 +2389,8 @@ static int nfs4_show_open(struct seq_file *s, struct nfs4_stid *st)
 	oo = ols->st_stateowner;
 	nf = st->sc_file;
 	file = find_any_file(nf);
+	if (!file)
+		return 0;
 
 	seq_printf(s, "- 0x%16phN: { type: open, ", &st->sc_stateid);
 
@@ -2411,6 +2424,8 @@ static int nfs4_show_lock(struct seq_file *s, struct nfs4_stid *st)
 	oo = ols->st_stateowner;
 	nf = st->sc_file;
 	file = find_any_file(nf);
+	if (!file)
+		return 0;
 
 	seq_printf(s, "- 0x%16phN: { type: lock, ", &st->sc_stateid);
 
@@ -2439,7 +2454,9 @@ static int nfs4_show_deleg(struct seq_file *s, struct nfs4_stid *st)
 
 	ds = delegstateid(st);
 	nf = st->sc_file;
-	file = nf->fi_deleg_file;
+	file = find_deleg_file(nf);
+	if (!file)
+		return 0;
 
 	seq_printf(s, "- 0x%16phN: { type: deleg, ", &st->sc_stateid);
 
@@ -2451,6 +2468,7 @@ static int nfs4_show_deleg(struct seq_file *s, struct nfs4_stid *st)
 
 	nfs4_show_superblock(s, file);
 	seq_printf(s, " }\n");
+	nfsd_file_put(file);
 
 	return 0;
 }
-- 
2.25.1



