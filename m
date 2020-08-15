Return-Path: <SRS0=qJsj=BZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC207C433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 21:58:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF8682053B
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 21:58:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729539AbgHOV6Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Aug 2020 17:58:16 -0400
Received: from mga14.intel.com ([192.55.52.115]:63150 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728949AbgHOV6O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Aug 2020 17:58:14 -0400
IronPort-SDR: 2nY31U91qgrGANcHqGNPkVKWdnXYBOiKgIqfOfQGblHGhDWYw+5WromSWxmsJnmQzTsjj4SLeg
 F40NX/CbmmqA==
X-IronPort-AV: E=McAfee;i="6000,8403,9713"; a="153750618"
X-IronPort-AV: E=Sophos;i="5.76,314,1592895600"; 
   d="scan'208";a="153750618"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2020 17:36:46 -0700
IronPort-SDR: DK8MeVuGXH7vxDzIowTtxOXe3xotNKbC69nqnb4aqlFPjcrBEkDzbTAaKxJxVU0IGk+E4Oc8lc
 CKxJ4ZP3ZNQA==
X-IronPort-AV: E=Sophos;i="5.76,314,1592895600"; 
   d="scan'208";a="470756578"
Received: from agluck-desk2.sc.intel.com (HELO agluck-desk2.amr.corp.intel.com) ([10.3.52.68])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2020 17:36:46 -0700
Date:   Fri, 14 Aug 2020 17:36:45 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org,
        linux-edac@vger.kernel.org
Subject: [GIT PULL] edac for v5.9 (part 2)
Message-ID: <20200815003645.GA22594@agluck-desk2.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Here's one more pull for EDAC with a driver that I let slip
through the cracks.

-Tony

The following changes since commit 709ed1bcef12398ac1a35c149f3e582db04456c2:

  EDAC/ie31200: Fallback if host bridge device is already initialized (2020-08-10 11:13:06 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git tags/edac_updates_for_5.9_pt2

for you to fetch changes up to 709ed1bcef12398ac1a35c149f3e582db04456c2:

  EDAC/ie31200: Fallback if host bridge device is already initialized (2020-08-10 11:13:06 -0700)

----------------------------------------------------------------
Fixes for ie31200 driver that missed the first pull

----------------------------------------------------------------

