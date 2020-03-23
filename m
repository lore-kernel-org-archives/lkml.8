Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21D5BC4332B
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 21:10:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9B71206C3
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 21:10:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726987AbgCWVKf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 17:10:35 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:40452 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726177AbgCWVKf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 17:10:35 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: ezequiel)
        with ESMTPSA id E2F92296002
From:   Ezequiel Garcia <ezequiel@collabora.com>
To:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Tomasz Figa <tfiga@chromium.org>,
        Nicolas Dufresne <nicolas@ndufresne.ca>, kernel@collabora.com,
        Hans Verkuil <hverkuil@xs4all.nl>, Sean Young <sean@mess.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@iki.fi>,
        Michael Ira Krufky <mkrufky@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Helen Koike <helen.koike@collabora.com>,
        Ezequiel Garcia <ezequiel@collabora.com>
Subject: [PATCH 0/2] media: Clean up stateless codec configuration
Date:   Mon, 23 Mar 2020 18:10:20 -0300
Message-Id: <20200323211022.28297-1-ezequiel@collabora.com>
X-Mailer: git-send-email 2.26.0.rc2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is another attempt at cleaning up the media
configuration for certain devices, targetting
stateless codecs for now.

The previous attempt was taking the bull by the horns,
removing all the existing "support" configurations
such as "Cameras/video grabbers support", "Analog TV support",
and the like:

https://patchwork.linuxtv.org/patch/62423/

This raised some concerns, but also some supporters, feel free
to jump on that discussion!

This series gives a different approach to reach the goal
mentioned by Tomasz: enabling specific hardware.

Patch 1 allows us to select the media controller API, without
requiring a "support" option. In other words, it stops hiding
the media controller API behing the "support" options.

Patch 2 enables VIDEO_DEV (video4linux core) when MEDIA_SUPPORT
is selected.

With this, we can now enable specific hardware such as stateless
codecs such as Hantro, Cedrus, as well as RKISP1.

Ezequiel Garcia (2):
  media: Allow to enable the media controller API unconditionally
  media: Remove VIDEO_DEV unneeded dependency

 drivers/media/Kconfig    | 2 --
 drivers/media/mc/Kconfig | 1 -
 2 files changed, 3 deletions(-)

-- 
2.26.0.rc2

