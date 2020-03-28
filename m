Return-Path: <SRS0=NZ+o=5N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6E84C43331
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 05:17:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A515F206F6
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 05:17:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725947AbgC1FK2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Mar 2020 01:10:28 -0400
Received: from mta01.start.ca ([162.250.196.97]:43976 "EHLO mta01.start.ca"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725372AbgC1FK2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 01:10:28 -0400
Received: from mta01.start.ca (localhost [127.0.0.1])
        by mta01.start.ca (Postfix) with ESMTP id 48D6F4290F;
        Sat, 28 Mar 2020 01:10:27 -0400 (EDT)
Received: from localhost (dhcp-24-53-240-163.cable.user.start.ca [24.53.240.163])
        by mta01.start.ca (Postfix) with ESMTPS id 0D973428FE;
        Sat, 28 Mar 2020 01:10:07 -0400 (EDT)
From:   Nick Bowler <nbowler@draconx.ca>
To:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Sagi Grimberg <sagi@grimberg.me>,
        Christoph Hellwig <hch@infradead.org>,
        Keith Busch <kbusch@kernel.org>
Subject: [PATCH v2 0/2] nvme: compat ioctl fixes
Date:   Sat, 28 Mar 2020 01:09:07 -0400
Message-Id: <20200328050909.30639-1-nbowler@draconx.ca>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On review of my earlier patch to correct how 32-bit addresses in the
NVME_IOCTL_ADMIN_CMD compat ioctl (via nvme_user_cmd function) were
handled, similar problems were noted in the nvme_user_cmd64 function.

Additionally, NVME_IOCTL_SUBMIT_IO is busted in the compat case because
it not only has the same 32-bit address problem, but additionally the
corresponding nvme_user_io structure padding differs between 32-bit and
64-bit x86 (and some other arches presumably have the same problem).

Note that since I do not know of any users of the NVME_IOCTL_IO64_CMD
or NVME_IOCTL_ADMIN64_CMD ioctls, I have not tested the changes to the
nvme_user_cmd64 function (but these changes are virtually identical
to those done in the other functions function).

Nick Bowler (2):
  nvme: Fix compat NVME_IOCTL_SUBMIT_IO numbering
  nvme: Fix compat address handling in several ioctls

 drivers/nvme/host/core.c        | 47 ++++++++++++++++++++++++---------
 include/uapi/linux/nvme_ioctl.h | 25 ++++++++++++++++++
 2 files changed, 59 insertions(+), 13 deletions(-)

-- 
2.24.1

