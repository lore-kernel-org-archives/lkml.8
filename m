Return-Path: <SRS0=iqK9=5A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A021C10DCE
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 17:17:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27054206E9
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 17:17:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728980AbgCORRl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Mar 2020 13:17:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:56412 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728887AbgCORRk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Mar 2020 13:17:40 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 36A7FADB5;
        Sun, 15 Mar 2020 17:17:39 +0000 (UTC)
Received: by unicorn.suse.cz (Postfix, from userid 1000)
        id 25B9EE0C04; Sun, 15 Mar 2020 18:17:38 +0100 (CET)
Message-Id: <cover.1584292182.git.mkubecek@suse.cz>
From:   Michal Kubecek <mkubecek@suse.cz>
Subject: [PATCH net 0/3] ethtool: fail with error if request has unknown flags
To:     David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-kernel@vger.kernel.org
Date:   Sun, 15 Mar 2020 18:17:38 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jakub Kicinski pointed out that if unrecognized flags are set in netlink
header request, kernel shoud fail with an error rather than silently
ignore them so that we have more freedom in future flags semantics.

To help userspace with handling such errors, inform the client which
flags are supported by kernel. For that purpose, we need to allow
passing cookies as part of extack also in case of error (they can be
only passed on success now).

Michal Kubecek (3):
  netlink: allow extack cookie also for error messages
  netlink: add nl_set_extack_cookie_u32()
  ethtool: reject unrecognized request flags

 include/linux/netlink.h  |  9 +++++++++
 net/ethtool/netlink.c    | 16 +++++++++++----
 net/netlink/af_netlink.c | 43 ++++++++++++++++------------------------
 3 files changed, 38 insertions(+), 30 deletions(-)

-- 
2.25.1

