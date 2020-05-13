Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 258F3C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 21:19:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1585120693
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 21:19:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728528AbgEMVTo convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 17:19:44 -0400
Received: from mga17.intel.com ([192.55.52.151]:19677 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726550AbgEMVTn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 17:19:43 -0400
IronPort-SDR: VOHe+ad1SnT3L7MehmLi0l9bw/eN2GL3qQNZgo77pv+qA0aOTYz8VAw9Tu9YAdxOdBERXoKksx
 Cy1i3KtMzMxw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2020 14:19:43 -0700
IronPort-SDR: RX0yGmNOQKORgyPl/FTreZ76qy6kYoQKGZMx7CM1Bxqxe2kPPfi/rpyHbdX/yLFKHzE31Fk8rK
 kbaGW4m7clZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,389,1583222400"; 
   d="scan'208";a="297800373"
Received: from orsmsx102.amr.corp.intel.com ([10.22.225.129])
  by fmsmga002.fm.intel.com with ESMTP; 13 May 2020 14:19:43 -0700
Received: from orsmsx159.amr.corp.intel.com (10.22.240.24) by
 ORSMSX102.amr.corp.intel.com (10.22.225.129) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 13 May 2020 14:19:42 -0700
Received: from orsmsx115.amr.corp.intel.com ([169.254.4.83]) by
 ORSMSX159.amr.corp.intel.com ([169.254.11.195]) with mapi id 14.03.0439.000;
 Wed, 13 May 2020 14:19:42 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
CC:     Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Qais Yousef <qais.yousef@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] ia64: enable HAVE_COPY_THREAD_TLS, switch to
 kernel_clone_args
Thread-Topic: [PATCH] ia64: enable HAVE_COPY_THREAD_TLS, switch to
 kernel_clone_args
Thread-Index: AQHWKWf1Txnaoa1YmEC7x4JwsPvTJaimg9Pg
Date:   Wed, 13 May 2020 21:19:41 +0000
Message-ID: <3908561D78D1C84285E8C5FCA982C28F7F6266E0@ORSMSX115.amr.corp.intel.com>
References: <20200513204848.1208864-1-christian.brauner@ubuntu.com>
In-Reply-To: <20200513204848.1208864-1-christian.brauner@ubuntu.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.22.254.139]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> I tried my very best to test this patch including installing Debian 3
> and 4 to try and get my hands on a gcc version that would allow
> cross-compiling for ia64. But no, even that wasn't possible let alone a
> working qemu for ia64. So this is largely untested but hopefully a
> straightforward change. If this breaks something we will hear from
> people if they still care about new kernels on ia64 since they won't be
> able to get any further than trying to start init. :) If this patch
> breaks it, I'll fix it.

My last functional ia64 machine no longer powers on. Unclear if it's just
a broken power supply or something more serious. With almost nobody
in offices/labs anymore my search for another machine is proceeding
slowly.

Which is to say ... it won't be me noticing any breakage (at least not for
a while).

I think Al Viro bought an ia64 on ebay a while back ... if that's still running
perhaps he'll test?

-Tony
