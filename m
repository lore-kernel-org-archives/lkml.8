Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E310CC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 13:07:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6E9C2076C
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 13:07:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728670AbgHKNHI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 09:07:08 -0400
Received: from mga04.intel.com ([192.55.52.120]:31994 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728619AbgHKNHI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 09:07:08 -0400
IronPort-SDR: mdAPz45f+KJIjUrLrDy0EB983Bp8x5Yk0RENUClZhpoQjNIGJoZTR+ambye7tEJjMgXpO5oWEJ
 s/S2rZCQfkQg==
X-IronPort-AV: E=McAfee;i="6000,8403,9709"; a="151159529"
X-IronPort-AV: E=Sophos;i="5.75,461,1589266800"; 
   d="scan'208";a="151159529"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2020 06:07:07 -0700
IronPort-SDR: q7TSaGA3zgBY9VQdB2f9iIBrK8SgrW02ME3wO9czPhvx2EdQyeX/wTxVCBnXuDXkSzJDW7BQR5
 c4tCTsddmv3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,461,1589266800"; 
   d="scan'208";a="398520755"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 11 Aug 2020 06:07:04 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 11 Aug 2020 16:07:03 +0300
Date:   Tue, 11 Aug 2020 16:07:03 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Prashant Malani <pmalani@chromium.org>,
        "Shaikh, Azhar" <azhar.shaikh@intel.com>
Cc:     "bleung@chromium.org" <bleung@chromium.org>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        "groeck@chromium.org" <groeck@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Patel, Utkarsh H" <utkarsh.h.patel@intel.com>,
        "Bowman, Casey G" <casey.g.bowman@intel.com>,
        "Mani, Rajmohan" <rajmohan.mani@intel.com>
Subject: Re: [PATCH v2 2/2] platform/chrome: cros_ec_typec: Avoid setting usb
 role during disconnect
Message-ID: <20200811130703.GA627773@kuha.fi.intel.com>
References: <20200730225609.7395-1-azhar.shaikh@intel.com>
 <20200730225609.7395-3-azhar.shaikh@intel.com>
 <20200730230238.GD3145664@google.com>
 <MWHPR11MB1518178C5B2335FC02CD36AE91710@MWHPR11MB1518.namprd11.prod.outlook.com>
 <20200730232504.GG3145664@google.com>
 <MWHPR11MB151867DF25664C80E99A326D914B0@MWHPR11MB1518.namprd11.prod.outlook.com>
 <CACeCKaf6WuW6XbFBQoVEW55w=OHfaVmmDn1xepiYYeRyMzZFrA@mail.gmail.com>
 <20200806113907.GX883641@kuha.fi.intel.com>
 <CACeCKaeLmVudhssvnYrQGmnJiD-byW8jOas1QKyQj4gg0=sC4A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACeCKaeLmVudhssvnYrQGmnJiD-byW8jOas1QKyQj4gg0=sC4A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Aug 06, 2020 at 11:39:08AM -0700, Prashant Malani wrote:
> I would suggest:
> - Merging Patch 1 (role set correction) and Patch 2 (moving the
> usb_role_switch_set_role() inside cros_typec_configure_mux()
> *but* keep it at the end to preserve existing ordering) into 1 patch.
> - Add another patch which re-orders the calls and which in the commit
> message lists out all the reasons why this re-ordering
> needs to be done.
> 
> Doing the above will help keep better track of why the changes were made.

So Azhar can you please prepare v3?


thanks,

-- 
heikki
