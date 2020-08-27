Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9459C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 06:51:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FBC9207BC
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 06:51:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728015AbgH0Gvm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 02:51:42 -0400
Received: from mga02.intel.com ([134.134.136.20]:36254 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726123AbgH0Gvk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 02:51:40 -0400
IronPort-SDR: /pNnU/gV/Iv2bkGNoK19feWCkqJONTs85ii7eUSCE8ZOmh4h6Idnl9ueNHrxriG3mmFY1/TOCj
 VAX2HC2VaAtw==
X-IronPort-AV: E=McAfee;i="6000,8403,9725"; a="144190786"
X-IronPort-AV: E=Sophos;i="5.76,358,1592895600"; 
   d="scan'208";a="144190786"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2020 23:51:33 -0700
IronPort-SDR: UrohNALgNxbep0uFeteIqLQ3gp1QQa1dSSTkMQQCS3PNaiRHnX9+KIl9SKRf+IBSBUBAuC7i7d
 Xb3bcDsZ1hKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,358,1592895600"; 
   d="scan'208";a="475087553"
Received: from sgsxdev004.isng.intel.com (HELO localhost) ([10.226.88.13])
  by orsmga005.jf.intel.com with ESMTP; 26 Aug 2020 23:51:30 -0700
From:   "Ramuthevar,Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
To:     cw00.choi@samsung.com, linux-kernel@vger.kernel.org
Cc:     vijaikumar.kanagarajan@gmail.com, krzk@kernel.org,
        myungjoo.ham@samsung.com, heikki.krogerus@linux.intel.com,
        cheol.yong.kim@intel.com, qi-ming.wu@intel.com, yin1.li@intel.com,
        "Ramuthevar,Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Subject: [PATCH v3 0/1]extcon: ptn5150: Add usb-typec support for Intel LGM SoC
Date:   Thu, 27 Aug 2020 14:51:27 +0800
Message-Id: <20200827065128.55094-1-vadivel.muruganx.ramuthevar@linux.intel.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add usb-typec detection support for the Intel LGM SoC based boards.

Original driver is not supporting usb detection on Intel LGM SoC based boards
then we debugged and fixed the issue, but before sending our patches Mr.Krzyszto
has sent the same kind of patches, so I have rebased over his latest patches
which is present in maintainer tree.

Built and tested it's working fine, overthat created the new patch.

Thanks to Chanwoo Choi for the review comments and suggestions
---
v3:
  - Chanwoo Choi review comments update
  - replace 'capabiliy' to 'state' in commit message
  - add blank line 
v2:
  - Krzyszto review comments update
  - squash my previous patches 1 to 5 as single patch
  - add extcon_set_property_capability for EXTCON_USB and EXTCON_PROP_USB_TYPEC_POLARITY


Ramuthevar Vadivel Murugan (1):
  extcon: ptn5150: Set the VBUS and POLARITY property capability

 drivers/extcon/extcon-ptn5150.c | 7 +++++++
 1 file changed, 7 insertions(+)

-- 
2.11.0

