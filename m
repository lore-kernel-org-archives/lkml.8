Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AC1AC2BAEE
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 13:20:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 358C3208CA
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 13:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585056022;
	bh=3xW+pscrqJeC5q3xuuLfk72SfIQsKV4XoV/9Yx9ilGo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0GUQdhTmOoT/ita6/on8GaJq7D97vdLUhm4mC5lmeejg+2XstoJlLC36uV9wKo3Ef
	 trlSZM4phx9+XLR2mYs8R5iWGytpy+ed84yBr77gfOO4ljp6qrh+y3mK+DYp4t1J4b
	 IKHlhNF3XGR5YlzTZyH4TY8ILCz2CNYIuPAOrafg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728926AbgCXNUV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 09:20:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:41478 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728916AbgCXNUQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 09:20:16 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0E18F20775;
        Tue, 24 Mar 2020 13:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585056016;
        bh=3xW+pscrqJeC5q3xuuLfk72SfIQsKV4XoV/9Yx9ilGo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qOmwJc+Nkm6AeMTtXQBN1BeXTsNngWqGWoFCINjrXqdy3pu19BrP3FBKzY8D/V+je
         bTAoVYv85glfYC3SCt5b8lJdiNiyavXhd+KR3JtFjvkj/g4DV8kx3OJcF3JkcERCB5
         SAWk4PHKQjjI0Ej7RFMnSDRvcKHPsYCPo2rVh7B0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Qiujun Huang <hqjagain@gmail.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        syzbot+05835159fe322770fe3d@syzkaller.appspotmail.com
Subject: [PATCH 5.4 082/102] drm/lease: fix WARNING in idr_destroy
Date:   Tue, 24 Mar 2020 14:11:14 +0100
Message-Id: <20200324130814.847513002@linuxfoundation.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200324130806.544601211@linuxfoundation.org>
References: <20200324130806.544601211@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qiujun Huang <hqjagain@gmail.com>

commit b216a8e7908cd750550c0480cf7d2b3a37f06954 upstream.

drm_lease_create takes ownership of leases. And leases will be released
by drm_master_put.

drm_master_put
    ->drm_master_destroy
            ->idr_destroy

So we needn't call idr_destroy again.

Reported-and-tested-by: syzbot+05835159fe322770fe3d@syzkaller.appspotmail.com
Signed-off-by: Qiujun Huang <hqjagain@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Link: https://patchwork.freedesktop.org/patch/msgid/1584518030-4173-1-git-send-email-hqjagain@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/drm_lease.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/gpu/drm/drm_lease.c
+++ b/drivers/gpu/drm/drm_lease.c
@@ -542,10 +542,12 @@ int drm_mode_create_lease_ioctl(struct d
 	}
 
 	DRM_DEBUG_LEASE("Creating lease\n");
+	/* lessee will take the ownership of leases */
 	lessee = drm_lease_create(lessor, &leases);
 
 	if (IS_ERR(lessee)) {
 		ret = PTR_ERR(lessee);
+		idr_destroy(&leases);
 		goto out_leases;
 	}
 
@@ -580,7 +582,6 @@ out_lessee:
 
 out_leases:
 	put_unused_fd(fd);
-	idr_destroy(&leases);
 
 	DRM_DEBUG_LEASE("drm_mode_create_lease_ioctl failed: %d\n", ret);
 	return ret;


