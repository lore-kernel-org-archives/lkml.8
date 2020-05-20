Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDC3CC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 10:36:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2DAC207F9
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 10:36:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726836AbgETKgb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 06:36:31 -0400
Received: from mga12.intel.com ([192.55.52.136]:3797 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726403AbgETKga (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 06:36:30 -0400
IronPort-SDR: rPiuc8we8mFlyyIvrJWWkeyzuVdefqSuwOZ0qZkhgbSOc3jyFMMPUflVb+grdtZ89MLzLbzByN
 0++lGqghLLJw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2020 03:36:30 -0700
IronPort-SDR: Z9gd2bzGb7kk/0DmdkeLuKaq6oXc4ERVjBvsJhjIiW+vWXtptU8LfXDhLhr9xSkQDgC7+I/LEc
 qfzTYvfzFPSg==
X-IronPort-AV: E=Sophos;i="5.73,413,1583222400"; 
   d="scan'208";a="253567836"
Received: from paasikivi.fi.intel.com ([10.237.72.42])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2020 03:36:28 -0700
Received: by paasikivi.fi.intel.com (Postfix, from userid 1000)
        id 8382E20CEF; Wed, 20 May 2020 13:36:26 +0300 (EEST)
Date:   Wed, 20 May 2020 13:36:26 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [PATCH v1] drivers property: When no children in primary, try
 secondary
Message-ID: <20200520103626.GY20066@paasikivi.fi.intel.com>
References: <20200520102959.34812-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200520102959.34812-1-andriy.shevchenko@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks, Andy!

On Wed, May 20, 2020 at 01:29:59PM +0300, Andy Shevchenko wrote:
> Software firmware nodes can provide a child node to its parent.
> Since software node can be secondary, we need a mechanism to access
> the children. The idea is to list children of the primary node first
> and when they are finished, continue with secondary node if available.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>

-- 
Sakari Ailus
