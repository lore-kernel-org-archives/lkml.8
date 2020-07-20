Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6C15C433E7
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 08:22:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BEC0B20709
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 08:22:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595233323;
	bh=TFV90mQY3UkXWqNiCk+pJEzkoqTKqu3TrJxJjxsWFQk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Oq1HwZZtgWcI916ctYgmxfYxDdyGpBDSr0FQAgZkWXPFhzowDUkjXakzSqnAoIig4
	 gcQSY9HVug4fSiGmsOHrDRU4HkXoxLxZTAZ0QlUu+3NhJEt+JAq2ZvELwbFKWjOfvu
	 Rtj7dy9BoUCvlNG3KTfyi8naLA4prN12l8Uby9p8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727907AbgGTIWC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 04:22:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:46704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725815AbgGTIWC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 04:22:02 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 61A4E21775;
        Mon, 20 Jul 2020 08:22:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595233322;
        bh=TFV90mQY3UkXWqNiCk+pJEzkoqTKqu3TrJxJjxsWFQk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qkYdMDCg60DquI3q7LH0t4dXtha0EN0KNRmHDheXbI21XeyyQHwCngL6OXIYae3NE
         AX8Ui9vDhq7FIOaEnuY5hWj1wI+rIVYR/UGPEwU0CuXwOkSXD0CV53zb5mqytyzvun
         WVZs0BWOLSWI3BVL73v1s43FtOzXAEzCOf8O2wDc=
Date:   Mon, 20 Jul 2020 10:22:12 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Darshan D V <darshandv10@gmail.com>
Cc:     yuehaibing@huawei.com, ardb@kernel.org, contact@christina-quast.de,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] staging: rtl8192e: add space before open parenthesis
Message-ID: <20200720082212.GA721569@kroah.com>
References: <20200719120918.17862-1-darshandv10@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200719120918.17862-1-darshandv10@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 19, 2020 at 05:39:17PM +0530, Darshan D V wrote:
> rtllib_crypt_ccmp.c: 

Why is this listed here, with a trailing space?  There's no real need
for it, do you see other patches for this file/driver doing that?  Try
looking at those for examples of how to properly format changelog texts.

Same thing for your 2/2 patch.

thanks,

greg k-h
