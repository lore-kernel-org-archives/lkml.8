Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D05CC3F2D8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 14:09:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E53321739
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 14:09:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729450AbgCDOJ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 09:09:29 -0500
Received: from sauhun.de ([88.99.104.3]:33702 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725795AbgCDOJ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 09:09:28 -0500
Received: from localhost (p54B331AD.dip0.t-ipconnect.de [84.179.49.173])
        by pokefinder.org (Postfix) with ESMTPSA id D9AA22C1F1E;
        Wed,  4 Mar 2020 15:09:25 +0100 (CET)
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-doc@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 0/2] include/bitmap.h: updates to docs
Date:   Wed,  4 Mar 2020 15:09:18 +0100
Message-Id: <20200304140920.6109-1-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While looking for functions to handle region of bits, I stumbled over
two issues in the documentation part of bitmap.h. These two patches
address them.

My guess is that this could go in via Jon's documentation tree, but I
am CCing Andrew nonetheless.

Based on v5.6-rc1.

Looking forward to comments!

   Wolfram


Wolfram Sang (2):
  include/bitmap.h: add missing parameter in docs
  include/bitmap.h: add new functions to documentation

 include/linux/bitmap.h | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

-- 
2.20.1

