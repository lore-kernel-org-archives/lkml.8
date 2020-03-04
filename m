Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1BB1C3F2D7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 16:18:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B42E2215A4
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 16:18:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388274AbgCDQSh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 11:18:37 -0500
Received: from mga07.intel.com ([134.134.136.100]:47764 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726275AbgCDQSg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 11:18:36 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Mar 2020 08:18:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,514,1574150400"; 
   d="scan'208";a="352136478"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga001.fm.intel.com with SMTP; 04 Mar 2020 08:18:28 -0800
Received: by lahna (sSMTP sendmail emulation); Wed, 04 Mar 2020 18:18:27 +0200
Date:   Wed, 4 Mar 2020 18:18:27 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v2 3/3] Revert "thunderbolt: Prevent crash if non-active
 NVMem file is read"
Message-ID: <20200304161827.GQ2540@lahna.fi.intel.com>
References: <PSXP216MB0438FE68DAAFC23CB9AAD5E180E70@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
 <PSXP216MB04388C56BECC4CE5EC81EA2680E70@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
 <20200303103310.GN2540@lahna.fi.intel.com>
 <PSXP216MB04384541A10255DF4E70F4D480E50@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PSXP216MB04384541A10255DF4E70F4D480E50@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 04, 2020 at 04:07:29PM +0000, Nicholas Johnson wrote:
> On Tue, Mar 03, 2020 at 12:33:10PM +0200, Mika Westerberg wrote:
> > On Mon, Mar 02, 2020 at 03:43:29PM +0000, Nicholas Johnson wrote:
> > > This reverts commit 03cd45d2e219301880cabc357e3cf478a500080f.
> > > 
> > > Since NVMEM subsystem gained support for write-only instances, this
> > > workaround is no longer required, so drop it.
> > > 
> > > Signed-off-by: Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
> > 
> > Assuming this goes through The NVMem tree:
> > 
> > Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > 
> > If that's not the case, please let me know. I can also take them through
> > the Thunderbolt tree.
> I do not know how this would normally work - I have not experienced much 
> cross-subsystem work. Perhaps it should be taken through your tree. If 
> it goes through your tree and not part of this series, perhaps it does 
> not make sense for it to be authored by me, either. It's just a revert; 
> it does not take a lot of effort or doing something original.

Your authorship is fine.

Since this patch depends on the first one, it should go together with
that one either to NVMem tree or Thunderbolt tree. Either is fine by me
but if I take them then I need an ack from Srinivas.
