Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49FEDC433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 17:15:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0EEAA20732
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 17:15:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599585316;
	bh=fy6yFgsQnKEq5JeOEazG6HyDQXit/TLSbvWOcO0SZDg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Ufp/f7wZuS07dVDj5jWHclDBpgTC5Ocj1U7AiQaOFWOPGsRxNt1yk5bYg33wNXtAS
	 ZlG6FczV8wRjDHf/fj7thaJbQelrQ6FOObz6a7HYIcvFxeHw7KOQz2eSYdZFuH9ZjW
	 TpBkyyuglzcgJ1OooLekFHIoaohZ0jvBLSMI6ym4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731962AbgIHRPG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 13:15:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:57642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731784AbgIHQS6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 12:18:58 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EA5862483E;
        Tue,  8 Sep 2020 15:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599579900;
        bh=fy6yFgsQnKEq5JeOEazG6HyDQXit/TLSbvWOcO0SZDg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dGvdkBtPLLyRyzMrpTM9MgE2TC2/c3EU2KCC0BcJ3xGw73P4sRviY9mubu/o/+SKL
         jr+BW1ik3Jjr2t/tN+PK7waqVrpvoxutwAF32xPlt8/hOXZVRev0Mf8cOKCHMhoFvm
         WSXvF0h54IGAiBU72MxRkoEzcDup4BxWDAhAoWZg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 049/129] media: vicodec: add missing v4l2_ctrl_request_hdl_put()
Date:   Tue,  8 Sep 2020 17:24:50 +0200
Message-Id: <20200908152232.163255138@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200908152229.689878733@linuxfoundation.org>
References: <20200908152229.689878733@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hans Verkuil <hverkuil-cisco@xs4all.nl>

[ Upstream commit 2e7c8fb8942773f412fe12f3b63e8bb92c18ab3f ]

The check for a required control in the request was missing a call to
v4l2_ctrl_request_hdl_put(), so the control request object was never
released.

Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Fixes: 997deb811bf5 ("media: vicodec: Add support for stateless decoder.")
Reviewed-by: Ezequiel Garcia <ezequiel@collabora.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/vicodec/vicodec-core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/platform/vicodec/vicodec-core.c b/drivers/media/platform/vicodec/vicodec-core.c
index 84ec36156f73f..c77281d43f892 100644
--- a/drivers/media/platform/vicodec/vicodec-core.c
+++ b/drivers/media/platform/vicodec/vicodec-core.c
@@ -2052,6 +2052,7 @@ static int vicodec_request_validate(struct media_request *req)
 	}
 	ctrl = v4l2_ctrl_request_hdl_ctrl_find(hdl,
 					       vicodec_ctrl_stateless_state.id);
+	v4l2_ctrl_request_hdl_put(hdl);
 	if (!ctrl) {
 		v4l2_info(&ctx->dev->v4l2_dev,
 			  "Missing required codec control\n");
-- 
2.25.1



