Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1ABBC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 11:57:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADC2C20786
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 11:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597665447;
	bh=WlpyWk2CigbIwSvUvCGB3jBf0Ifuv83GLdABZeilG9I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=dPzm9cIkGDSqdjEqRMORwh1YT5AS0ipbeuVEZkAGq1SzeOJ5H5ZYDOC5YtIVvLe+C
	 wUgZDjXpN1u2iUS/P6ZJKkynssIMQakZwN099N+TdY1FONTm+/HqMg4H2Djces6p6G
	 /b4EV6Rrt+C3M531KThBykLG0gwmvl8gdbd2TRIw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727889AbgHQL5Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 07:57:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:50490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726633AbgHQL5Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 07:57:25 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 81FA1204EA;
        Mon, 17 Aug 2020 11:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597665445;
        bh=WlpyWk2CigbIwSvUvCGB3jBf0Ifuv83GLdABZeilG9I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xvCAEQt7XuRhAa959zo5CVsMnypZOd8mFKK5XD9d+i9uFdBaPVgKy+mVnyhQixtWN
         QTm+l5gT1UjH2su3kPMB4xFcnQB+CQifQVoY+7sNvADHd6xJ7vE0vWn6/4HwWz2S4O
         LMBh1EIhEsg09SBQQdqsgmLqcqjhvl7Bo04s/nak=
Date:   Mon, 17 Aug 2020 13:57:44 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jim Baxter <jim_baxter@mentor.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-usb@vger.kernel.org,
        "Resch Carsten (CM/ESO6)" <Carsten.Resch@de.bosch.com>,
        "Rosca, Eugeniu (ADITG/ESB)" <erosca@de.adit-jv.com>
Subject: Re: PROBLEM: Long Workqueue delays.
Message-ID: <20200817115744.GA3985908@kroah.com>
References: <71aafe68-7fe0-6b77-ea8e-83edd3f16c8d@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <71aafe68-7fe0-6b77-ea8e-83edd3f16c8d@mentor.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 17, 2020 at 12:40:03PM +0100, Jim Baxter wrote:
> We have issues with the workqueue of the kernel overloading the CPU 0 
> when we we disconnect a USB stick.
> 
> This results in other items on the shared workqueue being delayed by
> around 6.5 seconds with a default kernel configuration and 2.3 seconds
> on a config tailored for our RCar embedded platform.
> 
> I am aware there will be delays on the shared workqueue, are the delays
> we are seeing considered normal?
> 
> 
> 
> We first noticed this issue on custom hardware and we have recreated it
> on an RCar Starter Kit using a test module [1] to replicate the
> behaviour, the test module outputs any delays of greater then 9ms.
> 
> To run the test we have a 4GB random file on a USB stick and perform
> the following test:
> 
> 
> - Load the Module:
> # taskset -c 0 modprobe latency-mon
> 
> - Copy large amount of data from the stick:
> # dd if=/run/media/sda1/sample.txt of=/dev/zero
> [ 1437.517603] DELAY: 10
> 8388607+1 records in
> 8388607+1 records out
> 

Is this data really flushed out to the device?

> - Disconnect the USB stick:
> [ 1551.796792] usb 2-1: USB disconnect, device number 2
> [ 1558.625517] DELAY: 6782
> 
> 
> The Delay output 6782 is in milliseconds.

What USB workqueue is taking so long?

The one trying to deal with the filesystem flushing out the data that it
can't do now that the device is removed?  :)

thanks,

greg k-h
