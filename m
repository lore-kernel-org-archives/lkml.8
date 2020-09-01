Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 105B0C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 17:13:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CAAE7206FA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 17:13:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598980383;
	bh=jJ9s4BRQTppGhHlywkzlUypq+zFkvImt/Sm5IUwmriI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EVb5cKhTlq5gHIIP1Zui1zxdvKgBtCxMAG+h7xDYQa2yQPSQWO2r34wVPhJZf5Igt
	 GjmUvpJekswNpVLUBHhe3rRa3GTCnU8HxUdflWkR57PVkk3Xcr0N8VItpOd/vejr5m
	 AAIl200kifW9c+tKl77/AYgWPS4R0ndF5fdTKqdw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732434AbgIARNC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 13:13:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:59866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728764AbgIAPPj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 11:15:39 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8565920767;
        Tue,  1 Sep 2020 15:15:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598973339;
        bh=jJ9s4BRQTppGhHlywkzlUypq+zFkvImt/Sm5IUwmriI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1ckGz+uiaFWYMRJQIGIMVmvtkv8KCsEHhPjo3HrHIcoX5qFRnxf8TNdzlO8hl37/x
         lD9eRbB/o9DdRdOSza2dcxDlqFnUIdTO+vYs9Z53ZJAVUp2d18+cFKyDb/1o4TvUDz
         zsSfraY8jSUula6qRMDZekSMJIvR9H4cFleaDV+Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Felipe Balbi <balbi@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 40/78] usb: gadget: f_tcm: Fix some resource leaks in some error paths
Date:   Tue,  1 Sep 2020 17:10:16 +0200
Message-Id: <20200901150926.740293283@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200901150924.680106554@linuxfoundation.org>
References: <20200901150924.680106554@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

[ Upstream commit 07c8434150f4eb0b65cae288721c8af1080fde17 ]

If a memory allocation fails within a 'usb_ep_alloc_request()' call, the
already allocated memory must be released.

Fix a mix-up in the code and free the correct requests.

Fixes: c52661d60f63 ("usb-gadget: Initial merge of target module for UASP + BOT")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Signed-off-by: Felipe Balbi <balbi@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/gadget/function/f_tcm.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/gadget/function/f_tcm.c b/drivers/usb/gadget/function/f_tcm.c
index d2351139342f6..7e8e262b36297 100644
--- a/drivers/usb/gadget/function/f_tcm.c
+++ b/drivers/usb/gadget/function/f_tcm.c
@@ -751,12 +751,13 @@ static int uasp_alloc_stream_res(struct f_uas *fu, struct uas_stream *stream)
 		goto err_sts;
 
 	return 0;
+
 err_sts:
-	usb_ep_free_request(fu->ep_status, stream->req_status);
-	stream->req_status = NULL;
-err_out:
 	usb_ep_free_request(fu->ep_out, stream->req_out);
 	stream->req_out = NULL;
+err_out:
+	usb_ep_free_request(fu->ep_in, stream->req_in);
+	stream->req_in = NULL;
 out:
 	return -ENOMEM;
 }
-- 
2.25.1



