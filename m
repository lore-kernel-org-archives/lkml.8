Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60E71C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 14:22:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21B112078C
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 14:22:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589552576;
	bh=P1wz18FD1v+ELmsuVnl//xXDeQTb7E8QMzUzntx7yCE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=m1RGbKaxr8NJ3cmMPFwWQSLTM0f75AeT2pmHDWfOWmMmFIJdBm1snwlPmbiL37j+x
	 hd2HOXrb3XbI6B6ue8YgBuCdlcC6cXswb35SclYllXt8WG05kTTHE067tSQLV+rd3/
	 kYk0IfraLVRoyRf2yK/X/WxrSpRfXlrK7NP5na2o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726221AbgEOOWz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 10:22:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:41922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726140AbgEOOWz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 10:22:55 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 239922076A;
        Fri, 15 May 2020 14:22:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589552573;
        bh=P1wz18FD1v+ELmsuVnl//xXDeQTb7E8QMzUzntx7yCE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XgusqbOcZyTJyECfVxc4oUD/Yr2F4jSZmZjI0fFQbOjJGIE/XhU2iiZWRDucqXtXC
         MegvSrBPs2GxyTu+X+Ueb55ryH32xHHh326Cy/NwNTrLNguuw4V171WP9LWdPhpqJz
         6fLwPv6Gyzfg5pOmSPK2SdUPhl8tlPNL8u5YK9jM=
Date:   Fri, 15 May 2020 16:22:51 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     Calvin Johnson <calvin.johnson@oss.nxp.com>,
        Mike Leach <mike.leach@linaro.org>, linux.cj@gmail.com,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] coresight: cti: remove incorrect NULL return check
Message-ID: <20200515142251.GA2407979@kroah.com>
References: <20200507053547.13707-1-calvin.johnson@oss.nxp.com>
 <CANLsYkzeHpZygbQtz8Ed7dEaVMz362ftHQJ50DrBYR=+72NpJQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANLsYkzeHpZygbQtz8Ed7dEaVMz362ftHQJ50DrBYR=+72NpJQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 12, 2020 at 12:00:21PM -0600, Mathieu Poirier wrote:
> Hi Greg,
> 
> On Wed, 6 May 2020 at 23:36, Calvin Johnson <calvin.johnson@oss.nxp.com> wrote:
> >
> > fwnode_find_reference() doesn't return NULL and hence that check
> > should be avoided.
> >
> > Signed-off-by: Calvin Johnson <calvin.johnson@oss.nxp.com>
> > Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> 
> I just noticed you were not CC'ed on the original conversation Calvin
> and I had and as such you probably don't know what to do with this
> patch.  Please see if you can pick it up as a fix for 5.7.  If that is
> not possible I will queue it up for inclusion in the 5.8 cycle.

I can take this for 5.7-final, thanks.

greg k-h
