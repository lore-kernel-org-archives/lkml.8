Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40089C3F2CF
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 08:33:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E9F1246A2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 08:33:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbgB1Id5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 03:33:57 -0500
Received: from smtprelay0065.hostedemail.com ([216.40.44.65]:39379 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725877AbgB1Id4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 03:33:56 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 3107E180265A6;
        Fri, 28 Feb 2020 08:33:55 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: power64_796178c799809
X-Filterd-Recvd-Size: 2097
Received: from joe-laptop.perches.com (unknown [47.151.143.254])
        (Authenticated sender: joe@perches.com)
        by omf04.hostedemail.com (Postfix) with ESMTPA;
        Fri, 28 Feb 2020 08:33:54 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     Randy Dunlap <rdunlap@infradead.org>, linux-parisc@vger.kernel.org
Cc:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>, linux-kernel@vger.kernel.org
Subject: [PATCH 0/7] parport: Use generic kernel logging styles
Date:   Fri, 28 Feb 2020 00:32:11 -0800
Message-Id: <cover.1582878393.git.joe@perches.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <69fb1d36-b6cf-7c46-96d1-9403de6ab47a@infradead.org>
References: <69fb1d36-b6cf-7c46-96d1-9403de6ab47a@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Well, if the parport logging is getting some generic fixing,
here's some more generic logging fixing...

Joe Perches (7):
  parport: Convert printk(KERN_<LEVEL> to pr_<level>(
  parport: Use more comon logging styles
  parport: daisy: Convert DPRINTK to pr_debug
  parport_amiga: Convert DPRINTK to pr_debug
  parport_mfc3: Convert DPRINTK to pr_debug
  parport_pc: Convert DPRINTK to pr_debug
  parport: Standardize use of printmode

 drivers/parport/daisy.c          |  29 +---
 drivers/parport/ieee1284.c       |   4 +-
 drivers/parport/ieee1284_ops.c   |   3 +-
 drivers/parport/parport_amiga.c  |  22 +--
 drivers/parport/parport_atari.c  |   2 +-
 drivers/parport/parport_cs.c     |   6 +-
 drivers/parport/parport_gsc.c    |  25 +--
 drivers/parport/parport_gsc.h    |  21 ++-
 drivers/parport/parport_ip32.c   | 117 +++++++-------
 drivers/parport/parport_mfc3.c   |  21 +--
 drivers/parport/parport_pc.c     | 263 +++++++++++++------------------
 drivers/parport/parport_sunbpp.c |   2 +-
 drivers/parport/probe.c          |  34 ++--
 drivers/parport/procfs.c         |   6 +-
 drivers/parport/share.c          |  37 +++--
 15 files changed, 261 insertions(+), 331 deletions(-)

-- 
2.24.0

