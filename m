Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32AB1C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 14:07:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 170002083E
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 14:07:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729727AbgEUOH1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 10:07:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729717AbgEUOH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 10:07:26 -0400
Received: from ou.quest-ce.net (unknown [IPv6:2001:bc8:3541:100::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D199DC061A0E
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 07:07:25 -0700 (PDT)
Received: from [2a01:e35:39f2:1220:ab87:b468:44f5:c88a] (helo=quest-ce.net)
        by ou.quest-ce.net with esmtpsa (TLS1.1:RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <ydroneaud@opteya.com>)
        id 1jblWu-000EPr-Mm; Thu, 21 May 2020 15:46:36 +0200
From:   Yann Droneaud <ydroneaud@opteya.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, Theodore Ts'o <tytso@mit.edu>
Cc:     Andy Lutomirski <luto@kernel.org>, linux-kernel@vger.kernel.org,
        Yann Droneaud <ydroneaud@opteya.com>
Date:   Thu, 21 May 2020 15:46:24 +0200
Message-Id: <cover.1590068270.git.ydroneaud@opteya.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a01:e35:39f2:1220:ab87:b468:44f5:c88a
X-SA-Exim-Mail-From: ydroneaud@opteya.com
Subject: [PATCH 0/4] random/trace: remove unused function
X-SA-Exim-Version: 4.2.1 (built Mon, 26 Dec 2011 16:24:06 +0000)
X-SA-Exim-Scanned: Yes (on ou.quest-ce.net)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

After simplifications brought recently to random [1], some
trace functions are no more needed. This patchset removes
them.

[1] https://lore.kernel.org/linux-api/cover.1577088521.git.luto@kernel.org/

Yann Droneaud (4):
  random/trace: remove unused trace_random_read()
  random/trace: remove unused trace_push_to_pool()
  random/trace: remove unused trace_extract_entropy_user()
  random/trace: remove unused trace_xfer_secondary_pool()

 include/trace/events/random.h | 93 +----------------------------------
 1 file changed, 1 insertion(+), 92 deletions(-)

-- 
2.25.4

