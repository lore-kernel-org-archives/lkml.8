Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15A54C3F2D3
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 16:17:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCF002467B
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 16:17:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="LWyZS36Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbgB1QRa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 11:17:30 -0500
Received: from mail-qv1-f65.google.com ([209.85.219.65]:47037 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725769AbgB1QRa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 11:17:30 -0500
Received: by mail-qv1-f65.google.com with SMTP id bo12so1554986qvb.13
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2020 08:17:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zKdk38aJhA82hTscy9LF9azysMLoDz1ezEIJvuBKa8A=;
        b=LWyZS36QTY1vsAoUR3es9SvlYx3lYN3A53KEZ57uzSbow9k+2Vp3NuFz7Z+D8pVq5/
         JWj3jtVCw8/0GT57CwTd7SkK9TaNk787ExJyePNfD6e6i2rDmYDCRo2TM/sPxUNsvLp6
         Owq24V+xwgUtq5PPDhFm2qUCFRCWqjXYHHEfvL6owrafX7W44vg9CeeyXKa7scBPfa98
         Lz8uzDO5KvRtUkiTTc0DBYEpIMZBjLVwg7r00CaPQbpO6hbl3p/3ZkCW2GVovZBUefAs
         MCtrJjjxrDIysGQIVi3OWfluEq0tHV6wRhEiEPV1v4qw3maghZZa8lZERuHkPBHeGe/d
         jVvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zKdk38aJhA82hTscy9LF9azysMLoDz1ezEIJvuBKa8A=;
        b=Afr/p4QqLPIJxDCv+Wpvz71nZu9XT/yU1SRNANfoApsW2XVLWWGNfMwARWDAnMaRx7
         3cqO4eme9T0zpA36L5GY1IauC/t410Ssf83qIJq+sK3qjCKBw9cMYgChMsYukO9KWT9S
         1apkaO5Lwx4SfhsQ4uT9JLCcZWjqkT75icCLNaB0cO4tu1/kspdae2oaNC1ZAd0Od/qC
         lz1VdJL4ANOSqoKhpaIPGS/5mRhqQCyfzPrjfIpJV3/8dDuliaOvxKhCk2xj22YKGz5J
         XOJhiWPby2lrXGdjQ4+36pEtw02VHkqE7oNk6QVRqvWBb2okQ7VPX2Y6V3svdpbCFPN1
         WGNQ==
X-Gm-Message-State: APjAAAWaZEOhMc1yW8AhAUqZ8Ou78OpGw0gH5EVayQUIUOvQWlI1Zdvc
        5OO9PlITYg0slKFjSsQqXbopVQ==
X-Google-Smtp-Source: APXvYqziLkBoEb6rQTlAFGTGstcdRLdHTq/BBvQvyn2/V2cOoRQ/UjvaRO7NSbHN485P6/4/Q/0RmQ==
X-Received: by 2002:ad4:4684:: with SMTP id bq4mr4174239qvb.35.1582906649607;
        Fri, 28 Feb 2020 08:17:29 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id p126sm5375393qkd.108.2020.02.28.08.17.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 28 Feb 2020 08:17:29 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1j7iKO-0006xA-Oh; Fri, 28 Feb 2020 12:17:28 -0400
Date:   Fri, 28 Feb 2020 12:17:28 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Bernard Metzler <bmt@zurich.ibm.com>
Cc:     dledford@redhat.com, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH for-rc] RDMA/siw: Fix failure handling during device
 creation
Message-ID: <20200228161728.GT31668@ziepe.ca>
References: <20200226142920.11074-1-bmt@zurich.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200226142920.11074-1-bmt@zurich.ibm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 26, 2020 at 03:29:20PM +0100, Bernard Metzler wrote:
> A failing call to ib_device_set_netdev() during device creation
> caused system crash due to xa_destroy of uninitialized xarray
> hit by device deallocation. Fixed by moving xarray initialization
> before potential device deallocation.
> Fixes also correct propagation of ib_device_set_netdev() failure
> to caller.

This is for -rc, so please split into two patches. The error
propagation is probably not -rc worthy

Jason
