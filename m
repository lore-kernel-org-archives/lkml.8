Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4513C2BB86
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 12:56:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 842D72073E
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 12:56:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586782599;
	bh=18DKhHBYMozZ6+lW7jqDESjmUuzWD027T7nLZuXSulA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=l1k7PVQzbF614n+BBvqaUGtAiwkI4bXZ5SAqrkHGIWFuuTxPteKkZ9XkAnMK4IVj0
	 9qeqaBN8JLGPSAEkrwaRMiCjXZH8rN4+4Bfr/8PjHtHd9BetWRF4ErS3FMhoZdpqzf
	 cRFniLZnx/4e2ZpAdfg/ncDEEmw9dzWnpxr4Is0k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729645AbgDMM4i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 08:56:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:54096 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729574AbgDMM4h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 08:56:37 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 905562073E;
        Mon, 13 Apr 2020 12:56:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586782596;
        bh=18DKhHBYMozZ6+lW7jqDESjmUuzWD027T7nLZuXSulA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tTmxOG7cTpjaO4DRNXaaDdmdKQtm89+iOD+zLf1aCkTwZxOxH8gXDbS9iRfXk01dy
         UycFw0/GDO0TPtsqoYBFlhTgMhP4V8FzXpviTcCUfPm4ZGHFbzN16V3AdWFhT4UAh6
         W1JCrSLvHOdfJwTdjnFYdEPjFvZb7faavh4D2alI=
Date:   Mon, 13 Apr 2020 14:56:33 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Oscar Carter <oscar.carter@gmx.com>
Cc:     Forest Bond <forest@alittletooquiet.net>,
        devel@driverdev.osuosl.org, Malcolm Priestley <tvboxspy@gmail.com>,
        linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH v3 1/2] staging: vt6656: Use define instead of magic
 number for tx_rate
Message-ID: <20200413125633.GB3127208@kroah.com>
References: <20200407163915.7491-1-oscar.carter@gmx.com>
 <20200407163915.7491-2-oscar.carter@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200407163915.7491-2-oscar.carter@gmx.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 07, 2020 at 06:39:14PM +0200, Oscar Carter wrote:
> Use the define RATE_11M present in the file "device.h" instead of the
> magic number 3. So the code is more clear.
> 
> Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Oscar Carter <oscar.carter@gmx.com>
> ---
>  drivers/staging/vt6656/baseband.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

This patch did not apply to my tree, please rebase and resend.

thanks,

greg k-h
