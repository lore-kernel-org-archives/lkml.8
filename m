Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7A1FC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 14:32:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F6CE2067B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 14:32:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726745AbgFJOcW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 10:32:22 -0400
Received: from netrider.rowland.org ([192.131.102.5]:53057 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726512AbgFJOcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 10:32:21 -0400
Received: (qmail 14093 invoked by uid 1000); 10 Jun 2020 10:32:20 -0400
Date:   Wed, 10 Jun 2020 10:32:20 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     mathias.nyman@intel.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:USB XHCI DRIVER" <linux-usb@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] xhci: Suspend ports to U3 directly from U1 or U2
Message-ID: <20200610143220.GC11727@rowland.harvard.edu>
References: <20200610064231.9454-1-kai.heng.feng@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200610064231.9454-1-kai.heng.feng@canonical.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 10, 2020 at 02:42:30PM +0800, Kai-Heng Feng wrote:
> xHCI spec "4.15.1 Port Suspend" states that port can be put to U3 as long
> as Enabled bit is set and from U0, U1 or U2 state.
> 
> Currently only USB_PORT_FEAT_LINK_STATE puts port to U3 directly, let's
> do the same for USB_PORT_FEAT_SUSPEND and bus suspend case.
> 
> This is particularly useful for USB2 devices, which may take a very long
> time to switch USB2 LPM on and off.

Have these two patches been tested with a variety of USB-2.0 and USB-2.1 
devices?

Alan Stern
