Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C07EEC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 15:24:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F6E5206DA
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 15:24:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597764249;
	bh=l+XDkFtgwt5zPcrqWTSPLzrMj4I4erDakB2KPO2q0W8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=QKVBKEc5nbeUlaUmD/5eA1Zxjg6dnfBtcKInba2EsnyqDz0zZbf6HD1L1Gg3UAVO8
	 QBLPhpMAMRT/umEI4l3htW6KKZnTZgSDXe9gqfkmmYe5PXzv76LtltuCrIY9XEfnk+
	 HOamZ+IvFRp5Wykjz3EYsBywvsEHtIRaST7sCalE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728003AbgHRPYH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 11:24:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:49514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726630AbgHRPYD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 11:24:03 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0B842206DA;
        Tue, 18 Aug 2020 15:24:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597764242;
        bh=l+XDkFtgwt5zPcrqWTSPLzrMj4I4erDakB2KPO2q0W8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r8ABkGvSYNJGp1keyzWqUbDkgmiflm68OURmknP3Vc8X5fAboGhFIYrQ/VZJ0woks
         p8iEtWuL12pyj2NR9RzYb0LAmN8L1d9QkyEJQeFdzFghMqFfERZm9+ugK+XfSxx9uN
         VvPsX0SwBa5RWcQZ+zrV9p3Fy6vU5VuIwSfSVmAQ=
Date:   Tue, 18 Aug 2020 17:24:26 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Vaishnav M A <vaishnav@beagleboard.org>
Cc:     greybus-dev@lists.linaro.org, linux-kernel@vger.kernel.org,
        arnd@arndb.de, johan@kernel.org, elder@kernel.org, robh@kernel.org,
        mchehab+huawei@kernel.org, davem@davemloft.net,
        jkridner@beagleboard.org, drew@beagleboard.org,
        robertcnelson@beagleboard.org, rajkovic@mikroe.com,
        chrisfriedt@gmail.com, zoran.stojsavljevic@gmail.com
Subject: Re: [RFC PATCH v2 0/3] mikroBUS driver for add-on boards
Message-ID: <20200818152426.GA713928@kroah.com>
References: <20200818124815.11029-1-vaishnav@beagleboard.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200818124815.11029-1-vaishnav@beagleboard.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 18, 2020 at 06:18:12PM +0530, Vaishnav M A wrote:
> Hi,
> 
> This Patch series is an update to the mikroBUS driver
> RFC v1 Patch : https://lkml.org/lkml/2020/7/24/518 .

Please use lore.kernel.org for links, we have no idea if lkml.org will
be working tomorrow or not :)

> The mikrobus driver is updated to add mikrobus ports from device-tree
> overlays, the debug interfaces for adding mikrobus ports through sysFS
> is removed, and the driver considers the extended usage of mikrobus
> port pins from their standard purposes.

I don't know what "properties" and "device" mean with regards to things
here, any chance you can provide a patch to the greybus spec itself that
adds this information so we can better understand the reasoning here to
see if the kernel changes match up with the goals?

thanks,

greg k-h
