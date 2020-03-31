Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8F73C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 16:59:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2B6720786
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 16:59:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731027AbgCaQ7F convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 12:59:05 -0400
Received: from mga17.intel.com ([192.55.52.151]:40607 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730099AbgCaQ7F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 12:59:05 -0400
IronPort-SDR: NR3ohADNYrgM8LMxAUPO6uiMThMTeFdAuf0tTFMX0LyUkpPpVI4MmOeMfvpwHoIp8iKy6XEkv2
 4RPTIhk3XrXg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2020 09:59:04 -0700
IronPort-SDR: QNddGzEaR41Pk1kARx6T6NkTrtuIMdCBDVlORF3OqMAFpD3VKw819q8WU+hSRa2fE/WlJ3rpus
 Ju9dX72Xz4cA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,328,1580803200"; 
   d="scan'208";a="359559293"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
  by fmsmga001.fm.intel.com with ESMTP; 31 Mar 2020 09:59:03 -0700
Received: from fmsmsx126.amr.corp.intel.com (10.18.125.43) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 31 Mar 2020 09:59:03 -0700
Received: from fmsmsx101.amr.corp.intel.com ([169.254.1.121]) by
 FMSMSX126.amr.corp.intel.com ([169.254.1.221]) with mapi id 14.03.0439.000;
 Tue, 31 Mar 2020 09:59:03 -0700
From:   "Keller, Jacob E" <jacob.e.keller@intel.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jiri Pirko <jiri@mellanox.com>
CC:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next] netdevsim: dev: Fix memory leak in
 nsim_dev_take_snapshot_write
Thread-Topic: [PATCH net-next] netdevsim: dev: Fix memory leak in
 nsim_dev_take_snapshot_write
Thread-Index: AQHWBurBnbLOF3VzoE2u5DvbpZ6iMKhi7WBA
Date:   Tue, 31 Mar 2020 16:59:02 +0000
Message-ID: <02874ECE860811409154E81DA85FBB58B6CABF0F@fmsmsx101.amr.corp.intel.com>
References: <20200330232702.GA3212@embeddedor.com>
In-Reply-To: <20200330232702.GA3212@embeddedor.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.1.200.106]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Gustavo A. R. Silva <gustavo@embeddedor.com>
> Sent: Monday, March 30, 2020 4:27 PM
> To: Jakub Kicinski <kuba@kernel.org>; David S. Miller <davem@davemloft.net>;
> Keller, Jacob E <jacob.e.keller@intel.com>; Jiri Pirko <jiri@mellanox.com>
> Cc: netdev@vger.kernel.org; linux-kernel@vger.kernel.org; Gustavo A. R. Silva
> <gustavo@embeddedor.com>
> Subject: [PATCH net-next] netdevsim: dev: Fix memory leak in
> nsim_dev_take_snapshot_write
> 
> In case memory resources for dummy_data were allocated, release them
> before return.
> 
> Addresses-Coverity-ID: 1491997 ("Resource leak")
> Fixes: 7ef19d3b1d5e ("devlink: report error once U32_MAX snapshot ids have
> been used")
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---

Ahh! Thanks!

Belated Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

