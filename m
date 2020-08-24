Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59367C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 15:50:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 380652071E
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 15:50:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728048AbgHXPur (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 11:50:47 -0400
Received: from mga07.intel.com ([134.134.136.100]:44571 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727909AbgHXPtN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 11:49:13 -0400
IronPort-SDR: YvltmouDrc1cecNM7en7biBAHd2eaWaVBxSum095qyyO8QtHNivp1O7I/CLOogngaiJE6/XFSA
 aopsb+YXkHyQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9722"; a="220195496"
X-IronPort-AV: E=Sophos;i="5.76,349,1592895600"; 
   d="scan'208";a="220195496"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2020 08:49:12 -0700
IronPort-SDR: dwy0MMhY4TyHvqSc6ftjydstGI/oxXcMexha0Tar/gIT+rHCXNLyuP9h0gusosMAZ5dANHr37C
 zOOhbE9iIWjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,349,1592895600"; 
   d="scan'208";a="281233397"
Received: from lkp-server01.sh.intel.com (HELO c420d4f0765f) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 24 Aug 2020 08:49:09 -0700
Received: from kbuild by c420d4f0765f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kAEib-0000E6-81; Mon, 24 Aug 2020 15:49:09 +0000
Date:   Mon, 24 Aug 2020 23:48:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     Al Cooper <alcooperx@gmail.com>, linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org, Al Cooper <al.cooper@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>
Subject: [RFC PATCH] usb: sync_all_pins() can be static
Message-ID: <20200824154815.GA19019@be043b8c5769>
References: <20200812202018.49046-4-alcooperx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200812202018.49046-4-alcooperx@gmail.com>
X-Patchwork-Hint: ignore
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: kernel test robot <lkp@intel.com>
---
 brcmstb-usb-pinmap.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/host/brcmstb-usb-pinmap.c b/drivers/usb/host/brcmstb-usb-pinmap.c
index 647373b7e53b7a..2dd117d4fcfefc 100644
--- a/drivers/usb/host/brcmstb-usb-pinmap.c
+++ b/drivers/usb/host/brcmstb-usb-pinmap.c
@@ -216,7 +216,7 @@ static int parse_pins(struct device *dev, struct device_node *dn,
 	return 0;
 }
 
-void sync_all_pins(struct brcmstb_usb_pinmap_data *pdata)
+static void sync_all_pins(struct brcmstb_usb_pinmap_data *pdata)
 {
 	struct out_pin *pout;
 	struct in_pin *pin;
