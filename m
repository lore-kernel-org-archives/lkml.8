Return-Path: <SRS0=AKQz=7N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E14DDC433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 31 May 2020 04:30:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B551207D5
	for <linux-kernel@archiver.kernel.org>; Sun, 31 May 2020 04:30:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="kHJIg/vi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726092AbgEaEaC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 May 2020 00:30:02 -0400
Received: from mail-m964.mail.126.com ([123.126.96.4]:58912 "EHLO
        mail-m964.mail.126.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbgEaEaB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 May 2020 00:30:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=3aTYp+At4YUYmBmcKf
        Jj9YLNBYbqxi0Yc5VNogOYKZk=; b=kHJIg/vil8k20ClBc9Lfw6q/+wtneCIGCA
        SukvR+0RbpoJbI7utYt7096T1vIw1/sIPluVqN7WaVWTCsyZYOfRa2TRwPU5sh5I
        iOeeRarmyW3kWKliJtk+SG0D4Gb091l7ur2rJwLoJbyzUs+sLcnVfMb5X0MUGcKG
        jIgAR33oQ=
Received: from localhost.localdomain (unknown [122.194.9.250])
        by smtp9 (Coremail) with SMTP id NeRpCgBnypPFMtNeL+F_QA--.1465S3;
        Sun, 31 May 2020 12:29:58 +0800 (CST)
From:   chenxb_99091@126.com
To:     stable@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, chenxb_99091@126.com
Subject: Stable backport request for linux-4.4.y
Date:   Sun, 31 May 2020 12:29:55 +0800
Message-Id: <1590899395-26674-1-git-send-email-chenxb_99091@126.com>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: NeRpCgBnypPFMtNeL+F_QA--.1465S3
X-Coremail-Antispam: 1Uf129KBjvdXoWrury3XFy7tr1kWF4rCw47twb_yoWxtFcEkr
        47Wwn8GrW7Jr4Iq3WUtr4fZF1Fgw4rtrWrJrsYv39xWrykZr4fZw4akasavr1qv3W0yF1k
        ur10qan5WrWftjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU8LL0UUUUUU==
X-Originating-IP: [122.194.9.250]
X-CM-SenderInfo: hfkh05lebzmiizr6ij2wof0z/1tbiVwY1xVpEAXSp2wAAs4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xuebing Chen <chenxb_99091@126.com>

In linux-4.4.y,the <include/drm/drm_crtc.h> provides drm_for_each_plane_mask macro 
and plane_mask is defined as bitmask of plane indices, such as
1 << drm_plane_index(plane). There is an error setting of plane_mask
in pan_display_atomic() function.

Please backport the following patch to the 4.4.y kernel stable tree:
commit 7118fd9bd975a9f3093239d4c0f4e15356b57fab 
("drm/fb-helper: Use proper plane mask for fb cleanup")
The above patch fixes error setting of plane_mask in pan_display_atomic() function.
    
Cc: stable@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Xuebing Chen <chenxb_99091@126.com>









