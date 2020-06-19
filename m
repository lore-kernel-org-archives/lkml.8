Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 464ACC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 01:28:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 295B820773
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 01:28:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730198AbgFSB1N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 21:27:13 -0400
Received: from mga18.intel.com ([134.134.136.126]:27889 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727045AbgFSB1M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 21:27:12 -0400
IronPort-SDR: JxOop8CHUaG+EnReltG2xM1d6YX9E6wAqnd4CkWaky90NtZzigxLdN7HmZwHftTO9QRgnMHgk4
 ZCXpxo0JX4ZA==
X-IronPort-AV: E=McAfee;i="6000,8403,9656"; a="130157185"
X-IronPort-AV: E=Sophos;i="5.75,253,1589266800"; 
   d="scan'208";a="130157185"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2020 18:27:12 -0700
IronPort-SDR: kutyfQht+s9SOvyPInPenXhxoCU9kZEa3l2+nnHwyqrkAPx82bCtTyEnDVEPCjAnCr4zNBjTFQ
 Dgofl5AHEhQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,253,1589266800"; 
   d="scan'208";a="299895109"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.141])
  by fmsmga004.fm.intel.com with ESMTP; 18 Jun 2020 18:27:10 -0700
Date:   Fri, 19 Jun 2020 09:23:28 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        trix@redhat.com, hao.wu@intel.com, matthew.gerlach@linux.intel.com,
        russell.h.weight@intel.com
Subject: Re: [PATCH v2 0/6] add regmap & indirect access support
Message-ID: <20200619012328.GA8641@yilunxu-OptiPlex-7050>
References: <1592493910-30473-1-git-send-email-yilun.xu@intel.com>
 <20200618153539.GM5789@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200618153539.GM5789@sirena.org.uk>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 18, 2020 at 04:35:39PM +0100, Mark Brown wrote:
> On Thu, Jun 18, 2020 at 11:25:07PM +0800, Xu Yilun wrote:
> > Updated the regmap & indirect access support for spi-altera.
> > 
> > Patch #1, #2, #3 is already applied.
> 
> The numbering for patches within a series is there *only* to say what
> order things need to go in in that posting, they don't have any
> relevance from one posting to another.  Sending a series with some
> numbers missing causes a lot of confusion since it's not clear which
> patches even exist.

Thanks for your guidance. I'll take care of it.

Think I should re-send this patch to make it clear.


