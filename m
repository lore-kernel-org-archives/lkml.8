Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B12A8C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 20:38:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A76F520855
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 20:38:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbgHFUig (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 16:38:36 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:44099 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725272AbgHFUig (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 16:38:36 -0400
X-Originating-IP: 176.88.145.153
Received: from [192.168.1.4] (unknown [176.88.145.153])
        (Authenticated sender: cengiz@kernel.wtf)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 05974FF805;
        Thu,  6 Aug 2020 20:38:31 +0000 (UTC)
From:   Cengiz Can <cengiz@kernel.wtf>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     <andy.shevchenko@gmail.com>, <devel@driverdev.osuosl.org>,
        <linux-kernel@vger.kernel.org>, <sakari.ailus@linux.intel.com>,
        <mchehab@kernel.org>, <dan.carpenter@oracle.com>,
        <linux-media@vger.kernel.org>
Date:   Thu, 06 Aug 2020 23:38:28 +0300
Message-ID: <173c57f19a0.2bfa.85c738e3968116fc5c0dc2de74002084@kernel.wtf>
In-Reply-To: <20200806183933.GA2939128@kroah.com>
References: <20200731083856.GF3703480@smile.fi.intel.com>
 <20200801220101.2783-1-cengiz@kernel.wtf>
 <173c50d7bb0.2bfa.85c738e3968116fc5c0dc2de74002084@kernel.wtf>
 <20200806183933.GA2939128@kroah.com>
User-Agent: AquaMail/1.25.2-1672 (build: 102500008)
Subject: Re: [PATCH v6] staging: atomisp: move null check to earlier point
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="us-ascii"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On August 6, 2020 21:39:21 Greg KH <gregkh@linuxfoundation.org> wrote:

> On Thu, Aug 06, 2020 at 09:34:22PM +0300, Cengiz Can wrote:
>> Hello Andy,
>>
>> Can I get some feedback on v6 please?
>
>
> It's been 4 days, in the middle of a merge window, please give people a
> chance to catch up on other things...

I wasn't aware of that we're currently in a merge window. Sorry for my 
impatience.

>
> and do not top post please.

Sorry. I was tricked by my mobile email client.

>
> thanks,
>
> greg k-h

Thanks again and I wish a smooth merge window to all maintainers.

Cengiz Can


