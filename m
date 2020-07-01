Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF3A8C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 10:51:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9930820747
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 10:51:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730114AbgGAKvB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 06:51:01 -0400
Received: from mga07.intel.com ([134.134.136.100]:4288 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729791AbgGAKvB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 06:51:01 -0400
IronPort-SDR: i1r71mXlTJGdL9T6fPgcGdNmgcpoWFaiovfbVayR8sx6yhNLH5nZDvBjPkXKgIrrMXOZw8cG9Q
 iSVWDdrx0iGg==
X-IronPort-AV: E=McAfee;i="6000,8403,9668"; a="211589913"
X-IronPort-AV: E=Sophos;i="5.75,299,1589266800"; 
   d="scan'208";a="211589913"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2020 03:50:59 -0700
IronPort-SDR: fqdJjYt0cdpBdhV9T+5fkkEjx1fpdbgRU0STGFzgfVj1c3WKqbZkEadWiXoQVuy7trbiZuO4AU
 HF4yU22+wEsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,299,1589266800"; 
   d="scan'208";a="386975562"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga001.fm.intel.com with SMTP; 01 Jul 2020 03:50:56 -0700
Received: by lahna (sSMTP sendmail emulation); Wed, 01 Jul 2020 13:50:55 +0300
Date:   Wed, 1 Jul 2020 13:50:55 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Colin King <colin.king@canonical.com>
Cc:     Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        linux-usb@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] thunderbolt: ensure left shift of 512 does not
 overflow a 32 bit int
Message-ID: <20200701105055.GQ5180@lahna.fi.intel.com>
References: <20200630145558.516961-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200630145558.516961-1-colin.king@canonical.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 30, 2020 at 03:55:58PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The 32 bit int value 512 is being left shifted and then used in a context
> that expects the expression to be a larger unsigned long. There may be
> a potential integer overflow, so make 512 a UL before shift to avoid
> any such issues.
> 
> Addresses-Coverity: ("Uninintentional integer overflow")
> Fixes: 3b1d8d577ca8 ("thunderbolt: Implement USB3 bandwidth negotiation routines")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied, thanks!
