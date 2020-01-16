Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6401C33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 23:33:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AF9E20684
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 23:33:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579217621;
	bh=J2Uu6xeW8tRMtlFYFag5dwkPExafMGRmGM8omqTSyzI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jywapWFj5ln5XWNxuJFn2w+zZ1NCZ1pulTf5dbBPLR2nlIGvBgnz596s3ymIkE9uX
	 2ckxEsxL18qc+V40CpLUQL1Mfxews09hueqJBjg24/gJzUQxEaFOYzz7ywCbOoEpto
	 XxzxfycAWCGbetvdzVwjq2Hr9OG/z4Pw53zGPsOE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404114AbgAPXdk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 18:33:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:44242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404393AbgAPXdh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 18:33:37 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 003E120748;
        Thu, 16 Jan 2020 23:33:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579217617;
        bh=J2Uu6xeW8tRMtlFYFag5dwkPExafMGRmGM8omqTSyzI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KJjQdDs571NGj45gt3hTMsPQ8LRXF+EPdWUAOQPXbk/bs/gEGNLu3C0XJ6OZuDbE2
         RZ6Sn4ltcvkdalQn5+Ll5x6VYv/05cwR/59tnyYxaH9TZsZwStfWnB0GL0wlfWVjMp
         pU6Q7WmXnE73xmhgcjNv3GwQCfDNm+ynAMDzgndQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Seung-Woo Kim <sw0312.kim@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: [PATCH 4.14 55/71] media: exynos4-is: Fix recursive locking in isp_video_release()
Date:   Fri, 17 Jan 2020 00:18:53 +0100
Message-Id: <20200116231717.159884178@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200116231709.377772748@linuxfoundation.org>
References: <20200116231709.377772748@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Seung-Woo Kim <sw0312.kim@samsung.com>

commit 704c6c80fb471d1bb0ef0d61a94617d1d55743cd upstream.

>From isp_video_release(), &isp->video_lock is held and subsequent
vb2_fop_release() tries to lock vdev->lock which is same with the
previous one. Replace vb2_fop_release() with _vb2_fop_release() to
fix the recursive locking.

Fixes: 1380f5754cb0 ("[media] videobuf2: Add missing lock held on vb2_fop_release")
Signed-off-by: Seung-Woo Kim <sw0312.kim@samsung.com>
Reviewed-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/media/platform/exynos4-is/fimc-isp-video.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/media/platform/exynos4-is/fimc-isp-video.c
+++ b/drivers/media/platform/exynos4-is/fimc-isp-video.c
@@ -316,7 +316,7 @@ static int isp_video_release(struct file
 		ivc->streaming = 0;
 	}
 
-	vb2_fop_release(file);
+	_vb2_fop_release(file, NULL);
 
 	if (v4l2_fh_is_singular_file(file)) {
 		fimc_pipeline_call(&ivc->ve, close);


