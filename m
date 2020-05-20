Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DDA5C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 16:41:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5AB042065F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 16:41:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726831AbgETQl6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 12:41:58 -0400
Received: from mga07.intel.com ([134.134.136.100]:20746 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726486AbgETQl6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 12:41:58 -0400
IronPort-SDR: ol1UaiOOuLMQ7bmRx6lf0teG/nyvA+v58rwnDRdF9ZexH+DNm9SfYq0NoF7Rqqo0OqMY3TLoYC
 RvSn0egEdqow==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2020 09:41:57 -0700
IronPort-SDR: i1rACb6lLbJf4eWBCXQ8spmHyZDQlF5BDIYFWF52Olgd8g5WBgYTRM06z4toktPZqLnOUSdlWP
 92f2PYNOImsw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,414,1583222400"; 
   d="scan'208";a="253663606"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga007.jf.intel.com with ESMTP; 20 May 2020 09:41:53 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jbRn2-007sEw-9k; Wed, 20 May 2020 19:41:56 +0300
Date:   Wed, 20 May 2020 19:41:56 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        linux-kernel@vger.kernel.org, davidgow@google.com,
        Heidi Fahim <heidifahim@google.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v1] Revert "software node: Simplify
 software_node_release() function"
Message-ID: <20200520164156.GA1634618@smile.fi.intel.com>
References: <20200228000001.240428-1-brendanhiggins@google.com>
 <20200520150227.GA8397@linux-b0ei>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200520150227.GA8397@linux-b0ei>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 20, 2020 at 05:02:27PM +0200, Petr Mladek wrote:
> On Thu 2020-02-27 16:00:01, Brendan Higgins wrote:

> I have found similar report from a test robot, see
> https://lore.kernel.org/lkml/20200303002816.GW6548@shao2-debian/
> 
> 
> I was staring into it for a while and do not understand it. The revert
> makes sense. I wonder if it somehow changes the order in which
> the release methods are called.
> 
> Anyway, reverting the revert makes test_printf working.

There is a proper fix IIRC from Heikki in driver core (no link at hand, sorry).

-- 
With Best Regards,
Andy Shevchenko


