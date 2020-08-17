Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D724C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 11:48:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C8F52072E
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 11:48:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726983AbgHQLsL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 07:48:11 -0400
Received: from esa2.mentor.iphmx.com ([68.232.141.98]:56203 "EHLO
        esa2.mentor.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726161AbgHQLsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 07:48:04 -0400
X-Greylist: delayed 450 seconds by postgrey-1.27 at vger.kernel.org; Mon, 17 Aug 2020 07:48:03 EDT
IronPort-SDR: 0FUq5f3wNblAwD1gNi8256kNsxk+TPqJN5kglFdoJ10MYQlu4kz1j87nE6fswv9laMUZEK9ppF
 Kajuu9jjtgXpazBiDljB/0kT65+uv2XKCzFCKxzJ3pQ5Zxrtjzth4e+P9iScECitNfV9zOrenf
 e6hZY+dm13lZqD1kyrBEAcVyQ1FCapmR3J7zLW7YSj5FQZMKEvh5ZvKY2mJHd0yqSmBoFcZbmT
 wF2QggmnztCAM3Rz1AJnL7BIWbOCMI6JC+Y5iwCzbCmJdwtJOXHofSGo1fAMMl6Jg/ZkQt72FJ
 eNA=
X-IronPort-AV: E=Sophos;i="5.76,322,1592899200"; 
   d="scan'208";a="51996397"
Received: from orw-gwy-02-in.mentorg.com ([192.94.38.167])
  by esa2.mentor.iphmx.com with ESMTP; 17 Aug 2020 03:40:24 -0800
IronPort-SDR: cwbtSVHmdpLaTlkjr/UF5ziHgd9DIztGwkD/FbAokHdQgOsK9A9gFr+lvvZdVpAQEQfXsTFzi+
 FnQZ0jsZc7tqVsTwto2mOKyYUCBO8RtCdC/OITMdrn/CYd38sW+4/npq9YGcikhKk7lxzu5Re/
 hn2uY/dwlXA/THkMNwTwmyzVdbfi4TDU8OKWXInys6X9wQaqhaJkru6HfC0Q9Z4xGWLZYHbi1v
 bUAwf7H6aspVAysWJIGS4pvwuoeg8PvreNz6/5nQnNwVFxQ3rlvHBlYnnC9q0UdeyiiDZyWIrJ
 96s=
To:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-usb@vger.kernel.org>
CC:     "Resch Carsten (CM/ESO6)" <Carsten.Resch@de.bosch.com>,
        "Rosca, Eugeniu (ADITG/ESB)" <erosca@de.adit-jv.com>
From:   Jim Baxter <jim_baxter@mentor.com>
Subject: PROBLEM: Long Workqueue delays.
Message-ID: <71aafe68-7fe0-6b77-ea8e-83edd3f16c8d@mentor.com>
Date:   Mon, 17 Aug 2020 12:40:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Originating-IP: [137.202.0.90]
X-ClientProxiedBy: svr-ies-mbx-06.mgc.mentorg.com (139.181.222.6) To
 SVR-IES-MBX-03.mgc.mentorg.com (139.181.222.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have issues with the workqueue of the kernel overloading the CPU 0 
when we we disconnect a USB stick.

This results in other items on the shared workqueue being delayed by
around 6.5 seconds with a default kernel configuration and 2.3 seconds
on a config tailored for our RCar embedded platform.

I am aware there will be delays on the shared workqueue, are the delays
we are seeing considered normal?



We first noticed this issue on custom hardware and we have recreated it
on an RCar Starter Kit using a test module [1] to replicate the
behaviour, the test module outputs any delays of greater then 9ms.

To run the test we have a 4GB random file on a USB stick and perform
the following test:


- Load the Module:
# taskset -c 0 modprobe latency-mon

- Copy large amount of data from the stick:
# dd if=/run/media/sda1/sample.txt of=/dev/zero
[ 1437.517603] DELAY: 10
8388607+1 records in
8388607+1 records out


- Disconnect the USB stick:
[ 1551.796792] usb 2-1: USB disconnect, device number 2
[ 1558.625517] DELAY: 6782


The Delay output 6782 is in milliseconds.

Thank you for you help.
Jim Baxter

[1] Test Module:
// SPDX-License-Identifier: GPL-2.0
/*
 * Simple WQ latency monitoring
 *
 * Copyright (C) 2020 Advanced Driver Information Technology.
 */

#include <linux/init.h>
#include <linux/ktime.h>
#include <linux/module.h>

#define PERIOD_MS 100

static struct delayed_work wq;
static u64 us_save;

static void wq_cb(struct work_struct *work)
{
	u64 us = ktime_to_us(ktime_get());
	u64 us_diff = us - us_save;
	u64 us_print = 0;

	if (!us_save)
		goto skip_print;


	us_print = us_diff / 1000 - PERIOD_MS;
	if (us_print > 9)
		pr_crit("DELAY: %lld\n", us_print);

skip_print:
	us_save = us;
	schedule_delayed_work(&wq, msecs_to_jiffies(PERIOD_MS));
}

static int latency_mon_init(void)
{
	us_save = 0;
	INIT_DELAYED_WORK(&wq, wq_cb);
	schedule_delayed_work(&wq, msecs_to_jiffies(PERIOD_MS));

	return 0;
}

static void latency_mon_exit(void)
{
	cancel_delayed_work_sync(&wq);
	pr_info("%s\n", __func__);
}

module_init(latency_mon_init);
module_exit(latency_mon_exit);
MODULE_AUTHOR("Eugeniu Rosca <erosca@de.adit-jv.com>");
MODULE_LICENSE("GPL");
