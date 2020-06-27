Return-Path: <SRS0=QqoS=AI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C48BC433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 05:15:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC3922081A
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 05:15:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593234915;
	bh=B7Yo4g2/XHRVv7dQ6rLNnMcYK72cvm1KamY5mKZz7Y4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ZZHJ/+V82zchKes7IEbQAUP2CulkMe0J74i5/8GG1uwjv1A4GYnK8SiyL7m6NcZlL
	 uhs5D5kXnU6QjNEd7lWUhuSlAW2oNvtANXl3oPygoSHxVXoeFthwhsvyxBB9wDv7/v
	 mU3mOMYhvu8wHUSWaeFh0dEzEarE/ysoG6f/kMZ4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725976AbgF0FPN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jun 2020 01:15:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:39020 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725840AbgF0FPM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jun 2020 01:15:12 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BC6A020720;
        Sat, 27 Jun 2020 05:15:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593234912;
        bh=B7Yo4g2/XHRVv7dQ6rLNnMcYK72cvm1KamY5mKZz7Y4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uTqA9Q1Pb+K6/b8f0s37qUZOdGZmNDHQ//8VZFn4qWSvI9Kml9y2woZxbS7oRMyBf
         HWrKtUZefg2cGXJsi0xKd/e90X67tJg7q8q/p9C2NHLK/p0TuxUlB8u8IwsnC85l9k
         ZzgB9CsQLOzD22rQPyGzMoWL6shIt1GxF920Cx0E=
Date:   Sat, 27 Jun 2020 07:15:09 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     richard.gong@linux.intel.com, atull@kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH V3] firmware: stratix10-svc: Fix some error handling code
Message-ID: <20200627051509.GC233327@kroah.com>
References: <0ecc14c7-b4df-1890-fbe7-91307c2db398@wanadoo.fr>
 <20200626193720.949431-1-christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200626193720.949431-1-christophe.jaillet@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 26, 2020 at 09:37:20PM +0200, Christophe JAILLET wrote:
> Fix several error handling issues:

<snip>

When you have to list a bunch of different things you do in a driver,
that's a huge hint this needs to be broken up into multiple patches.

Please do that here.

thanks,

greg k-h
