Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E945EC2BA2B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 11:51:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6B8D206F7
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 11:51:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726203AbgDJLv0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Apr 2020 07:51:26 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:49030 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725913AbgDJLvZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 07:51:25 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: ezequiel)
        with ESMTPSA id 480D12A0E46
From:   Ezequiel Garcia <ezequiel@collabora.com>
To:     linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Tomasz Figa <tfiga@chromium.org>, kernel@collabora.com,
        Jonas Karlman <jonas@kwiboo.se>,
        Heiko Stuebner <heiko@sntech.de>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Alexandre Courbot <acourbot@chromium.org>,
        Jeffrey Kardatzke <jkardatzke@chromium.org>,
        Ezequiel Garcia <ezequiel@collabora.com>
Subject: [PATCH v2 0/3] media: rkvdec: Add a VP9 backend
Date:   Fri, 10 Apr 2020 08:51:10 -0300
Message-Id: <20200410115113.31728-1-ezequiel@collabora.com>
X-Mailer: git-send-email 2.26.0.rc2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Second iteration of the VP9 stateless codec uAPI, plus
support for Rockchip VDEC.

This is mostly identical to first iteration, as you can see,
the changelog is quite minimal.

Feedback and testing welcome!

Thanks,
Ezequiel

Changelog
---------

v2:

* Documentation style issues pointed out by Nicolas internally.
* s/VP9_PROFILE_MAX/V4L2_VP9_PROFILE_MAX/
* Fix wrong kfree(ctx).
* constify a couple structs on rkvdec-vp9.c

This series applies on top of media master, plus Rockchip VDEC
driver v8 series [1]

[1] https://patchwork.linuxtv.org/project/linux-media/list/?series=2107

Boris Brezillon (3):
  media: v4l2-ctrls: Add the [__]v4l2_ctrl_s_ctrl_compound() helpers
  media: uapi: Add VP9 stateless decoder controls
  media: rkvdec: Add the VP9 backend

 Documentation/media/uapi/v4l/biblio.rst       |   10 +
 .../media/uapi/v4l/ext-ctrls-codec.rst        |  584 ++++++
 drivers/media/v4l2-core/v4l2-ctrls.c          |  257 +++
 drivers/media/v4l2-core/v4l2-ioctl.c          |    1 +
 drivers/staging/media/rkvdec/Makefile         |    2 +-
 drivers/staging/media/rkvdec/rkvdec-vp9.c     | 1572 +++++++++++++++++
 drivers/staging/media/rkvdec/rkvdec.c         |   56 +-
 drivers/staging/media/rkvdec/rkvdec.h         |    6 +
 include/media/v4l2-ctrls.h                    |   44 +
 include/media/vp9-ctrls.h                     |  515 ++++++
 10 files changed, 3043 insertions(+), 4 deletions(-)
 create mode 100644 drivers/staging/media/rkvdec/rkvdec-vp9.c
 create mode 100644 include/media/vp9-ctrls.h

-- 
2.26.0.rc2

