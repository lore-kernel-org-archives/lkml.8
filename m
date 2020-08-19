Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40FB1C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 19:12:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19083207BB
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 19:12:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726815AbgHSTMB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 15:12:01 -0400
Received: from mga12.intel.com ([192.55.52.136]:19300 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725997AbgHSTMA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 15:12:00 -0400
IronPort-SDR: PBwhhetZ+lbxj+QM9dts/H5lOiH7xvHUOad1VFfBs5XJ1NX9Ax/Ijy16appWOY4zSIftlAg95r
 CEPszwQ75qJg==
X-IronPort-AV: E=McAfee;i="6000,8403,9718"; a="134705186"
X-IronPort-AV: E=Sophos;i="5.76,332,1592895600"; 
   d="scan'208";a="134705186"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2020 12:11:59 -0700
IronPort-SDR: OZiP4TSX2CGzEbsrbEbgO/L1SigWcyMus4uNFG7SuZdnuwRJsPsI4raA3IUk/XZm6VABXHYSE6
 5evmasYNJRDA==
X-IronPort-AV: E=Sophos;i="5.76,332,1592895600"; 
   d="scan'208";a="278408392"
Received: from dfugate-mobl1.amr.corp.intel.com (HELO dwf-u18040) ([10.212.117.189])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2020 12:11:59 -0700
Message-ID: <b52854fe11640a5a5f54e08b1d3c7a556f97aad5.camel@linux.intel.com>
Subject: Re: [PATCH 2/2] nvme: add emulation for zone-append
From:   David Fugate <david.fugate@linux.intel.com>
Reply-To: david.fugate@linux.intel.com
To:     Christoph Hellwig <hch@lst.de>, Kanchan Joshi <joshi.k@samsung.com>
Cc:     "kbusch@kernel.org" <kbusch@kernel.org>,
        "Damien.LeMoal@wdc.com" <Damien.LeMoal@wdc.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "johannes.thumshirn@wdc.com" <johannes.thumshirn@wdc.com>,
        Nitesh Shetty <nj.shetty@samsung.com>,
        SelvaKumar S <selvakuma.s1@samsung.com>,
        Javier Gonzalez <javier.gonz@samsung.com>
Date:   Wed, 19 Aug 2020 13:11:58 -0600
In-Reply-To: <20200818071249.GB2544@lst.de>
References: <20200818052936.10995-1-joshi.k@samsung.com>
         <CGME20200818053256epcas5p46d0b66b3702192eb6617c8bba334c15f@epcas5p4.samsung.com>
         <20200818052936.10995-3-joshi.k@samsung.com> <20200818071249.GB2544@lst.de>
Organization: Intel
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-08-18 at 07:12 +0000, Christoph Hellwig wrote:
> On Tue, Aug 18, 2020 at 10:59:36AM +0530, Kanchan Joshi wrote:
> > If drive does not support zone-append natively, enable emulation
> > using
> > regular write.
> > Make emulated zone-append cmd write-lock the zone, preventing
> > concurrent append/write on the same zone.
> 
> I really don't think we should add this.  ZNS and the Linux support
> were all designed with Zone Append in mind, and then your company did
> the nastiest possible move violating the normal NVMe procedures to
> make
> it optional.  But that doesn't change the fact the Linux should keep
> requiring it, especially with the amount of code added here and how
> it
> hooks in the fast path.

Intel does not support making *optional* NVMe spec features *required*
by the NVMe driver. 

It's forgivable WDC's accepted contribution didn't work with other
vendors' devices choosing not to implement the optional Zone Append,
but it's not OK to reject contributions remedying this.  Provided
there's no glaring technical issues, Samsung's contribution should be
accepted to maintain both spec compliance as well as vendor neutrality.


