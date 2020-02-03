Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C495C33CAC
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 13:34:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E0CD2087E
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 13:34:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727468AbgBCNeF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 08:34:05 -0500
Received: from mga17.intel.com ([192.55.52.151]:64767 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727066AbgBCNeF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 08:34:05 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Feb 2020 05:34:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,398,1574150400"; 
   d="scan'208";a="219385639"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga007.jf.intel.com with ESMTP; 03 Feb 2020 05:34:03 -0800
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1iybrY-0007JL-Nt; Mon, 03 Feb 2020 15:34:04 +0200
Date:   Mon, 3 Feb 2020 15:34:04 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 5/6] console: Introduce ->exit() callback
Message-ID: <20200203133404.GC32742@smile.fi.intel.com>
References: <20200130152558.51839-1-andriy.shevchenko@linux.intel.com>
 <20200130152558.51839-5-andriy.shevchenko@linux.intel.com>
 <20200131013154.GH115889@google.com>
 <20200131112724.GM32742@smile.fi.intel.com>
 <20200201010804.GB1352@jagdpanzerIV.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200201010804.GB1352@jagdpanzerIV.localdomain>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 01, 2020 at 10:08:04AM +0900, Sergey Senozhatsky wrote:
> On (20/01/31 13:27), Andy Shevchenko wrote:

> > > I would probably push it a bit further (I posted this snippet in another
> > > thread). If console is not on the list then there is nothing for us to do
> > > and sysfs notify is pointless.
> > 
> > I didn't see post in the other thread, but I suppose that this snipped is
> > for patch 4 in the series, correct?
> 
> No worries! Yes, for v4.

I guess it was v5 be mentioned above, nevertheless, just sent v5.

-- 
With Best Regards,
Andy Shevchenko


