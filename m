Return-Path: <SRS0=fzvl=3P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62630C2D0DB
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jan 2020 22:11:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 324A4206F0
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jan 2020 22:11:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728831AbgAZWLC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jan 2020 17:11:02 -0500
Received: from mx2.suse.de ([195.135.220.15]:43564 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726703AbgAZWLC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jan 2020 17:11:02 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 2E88DAB7F;
        Sun, 26 Jan 2020 22:11:00 +0000 (UTC)
Received: by unicorn.suse.cz (Postfix, from userid 1000)
        id 7AC5FE06B1; Sun, 26 Jan 2020 23:10:58 +0100 (CET)
Message-Id: <cover.1580075977.git.mkubecek@suse.cz>
From:   Michal Kubecek <mkubecek@suse.cz>
Subject: [PATCH net-next 0/7] ethtool netlink interface, part 2
To:     David Miller <davem@davemloft.net>, netdev@vger.kernel.org
Cc:     Jakub Kicinski <kuba@kernel.org>, Jiri Pirko <jiri@resnulli.us>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        John Linville <linville@tuxdriver.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-kernel@vger.kernel.org
Date:   Sun, 26 Jan 2020 23:10:58 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This shorter series adds support for getting and setting of wake-on-lan
settings and message mask (originally message level). Together with the
code already in net-next, this will allow full implementation of
"ethtool <dev>" and "ethtool -s <dev> ...".

Older versions of the ethtool netlink series allowed getting WoL settings
by unprivileged users and only filtered out the password but this was
a source of controversy so for now, ETHTOOL_MSG_WOL_GET request always
requires CAP_NET_ADMIN as ETHTOOL_GWOL ioctl request does.

Michal Kubecek (7):
  ethtool: fix kernel-doc descriptions
  ethtool: provide message mask with DEBUG_GET request
  ethtool: set message mask with DEBUG_SET request
  ethtool: add DEBUG_NTF notification
  ethtool: provide WoL settings with WOL_GET request
  ethtool: set wake-on-lan settings with WOL_SET request
  ethtool: add WOL_NTF notification

 Documentation/networking/ethtool-netlink.rst | 110 +++++++++++-
 include/linux/netdevice.h                    |  56 ++++--
 include/uapi/linux/ethtool.h                 |   6 +
 include/uapi/linux/ethtool_netlink.h         |  33 ++++
 net/ethtool/Makefile                         |   2 +-
 net/ethtool/common.c                         |  31 ++++
 net/ethtool/common.h                         |   2 +
 net/ethtool/debug.c                          | 134 ++++++++++++++
 net/ethtool/ioctl.c                          |   3 +
 net/ethtool/netlink.c                        |  57 ++++--
 net/ethtool/netlink.h                        |   4 +
 net/ethtool/strset.c                         |  11 ++
 net/ethtool/wol.c                            | 177 +++++++++++++++++++
 13 files changed, 592 insertions(+), 34 deletions(-)
 create mode 100644 net/ethtool/debug.c
 create mode 100644 net/ethtool/wol.c

-- 
2.25.0

