Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76017C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 09:09:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36F0920792
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 09:09:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728042AbgHEJJl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 05:09:41 -0400
Received: from mga11.intel.com ([192.55.52.93]:47285 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726175AbgHEJJk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 05:09:40 -0400
IronPort-SDR: 0UNVwP11W/51VEfColG0lus07NmkDyTg8pVQBpjphVY18nHTisuBxKCPPiBeFrpT96P+S+ZLB2
 3fc9OmYGNw0w==
X-IronPort-AV: E=McAfee;i="6000,8403,9703"; a="150263827"
X-IronPort-AV: E=Sophos;i="5.75,436,1589266800"; 
   d="scan'208";a="150263827"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2020 02:09:39 -0700
IronPort-SDR: pZjmzCSgBhyzSFmuJe7zO81sEaEyxy7DsD+baqFeQCx3BaOQV118xzOGlMH5wcZ3ZNNdUzv5di
 avpduYw0gHCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,436,1589266800"; 
   d="scan'208";a="396857031"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 05 Aug 2020 02:09:35 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 05 Aug 2020 12:09:35 +0300
Date:   Wed, 5 Aug 2020 12:09:34 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Azhar Shaikh <azhar.shaikh@intel.com>
Cc:     bleung@chromium.org, enric.balletbo@collabora.com,
        groeck@chromium.org, pmalani@chromium.org,
        linux-kernel@vger.kernel.org, utkarsh.h.patel@intel.com,
        casey.g.bowman@intel.com, rajmohan.mani@intel.com
Subject: Re: [PATCH v2 0/2] TypeC Connector Class driver improvements
Message-ID: <20200805090934.GV883641@kuha.fi.intel.com>
References: <20200730225609.7395-1-azhar.shaikh@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200730225609.7395-1-azhar.shaikh@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 30, 2020 at 03:56:07PM -0700, Azhar Shaikh wrote:
> Changes in v2:
> * Patch 1: "platform/chrome: cros_ec_typec: Send enum values to
>             usb_role_switch_set_role()"
>   * Update the commit message to change 'USB_ROLE_HOST in case of
>     UFP.'  to 'USB_ROLE_HOST in case of DFP.'
> 
> * Patch 2: "platform/chrome: cros_ec_typec: Avoid setting usb role twice
>             during disconnect"
>   * New patch added.
> 
> Azhar Shaikh (2):
>   platform/chrome: cros_ec_typec: Send enum values to
>     usb_role_switch_set_role()
>   platform/chrome: cros_ec_typec: Avoid setting usb role twice during
>     disconnect
> 
>  drivers/platform/chrome/cros_ec_typec.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)

I've lost track of this topic. There are threads with subject "[PATCH
v2 0/2] TypeC Connector Class driver improvements" in my inbox? I
guess one of them was supposed to be v3?

Please send the v3 with proper change log. Let's start over.

thanks,

-- 
heikki
