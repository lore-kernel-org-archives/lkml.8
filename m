Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4BE9C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 19:41:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D93F20674
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 19:41:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404307AbgHQTlk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 15:41:40 -0400
Received: from netrider.rowland.org ([192.131.102.5]:58775 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1729708AbgHQPZN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 11:25:13 -0400
Received: (qmail 113589 invoked by uid 1000); 17 Aug 2020 11:25:07 -0400
Date:   Mon, 17 Aug 2020 11:25:07 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Jim Baxter <jim_baxter@mentor.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-usb@vger.kernel.org,
        "Resch Carsten \(CM/ESO6\)" <Carsten.Resch@de.bosch.com>,
        "Rosca, Eugeniu \(ADITG/ESB\)" <erosca@de.adit-jv.com>
Subject: Re: PROBLEM: Long Workqueue delays.
Message-ID: <20200817152507.GC112820@rowland.harvard.edu>
References: <71aafe68-7fe0-6b77-ea8e-83edd3f16c8d@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <71aafe68-7fe0-6b77-ea8e-83edd3f16c8d@mentor.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 17, 2020 at 12:40:03PM +0100, Jim Baxter wrote:
> We have issues with the workqueue of the kernel overloading the CPU 0 
> when we we disconnect a USB stick.

Do you unmount the stick before disconnecting it?

> This results in other items on the shared workqueue being delayed by
> around 6.5 seconds with a default kernel configuration and 2.3 seconds
> on a config tailored for our RCar embedded platform.
> 
> I am aware there will be delays on the shared workqueue, are the delays
> we are seeing considered normal?

Assuming the workqueue delay is caused by the USB subsystem, you may be 
able to get more information by turning on USB dynamic debugging:

	echo 'module usbcore =p' >/sys/kernel/debug/dynamic_debug/control

and seeing what shows up in the dmesg log.

One long-running job should not normally be enough to delay an entire 
workqueues.  Workqueues are allowed to spawn multiple threads; they are 
supposed to resize themselves dynamically as required.

Alan Stern
