Return-Path: <SRS0=5Fkd=6R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8679C28CBC
	for <linux-kernel@archiver.kernel.org>; Sun,  3 May 2020 15:43:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D64F208DB
	for <linux-kernel@archiver.kernel.org>; Sun,  3 May 2020 15:43:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kocurkovo.cz header.i=@kocurkovo.cz header.b="B7wDTNX7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728904AbgECPnS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 May 2020 11:43:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728677AbgECPnS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 May 2020 11:43:18 -0400
Received: from mail.kocurkovo.cz (unknown [IPv6:2a02:2b88:2:1::5b29:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76956C061A0E
        for <linux-kernel@vger.kernel.org>; Sun,  3 May 2020 08:43:17 -0700 (PDT)
Received: by mail.kocurkovo.cz (Postfix, from userid 1000)
        id 4B75D950; Sun,  3 May 2020 17:43:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.kocurkovo.cz 4B75D950
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kocurkovo.cz;
        s=mail; t=1588520593;
        bh=uYLY76daBgLejEJsam0HqY4XMyeNCKXdpr7JrpWamos=;
        h=From:To:Cc:Subject:Date:From;
        b=B7wDTNX7GvU1V8oj5ESYni99nDHUJE7YOOOCnIQgm4KL1XKDnzoZmmNsAlOtNdhx8
         IISMxyjX9trdwb7a3QIZXVTE235OxvutfIY2HHlXrQU1MSZo2Gg8ZXgP/eMd972Zf+
         30eAtrVPOzVPPQJAJ9ntVebdLz/kZpb1ZQyEbAN8=
From:   Matej Dujava <mdujava@kocurkovo.cz>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Cc:     Stefano Brivio <sbrivio@redhat.com>,
        Briana Oursler <briana.oursler@gmail.com>,
        "Frank A. Cancio Bello" <frank@generalsoftwareinc.com>,
        Matej Dujava <mdujava@kocurkovo.cz>
Subject: [PATCH v2 0/2] Early return in s_uGetTxRsvTime
Date:   Sun,  3 May 2020 17:42:48 +0200
Message-Id: <1588520570-14388-1-git-send-email-mdujava@kocurkovo.cz>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set will fix checkpatch LONG_LINE warnings and will save us
one call of bb_get_frame_time in case od !bNeedAck.

Change history:
v2: Implemented advice of ternary operator from Joe Perches <joe@perches.com>

Matej Dujava (2):
  staging: vt6655: return early if not bNeedAck
  staging: vt6655: fix LONG_LINE warning

 drivers/staging/vt6655/rxtx.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

--
2.26.2

