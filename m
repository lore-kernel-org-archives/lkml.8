Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7249EC3F2D7
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 15:58:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5532A222C4
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 15:58:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727357AbgCBP6T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 10:58:19 -0500
Received: from mga07.intel.com ([134.134.136.100]:58152 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727085AbgCBP6S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 10:58:18 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Mar 2020 07:58:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,507,1574150400"; 
   d="scan'208";a="438321722"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga005.fm.intel.com with ESMTP; 02 Mar 2020 07:58:16 -0800
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1j8nSU-006Ibe-Ru; Mon, 02 Mar 2020 17:58:18 +0200
Date:   Mon, 2 Mar 2020 17:58:18 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Winkler, Tomas" <tomas.winkler@intel.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v1] mei: Don't encourage to use kernel internal types in
 user code
Message-ID: <20200302155818.GG1224808@smile.fi.intel.com>
References: <20200228151328.45062-1-andriy.shevchenko@linux.intel.com>
 <3bb5abe91919458aa6166eb60d9451ff@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3bb5abe91919458aa6166eb60d9451ff@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Cc: Christoph.

On Sat, Feb 29, 2020 at 04:28:11PM +0000, Winkler, Tomas wrote:
> > uuid_le is internal kernel type which shall not be exposed to the user in the first
> > place. 
> Why, these types are exported via include/uapi/linux/uuid.h

Which is wrong from the day 1.

The uuid_t type is being provided by libuuid in the user space, there is no
(more) kernel exported equivalent. Same should be done to the uuid_le.

We already discussed this couple of years ago.

> In order to mitigate the (wrong) distribution of the use of that type,
> > switch MEI AMT sample to plain unsigned char array.
> 
> There was a change to guid_t from uuild_le, anyhow there is much more code
>  except this sample that uses those types. 

I guess you misunderstood the point. The types are for kernel use and keeping them
exported in a condition like it's now (quoter baked due to drop of uuid_be part
completely and uuid_le partially) is wrong.

There is *no* ABI change. And basically libuuid or another one should provide
type and infrastructure for this.

> Nack so far.

If you would like to bear the legacy type, why not to move this UUID UAPI parts
directly to MEI?

-- 
With Best Regards,
Andy Shevchenko


