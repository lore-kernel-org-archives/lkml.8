Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31355C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 13:14:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09420208CA
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 13:14:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585055645;
	bh=6s9uy5xzX1sLLBScjhMoyQS+vuc5nqn5RX1vfWZv+xc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lTejmuPsTGamIkS1+5G+sDs4dd8dweWufB2sB/6t0eJ496VAMUV5Nwpf7zm0rl1TW
	 v9nTrlzE7cdhrbEfRuuVSGqei7b7EqzR7QVE7b5B0uTXXrmVtIqTdXJs0S8bZwkbh3
	 surRPOBIOlBW8++IhzitH8KE6La0TZQCsZdeiMq4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727970AbgCXNOE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 09:14:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:60436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727981AbgCXNOA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 09:14:00 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9926420775;
        Tue, 24 Mar 2020 13:13:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585055640;
        bh=6s9uy5xzX1sLLBScjhMoyQS+vuc5nqn5RX1vfWZv+xc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=w0RXHJDcekxxSGfq0UcgYTD1AtISue6agP86AtKbRrbraPEBQGxcJGRi/DKSt+9zN
         PoAjeYHeUcxG0EfpfhtdOEd4C5JC8JD5txyyjj0IxnZQukiO/69LHaZ//5SCh6WJ5h
         vmFvVu1RuBt881T8BVK3VtBWLBZLryiwt3KGfdMQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Qiujun Huang <hqjagain@gmail.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        syzbot+05835159fe322770fe3d@syzkaller.appspotmail.com
Subject: [PATCH 4.19 46/65] drm/lease: fix WARNING in idr_destroy
Date:   Tue, 24 Mar 2020 14:11:07 +0100
Message-Id: <20200324130802.802517861@linuxfoundation.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200324130756.679112147@linuxfoundation.org>
References: <20200324130756.679112147@linuxfoundation.org>
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
@@ -545,10 +545,12 @@ int drm_mode_create_lease_ioctl(struct d
 	}
 
 	DRM_DEBUG_LEASE("Creating lease\n");
+	/* lessee will take the ownership of leases */
 	lessee = drm_lease_create(lessor, &leases);
 
 	if (IS_ERR(lessee)) {
 		ret = PTR_ERR(lessee);
+		idr_destroy(&leases);
 		goto out_leases;
 	}
 
@@ -583,7 +585,6 @@ out_lessee:
 
 out_leases:
 	put_unused_fd(fd);
-	idr_destroy(&leases);
 
 	DRM_DEBUG_LEASE("drm_mode_create_lease_ioctl failed: %d\n", ret);
 	return ret;


