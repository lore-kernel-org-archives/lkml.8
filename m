Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06A2CC2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 09:12:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6D4E24655
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 09:12:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729144AbgAVJMH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 04:12:07 -0500
Received: from mga05.intel.com ([192.55.52.43]:20252 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725911AbgAVJMG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 04:12:06 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Jan 2020 01:12:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,349,1574150400"; 
   d="scan'208";a="282973988"
Received: from kuha.fi.intel.com ([10.237.72.53])
  by fmsmga001.fm.intel.com with SMTP; 22 Jan 2020 01:12:03 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 22 Jan 2020 11:12:02 +0200
Date:   Wed, 22 Jan 2020 11:12:02 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Thomas Hebb <tommyhebb@gmail.com>, linux-kernel@vger.kernel.org,
        linux-stable@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH v2 2/2] usb: typec: fusb302: fix "op-sink-microwatt"
 default that was in mW
Message-ID: <20200122091202.GA22653@kuha.fi.intel.com>
References: <0eac53c4878423a9abd49d2142fe4cb1136db4e2.1579529138.git.tommyhebb@gmail.com>
 <c497958a1b0d8e3421c5eda46abddba6651cec1e.1579529138.git.tommyhebb@gmail.com>
 <20200122090820.GA2643799@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200122090820.GA2643799@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 22, 2020 at 10:08:20AM +0100, Greg Kroah-Hartman wrote:
> On Mon, Jan 20, 2020 at 06:05:41AM -0800, Thomas Hebb wrote:
> > commit 8f6244055bd3 ("usb: typec: fusb302: Always provide fwnode for the
> > port") didn't convert this value from mW to uW when migrating to a new
> > specification format like it should have.
> > 
> > Fixes: 8f6244055bd3 ("usb: typec: fusb302: Always provide fwnode for the port")
> > Cc: linux-stable@vger.kernel.org
> 
> Nit, there is no such address :)

Thomas already fixed the address in v3.

thanks,

-- 
heikki
