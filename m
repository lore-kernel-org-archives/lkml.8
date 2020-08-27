Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55AA6C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 07:22:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25A2622BF3
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 07:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598512920;
	bh=H3y7qjiYnJpGieeDPWxLXnVnRPSvd+5g87Fza6AoFbU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wsE23tBjyjQx0ZIDzYvDNU8mryfrhjQpzoeOOTcCajDnVxx9mGfnaUzuJMylFMWoM
	 MbWk6hyK2bpZ1JHh+ZNqHyuev/7IM4KmmCR26hEUTBpZnCp9O3QXQuI5W66epU6AI7
	 ZzIQGa/jiTyHrAHgRxXiNGmOdg7/yKFtgYrz4VNM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728121AbgH0HV6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 03:21:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:55624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728093AbgH0HVx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 03:21:53 -0400
Received: from mail.kernel.org (ip5f5ad5a8.dynamic.kabel-deutschland.de [95.90.213.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 47CD122BF5;
        Thu, 27 Aug 2020 07:21:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598512912;
        bh=H3y7qjiYnJpGieeDPWxLXnVnRPSvd+5g87Fza6AoFbU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qyvKzfakNhz9rTVHTvaYVpFbSpcn/2m8ta4nSmheSbh2NwwPbNPfOe50qrPMut3uu
         imiN/TD9BxHM4clpKO0bzg4A9me2hb4RQkjjuk+jwUzJPqbj0es2uCB0OWuiabfn9c
         O0bW9sVCO64p2moM9Np5EyiC3nV+68YyrXfd2bbo=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kBCEI-002s5H-AA; Thu, 27 Aug 2020 09:21:50 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        linux-media@vger.kernel.org
Subject: [PATCH v10 2/4] media: open.rst: remove the minor number range
Date:   Thu, 27 Aug 2020 09:21:46 +0200
Message-Id: <d4a4dd87d7331895dcd8b9afcb2b48a3bae5b5f9.1598512802.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1598512802.git.mchehab+huawei@kernel.org>
References: <cover.1598512802.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

minor numbers use to range between 0 to 255, but that
was changed a long time ago. While it still applies when
CONFIG_VIDEO_FIXED_MINOR_RANGES, when the minor number is
dynamically allocated, this may not be true. In any case,
this is not relevant, as udev will take care of it.

So, remove this useless misinformation.

Acked-by: Hans Verkuil <hans.verkuil@cisco.com>
Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/userspace-api/media/v4l/open.rst | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/Documentation/userspace-api/media/v4l/open.rst b/Documentation/userspace-api/media/v4l/open.rst
index 332763053292..b9367e02b884 100644
--- a/Documentation/userspace-api/media/v4l/open.rst
+++ b/Documentation/userspace-api/media/v4l/open.rst
@@ -26,11 +26,10 @@ helper functions and a common application interface specified in this
 document.
 
 Each driver thus loaded registers one or more device nodes with major
-number 81 and a minor number between 0 and 255. Minor numbers are
-allocated dynamically unless the kernel is compiled with the kernel
-option CONFIG_VIDEO_FIXED_MINOR_RANGES. In that case minor numbers
-are allocated in ranges depending on the device node type (video, radio,
-etc.).
+number 81. Minor numbers are allocated dynamically unless the kernel
+is compiled with the kernel option CONFIG_VIDEO_FIXED_MINOR_RANGES.
+In that case minor numbers are allocated in ranges depending on the
+device node type.
 
 The device nodes supported by the Video4Linux subsystem are:
 
-- 
2.26.2

