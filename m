Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF764C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 20:57:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F4372074B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 20:57:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596056231;
	bh=us69NBFeFCvCXZFBU2qcw5Cmbco3nD42iGG/gPhfYJg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=2exuXbyyt47CUUvSr0jPrPyIezwNgeKYItEDdJQ+uQEse55gsNxHfd1qSewNuhv0L
	 CErsKtaO4HjAGpYE3HjpSzoezI6YVdxGHSZcTDddo35+0kI84P3oQY2+nrKZHpWABF
	 /YtThhYz6oUgpxMVNw+2RlrO4koTUU6DMQeFuUMs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727005AbgG2U5K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 16:57:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:34922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726496AbgG2U5K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 16:57:10 -0400
Received: from kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com (unknown [163.114.132.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2E3852074B;
        Wed, 29 Jul 2020 20:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596056229;
        bh=us69NBFeFCvCXZFBU2qcw5Cmbco3nD42iGG/gPhfYJg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fRKYBmIXhYRcCs7Z8k4qgx2Qr879o1vXtYdDcOLrLzLmrmOs8VBHF6IpPoQ8lt5Q3
         WuPg5+pl741bKVGgyeJJNkG3gfYLoT68JilULQWwAKZMw/XkeTKp4n4AIg6lMp/qTC
         4qV9aIeKE+PYUvAmPIXobkOlEKLW4YG+q/DB98cg=
Date:   Wed, 29 Jul 2020 13:57:07 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Moshe Shemesh <moshe@mellanox.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Jiri Pirko <jiri@mellanox.com>,
        Vasundhara Volam <vasundhara-v.volam@broadcom.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next RFC 09/13] devlink: Add enable_remote_dev_reset
 generic parameter
Message-ID: <20200729135707.5fc65fc8@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <5baf2825-a550-f68f-f76e-3a8688aa6ae6@mellanox.com>
References: <1595847753-2234-1-git-send-email-moshe@mellanox.com>
        <1595847753-2234-10-git-send-email-moshe@mellanox.com>
        <20200727175935.0785102a@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
        <5baf2825-a550-f68f-f76e-3a8688aa6ae6@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Jul 2020 17:42:12 +0300 Moshe Shemesh wrote:
> On 7/28/2020 3:59 AM, Jakub Kicinski wrote:
> > On Mon, 27 Jul 2020 14:02:29 +0300 Moshe Shemesh wrote:  
> >> The enable_remote_dev_reset devlink param flags that the host admin
> >> allows device resets that can be initiated by other hosts. This
> >> parameter is useful for setups where a device is shared by different
> >> hosts, such as multi-host setup. Once the user set this parameter to
> >> false, the driver should NACK any attempt to reset the device while the
> >> driver is loaded.
> >>
> >> Signed-off-by: Moshe Shemesh <moshe@mellanox.com>  
> > There needs to be a devlink event generated when reset is triggered
> > (remotely or not).
> >
> > You're also missing failure reasons. Users need to know if the reset
> > request was clearly nacked by some host, not supported, etc. vs
> > unexpected failure.  
> 
> I will fix and send extack message to the user accordingly.

I'd suggest the reason codes to be somewhat standard.

The groups I can think of:
 - timeout - device did not respond to the reset request
 - device reject - FW or else has nacked the activation req
 - host incapable - one of the participating hosts (in MH) is not
   capable of handling live activation
 - host denied - one of the participating hosts has NACKed
 - host timeout - one of the p. hosts did not ack or done the procedure
   in time (e.g. has not toggled the link)
 - failed reset - the activation itself had failed
 - failed reinit - one of p. hosts was not able to cleanly come back up
