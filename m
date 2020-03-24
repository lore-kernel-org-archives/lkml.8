Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90416C4332B
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 12:30:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 624E0208C3
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 12:30:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="emWAw3c3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727548AbgCXMav (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 08:30:51 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42083 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727283AbgCXMau (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 08:30:50 -0400
Received: by mail-pf1-f194.google.com with SMTP id 22so5607605pfa.9;
        Tue, 24 Mar 2020 05:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=AomG1PxVMQy2uJ0CQrO8q+2Jd5FtFdpWBMBCz71R9bA=;
        b=emWAw3c3Z3l+vLxuQEDk2/MhYt7ZXCRCdghq7XVq4rKrz2fhoEpV7e1oqZige7eWU2
         m1vQBgCk3H7MuCiUC2z+1QeN/X5K1MtWXVnUfxXNp+dA04uibuL7EFeH50XJQKdIrKa5
         10smy6XCfZ5GudAF8YO9tDFDQMVnbB4embEHcgPxoGlNV4ylLUimYc6Cf22FVVwQZ/2X
         BXDZHClTEuw9LlSkLtkB3YM8zM9V0BvRU5HJyQD+CbeBIRRQ+1RoAM41PvIZukabpT0S
         daOahxZJyqdiovsl3Bt6nswiTiA0r4d6DdfAY60UPCDQhunvi3DYsgZ/xeJEh9gT5wRU
         1Jsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=AomG1PxVMQy2uJ0CQrO8q+2Jd5FtFdpWBMBCz71R9bA=;
        b=UB6hT/qfNHTlE9SgU+zJy4WnyTC8irwBYZhSGJM2q4b/pgTQ0Z8o1VXwUb6xLmvbIy
         9ZiZlt5zLg/s3TRTAq93Ua62d4z5iCrS1/TSW62VdP8XX7mpEFeIaD5TOPCNlKTzAQK6
         mwCPov/cxlh3e6W3GtlzbDcVwnMcJGOkehaJ8tBGG6pxGqFZnO2AmLz/gSJm96coCtP8
         5b/Pbsi6bSgIsXhGwvWld1eFEbSdHWIDzA3mAgHEj7QoHqwI7IRWCpq/nlQ6U3Cjxw2K
         XfAzrvQ9WFg//7RfEWumG18DkaihOvYPCuY3Wg4HQpoGum6iDjigkZXP2efLqikcw5br
         OwNA==
X-Gm-Message-State: ANhLgQ0FB2+uS/q9f16YfonRLLZkIMVeUwGoRRTeXxCgfYTXSkUBVqI2
        WxE2+zO3kEZkbAZKuwHFpCg=
X-Google-Smtp-Source: ADFU+vtisFHlmrRHkVlX2/zo73z2wp/UecvD7A36s81dUTt4r1aYp9VeC1+URs7iahDg2bbvx0dJeA==
X-Received: by 2002:a63:a65:: with SMTP id z37mr26395712pgk.31.1585053049065;
        Tue, 24 Mar 2020 05:30:49 -0700 (PDT)
Received: from localhost.localdomain ([180.70.143.152])
        by smtp.gmail.com with ESMTPSA id c83sm15759395pfb.44.2020.03.24.05.30.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2020 05:30:47 -0700 (PDT)
From:   Taehee Yoo <ap420073@gmail.com>
To:     davem@davemloft.net, kuba@kernel.org, gregkh@linuxfoundation.org,
        rafael@kernel.org, j.vosburgh@gmail.com, vfalico@gmail.com,
        andy@greyhouse.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     ap420073@gmail.com, mitch.a.williams@intel.com
Subject: [PATCH net 0/3] net: core: avoid unexpected situation in namespace change routine
Date:   Tue, 24 Mar 2020 12:30:41 +0000
Message-Id: <20200324123041.18825-1-ap420073@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset is to avoid an unexpected situation when an interface's
namespace is being changed.

When interface's namespace is being changed, dev_change_net_namespace()
is called. This removes and re-allocates many resources that include
sysfs files. The "/net/class/net/<interface name>" is one of them.
If the sysfs creation routine(device_rename()) found duplicate sysfs
file name, it warns about it and fails. But unfortunately, at that point,
dev_change_net_namespace() doesn't return fail because rollback cost
is too high.
So, the interface can't have a sysfs file.

The approach of this patchset is to find the duplicate sysfs file as
fast as possible. If it found that, dev_change_net_namespace() returns
fail immediately with zero rollback cost.

1. The first patch is to add class_find_and_get_file_ns() helper function.
That function will be used for checking the existence of duplicate
sysfs file.
2. The second patch is to add netdev_class_has_file_ns().
That function is to check whether duplicate sysfs file in
the "/sys/class/net*" using class_find_and_get_file_ns().
3. The last patch is to avoid an unexpected situation.
a) If duplicate sysfs is existing, it fails as fast as possible in
the dev_change_net_namespace()
b) Acquire rtnl_lock() in both bond_create_sysfs() and bond_destroy_sysfs()
to avoid race condition.
c) Do not remove "/sys/class/net/bonding_masters" sysfs file by
bond_destroy_sysfs() if the file wasn't created by bond_create_sysfs().

Test commands#1:
    ip netns add nst 
    ip link add bonding_masters type dummy
    modprobe bonding
    ip link set bonding_masters netns nst 

Test commands#2:
    ip link add bonding_masters type dummy
    ls /sys/class/net
    modprobe bonding
    modprobe -rv bonding
    ls /sys/class/net

After removing the bonding module, we can see the "bonding_masters"
interface's sysfs will be removed.
This is an unexpected situation.

Taehee Yoo (3):
  class: add class_find_and_get_file_ns() helper function
  net: core: add netdev_class_has_file_ns() helper function
  net: core: avoid warning in dev_change_net_namespace()

 drivers/base/class.c             | 12 ++++++++++++
 drivers/net/bonding/bond_sysfs.c | 13 ++++++++++++-
 include/linux/device/class.h     |  4 +++-
 include/linux/netdevice.h        |  2 +-
 include/net/bonding.h            |  1 +
 net/core/dev.c                   |  4 ++++
 net/core/net-sysfs.c             | 13 +++++++++++++
 7 files changed, 46 insertions(+), 3 deletions(-)

-- 
2.17.1

