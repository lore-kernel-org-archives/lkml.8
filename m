Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA4EAC3F2CD
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 05:35:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8AB12072D
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 05:35:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726069AbgCFFe7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 00:34:59 -0500
Received: from mga06.intel.com ([134.134.136.31]:32132 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725280AbgCFFe7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 00:34:59 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Mar 2020 21:34:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,520,1574150400"; 
   d="scan'208";a="352662556"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga001.fm.intel.com with SMTP; 05 Mar 2020 21:34:56 -0800
Received: by lahna (sSMTP sendmail emulation); Fri, 06 Mar 2020 07:34:55 +0200
Date:   Fri, 6 Mar 2020 07:34:55 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/3] Revert "thunderbolt: Prevent crash if non-active
 NVMem file is read"
Message-ID: <20200306053455.GY2540@lahna.fi.intel.com>
References: <PSXP216MB0438FE68DAAFC23CB9AAD5E180E70@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
 <PSXP216MB04388C56BECC4CE5EC81EA2680E70@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
 <20200303103310.GN2540@lahna.fi.intel.com>
 <PSXP216MB04384541A10255DF4E70F4D480E50@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
 <20200304161827.GQ2540@lahna.fi.intel.com>
 <101ca1ac-c3d3-6685-e21b-4c519346b67f@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <101ca1ac-c3d3-6685-e21b-4c519346b67f@linaro.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 05, 2020 at 05:05:47PM +0000, Srinivas Kandagatla wrote:
> 
> 
> On 04/03/2020 16:18, Mika Westerberg wrote:
> > On Wed, Mar 04, 2020 at 04:07:29PM +0000, Nicholas Johnson wrote:
> > > On Tue, Mar 03, 2020 at 12:33:10PM +0200, Mika Westerberg wrote:
> > > > On Mon, Mar 02, 2020 at 03:43:29PM +0000, Nicholas Johnson wrote:
> > > > > This reverts commit 03cd45d2e219301880cabc357e3cf478a500080f.
> > > > > 
> > > > > Since NVMEM subsystem gained support for write-only instances, this
> > > > > workaround is no longer required, so drop it.
> > > > > 
> > > > > Signed-off-by: Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
> > > > 
> > > > Assuming this goes through The NVMem tree:
> > > > 
> > > > Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > > > 
> > > > If that's not the case, please let me know. I can also take them through
> > > > the Thunderbolt tree.
> > > I do not know how this would normally work - I have not experienced much
> > > cross-subsystem work. Perhaps it should be taken through your tree. If
> > > it goes through your tree and not part of this series, perhaps it does
> > > not make sense for it to be authored by me, either. It's just a revert;
> > > it does not take a lot of effort or doing something original.
> > 
> > Your authorship is fine.
> > 
> > Since this patch depends on the first one, it should go together with
> > that one either to NVMem tree or Thunderbolt tree. Either is fine by me
> > but if I take them then I need an ack from Srinivas.
> > 
> 
> I applied 2/3 patch which should show up in next 5.7-rc1 release, with that
> in place you can revert this patch. Please take this patch via respective
> tree, it does not make much sense for me to apply this as its not going to
> break any build.

OK, that works for me as well.

Nicholas, can you send this one again after 5.7-rc1 is is released? I
can then pick it up to my tree.
