Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FFF5C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 09:29:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C91022CA1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 09:29:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597915791;
	bh=jfRmqQXtOm3jQLhGdzHpq2QpxhkScsukKFbXDwwPES8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=U8Nc3ksX8KrRBIfno4O45t4glw2eCka/mearcY9ttF9nYmGl1CO1hxFx/E5IV1tIZ
	 nzR/rMZH3TBAcry5uRhaMoPsloTzzVYiEcJNWmxmcw2NCUs/NBl9SuSM+v3emBg4P6
	 q58lIAgRurdF0eYpSKqV1YDhpxZtezaFZNSOeYTs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728115AbgHTJ3s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 05:29:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:36966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727780AbgHTJ22 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 05:28:28 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 872A32173E;
        Thu, 20 Aug 2020 09:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597915704;
        bh=jfRmqQXtOm3jQLhGdzHpq2QpxhkScsukKFbXDwwPES8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wCAQy8QkYVcojUCCbHmIWBmCyR3n/64GmpBPK/jEbeWqjcSCcNNkQbotqxTXFW2Mf
         zCKzDPCHTO0XWgvyn9UgGfq37oPNX7kUpyWanXoSApmmb0JIvS5mtaSpb7v1Dzgb4A
         GzUSFiWF64lhxdgRN89BFjkftkzU1mMdaV5Qvj74=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 5.8 106/232] gfs2: Fix refcount leak in gfs2_glock_poke
Date:   Thu, 20 Aug 2020 11:19:17 +0200
Message-Id: <20200820091617.956813624@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200820091612.692383444@linuxfoundation.org>
References: <20200820091612.692383444@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andreas Gruenbacher <agruenba@redhat.com>

commit c07bfb4d8fa1ee11c6d18b093d0bb6c8832d3626 upstream.

In gfs2_glock_poke, make sure gfs2_holder_uninit is called on the local
glock holder.  Without that, we're leaking a glock and a pid reference.

Fixes: 9e8990dea926 ("gfs2: Smarter iopen glock waiting")
Cc: stable@vger.kernel.org # v5.8+
Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/gfs2/glock.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/fs/gfs2/glock.c
+++ b/fs/gfs2/glock.c
@@ -790,9 +790,11 @@ static void gfs2_glock_poke(struct gfs2_
 	struct gfs2_holder gh;
 	int error;
 
-	error = gfs2_glock_nq_init(gl, LM_ST_SHARED, flags, &gh);
+	gfs2_holder_init(gl, LM_ST_SHARED, flags, &gh);
+	error = gfs2_glock_nq(&gh);
 	if (!error)
 		gfs2_glock_dq(&gh);
+	gfs2_holder_uninit(&gh);
 }
 
 static bool gfs2_try_evict(struct gfs2_glock *gl)


