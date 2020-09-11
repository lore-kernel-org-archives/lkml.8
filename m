Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFDD5C43461
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 16:40:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A471221EB
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 16:40:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726297AbgIKQkT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 12:40:19 -0400
Received: from mga09.intel.com ([134.134.136.24]:32686 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725848AbgIKQj7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 12:39:59 -0400
IronPort-SDR: ZLyRwnYAKAuOf81/7pb4B5c58IO5GmR8A2I90iPOV8Fs09ruvVK6Yg5t7z5DAS5aHSC84eWd4p
 pq3lzC1N2N4Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9741"; a="159741900"
X-IronPort-AV: E=Sophos;i="5.76,416,1592895600"; 
   d="scan'208";a="159741900"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2020 09:39:59 -0700
IronPort-SDR: UxHoHvY6JGdy6oFJdCShGUqV54JTAXF8LDcmBr7Ede4T+kyU1rOyotJz3yPlbpKz0qnvsU1CBm
 pGIkwB5tUmSw==
X-IronPort-AV: E=Sophos;i="5.76,416,1592895600"; 
   d="scan'208";a="481382696"
Received: from agluck-desk2.sc.intel.com (HELO agluck-desk2.amr.corp.intel.com) ([10.3.52.68])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2020 09:39:58 -0700
Date:   Fri, 11 Sep 2020 09:39:57 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     fenghua.yu@intel.com, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Anant Thazhemadam <anant.thazhemadam@gmail.com>
Subject: Re: [PATCH] ia64: remove perfmon
Message-ID: <20200911163957.GA828@agluck-desk2.amr.corp.intel.com>
References: <20200911094920.1173631-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200911094920.1173631-1-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 11, 2020 at 11:49:19AM +0200, Christoph Hellwig wrote:
> perfmon has been marked broken and thus been disabled for all builds
> for more than two years.  Remove it entirely.
> 
> Cc: Anant Thazhemadam <anant.thazhemadam@gmail.com>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Applied. Thanks

-Tony
