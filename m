Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ABF0C35E04
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 15:43:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A6FC2082F
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 15:43:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730388AbgBYPnq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 10:43:46 -0500
Received: from mga06.intel.com ([134.134.136.31]:21025 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726019AbgBYPnq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 10:43:46 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Feb 2020 07:43:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,484,1574150400"; 
   d="scan'208";a="350167914"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga001.fm.intel.com with SMTP; 25 Feb 2020 07:43:43 -0800
Received: by lahna (sSMTP sendmail emulation); Tue, 25 Feb 2020 17:43:43 +0200
Date:   Tue, 25 Feb 2020 17:43:43 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v1 1/3] nvmem: Add support for write-only instances
Message-ID: <20200225154343.GG2667@lahna.fi.intel.com>
References: <PSXP216MB043899D4B8F693E1E5C3ECCE80EC0@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
 <PSXP216MB043820B6E11AE4E78374C7F980EC0@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
 <20200225125141.GA2667@lahna.fi.intel.com>
 <PSXP216MB0438D95E25CA8BA02A40735480ED0@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PSXP216MB0438D95E25CA8BA02A40735480ED0@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 25, 2020 at 03:30:22PM +0000, Nicholas Johnson wrote:
> > Actually I think maybe we make this one only writeable by root, in other
> > words it would always require ->root_only to be set.
> There is a world-accessible rw entry already, which would, if anything, 
> be even more dangerous than a world writable entry. However, there could 
> be a hypothetical use case. I agree it is unlikely to be required, but 
> who knows?

You mean 0644 entry? That should be fine as it is not writable by anyone
else than the owner (root in this case).

> Based on your statement that no sysfs should ever be world-writable, 
> should I be trying to remove the world-accessible rw as well?

No I don't think it is necesary. Just let's not add attributes that
anyone can write without good reasoning ;-)
