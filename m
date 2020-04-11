Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95819C2D0EC
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 01:35:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C29620787
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 01:35:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586568943;
	bh=Sn4rPm/N5fREdC2yn4GE3gfAkpCPg1VdD3eTXAPq0EI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=XKIYPrKz1DpZkH4lbHVabtdl+LN5FTCHJY8jftizpN/Y6i5CiVhhLTO5wPEoXSi5l
	 0amm0G62WNdpRerFObC0+qwr3Ko2ULny+ibj0PouqhXEn23EmO8P669w4yr/XbJr+m
	 1YgyM9M0ZENB5krRnLsDtaiMUpVKMwI2MrVeSKRw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726902AbgDKBfm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Apr 2020 21:35:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:42182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726641AbgDKBfl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 21:35:41 -0400
Received: from kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com (unknown [163.114.132.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 790C32082D;
        Sat, 11 Apr 2020 01:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586568941;
        bh=Sn4rPm/N5fREdC2yn4GE3gfAkpCPg1VdD3eTXAPq0EI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=zWxO2qM7NDTJM6/yFxushIq0FFD4EoAPZ8yWJSaq4mI1i50pa/ulqnfGFPeFi7sat
         18tMXoJvk9C5eWWik6ioFZhxV7xiw3h4ql/2ruyrfCT+BpuBj/b+xUacRG6Uu8rBGi
         AtpKghWa+H1Ny1nFuR5aLbyUlOG6umxnJtJvZabg=
Date:   Fri, 10 Apr 2020 18:35:39 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Colin King <colin.king@canonical.com>
Cc:     Jon Mason <jdmason@kudzu.us>,
        "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: neterion: remove redundant assignment to variable
 tmp64
Message-ID: <20200410183539.627ad5f2@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20200410191150.75588-1-colin.king@canonical.com>
References: <20200410191150.75588-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Apr 2020 20:11:50 +0100 Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The variable tmp64 is being initialized with a value that is never read
> and it is being updated later with a new value.  The initialization is
> redundant and can be removed.
> 
> Addresses-Coverity: ("Unused value")

Patch looks good, but what's the value of this tag?

> Signed-off-by: Colin Ian King <colin.king@canonical.com>
