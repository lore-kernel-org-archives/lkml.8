Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB693C4332B
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 13:08:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A7E22072D
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 13:08:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728364AbgCWNIt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 09:08:49 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:35768 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728308AbgCWNIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 09:08:49 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: aratiu)
        with ESMTPSA id 8290A290467
From:   Adrian Ratiu <adrian.ratiu@collabora.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ezequiel Garcia <ezequiel@collabora.com>, kernel@collabora.com,
        kernel@pengutronix.de, Tim Harvey <tharvey@gateworks.com>
Subject: [PATCH 0/2] media: coda: Add ability to decode wider range of jpegs
Date:   Mon, 23 Mar 2020 15:09:35 +0200
Message-Id: <20200323130937.3666244-1-adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.25.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

At Ezequiel's suggestion I'm sending these patches as a standalone
series which applies on top of Philipp's v2 decoder series located
at Message-Id: <20200318183536.15779-1-p.zabel@pengutronix.de>

The use case for these is that we get jpegs from smartphone apps
over which we have no control: they run on a variety of OSes /
technologies / libraries, could produce jpegs with dimensions from
64x64 to full HD and could use standard or optimized huffman coding.

By relaxing these two checks in the decoder we are able to correctly
display all our images and think these would also benefit others.

Tested with CODA960 on IMX6DL.

Kind regards,
Adrian

Adrian Ratiu (2):
  media: coda: jpeg: support optimized huffman tables
  media: coda: be more flexible wrt jpeg dimensions

 drivers/media/platform/coda/coda-jpeg.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

-- 
2.25.2

