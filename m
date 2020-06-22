Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C73FC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 16:38:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F17A22073E
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 16:38:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729792AbgFVQiA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 12:38:00 -0400
Received: from mga09.intel.com ([134.134.136.24]:45770 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729260AbgFVQiA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 12:38:00 -0400
IronPort-SDR: 9aDMIAudlv/lEvT+ZUeEA7/uq/VReLVbFLjEUN6pspFkwuSVFpkk5MHyVXhiCGo1rW8arDqOcQ
 Df7FA9WczP6w==
X-IronPort-AV: E=McAfee;i="6000,8403,9660"; a="145321772"
X-IronPort-AV: E=Sophos;i="5.75,267,1589266800"; 
   d="scan'208";a="145321772"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2020 09:37:59 -0700
IronPort-SDR: tUatlQhKCXoMlU2i9XOmGEVCNLlPs3jyOOdZIjUT+MC7KpNBMZ6zeCIwkpHCizk0l5JO/fepmN
 cdClWSlqsypg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,267,1589266800"; 
   d="scan'208";a="478444703"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga006.fm.intel.com with SMTP; 22 Jun 2020 09:37:57 -0700
Received: by lahna (sSMTP sendmail emulation); Mon, 22 Jun 2020 19:37:56 +0300
Date:   Mon, 22 Jun 2020 19:37:56 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Mario Limonciello <mario.limonciello@dell.com>
Cc:     Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] Allow breaking up Thunderbolt/USB4 updates
Message-ID: <20200622163756.GV2795@lahna.fi.intel.com>
References: <20200622143035.25327-1-mario.limonciello@dell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200622143035.25327-1-mario.limonciello@dell.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mario,

On Mon, Jun 22, 2020 at 09:30:33AM -0500, Mario Limonciello wrote:
> Currently updates to Thunderbolt and USB4 controllers are fully atomic
> actions. When writing into the non-active NVM nothing gets flushed to
> the hardware until authenticate is sent.
> 
> There has been some desire to improve the perceived performance of these
> updates, particularly for userland that may perform the update upon
> a performance sensitive time like logging out.
> 
> So allow userland to flush the image to hardware at runtime, and then
> allow authenticating the image at another time.
> 
> For the Dell WD19TB some specific hardware capability exists that allows
> extending this to automatically complete the update when unplugged.
> Export that functionality to userspace as well.
> 
> This patch series is done relative thunderbolt.git/next.

Thanks for the patch series. I wonder if you could base this on top of
my "retimer NVM upgrade" series here (you are also Cc'd):

  https://lore.kernel.org/linux-usb/20200616135617.85752-1-mika.westerberg@linux.intel.com/

That series moves some of the common NVM functionality into a separate
file (nvm.c).

> Mario Limonciello (2):
>   thunderbolt: Add support for separating the flush to SPI and
>     authenticate
>   thunderbolt: Add support for authenticate on disconnect
> 
>  .../ABI/testing/sysfs-bus-thunderbolt         | 24 +++++-
>  drivers/thunderbolt/Makefile                  |  1 +
>  drivers/thunderbolt/eeprom.c                  |  2 +
>  drivers/thunderbolt/lc.c                      | 14 ++++
>  drivers/thunderbolt/quirks.c                  | 38 +++++++++
>  drivers/thunderbolt/switch.c                  | 81 +++++++++++++++----
>  drivers/thunderbolt/tb-quirks.h               | 16 ++++
>  drivers/thunderbolt/tb.h                      |  4 +
>  drivers/thunderbolt/tb_regs.h                 |  1 +
>  9 files changed, 162 insertions(+), 19 deletions(-)
>  create mode 100644 drivers/thunderbolt/quirks.c
>  create mode 100644 drivers/thunderbolt/tb-quirks.h
> 
> -- 
> 2.25.1
