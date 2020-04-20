Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2EF2C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 12:01:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE4FF206DD
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 12:01:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726644AbgDTMBl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 08:01:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:40624 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726341AbgDTMBk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 08:01:40 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id B7DF0AC64;
        Mon, 20 Apr 2020 12:01:38 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     saravanak@google.com, linux-kernel@vger.kernel.org
Cc:     frowand.list@gmail.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org, gregkh@linuxfoundation.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Subject: [PATCH v3 0/2] of: property: fw_devlink misc fixes
Date:   Mon, 20 Apr 2020 14:00:59 +0200
Message-Id: <20200420120101.31405-1-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As I'm interested in using this feature to fine-tune Raspberry Pi 4's
device probe dependencies, I tried to get the board to boot with
fw_devlink=on. As of today's linux-next the board won't boot with that
option. I tried to address the underlying issues.

---
Changes since v2:
 - Address Saravana's comments

Changes since v1:
 - Address Saravana's comments
 - Drop patch #3 & #4


Nicolas Saenz Julienne (2):
  of: property: Fix create device links for all child-supplier
    dependencies
  of: property: Do not link to disabled devices

 drivers/of/property.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

-- 
2.26.0

