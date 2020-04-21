Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B735EC54FCC
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 13:08:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FBC92068F
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 13:08:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728934AbgDUNIr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 09:08:47 -0400
Received: from mga06.intel.com ([134.134.136.31]:37845 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728337AbgDUNIq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 09:08:46 -0400
IronPort-SDR: nJ5163S7MrKhoCO+Lvs7Hf8dsdL9PU5lD1LVodW8C3/zQdsKWrrAJWFeciIvAWfILaKXqqAvPD
 iNLVhlYN3ytg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2020 06:08:46 -0700
IronPort-SDR: T8IlvodrNAxmEYLLQ/nHkoijm/eF3BnuAZKqEckAVRtbKnoV8eIow+CmoXICZYexkqCSQTvgtZ
 Bq/Ymh5j/7Pw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,410,1580803200"; 
   d="scan'208";a="402181930"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga004.jf.intel.com with ESMTP; 21 Apr 2020 06:08:44 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jQsdq-002F9S-B0; Tue, 21 Apr 2020 16:08:46 +0300
Date:   Tue, 21 Apr 2020 16:08:46 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Jonathan Corbet <corbet@lwn.net>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: Re: [PATCH v3 1/3] lib/vsprintf: Print time64_t in human readable
 format
Message-ID: <20200421130846.GM185537@smile.fi.intel.com>
References: <20200415170046.33374-1-andriy.shevchenko@linux.intel.com>
 <20200415170046.33374-2-andriy.shevchenko@linux.intel.com>
 <20200416023219.GA30641@jagdpanzerIV.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200416023219.GA30641@jagdpanzerIV.localdomain>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 16, 2020 at 11:32:19AM +0900, Sergey Senozhatsky wrote:
> On (20/04/15 20:00), Andy Shevchenko wrote:
> [..]
> >  #include <linux/of.h>
> >  #include <net/addrconf.h>
> > @@ -1819,6 +1820,29 @@ char *rtc_str(char *buf, char *end, const struct rtc_time *tm,
> >  	return buf;
> >  }
> >  
> > +static noinline_for_stack
> > +char *time64_str(char *buf, char *end, const time64_t time,
> > +		 struct printf_spec spec, const char *fmt)
> > +{
> > +	struct rtc_time rtc_time;
> > +	struct tm tm;
> > +
> > +	time64_to_tm(time, 0, &tm);
> > +
> > +	rtc_time.tm_sec = tm.tm_sec;
> > +	rtc_time.tm_min = tm.tm_min;
> > +	rtc_time.tm_hour = tm.tm_hour;
> > +	rtc_time.tm_mday = tm.tm_mday;
> > +	rtc_time.tm_mon = tm.tm_mon;
> > +	rtc_time.tm_year = tm.tm_year;
> > +	rtc_time.tm_wday = tm.tm_wday;
> > +	rtc_time.tm_yday = tm.tm_yday;
> > +
> > +	rtc_time.tm_isdst = 0;
> 
> Here you convert time64_t (signed, we also have unsigned version - timeu64_t)
> to tm first and then convert tm to rtc_time. Will rtc_time64_to_tm() do the
> trick?

You missed v2 round. The RTC is configuration dependent and Alexandre in favour
of removing those from RTC completely by replacing with always enabled
time64_to_tm().

-- 
With Best Regards,
Andy Shevchenko


