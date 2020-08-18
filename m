Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 431ADC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 14:48:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E99220866
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 14:48:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727782AbgHROsV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 10:48:21 -0400
Received: from netrider.rowland.org ([192.131.102.5]:56943 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726863AbgHROsT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 10:48:19 -0400
Received: (qmail 146374 invoked by uid 1000); 18 Aug 2020 10:48:18 -0400
Date:   Tue, 18 Aug 2020 10:48:18 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Jim Baxter <jim_baxter@mentor.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-usb@vger.kernel.org,
        "Resch Carsten \(CM/ESO6\)" <Carsten.Resch@de.bosch.com>,
        "Rosca, Eugeniu \(ADITG/ESB\)" <erosca@de.adit-jv.com>
Subject: Re: PROBLEM: Long Workqueue delays.
Message-ID: <20200818144818.GB144306@rowland.harvard.edu>
References: <71aafe68-7fe0-6b77-ea8e-83edd3f16c8d@mentor.com>
 <20200817115744.GA3985908@kroah.com>
 <57a7841d-86e3-b6df-1488-a252a68a9ee0@mentor.com>
 <20200817184753.GA120209@rowland.harvard.edu>
 <1838f2c3-7915-9e5b-3112-6b082b945410@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1838f2c3-7915-9e5b-3112-6b082b945410@mentor.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 18, 2020 at 11:54:51AM +0100, Jim Baxter wrote:
> On 17/08/2020 19:47, Alan Stern wrote:
> > 
> > Unplugging a R/W USB drive without unmounting it first is a great way to 
> > corrupt the data.
> > 
> Thank you, post development we will only mount the USB stick as R/O.
> 
> >> Using perf Iidentified the hub_events workqueue was spending a lot of time in
> >> invalidate_partition(), I have included a cut down the captured data from perf in
> >> [2] which shows the additional functions where the kworker spends most of its time.
> > 
> > invalidate_partition() is part of the block layer, not part of USB.  It 
> > gets called whenever a drive is removed from the system, no matter what 
> > type of drive it is.  You should ask the people involved in that 
> > subsystem why it takes so long.
> > 
> 
> I included the linux-mm list but missed the filesystem, I will ask the question
> to the linux-fsdevel too.

What about linux-block?  The block layer is different from the 
memory-management (mm) layer.

Alan Stern
