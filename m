Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34F6DC10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 12:51:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0807824692
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 12:51:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583844712;
	bh=kNqg7uePm2vq1Lh6+cc4u5zajUhmI7rnSFTD2vc+6ZA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cW7kYlHO/F0a9B+ZZAP6x1RCDMjCQKLhX4w1tNrFE3CzKJZcr/BZPmVb1vlUyNWHa
	 dTmsxhpilHt7rApDzNL6zwP69yqMIlDsWLtCbvETea3aJahjxieFeMwP3sbpmS/FCr
	 AToQzaOLpHvceLR+tEtU9tW3+oioLRGNtprd9Ouw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728980AbgCJMvu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 08:51:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:57060 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728958AbgCJMvo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 08:51:44 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 92FAC2468E;
        Tue, 10 Mar 2020 12:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583844704;
        bh=kNqg7uePm2vq1Lh6+cc4u5zajUhmI7rnSFTD2vc+6ZA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=piyE8adKoo8PHI0Paz/AE/BslPpljFmyU2J5BYEQ3U5NBgocAsaU2nOETobQRvmrp
         Hu+06ZG4MMAKJM9kwsI0EG8ZN4vQazHRKIsVBzHGP8lnZyP+P4HcujEMwSZw1O935Z
         86LzN0oPA/aEV4ZNpsT7xWc4ppNjyHJKao3bgD0s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nicolas Dufresne <nicolas@ndufresne.ca>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: [PATCH 5.4 088/168] media: hantro: Fix broken media controller links
Date:   Tue, 10 Mar 2020 13:38:54 +0100
Message-Id: <20200310123644.175528961@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200310123635.322799692@linuxfoundation.org>
References: <20200310123635.322799692@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ezequiel Garcia <ezequiel@collabora.com>

commit d171c45da874e3858a83e6377e00280a507fe2f2 upstream.

The driver currently creates a broken topology,
with a source-to-source link and a sink-to-sink
link instead of two source-to-sink links.

Reported-by: Nicolas Dufresne <nicolas@ndufresne.ca>
Cc: <stable@vger.kernel.org>      # for v5.3 and up
Signed-off-by: Ezequiel Garcia <ezequiel@collabora.com>
Tested-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/staging/media/hantro/hantro_drv.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/staging/media/hantro/hantro_drv.c
+++ b/drivers/staging/media/hantro/hantro_drv.c
@@ -553,13 +553,13 @@ static int hantro_attach_func(struct han
 		goto err_rel_entity1;
 
 	/* Connect the three entities */
-	ret = media_create_pad_link(&func->vdev.entity, 0, &func->proc, 1,
+	ret = media_create_pad_link(&func->vdev.entity, 0, &func->proc, 0,
 				    MEDIA_LNK_FL_IMMUTABLE |
 				    MEDIA_LNK_FL_ENABLED);
 	if (ret)
 		goto err_rel_entity2;
 
-	ret = media_create_pad_link(&func->proc, 0, &func->sink, 0,
+	ret = media_create_pad_link(&func->proc, 1, &func->sink, 0,
 				    MEDIA_LNK_FL_IMMUTABLE |
 				    MEDIA_LNK_FL_ENABLED);
 	if (ret)


