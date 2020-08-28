Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9065AC433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 11:56:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 760A42078A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 11:56:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729280AbgH1L4G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 07:56:06 -0400
Received: from mga05.intel.com ([192.55.52.43]:42783 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729254AbgH1Lzl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 07:55:41 -0400
IronPort-SDR: OjAfjTU109U5LwDrpa8Wj2/lR5+TlB8Dc6/DEqoc/2zQUcJE8bzT3BzSEqC3AibqtdjQTycSYb
 Mwpj0phWZOSw==
X-IronPort-AV: E=McAfee;i="6000,8403,9726"; a="241466252"
X-IronPort-AV: E=Sophos;i="5.76,363,1592895600"; 
   d="scan'208";a="241466252"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2020 04:55:41 -0700
IronPort-SDR: CDWVn4pD0d9CtQDC/mBwC1uka+XKmqMRpG6RWdGNE0BXSDn5bFpk6orw5H+MTwo4d6V+AgT+Yx
 Txdd1RlD0UTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,363,1592895600"; 
   d="scan'208";a="403733742"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 28 Aug 2020 04:55:36 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Fri, 28 Aug 2020 14:55:35 +0300
Date:   Fri, 28 Aug 2020 14:55:35 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Rajmohan Mani <rajmohan.mani@intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Ayman Bagabas <ayman.bagabas@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Jithu Joseph <jithu.joseph@intel.com>,
        =?utf-8?B?Qmxhxb4=?= Hrastnik <blaz@mxxn.io>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-usb@vger.kernel.org, pmalani@chromium.org,
        bleung@chromium.org
Subject: Re: [PATCH v2 1/3] platform/x86: Add Intel Input Output Manager
 (IOM) driver
Message-ID: <20200828115535.GD174928@kuha.fi.intel.com>
References: <20200822040508.23510-1-rajmohan.mani@intel.com>
 <20200822040508.23510-2-rajmohan.mani@intel.com>
 <20200828074359.GC942935@kroah.com>
 <20200828090832.GB174928@kuha.fi.intel.com>
 <20200828100335.GB1229122@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200828100335.GB1229122@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 28, 2020 at 12:03:35PM +0200, Greg Kroah-Hartman wrote:
> Handle the situation today, if, in the future, someone else needs/wants
> this, _then_ work on splitting it out into separate pieces.  Don't
> create additional complexity today, for no benefit today.  It's already
> caused numerous review comments/complaints the way this is designed...

OK. We'll handle this in the mux driver for now.


thanks,

-- 
heikki
