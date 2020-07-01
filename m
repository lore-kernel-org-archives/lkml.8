Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9105C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 10:55:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97898206CB
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 10:55:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730150AbgGAKzz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 06:55:55 -0400
Received: from mga02.intel.com ([134.134.136.20]:39960 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729892AbgGAKzy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 06:55:54 -0400
IronPort-SDR: Ui6JidojlEaxEVB4wEVJ5O5nnfzSYSiB7JED6GD84NuRieGtnIlbfAvNyIDEJAX8uVrH/g/j06
 xF8A6aS/JgbQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9668"; a="134808883"
X-IronPort-AV: E=Sophos;i="5.75,300,1589266800"; 
   d="scan'208";a="134808883"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2020 03:55:53 -0700
IronPort-SDR: GXQIRMxbW+ii2kfDZ+sEivb30yP95UR7z9OHM7b228OGe6+c05HjxdSDhQlnkd6DLe1xX2VwP7
 ccXct5/T+FQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,300,1589266800"; 
   d="scan'208";a="386976297"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga001.fm.intel.com with SMTP; 01 Jul 2020 03:55:51 -0700
Received: by lahna (sSMTP sendmail emulation); Wed, 01 Jul 2020 13:55:50 +0300
Date:   Wed, 1 Jul 2020 13:55:50 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Mario Limonciello <mario.limonciello@dell.com>
Cc:     Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        perry.yuan@dell.com
Subject: Re: [PATCH v3 0/2] Allow breaking up Thunderbolt/USB4 updates
Message-ID: <20200701105550.GR5180@lahna.fi.intel.com>
References: <20200623161429.24214-1-mario.limonciello@dell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200623161429.24214-1-mario.limonciello@dell.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 23, 2020 at 11:14:27AM -0500, Mario Limonciello wrote:
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
> Changes from v2 to v3:
>  - Correct some whitespace and kernel-doc comments
>  - Add another missing 'const'
>  - For a quirk: (1<<1) -> BIT(0) 
> 
> Changes from v1 to v2:
>  - Improve documentation
>  - Drop tb-quirks.h
>  - Adjust function and parameter names to Mika's preferences
>  - Rebase onto thunderbolt.git/bleeding-edge to move on top of retimer work
> 
> Mario Limonciello (2):
>   thunderbolt: Add support for separating the flush to SPI and
>     authenticate
>   thunderbolt: Add support for authenticate on disconnect

Both applied to thunderbolt.git/next, thanks Mario!
