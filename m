Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E032C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 09:01:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 012EF212CC
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 09:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585645267;
	bh=i54h0PpoMrZjEXGvANY6FaJbACna+TsoRHILdEn6CI4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XVS3L1SuA9jIgb51o/cwAxauHjnnO+MO2/8EX+u+qWHfyvL9vdJqzcoJiGzl6djtZ
	 RRzERGbsg0tcX8NBv0a5GA70VgV1T4hEMRpPKrT1ex2L0mJXzTCeBlhHSxZ5nBFdGq
	 uUiGiADheeCxH+DyDZMX2vl7sMCj8z/WFslnFWJo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730292AbgCaJBF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 05:01:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:40050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730490AbgCaJBA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 05:01:00 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 099D720848;
        Tue, 31 Mar 2020 09:00:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585645259;
        bh=i54h0PpoMrZjEXGvANY6FaJbACna+TsoRHILdEn6CI4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kac2VdeIeEEZNknqs026yMb/tXtTTYrfDn0lu0G/tY7gB741yRzcZiJL2mXHytMVU
         isKBhUr631iIjJq9/DHOMTmI7KKemYF+4p5gxqURHhdA71rfWj/Uc3FEMyNUr4alk6
         3eD4BHXHJfvnK2GtiHKLHCz8pI0AGDBoOfOyUUoE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Dafna Hirschfeld <dafna.hirschfeld@collabora.com>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: [PATCH 5.6 23/23] media: v4l2-core: fix a use-after-free bug of sd->devnode
Date:   Tue, 31 Mar 2020 10:59:35 +0200
Message-Id: <20200331085317.704628095@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200331085308.098696461@linuxfoundation.org>
References: <20200331085308.098696461@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>

commit 6990570f7e0a6078e11b9c5dc13f4b6e3f49a398 upstream.

sd->devnode is released after calling
v4l2_subdev_release. Therefore it should be set
to NULL so that the subdev won't hold a pointer
to a released object. This fixes a reference
after free bug in function
v4l2_device_unregister_subdev

Fixes: 0e43734d4c46e ("media: v4l2-subdev: add release() internal op")

Cc: stable@vger.kernel.org
Signed-off-by: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
Reviewed-by: Ezequiel Garcia <ezequiel@collabora.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/media/v4l2-core/v4l2-device.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/media/v4l2-core/v4l2-device.c
+++ b/drivers/media/v4l2-core/v4l2-device.c
@@ -179,6 +179,7 @@ static void v4l2_subdev_release(struct v
 
 	if (sd->internal_ops && sd->internal_ops->release)
 		sd->internal_ops->release(sd);
+	sd->devnode = NULL;
 	module_put(owner);
 }
 


