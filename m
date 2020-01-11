Return-Path: <SRS0=GvTR=3A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80070C33C9E
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 04:20:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 319D82077C
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 04:20:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728342AbgAKEUH convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 23:20:07 -0500
Received: from mga06.intel.com ([134.134.136.31]:51431 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728324AbgAKEUG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 23:20:06 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Jan 2020 20:20:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,419,1571727600"; 
   d="scan'208";a="212459392"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
  by orsmga007.jf.intel.com with ESMTP; 10 Jan 2020 20:20:05 -0800
Received: from fmsmsx156.amr.corp.intel.com (10.18.116.74) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 10 Jan 2020 20:20:05 -0800
Received: from shsmsx108.ccr.corp.intel.com (10.239.4.97) by
 fmsmsx156.amr.corp.intel.com (10.18.116.74) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 10 Jan 2020 20:20:05 -0800
Received: from shsmsx101.ccr.corp.intel.com ([169.254.1.30]) by
 SHSMSX108.ccr.corp.intel.com ([169.254.8.39]) with mapi id 14.03.0439.000;
 Sat, 11 Jan 2020 12:20:04 +0800
From:   "Liu, Chuansheng" <chuansheng.liu@intel.com>
To:     Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Luck, Tony" <tony.luck@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>
Subject: RE: [PATCH] x86/mce/therm_throt: Fix the access of uninitialized
 therm_work
Thread-Topic: [PATCH] x86/mce/therm_throt: Fix the access of uninitialized
 therm_work
Thread-Index: AQHVxFzlxQRcQtSYTE6XKuL77zdvEafcsTeAgAAA4ICACDBbgA==
Date:   Sat, 11 Jan 2020 04:20:02 +0000
Message-ID: <27240C0AC20F114CBF8149A2696CBE4A61601F7D@SHSMSX101.ccr.corp.intel.com>
References: <20200106064155.64-1-chuansheng.liu@intel.com>
 <20200106070759.GB12238@zn.tnic> <20200106071107.GA95725@gmail.com>
In-Reply-To: <20200106071107.GA95725@gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo,

> -----Original Message-----
> From: Ingo Molnar <mingo.kernel.org@gmail.com> On Behalf Of Ingo Molnar
> Sent: Monday, January 6, 2020 3:11 PM
> To: Borislav Petkov <bp@alien8.de>
> Cc: Liu, Chuansheng <chuansheng.liu@intel.com>; linux-kernel@vger.kernel.org;
> Luck, Tony <tony.luck@intel.com>; tglx@linutronix.de; mingo@redhat.com;
> hpa@zytor.com
> Subject: Re: [PATCH] x86/mce/therm_throt: Fix the access of uninitialized
> therm_work
> 
> * Borislav Petkov <bp@alien8.de> wrote:
> 
> > On Mon, Jan 06, 2020 at 06:41:55AM +0000, Chuansheng Liu wrote:
> > > In ICL platform, it is easy to hit bootup failure with panic
> > > in thermal interrupt handler during early bootup stage.
> > >
> > > Such issue makes my platform almost can not boot up with
> > > latest kernel code.
> > >
> > > The call stack is like:
> > > kernel BUG at kernel/timer/timer.c:1152!
> > >
> > > Call Trace:
> > > __queue_delayed_work
> > > queue_delayed_work_on
> > > therm_throt_process
> > > intel_thermal_interrupt
> > > ...
> > >
> > > When one CPU is up, the irq is enabled prior to CPU UP
> > > notification which will then initialize therm_worker.
> >
> > You mean the unmasking of the thermal vector at the end of
> > intel_init_thermal()?
> >
> > If so, why don't you move that to the end of the notifier and unmask it
> > only after all the necessary work like setting up the workqueues etc, is
> > done, and save yourself adding yet another silly bool?
> 
> A debugging WARN_ON_ONCE() when the workqueue is not initialized yet
> would also be useful I suspect. This would turn any remaining race-crash
> boot failure in this area into a warning.
> 
Just checked the code, the WARN_ON_ONCE() is already there:
1622         WARN_ON_ONCE(timer->function != delayed_work_timer_fn);

With reproducing it, the corresponding log also shows before panic:
WARNING: CPU: 0 .... at kernel/workqueue.c:1622 __queue_delayed_work+0x73/0x90

Thanks for your reminder.

