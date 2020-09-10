Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2778CC43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 21:20:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF36C206E6
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 21:20:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728215AbgIJVUb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 17:20:31 -0400
Received: from mga02.intel.com ([134.134.136.20]:12068 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731129AbgIJOZ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 10:25:57 -0400
IronPort-SDR: kPO62fZkwfzYhdSQ0dNB85ynMgaYXz1hKWvKIUWeMMTwx9POTo8nOVgLI0RQSyGTwtbEgBSg0Q
 +C5kzvq2/j3g==
X-IronPort-AV: E=McAfee;i="6000,8403,9739"; a="146242409"
X-IronPort-AV: E=Sophos;i="5.76,413,1592895600"; 
   d="scan'208";a="146242409"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2020 07:18:19 -0700
IronPort-SDR: u749v4INZv0nb2WLsGJ89vgi00gipbviohUiUYv71p9n1iqJxIzmd12RqNVm2/xYLH+N+9oTR0
 /7xoZh4vZj2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,413,1592895600"; 
   d="scan'208";a="334188036"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga008.jf.intel.com with ESMTP; 10 Sep 2020 07:18:17 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1kGNOx-00Fhg9-3K; Thu, 10 Sep 2020 17:18:15 +0300
Date:   Thu, 10 Sep 2020 17:18:15 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     Kent Gibson <warthog618@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Subject: Re: [PATCH v5 00/20] gpio: cdev: add uAPI v2
Message-ID: <20200910141815.GW1891694@smile.fi.intel.com>
References: <20200827140020.159627-1-warthog618@gmail.com>
 <CACRpkdZZMbfpKy4gcfAzNq53LkYLcL9wm3Qtzyj_K8vkUW9RfQ@mail.gmail.com>
 <CAMpxmJXRY2wqqN3SzfJN+QTWAHYSYz4vEjLKWU82Y=PAmcm=5w@mail.gmail.com>
 <20200827224742.GA3714@sol>
 <CACRpkdZroNFFsHoBHUFTUUQij7nOcPQiXP-567+fH-Xerv=L4w@mail.gmail.com>
 <20200829013532.GA5905@sol>
 <CAMpxmJWjPzueMeKopo7qFke05CEePVD4YGbUiN7b_STKoYt0ZQ@mail.gmail.com>
 <20200910140949.GV1891694@smile.fi.intel.com>
 <CAMpxmJVG+0ndrnNODv=niNtULBBtGJi+R7LKRh6R1Kex+ef_Cw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMpxmJVG+0ndrnNODv=niNtULBBtGJi+R7LKRh6R1Kex+ef_Cw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 10, 2020 at 04:12:08PM +0200, Bartosz Golaszewski wrote:
> On Thu, Sep 10, 2020 at 4:09 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Tue, Sep 01, 2020 at 11:28:13AM +0200, Bartosz Golaszewski wrote:
> > > On Sat, Aug 29, 2020 at 3:35 AM Kent Gibson <warthog618@gmail.com> wrote:

...

> > > I personally like v6 more. The code is more elegant and we've also
> > > tried limiting GPIO chardev features before and now we're doing v2 so
> > > let's not make the same mistake twice. :)
> > >
> > > I'll try to review v6 in detail later today.
> >
> > Let me briefly review to this. Can you remind which patch has a top level
> > description of what features are provided in comparison to uAPI v1?
> > (Btw, do we have some kind of comparison table?)
> 
> We are now at v8 for this series. The cover letter contains a lot of
> info and patch 4/20 defining the uAPI header explains v2 even more. I
> think these are the most important parts. Any implementation details
> can be fixed later as opposed to the API itself.

Right, thanks for pointers!

-- 
With Best Regards,
Andy Shevchenko


