Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB5B4C33CAC
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 10:05:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1DF12082E
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 10:05:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727635AbgBCKFD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 05:05:03 -0500
Received: from mga12.intel.com ([192.55.52.136]:11975 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727571AbgBCKE6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 05:04:58 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Feb 2020 02:04:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,397,1574150400"; 
   d="scan'208";a="225122177"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga008.fm.intel.com with ESMTP; 03 Feb 2020 02:04:56 -0800
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1iyYbB-00058x-TN; Mon, 03 Feb 2020 12:04:57 +0200
Date:   Mon, 3 Feb 2020 12:04:57 +0200
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc:     Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        ibm-acpi-devel@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] platform/x86: thinkpad_acpi: remove unused defines
Message-ID: <20200203100457.GB32742@smile.fi.intel.com>
References: <20200131143650.4149-1-linux@weissschuh.net>
 <20200131143650.4149-2-linux@weissschuh.net>
 <20200203100043.GZ32742@smile.fi.intel.com>
 <20200203100211.GA32742@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200203100211.GA32742@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 03, 2020 at 12:02:11PM +0200, Andy Shevchenko wrote:
> On Mon, Feb 03, 2020 at 12:00:43PM +0200, Andy Shevchenko wrote:
> > On Fri, Jan 31, 2020 at 03:36:48PM +0100, Thomas Weißschuh wrote:
> > > They were never used.
> > 
> > Thanks for the series.
> > 
> > Unfortunately I may not proceed it since it misses our patchwork [1]
> > for some reason.
> 
> Oh, sorry! It misses our *mailing list* while patchwork is good.

Found your mails in archive (on the Web), so, it seems Google (gmail) doesn't
like them.

It seems no issue on your side. Anyway, I'm waiting for v3 as commented
previously.

> > Besides that, this patch is okay, but the rest two must be:
> >  - unified together to avoid regression in the middle
> >  - done other way around, simple add aliases to *old* ones
> > 
> > Don't forget to update any documentation if needed.
> > 
> > [1]: https://patchwork.kernel.org/project/platform-driver-x86/list/

-- 
With Best Regards,
Andy Shevchenko


