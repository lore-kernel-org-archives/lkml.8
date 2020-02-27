Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E1DEC3F363
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 13:48:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7213624656
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 13:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582811330;
	bh=Y5SnXWp1oU7iqTSLhVAfbzVeZIBa+qAGHzZ8XluSOMY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rJGg4Ed1QF1lbyNpKpGndEEoxnidkIP4GJS1eh5MpFNt83R6N2WCvUTjPkmS+FP8y
	 bxgbGGafAddvyuyw6CoDrNDziWRbWvnHMlzhyDJwlFEEE9crKyhtQWEScJ9MCabo9H
	 wfVjCuVAEGjKLtXWPPvj86lhsDkAj5W3Qp2OIwXU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730941AbgB0Nst (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 08:48:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:45704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730933AbgB0Nsq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 08:48:46 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BAAC120578;
        Thu, 27 Feb 2020 13:48:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582811326;
        bh=Y5SnXWp1oU7iqTSLhVAfbzVeZIBa+qAGHzZ8XluSOMY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=diA8bjapMy7utrptWzF+hMxAeeR126Ml3ChwBq9pSogK9AHhQSc/C8wDCjwqRSYGh
         v+FdeECiIwd5ERT70+0mvtPqgHboa2dY2X4u3jc2ZWSk4TQhwO6zKx/ucscEC5W9zX
         ePw6E8H98DheOLLdO6/6Uc0BHCp6Tk/+JAtC0Z+Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ezequiel Garcia <ezequiel@collabora.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 050/165] media: v4l2-device.h: Explicitly compare grp{id,mask} to zero in v4l2_device macros
Date:   Thu, 27 Feb 2020 14:35:24 +0100
Message-Id: <20200227132238.552707541@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200227132230.840899170@linuxfoundation.org>
References: <20200227132230.840899170@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nathan Chancellor <natechancellor@gmail.com>

[ Upstream commit afb34781620274236bd9fc9246e22f6963ef5262 ]

When building with Clang + -Wtautological-constant-compare, several of
the ivtv and cx18 drivers warn along the lines of:

 drivers/media/pci/cx18/cx18-driver.c:1005:21: warning: converting the
 result of '<<' to a boolean always evaluates to true
 [-Wtautological-constant-compare]
                         cx18_call_hw(cx, CX18_HW_GPIO_RESET_CTRL,
                                         ^
 drivers/media/pci/cx18/cx18-cards.h:18:37: note: expanded from macro
 'CX18_HW_GPIO_RESET_CTRL'
 #define CX18_HW_GPIO_RESET_CTRL         (1 << 6)
                                           ^
 1 warning generated.

This warning happens because the shift operation is implicitly converted
to a boolean in v4l2_device_mask_call_all before being negated. This can
be solved by just comparing the mask result to 0 explicitly so that
there is no boolean conversion. The ultimate goal is to enable
-Wtautological-compare globally because there are several subwarnings
that would be helpful to have.

For visual consistency and avoidance of these warnings in the future,
all of the implicitly boolean conversions in the v4l2_device macros
are converted to explicit ones as well.

Link: https://github.com/ClangBuiltLinux/linux/issues/752

Reviewed-by: Ezequiel Garcia <ezequiel@collabora.com>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/media/v4l2-device.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/media/v4l2-device.h b/include/media/v4l2-device.h
index 8ffa94009d1a9..76002416cead9 100644
--- a/include/media/v4l2-device.h
+++ b/include/media/v4l2-device.h
@@ -268,7 +268,7 @@ static inline void v4l2_subdev_notify(struct v4l2_subdev *sd,
 		struct v4l2_subdev *__sd;				\
 									\
 		__v4l2_device_call_subdevs_p(v4l2_dev, __sd,		\
-			!(grpid) || __sd->grp_id == (grpid), o, f ,	\
+			(grpid) == 0 || __sd->grp_id == (grpid), o, f ,	\
 			##args);					\
 	} while (0)
 
@@ -280,7 +280,7 @@ static inline void v4l2_subdev_notify(struct v4l2_subdev *sd,
 ({									\
 	struct v4l2_subdev *__sd;					\
 	__v4l2_device_call_subdevs_until_err_p(v4l2_dev, __sd,		\
-			!(grpid) || __sd->grp_id == (grpid), o, f ,	\
+			(grpid) == 0 || __sd->grp_id == (grpid), o, f ,	\
 			##args);					\
 })
 
@@ -294,8 +294,8 @@ static inline void v4l2_subdev_notify(struct v4l2_subdev *sd,
 		struct v4l2_subdev *__sd;				\
 									\
 		__v4l2_device_call_subdevs_p(v4l2_dev, __sd,		\
-			!(grpmsk) || (__sd->grp_id & (grpmsk)), o, f ,	\
-			##args);					\
+			(grpmsk) == 0 || (__sd->grp_id & (grpmsk)), o,	\
+			f , ##args);					\
 	} while (0)
 
 /*
@@ -308,8 +308,8 @@ static inline void v4l2_subdev_notify(struct v4l2_subdev *sd,
 ({									\
 	struct v4l2_subdev *__sd;					\
 	__v4l2_device_call_subdevs_until_err_p(v4l2_dev, __sd,		\
-			!(grpmsk) || (__sd->grp_id & (grpmsk)), o, f ,	\
-			##args);					\
+			(grpmsk) == 0 || (__sd->grp_id & (grpmsk)), o,	\
+			f , ##args);					\
 })
 
 /*
-- 
2.20.1



