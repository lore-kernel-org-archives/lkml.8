Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BD8EC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 11:48:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0222520672
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 11:48:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733114AbgF3Lsz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 07:48:55 -0400
Received: from mga11.intel.com ([192.55.52.93]:38196 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728419AbgF3Lsz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 07:48:55 -0400
IronPort-SDR: g68+hleK2PBihtnis3D2iThpaLCWSXzz2pPSTs37mN1vKvAinIucUHE2cgsQRHbVwPbLpoGYb4
 sqQoQKNpdPBw==
X-IronPort-AV: E=McAfee;i="6000,8403,9666"; a="144393104"
X-IronPort-AV: E=Sophos;i="5.75,297,1589266800"; 
   d="scan'208";a="144393104"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2020 04:48:54 -0700
IronPort-SDR: ihgcD26HSd3er82WHpBPNsTmfMXWuX0VTAgCQbXncFKlSOgMMooZOmtHqZSTtOqA03umGNVwON
 cM8cyw3LULCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,297,1589266800"; 
   d="scan'208";a="386674833"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga001.fm.intel.com with ESMTP; 30 Jun 2020 04:48:52 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jqEkv-00Gpqe-Gf; Tue, 30 Jun 2020 14:48:53 +0300
Date:   Tue, 30 Jun 2020 14:48:53 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     Cengiz Can <cengiz@kernel.wtf>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        kgdb-bugreport@lists.sourceforge.net,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH v3] kdb: remove unnecessary null check of dbg_io_ops
Message-ID: <20200630114853.GS3703480@smile.fi.intel.com>
References: <CAFA6WYNpCG2xPERd=NeKf+EthbX+1R4iieOL52kWnBp8y_+Nbw@mail.gmail.com>
 <20200630082922.28672-1-cengiz@kernel.wtf>
 <CAFA6WYPDTKQ4cm+TMmRt+qDiF+s3gggCsW1gfzCaaOdP9rJgdQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFA6WYPDTKQ4cm+TMmRt+qDiF+s3gggCsW1gfzCaaOdP9rJgdQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 30, 2020 at 05:06:31PM +0530, Sumit Garg wrote:
> On Tue, 30 Jun 2020 at 14:00, Cengiz Can <cengiz@kernel.wtf> wrote:
> >
> > `kdb_msg_write` operates on a global `struct kgdb_io *` called
> > `dbg_io_ops`.
> >
> > It's initialized in `debug_core.c` and checked throughout the debug
> > flow.
> >
> > There's a null check in `kdb_msg_write` which triggers static analyzers
> > and gives the (almost entirely wrong) impression that it can be null.
> >
> > Coverity scanner caught this as CID 1465042.
> >
> > I have removed the unnecessary null check and eliminated false-positive
> > forward null dereference warning.

> > -               while (len--) {
> > -                       dbg_io_ops->write_char(*cp);
> > -                       cp++;
> > -               }
> > +       while (len--) {
> > +               dbg_io_ops->write_char(*cp);
> > +               cp++;
> >         }

Despite being in the original code this can be simple done in two lines:

	while (len--)
		dbg_io_ops->write_char(*cp++);

-- 
With Best Regards,
Andy Shevchenko


