Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E09A2C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 23:26:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADE7A20748
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 23:26:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728719AbgHTX0i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 19:26:38 -0400
Received: from mga11.intel.com ([192.55.52.93]:38455 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728498AbgHTX0h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 19:26:37 -0400
IronPort-SDR: NvRIFNIpo3jGD8iw2mXPYOAWx7JBEwY6CI67vcX3ujVI9NrDJCn769lovDmafHNZtISfdfOGmG
 EUacAGIMsIqg==
X-IronPort-AV: E=McAfee;i="6000,8403,9719"; a="153030831"
X-IronPort-AV: E=Sophos;i="5.76,334,1592895600"; 
   d="scan'208";a="153030831"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2020 16:26:37 -0700
IronPort-SDR: 9Ky8mvGz0EN6h1i76ZR7v1lvNDl6DrRr3zpNs9V+NYGDw4SEgSPFiy5VWkb1qrPkhvjvx+kJ6N
 Hj1MJ1KtOSww==
X-IronPort-AV: E=Sophos;i="5.76,334,1592895600"; 
   d="scan'208";a="472830363"
Received: from unknown (HELO dwf-u18040) ([10.232.115.15])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2020 16:26:36 -0700
Message-ID: <0e911fce1c5c6f7dc01263ecdc280e76a0ea202f.camel@linux.intel.com>
Subject: Re: [PATCH 2/2] nvme: add emulation for zone-append
From:   David Fugate <david.fugate@linux.intel.com>
Reply-To: david.fugate@linux.intel.com
To:     Keith Busch <kbusch@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Kanchan Joshi <joshi.k@samsung.com>,
        "Damien.LeMoal@wdc.com" <Damien.LeMoal@wdc.com>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "johannes.thumshirn@wdc.com" <johannes.thumshirn@wdc.com>,
        Nitesh Shetty <nj.shetty@samsung.com>,
        SelvaKumar S <selvakuma.s1@samsung.com>,
        Javier Gonzalez <javier.gonz@samsung.com>,
        david.fugate@intel.com
Date:   Thu, 20 Aug 2020 17:26:35 -0600
In-Reply-To: <20200820034539.GA12222@redsun51.ssa.fujisawa.hgst.com>
References: <20200818052936.10995-1-joshi.k@samsung.com>
         <CGME20200818053256epcas5p46d0b66b3702192eb6617c8bba334c15f@epcas5p4.samsung.com>
         <20200818052936.10995-3-joshi.k@samsung.com> <20200818071249.GB2544@lst.de>
         <b52854fe11640a5a5f54e08b1d3c7a556f97aad5.camel@linux.intel.com>
         <9fa64efe-8477-5d33-20ed-9619a9fe8d70@kernel.dk>
         <d19605da52eb7aa3eb4132ad1781b5fbf636a8a0.camel@linux.intel.com>
         <20200819221054.GB26818@dhcp-10-100-145-180.wdl.wdc.com>
         <d9cc3ece0c70b51c2d40998081375ad3fa39ece2.camel@linux.intel.com>
         <20200820034539.GA12222@redsun51.ssa.fujisawa.hgst.com>
Organization: Intel
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-08-20 at 12:45 +0900, Keith Busch wrote:
> For the record, the suggestion provided, which you agreed to look
> into,
> most broadly enables your hardware on Linux and was entirely to your
> benefit. Not quite as dramatic as a political conspiracy.
> 
> You later responded with a technical argument against that
> suggestion;
> however, your reason didn't add up, and that's where you left the
> thread.

The suggestion to the rejected patch was passed onto the related FW
team, and the "technical argument" was our FW team's response to the
suggestion which I relayed to the list. At this point, there's no
closure on whether the device will get NOIOB.

My point in bringing up this example was a one-line, highly-
maintainable patch which improves the performance of Linux should not
have been immediatedly NAK'ed as it was. If you believe it should have,
we'll agree to disagree.

