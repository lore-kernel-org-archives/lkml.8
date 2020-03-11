Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88AF1C0044D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 21:40:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C46E206E7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 21:40:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729565AbgCKVkL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 17:40:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:46086 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726579AbgCKVkL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 17:40:11 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 6FBDAB28D;
        Wed, 11 Mar 2020 21:40:08 +0000 (UTC)
Received: by unicorn.suse.cz (Postfix, from userid 1000)
        id 34990E0C0A; Wed, 11 Mar 2020 22:40:03 +0100 (CET)
Message-Id: <cover.1583962006.git.mkubecek@suse.cz>
From:   Michal Kubecek <mkubecek@suse.cz>
Subject: [PATCH net-next 00/15] ethtool netlink interface, part 3
To:     David Miller <davem@davemloft.net>, netdev@vger.kernel.org
Cc:     Jakub Kicinski <kuba@kernel.org>, Jiri Pirko <jiri@resnulli.us>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        John Linville <linville@tuxdriver.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-kernel@vger.kernel.org
Date:   Wed, 11 Mar 2020 22:40:03 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implementation of more netlink request types:

  - netdev features (ethtool -k/-K, patches 3-6)
  - private flags (--show-priv-flags / --set-priv-flags, patches 7-9)
  - ring sizes (ethtool -g/-G, patches 10-12)
  - channel counts (ethtool -l/-L, patches 13-15)

Patch 1 is a style cleanup suggested in part 2 review and patch 2 updates
the mapping between netdev features and legacy ioctl requests (which are
still used by ethtool for backward compatibility).

Michal Kubecek (15):
  ethtool: rename ethnl_parse_header() to ethnl_parse_header_dev_get()
  ethtool: update mapping of features to legacy ioctl requests
  ethtool: provide netdev features with FEATURES_GET request
  ethtool: add ethnl_parse_bitset() helper
  ethtool: set netdev features with FEATURES_SET request
  ethtool: add FEATURES_NTF notification
  ethtool: provide private flags with PRIVFLAGS_GET request
  ethtool: set device private flags with PRIVFLAGS_SET request
  ethtool: add PRIVFLAGS_NTF notification
  ethtool: provide ring sizes with RINGS_GET request
  ethtool: set device ring sizes with RINGS_SET request
  ethtool: add RINGS_NTF notification
  ethtool: provide channel counts with CHANNELS_GET request
  ethtool: set device channel counts with CHANNELS_SET request
  ethtool: add CHANNELS_NTF notification

 Documentation/networking/ethtool-netlink.rst | 272 ++++++++++++++--
 include/uapi/linux/ethtool_netlink.h         |  82 +++++
 net/ethtool/Makefile                         |   3 +-
 net/ethtool/bitset.c                         |  94 ++++++
 net/ethtool/bitset.h                         |   4 +
 net/ethtool/channels.c                       | 216 +++++++++++++
 net/ethtool/common.c                         |  31 ++
 net/ethtool/common.h                         |   3 +
 net/ethtool/debug.c                          |   6 +-
 net/ethtool/features.c                       | 307 +++++++++++++++++++
 net/ethtool/ioctl.c                          |  52 +---
 net/ethtool/linkinfo.c                       |   6 +-
 net/ethtool/linkmodes.c                      |   6 +-
 net/ethtool/netlink.c                        |  99 +++++-
 net/ethtool/netlink.h                        |  15 +-
 net/ethtool/privflags.c                      | 209 +++++++++++++
 net/ethtool/rings.c                          | 189 ++++++++++++
 net/ethtool/wol.c                            |   5 +-
 18 files changed, 1519 insertions(+), 80 deletions(-)
 create mode 100644 net/ethtool/channels.c
 create mode 100644 net/ethtool/features.c
 create mode 100644 net/ethtool/privflags.c
 create mode 100644 net/ethtool/rings.c

-- 
2.25.1

