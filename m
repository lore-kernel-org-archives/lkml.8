Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92604C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 05:56:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76DF3206C3
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 05:56:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726550AbgFDF4d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 01:56:33 -0400
Received: from mga18.intel.com ([134.134.136.126]:35886 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726104AbgFDF4d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 01:56:33 -0400
IronPort-SDR: VdBwf73mEmuIT44kbrJFXHxKjj0pP2oUkkWw8kRn6ghFkWcujUoXw5CqBwXps2Ez/xcjTF6wvC
 ZMDmtIFy8+sQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2020 22:56:31 -0700
IronPort-SDR: /xfoCmiTbSF1eIMa6iM7jAiEFqX6Yzz6/VdWX8tNSn27aeS7EaSn0GQ1+2/wbAJ5DtWfmyBOjm
 TRKWlobwUJCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,471,1583222400"; 
   d="scan'208";a="378317789"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga001.fm.intel.com with SMTP; 03 Jun 2020 22:56:28 -0700
Received: by lahna (sSMTP sendmail emulation); Thu, 04 Jun 2020 08:56:27 +0300
Date:   Thu, 4 Jun 2020 08:56:27 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] thunderbolt: Improve USB4 config symbol help text
Message-ID: <20200604055627.GI247495@lahna.fi.intel.com>
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

Hi,

On Tue, Jun 02, 2020 at 02:28:15PM +0200, Geert Uytterhoeven wrote:
> Fix the spelling of "specification", and add a missing "the" article.
> 
> Fixes: 690ac0d20d4022bb ("thunderbolt: Update Kconfig entries to USB4")

Maybe Fixes tag here is too strong. It is simply fixing a typo :)

I will pick this one up once v5.8-rc1 is released and drop the Fixes tag.
