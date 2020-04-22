Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB245C5518C
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:36:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FAA420656
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:36:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587551786;
	bh=VEd9/hHSI2LM9QifGfHozkesULLQcwBlXWnlKyhmCus=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=L6cNPDV5v9E8UHGRHsG7DvbLBl6gL/zIsEigHd08Mv8/b1FZplXli60R4WX/8ufqq
	 z8nB3BgJi6MlpIsmqQN8QanzHudPP6IyCMBx1SKH79+jgs9Gluk+IkJf8HH7Cie4Zf
	 EYmVeO8Jym/Z2w12sABbAfujoXQEM/vYwZZbXNZo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730060AbgDVKXD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 06:23:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:57960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729431AbgDVKVe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 06:21:34 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6FE5720781;
        Wed, 22 Apr 2020 10:21:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587550893;
        bh=VEd9/hHSI2LM9QifGfHozkesULLQcwBlXWnlKyhmCus=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ncn9ducF6fPJAF3x0VeLd5UMjoKSBd9IDj7keIeZVmbNeN9g7VwM1AjEETi6zWQLV
         zAFC29NPTuYnIH1RmbZzcivRyVDNUP21uBQje68a1hPwR3Vxj13MjarliKggAs9Xw8
         kX+epsPsJqNPQUa1//5eg5JAvdrwblkDc9PQ5pcE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ilya Dryomov <idryomov@gmail.com>,
        Jason Dillaman <dillaman@redhat.com>
Subject: [PATCH 5.6 018/166] rbd: dont test rbd_dev->opts in rbd_dev_image_release()
Date:   Wed, 22 Apr 2020 11:55:45 +0200
Message-Id: <20200422095050.379977098@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200422095047.669225321@linuxfoundation.org>
References: <20200422095047.669225321@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ilya Dryomov <idryomov@gmail.com>

commit b8776051529230f76e464d5ffc5d1cf8465576bf upstream.

rbd_dev->opts is used to distinguish between the image that is being
mapped and a parent.  However, because we no longer establish watch for
read-only mappings, this test is imprecise and results in unnecessary
rbd_unregister_watch() calls.

Make it consistent with need_watch in rbd_dev_image_probe().

Fixes: b9ef2b8858a0 ("rbd: don't establish watch for read-only mappings")
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
Reviewed-by: Jason Dillaman <dillaman@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/block/rbd.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -6955,7 +6955,7 @@ static void rbd_print_dne(struct rbd_dev
 
 static void rbd_dev_image_release(struct rbd_device *rbd_dev)
 {
-	if (rbd_dev->opts)
+	if (!rbd_is_ro(rbd_dev))
 		rbd_unregister_watch(rbd_dev);
 
 	rbd_dev_unprobe(rbd_dev);


