Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89871C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 10:08:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63BB6206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 10:08:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387731AbgE1KIK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 06:08:10 -0400
Received: from mga18.intel.com ([134.134.136.126]:46347 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387624AbgE1KII (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 06:08:08 -0400
IronPort-SDR: yj9bYpMAfDabcsP635o9OgsE5VR0GDN17cCJ6pnzS37FsHWJ9mdJDJwbe49DlbfY9D2MTdNj/m
 Vuu+HJKS8PgA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2020 03:08:07 -0700
IronPort-SDR: f0QxIkCXMLpT7uPGwjlQr/w3sy+LgAkB6jAzbE0bp7IxkzPCC4JoUQbaRhXNnXItyFYmyzVX9o
 8W4eyG73WF9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,444,1583222400"; 
   d="scan'208";a="345862249"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga001.jf.intel.com with ESMTP; 28 May 2020 03:08:05 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andy.shevchenko@gmail.com>)
        id 1jeFSK-009PCc-Aq; Thu, 28 May 2020 13:08:08 +0300
Date:   Thu, 28 May 2020 13:08:08 +0300
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
To:     Michael Walle <michael@walle.cc>
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v4 2/2] gpio: add a reusable generic gpio_chip using
 regmap
Message-ID: <20200528100808.GI1634618@smile.fi.intel.com>
References: <20200525160741.21729-1-michael@walle.cc>
 <20200525160741.21729-3-michael@walle.cc>
 <d245b4f5-065f-4c82-ef8e-d906b363fdcf@linux.intel.com>
 <6d08ebbfbc9f656cb5650ede988cf36d@walle.cc>
 <fe44039a-4fa9-dab3-cd14-04967b729158@linux.intel.com>
 <143ec2f44c881706db9744465328329f@walle.cc>
 <CAHp75Vf7XxNFJMSOr6SzKHm0tssEVKzokaEeZ8nts5xQ2hQLNA@mail.gmail.com>
 <0d4bce3de91df9526ada76f4f2347d25@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0d4bce3de91df9526ada76f4f2347d25@walle.cc>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 28, 2020 at 10:46:56AM +0200, Michael Walle wrote:
> Am 2020-05-28 10:37, schrieb Andy Shevchenko:
> > On Thu, May 28, 2020 at 7:11 AM Michael Walle <michael@walle.cc> wrote:
> > > Am 2020-05-28 02:31, schrieb Pierre-Louis Bossart:
> > 
> > 
> > > I've send a v5 with that fix and your names property.
> > 
> > Did you already?
> 
> Yes, I forgot to add you :(
> 
> > Because I have a question why we have gpio-regmap.h instead of
> > gpio/regmap.h ?
> 
> No particular reason, I thought gpio/ was for low level gpio stuff (like
> the consumer.h, driver.h etc) or lets say - more integrated stuff.
> 
> I don't have a strong opinion. I can send a v6 with that change, on
> short notice if the maintainers prefer that location.

I guess it's quite close to core and belongs to GPIO family of headers, I
definitely would like to see it there, but let's wait for Linus and Bart to
speak up.

-- 
With Best Regards,
Andy Shevchenko


