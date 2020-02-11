Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AECCEC3B187
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 15:01:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85A4220675
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 15:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581433285;
	bh=y2EbHrP06L5OaU1623dq+EIafyEnQOLyL46r5Dkjrpo=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=FKWvKbWhvZKO0to0rB79X3wdMSe1E+DSu762vwAtbEIU9WbwphrtUTKSCjxcIH2dt
	 ks0uR8iZtx8QezObst0CTQ12vEsvfhk19vq2d2zlEHJsRD2qt6Ui/cemOF8D9wx7EQ
	 goS+R2CgwlWYHcOAVCuunIu1HmsLKQnKk08nYS/g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730301AbgBKPBY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 10:01:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:41410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728063AbgBKPBY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 10:01:24 -0500
Received: from pobox.suse.cz (prg-ext-pat.suse.com [213.151.95.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7BF6E2086A;
        Tue, 11 Feb 2020 15:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581433283;
        bh=y2EbHrP06L5OaU1623dq+EIafyEnQOLyL46r5Dkjrpo=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=Uaz/KHVYLGOszKR34MSUWB52cAjb8lmuCshYOv+e/VCKiXQsORIqdpuKMX0xn7QuO
         6axmkMTSXl4WkHQJC5xsUTxKQiPx/c8ObwVSJxQ4aD2NMQQfq1N5finJEKfJ9WfwM3
         SOuidlMVJL42uzyrnkWbIkJ7eyBmMVG51FboHqqY=
Date:   Tue, 11 Feb 2020 16:01:06 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Alan Stern <stern@rowland.harvard.edu>
cc:     peter enderborg <peter.enderborg@sony.com>,
        Johan Korsnes <jkorsnes@cisco.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kernel development list <linux-kernel@vger.kernel.org>,
        stable@vger.kernel.org
Subject: Re: [PATCH] HID: Extend report buffer size
In-Reply-To: <Pine.LNX.4.44L0.2002110952570.1574-100000@iolanthe.rowland.org>
Message-ID: <nycvar.YFH.7.76.2002111600250.3144@cbobk.fhfr.pm>
References: <Pine.LNX.4.44L0.2002110952570.1574-100000@iolanthe.rowland.org>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Feb 2020, Alan Stern wrote:

> > >> In the patch "HID: Fix slab-out-of-bounds read in hid_field_extract"
> > >> there added a check for buffer overruns. This made Elgato StreamDeck
> > >> to fail. This patch extend the buffer to 8192 to solve this. It also
> > >> adds a print of the requested length if it fails on this test.
> > >>
> > >> Signed-off-by: Peter Enderborg <peter.enderborg@sony.com>
> > >> ---
> > >>  drivers/hid/hid-core.c | 2 +-
> > >>  include/linux/hid.h    | 2 +-
> > >>  2 files changed, 2 insertions(+), 2 deletions(-)
> > >>
> > >> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> > >> index 851fe54ea59e..28841219b3d2 100644
> > >> --- a/drivers/hid/hid-core.c
> > >> +++ b/drivers/hid/hid-core.c
> > >> @@ -290,7 +290,7 @@ static int hid_add_field(struct hid_parser *parser, unsigned report_type, unsign
> > >>  
> > >>  	/* Total size check: Allow for possible report index byte */
> > >>  	if (report->size > (HID_MAX_BUFFER_SIZE - 1) << 3) {
> > >> -		hid_err(parser->device, "report is too long\n");
> > >> +		hid_err(parser->device, "report is too long (%d)\n", report->size);
> > >>  		return -1;
> > >>  	}
> > >>  
> > >> diff --git a/include/linux/hid.h b/include/linux/hid.h
> > >> index cd41f209043f..875f71132b14 100644
> > >> --- a/include/linux/hid.h
> > >> +++ b/include/linux/hid.h
> > >> @@ -492,7 +492,7 @@ struct hid_report_enum {
> > >>  };
> > >>  
> > >>  #define HID_MIN_BUFFER_SIZE	64		/* make sure there is at least a packet size of space */
> > >> -#define HID_MAX_BUFFER_SIZE	4096		/* 4kb */
> > >> +#define HID_MAX_BUFFER_SIZE	8192		/* 8kb */
> > >>  #define HID_CONTROL_FIFO_SIZE	256		/* to init devices with >100 reports */
> > >>  #define HID_OUTPUT_FIFO_SIZE	64
> > > The second part of this patch is identical to the "HID: core: increase
> > > HID report buffer size to 8KiB" patch submitted by Johan Korsnes a few
> > > weeks ago.  You might want to submit just the first part of your patch,
> > > or not submit anything at all.
> > >
> > > Alan Stern
> > >
> > >
> > Korsnes patch is not in Torvalds tree nor is it requested for stable. How do we get it there?
> 
> Bring the whole matter to Jiri's attention.  He is the person who will
> take care of it.

I have been a bit swamped during past few days. Johan's patch is in my 
list of things to process either today or tomorrow.

Thanks,

-- 
Jiri Kosina
SUSE Labs

