Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE21AC2BA19
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 12:56:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A908B2075E
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 12:56:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586782582;
	bh=pOHGZCZoW07Fu0ZaWxLsnPUSYtIXpjWkuH7RiI5DFEg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=owT8D2TQEimrnf1DolyU9CKYuv2KgAs+pQYz/TN697QtHKc9b+PMB2XIBOGR0XnYy
	 m1Lb+MXXJAoloH1+oTkB5/AYeogAdYqvO7lTNFwIEjgBjmGD/3PjLaYtrWPVYdn98r
	 /HbQmkDyTBkzVqzlucT7ykfy7+Neo4xYMJ2hMNtM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729636AbgDMM4V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 08:56:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:54012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729574AbgDMM4U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 08:56:20 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7F5D32073E;
        Mon, 13 Apr 2020 12:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586782579;
        bh=pOHGZCZoW07Fu0ZaWxLsnPUSYtIXpjWkuH7RiI5DFEg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UIyn+YvvNp3XP2ZY9H48InOqBSeOQz8L/OifYCLhKB6CyH2fpiKQS8af0VPcAUxBY
         xCeLHhNcvuBibTruRDfVyZC14nU96OLzB6p8nC9bntommQGDCvgJ6vtynQY8upow3q
         e91G7+4P+L3tt5Cn6PcfUMVuMw+OZ5QI5j14x1uE=
Date:   Mon, 13 Apr 2020 14:56:16 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Oscar Carter <oscar.carter@gmx.com>
Cc:     Forest Bond <forest@alittletooquiet.net>,
        devel@driverdev.osuosl.org, Malcolm Priestley <tvboxspy@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] staging: vt6656: Refactor the assignment of the
 phy->signal variable
Message-ID: <20200413125616.GA3127208@kroah.com>
References: <20200411122610.7901-1-oscar.carter@gmx.com>
 <20200411122610.7901-2-oscar.carter@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200411122610.7901-2-oscar.carter@gmx.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 11, 2020 at 02:26:09PM +0200, Oscar Carter wrote:
> Create a constant array with the values of the "phy->signal" for every
> rate. Remove all "phy->signal" assignments inside the switch statement
> and replace these with a single reading from the new vnt_phy_signal
> array.
> 
> The constant array can be of one dimension because the OR mask with
> BIT(3) or BIT(4) allow obtain a second value according to the rate,
> the preamble_type and the pkt_type.
> 
> Signed-off-by: Oscar Carter <oscar.carter@gmx.com>
> ---
>  drivers/staging/vt6656/baseband.c | 105 ++++++++----------------------
>  1 file changed, 26 insertions(+), 79 deletions(-)

This series did not apply to my tree, please rebase and resend.

thanks,

greg k-h
