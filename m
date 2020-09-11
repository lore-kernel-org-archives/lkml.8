Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ED29C2BC11
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 14:58:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC3C8223EA
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 14:58:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725899AbgIKO6T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 10:58:19 -0400
Received: from mga09.intel.com ([134.134.136.24]:12029 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726164AbgIKNCU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 09:02:20 -0400
IronPort-SDR: Wd+2uOTNEzGy4O4pazBAlzFQ6kG02QT2HwaJ5lPwkoLBoP/CepI0c2ifse6n7r2Ye80L5aiXP2
 qRtRtcyq4M/A==
X-IronPort-AV: E=McAfee;i="6000,8403,9740"; a="159685862"
X-IronPort-AV: E=Sophos;i="5.76,415,1592895600"; 
   d="scan'208";a="159685862"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2020 06:01:43 -0700
IronPort-SDR: YxYGhDnkS5Dha/oBPbDG7FhDSfZt3RGHWvjLpIcxHb3XNd3yepGxu9+OmPSJyDEfAxjey+JZg6
 vHs0cqdTHqwQ==
X-IronPort-AV: E=Sophos;i="5.76,415,1592895600"; 
   d="scan'208";a="318269669"
Received: from paasikivi.fi.intel.com ([10.237.72.42])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2020 06:01:39 -0700
Received: by paasikivi.fi.intel.com (Postfix, from userid 1000)
        id 3695A2079D; Fri, 11 Sep 2020 16:01:37 +0300 (EEST)
Date:   Fri, 11 Sep 2020 16:01:37 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Bingbu Cao <bingbu.cao@linux.intel.com>
Cc:     linux-i2c@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rajmohan.mani@intel.com, Tomasz Figa <tfiga@chromium.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Bingbu Cao <bingbu.cao@intel.com>,
        Chiranjeevi Rapolu <chiranjeevi.rapolu@intel.com>,
        Hyungwoo Yang <hyungwoo.yang@intel.com>,
        linux-media@vger.kernel.org
Subject: Re: [PATCH v8 3/6] ACPI: Add a convenience function to tell a device
 is in low power state
Message-ID: <20200911130137.GG26842@paasikivi.fi.intel.com>
References: <20200903081550.6012-1-sakari.ailus@linux.intel.com>
 <20200903081550.6012-4-sakari.ailus@linux.intel.com>
 <0c2d4728-6e32-ef93-8961-381fe36cfdaa@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0c2d4728-6e32-ef93-8961-381fe36cfdaa@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 10, 2020 at 08:06:06PM +0800, Bingbu Cao wrote:
...
> > @@ -987,6 +988,10 @@ static inline int acpi_dev_pm_attach(struct device *dev, bool power_on)
> >  {
> >  	return 0;
> >  }
> 
> Need a blank line here, ;).

I'll add that for v9.

-- 
Sakari Ailus
