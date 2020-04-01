Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED34AC2D0F3
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 21:37:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEAA820719
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 21:37:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732860AbgDAVhh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 17:37:37 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:34552 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732337AbgDAVhh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 17:37:37 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: ezequiel)
        with ESMTPSA id 9262829769C
From:   Ezequiel Garcia <ezequiel@collabora.com>
To:     linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     kernel@collabora.com, Hans Verkuil <hverkuil@xs4all.nl>,
        Ezequiel Garcia <ezequiel@collabora.com>
Subject: [PATCH 0/3] Rockchip ISP1 minor fixes
Date:   Wed,  1 Apr 2020 18:37:18 -0300
Message-Id: <20200401213721.24173-1-ezequiel@collabora.com>
X-Mailer: git-send-email 2.26.0.rc2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A small series of minor fixes I stumbled upon while
doing compile testing.

Patch 1 gets rid of an 'unused variable' warning, triggered
by building without CONFIG_OF.

Patches 2 and 3 cleanup the dependency of phy-rockchip-dphy-rx0
and rkisp1 drivers.

Ezequiel Garcia (3):
  rkisp1: Get rid of unused variable warning
  phy-rockchip-dphy-rx0: Drop unneeded CONFIG_OF dependency
  rkisp1: Fix wrong PHY config dependency

 drivers/staging/media/phy-rockchip-dphy-rx0/Kconfig | 2 +-
 drivers/staging/media/rkisp1/Kconfig                | 2 +-
 drivers/staging/media/rkisp1/rkisp1-dev.c           | 3 +--
 3 files changed, 3 insertions(+), 4 deletions(-)

-- 
2.26.0.rc2

