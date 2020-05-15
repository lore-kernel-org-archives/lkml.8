Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8D18C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 13:03:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8728720758
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 13:03:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589547796;
	bh=emcFPaH6fET2aDTeZuVBdsArlZ/l5XM2lDb4yp9b1To=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=cTNn90CyiQm4YV2QxzB7I/Tob4MLP9UVw6qcSTbO/FvXq7w7NhZ88AvjmL2CcaS8x
	 4/q0A4cig9RKB9b5kcvUCHKaAIcfUGoEKBXgfkpoJdNmKmtXfIl4CyG/pXaR4Yat8w
	 1WbHUkQQuQS4iLrwHplPJEDV2CIq3vk+0qYhC80c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726341AbgEONDQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 09:03:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:45260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726144AbgEONDP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 09:03:15 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BAA6C2074D;
        Fri, 15 May 2020 13:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589547794;
        bh=emcFPaH6fET2aDTeZuVBdsArlZ/l5XM2lDb4yp9b1To=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1qoh5lXJTRWFWf8lesrz3IkdnjeQPrlfLbxGdpZzIrDw3PNA5y6nAQb7jhco1iSrS
         SeRvZ6+NrPPlGFiEs0iQSvWnUD/86lFSf6e4Dx8E/HVp6zGhMSxq+olrZ+5lGWj40B
         fh/lFTNIxs0Is/1Ndv+dJaf/J9UDI9nDBBkb0hJU=
Date:   Fri, 15 May 2020 15:03:12 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Vladimir Stankovic <vladimir.stankovic@displaylink.com>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        mausb-host-devel@displaylink.com
Subject: Re: [PATCH v6 3/8] usb: mausb_host: HCD initialization
Message-ID: <20200515130312.GC1937631@kroah.com>
References: <20200425091954.1610-1-vladimir.stankovic@displaylink.com>
 <20200515123502.12099-1-vladimir.stankovic@displaylink.com>
 <20200515123502.12099-4-vladimir.stankovic@displaylink.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200515123502.12099-4-vladimir.stankovic@displaylink.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 15, 2020 at 02:34:57PM +0200, Vladimir Stankovic wrote:
> Implemented HCD initialization/deinitialization functionality.

Shortest changelog ever :(

Please describe things better.

thanks,

greg k-h
