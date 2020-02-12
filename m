Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 781BAC2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 11:44:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4751920848
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 11:44:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728312AbgBLLow (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 06:44:52 -0500
Received: from mga14.intel.com ([192.55.52.115]:46720 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727987AbgBLLow (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 06:44:52 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Feb 2020 03:44:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,428,1574150400"; 
   d="scan'208";a="347499922"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga001.fm.intel.com with SMTP; 12 Feb 2020 03:44:47 -0800
Received: by lahna (sSMTP sendmail emulation); Wed, 12 Feb 2020 13:44:46 +0200
Date:   Wed, 12 Feb 2020 13:44:46 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Darren Hart <dvhart@infradead.org>,
        Lee Jones <lee.jones@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Zha Qipeng <qipeng.zha@intel.com>,
        "David E . Box" <david.e.box@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 09/18] mfd: intel_soc_pmic: Add SCU IPC member to
 struct intel_soc_pmic
Message-ID: <20200212114446.GY2667@lahna.fi.intel.com>
References: <20200211132603.73509-1-mika.westerberg@linux.intel.com>
 <20200211132603.73509-10-mika.westerberg@linux.intel.com>
 <20200211155706.GH10400@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200211155706.GH10400@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 11, 2020 at 05:57:06PM +0200, Andy Shevchenko wrote:
> On Tue, Feb 11, 2020 at 04:25:54PM +0300, Mika Westerberg wrote:
> > Both PMIC drivers (intel_soc_pmic_mrfld and intel_soc_pmic_bxtwc) will
> > be using this field going forward to access the SCU IPC instance.
> > 
> > While there add kernel-doc for the intel_soc_pmic structure.
> 
> > + * @irq_chip_data_pwrbtn: Chained IRQ chip data for the power button
> > + * @irq_chip_data_tmu: Chained IRQ chip data for the time management unit
> > + * @irq_chip_data_bcu: Chained IRQ chip data for the burst control unit
> > + * @irq_chip_data_adc: Chained IRQ chip data for the general purpose ADC
> > + * @irq_chip_data_chgr: Chained IRQ chip data for the external charger
> > + * @irq_chip_data_crit: Chained IRQ chip data for the critical event handler
> 
> Perhaps capitalize the decoded abbreviation, e.g.
> general purpose ADC -> General Purpose ADC ?

Sure.
