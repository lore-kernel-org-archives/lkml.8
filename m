Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1934AC33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 23:25:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEE292087E
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 23:25:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579217119;
	bh=m8xS/QdXqDzMIWCYpmKHpbVJ73ewjXOb5tJMfMZoxEI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HWeAzw/6wahG63jPt8RiRs26tFPBsrHrZMxxXA5lTd8Dc0d8B+rtv3P3o6+50PSoO
	 JiD8/p2kIaOxnK6MJByS75Yk6Ivd+TLthTfy+VM36EmTIo+WDHxY/wJVENBMs6Fbc6
	 uzE2ibfL7skPgTWR21vkf+Qc6Vx8Z+GABzQWqpTY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387899AbgAPXZS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 18:25:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:54534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729946AbgAPXZG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 18:25:06 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2F6B22075B;
        Thu, 16 Jan 2020 23:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579217105;
        bh=m8xS/QdXqDzMIWCYpmKHpbVJ73ewjXOb5tJMfMZoxEI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cMPq7UJ24ApHpcc0QY5lT9iFVROdYZYYyTHoSorUL3K9L2jQT2rL5ImHJJhN1jSJ6
         OusxBWdT3VrnVIzbZVW5M9G6jjBR4tPGCbzmJBvph7v50hAOFCa5CIAK3XEkMd2Nu8
         gbr+efKwZVv0D+hFgtcvHzlrJodPtoLEDmL8+jRc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: [PATCH 5.4 150/203] media: rcar-vin: Fix incorrect return statement in rvin_try_format()
Date:   Fri, 17 Jan 2020 00:17:47 +0100
Message-Id: <20200116231758.004486179@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200116231745.218684830@linuxfoundation.org>
References: <20200116231745.218684830@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>

commit a0862a40364e2f87109317e31c51c9d7bc89e33f upstream.

While refactoring code the return statement became corrupted, fix it by
returning the correct return code.

Reported-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Fixes: 897e371389e77514 ("media: rcar-vin: simplify how formats are set and reset"
Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reviewed-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/media/platform/rcar-vin/rcar-v4l2.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/media/platform/rcar-vin/rcar-v4l2.c
+++ b/drivers/media/platform/rcar-vin/rcar-v4l2.c
@@ -208,6 +208,7 @@ static int rvin_try_format(struct rvin_d
 	ret = v4l2_subdev_call(sd, pad, set_fmt, pad_cfg, &format);
 	if (ret < 0 && ret != -ENOIOCTLCMD)
 		goto done;
+	ret = 0;
 
 	v4l2_fill_pix_format(pix, &format.format);
 
@@ -242,7 +243,7 @@ static int rvin_try_format(struct rvin_d
 done:
 	v4l2_subdev_free_pad_config(pad_cfg);
 
-	return 0;
+	return ret;
 }
 
 static int rvin_querycap(struct file *file, void *priv,


