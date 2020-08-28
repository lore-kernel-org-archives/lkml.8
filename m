Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDC96C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 13:43:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 902C0208C9
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 13:43:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729626AbgH1Nng (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 09:43:36 -0400
Received: from mga05.intel.com ([192.55.52.43]:50705 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729548AbgH1NkM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 09:40:12 -0400
IronPort-SDR: XBpWw5RKAnVwaco9YxKRcH2ZPU5mYYSruaMgG4dbl4S4o8rGOU2QfXdhzogct6bgkGDFqvNsQb
 II8HyONpwaqg==
X-IronPort-AV: E=McAfee;i="6000,8403,9726"; a="241479069"
X-IronPort-AV: E=Sophos;i="5.76,363,1592895600"; 
   d="scan'208";a="241479069"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2020 06:36:18 -0700
IronPort-SDR: Rr08q6WrtP/vyNPM8WWINEBmTc7N4MsNykE3hPre/qvTrTWfgSrLuaC3y059yZIEonGy8xaKM/
 b8l3MJxqPhRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,363,1592895600"; 
   d="scan'208";a="329954213"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga008.jf.intel.com with ESMTP; 28 Aug 2020 06:36:15 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1kBeY8-00C7um-G2; Fri, 28 Aug 2020 16:36:12 +0300
Date:   Fri, 28 Aug 2020 16:36:12 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     syzbot <syzbot+7a7613e5ba9ae7bd15f9@syzkaller.appspotmail.com>
Cc:     bigeasy@linutronix.de, felipe.balbi@linux.intel.com,
        gregkh@linuxfoundation.org, joe@perches.com, johan@kernel.org,
        kai.heng.feng@canonical.com, keescook@chromium.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        rafael.j.wysocki@intel.com, stern@rowland.harvard.edu,
        syzkaller-bugs@googlegroups.com
Subject: Re: INFO: task hung in usb_bulk_msg
Message-ID: <20200828133612.GR1891694@smile.fi.intel.com>
References: <000000000000d3c499057536ce86@google.com>
 <000000000000c69c7805adef8597@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000c69c7805adef8597@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 28, 2020 at 05:52:16AM -0700, syzbot wrote:
> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    15bc20c6 Merge tag 'tty-5.9-rc3' of git://git.kernel.org/p..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=1052a669900000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=978db74cb30aa994
> dashboard link: https://syzkaller.appspot.com/bug?extid=7a7613e5ba9ae7bd15f9
> compiler:       gcc (GCC) 10.1.0-syz 20200507
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=101c328e900000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=155eff41900000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+7a7613e5ba9ae7bd15f9@syzkaller.appspotmail.com

I have had hard times to understand the link between tty subsystem and this
report. Also I'm wondering how 'Maintainers' column is formed in the dashboard
view. And how the Cc list of this message in particular.

-- 
With Best Regards,
Andy Shevchenko


