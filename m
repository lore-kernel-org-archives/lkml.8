Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0D6FC433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 14:59:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83B5720709
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 14:59:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729452AbgGWO7k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 10:59:40 -0400
Received: from mga09.intel.com ([134.134.136.24]:50088 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727885AbgGWO7k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 10:59:40 -0400
IronPort-SDR: abCBptrdrDtTsRnIs24CJ3lKVm3X+ic8DD2h54rSiHROFcGb/EgqLWoIEIwKULWpXKtIdWjBOa
 bO53K664uCDQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9690"; a="151839015"
X-IronPort-AV: E=Sophos;i="5.75,386,1589266800"; 
   d="scan'208";a="151839015"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2020 07:59:39 -0700
IronPort-SDR: wviLJLFeuWBjR4/AL7eD0LAEhVXPn7sPSrBrTK1Wmf5MZVUibvYJEMjTG2yRaYXuJI4+E9EKWL
 atOeCtVubTwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,386,1589266800"; 
   d="scan'208";a="311051157"
Received: from twinkler-lnx.jer.intel.com ([10.12.91.138])
  by fmsmga004.fm.intel.com with ESMTP; 23 Jul 2020 07:59:37 -0700
From:   Tomas Winkler <tomas.winkler@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alexander Usyskin <alexander.usyskin@intel.com>,
        linux-kernel@vger.kernel.org,
        Tomas Winkler <tomas.winkler@intel.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [char-misc-next 0/6] mei: remove one-element arrays
Date:   Thu, 23 Jul 2020 17:59:21 +0300
Message-Id: <20200723145927.882743-1-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


1. Remove one-element arrays from hw.h
2. Adjust to preferred method of getting size of structure
from memory allocation and movement. sizeof(*var) 
instead of sizeof(struct some_struct)


Tomas Winkler (6):
  mei: hbm: use sizeof of variable instead of struct type
  mei: ioctl: use sizeof of variable instead of struct type
  mei: bus: use sizeof of variable instead of struct type
  mei: client: use sizeof of variable instead of struct type
  mei: hw: use sizeof of variable instead of struct type
  mei: hw: don't use one element arrays

 drivers/misc/mei/bus-fixup.c | 23 ++++++-----
 drivers/misc/mei/bus.c       |  2 +-
 drivers/misc/mei/client.c    |  8 ++--
 drivers/misc/mei/hbm.c       | 74 ++++++++++++++++--------------------
 drivers/misc/mei/hw-me.c     |  5 +--
 drivers/misc/mei/hw-txe.c    |  5 +--
 drivers/misc/mei/hw.h        |  8 ++--
 drivers/misc/mei/main.c      |  6 +--
 8 files changed, 59 insertions(+), 72 deletions(-)

-- 
2.25.4

