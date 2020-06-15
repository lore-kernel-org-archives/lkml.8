Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5373C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 11:42:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C90452067B
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 11:42:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729709AbgFOLmB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 07:42:01 -0400
Received: from mga06.intel.com ([134.134.136.31]:2605 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728510AbgFOLmA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 07:42:00 -0400
IronPort-SDR: 91Q3xAoMaLvBjDoge7JYh6gouNrfZooBs5XohVYlkz7xJp0+0/c7DZYUuyx7nYUiWRdQaqZs3U
 rwUsMVt7nFHA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2020 04:42:00 -0700
IronPort-SDR: edMYpNGcbYtkZJpX8hceBY+pUt+jSPsVgX+MAeesOE6QOWngMRTEXaq71faVUlSR10JODscGB0
 8aPpzV2Kk3NQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,514,1583222400"; 
   d="scan'208";a="382521026"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga001.fm.intel.com with SMTP; 15 Jun 2020 04:41:56 -0700
Received: by lahna (sSMTP sendmail emulation); Mon, 15 Jun 2020 14:41:56 +0300
Date:   Mon, 15 Jun 2020 14:41:56 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] thunderbolt: Improve USB4 config symbol help text
Message-ID: <20200615114156.GE247495@lahna.fi.intel.com>
References: <20200602122815.32111-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200602122815.32111-1-geert+renesas@glider.be>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 02, 2020 at 02:28:15PM +0200, Geert Uytterhoeven wrote:
> Fix the spelling of "specification", and add a missing "the" article.
> 
> Fixes: 690ac0d20d4022bb ("thunderbolt: Update Kconfig entries to USB4")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Applied to thunderbolt.git/next, thanks!
