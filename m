Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D581CC35E01
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 15:44:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B41622082F
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 15:44:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730567AbgBYPoe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 10:44:34 -0500
Received: from mga14.intel.com ([192.55.52.115]:53130 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726019AbgBYPoe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 10:44:34 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Feb 2020 07:44:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,484,1574150400"; 
   d="scan'208";a="350168008"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga001.fm.intel.com with SMTP; 25 Feb 2020 07:44:31 -0800
Received: by lahna (sSMTP sendmail emulation); Tue, 25 Feb 2020 17:44:31 +0200
Date:   Tue, 25 Feb 2020 17:44:31 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v1 2/3] Revert "thunderbolt: Prevent crash if non-active
 NVMem file is read"
Message-ID: <20200225154431.GH2667@lahna.fi.intel.com>
References: <PSXP216MB043899D4B8F693E1E5C3ECCE80EC0@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
 <PSXP216MB04383751C15C4D66B59335DA80EC0@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
 <20200225125629.GB2667@lahna.fi.intel.com>
 <PSXP216MB04387341897FDF77424BE82D80ED0@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PSXP216MB04387341897FDF77424BE82D80ED0@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 25, 2020 at 03:33:00PM +0000, Nicholas Johnson wrote:
> On Tue, Feb 25, 2020 at 02:56:29PM +0200, Mika Westerberg wrote:
> > On Mon, Feb 24, 2020 at 05:43:05PM +0000, Nicholas Johnson wrote:
> > > This reverts commit 03cd45d2e219301880cabc357e3cf478a500080f.
> > > 
> > > Since commit cd76ed9e5913 ("nvmem: add support for write-only
> > > instances"), this work around is no longer required, so drop it.
> > 
> > I don't think you can refer commits that only exists in your local tree.
> > I would just say that "since NVMem subsystem gained support for
> > write-only instances this workaround is not needed anymore" or somesuch.
> Are the commit hashes changed when applied to the kernel? If so, oops!

Yes, they will change once the patch gets committed to another git tree.
