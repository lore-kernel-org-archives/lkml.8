Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42F7CC11D0C
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 15:52:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A8E220659
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 15:52:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="rOdYYUhY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728583AbgBTPwK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 10:52:10 -0500
Received: from mx.treblig.org ([46.43.15.161]:58668 "EHLO mx.treblig.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728289AbgBTPwJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 10:52:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
        ; s=bytemarkmx; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID
        :Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID
        :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
        Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe
        :List-Post:List-Owner:List-Archive;
        bh=+C8IabH42Dpc9RVl6yu13ukx4iHkXHb1tLJu1omzXNc=; b=rOdYYUhY05kGc0rziD4apvUsNC
        Mbz0U4MZ7Q9g0cuiRPegO7kcbp/luzXuaXKlWqnZNNs2bEXaJFpRR8BMnr8zitgrV5rE7lBtSNy4O
        PNWLzXiaUUhy7TJaxI5lHv7qo9gcDXoNAJtVJGu/8owAsMzXjE4yPn34wNwFiIkeTALD6X+jTNbVs
        F8dUVK8nJ6XH2CyasQH9wORrPwdqQEBxfc4NXSF18gObA7OJwdp+AHwBMGxVHgDsR7FUCb+Lbe/6x
        z4wZ1Xjhfeb0WBgszkkV6bA4/eU1BydPPuehFga44C7mrfi1L3dpdQAHY+9uHgp+xHFeCpdXj8Zim
        4h8033TA==;
Received: from dg by mx.treblig.org with local (Exim 4.92)
        (envelope-from <dg@treblig.org>)
        id 1j4o7Q-0007el-Ow; Thu, 20 Feb 2020 15:52:04 +0000
Date:   Thu, 20 Feb 2020 15:52:04 +0000
From:   "Dr. David Alan Gilbert" <linux@treblig.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Meelis Roos <mroos@linux.ee>, linux-hwmon@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Chen Zhou <chenzhou10@huawei.com>
Subject: Re: w83627ehf crash in 5.6.0-rc2-00055-gca7e1fd1026c
Message-ID: <20200220155204.GC18071@gallifrey>
References: <434212bb-4eb9-7366-3255-79826d0e65bc@linux.ee>
 <20200220121451.GA18071@gallifrey>
 <6050ed14-f7a6-cb99-7268-072129226d48@linux.ee>
 <20200220135709.GB18071@gallifrey>
 <ad023dc1-1878-dcd9-a183-06003ed698af@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad023dc1-1878-dcd9-a183-06003ed698af@roeck-us.net>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/4.19.0-5-amd64 (x86_64)
X-Uptime: 15:51:37 up 172 days, 16:12,  1 user,  load average: 0.00, 0.00,
 0.00
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Guenter Roeck (linux@roeck-us.net) wrote:
> On 2/20/20 5:57 AM, Dr. David Alan Gilbert wrote:
> > * Meelis Roos (mroos@linux.ee) wrote:
> > > > It looks like not all chips have temp_label, so I think we need to change w83627ehf_is_visible
> > > > which has:
> > > > 
> > > >                   if (attr == hwmon_temp_input || attr == hwmon_temp_label)
> > > >                           return 0444;
> > > > 
> > > > to
> > > >                   if (attr == hwmon_temp_input)
> > > >                           return 0444;
> > > >                   if (attr == hwmon_temp_label) {
> > > >                           if (data->temp_label)
> > > > 				return 0444;
> > > > 			else
> > > > 				return 0;
> 
> Nitpick: else after return isn't necessary. Too bad I didn't notice that before;
> static analyzers will have a field day :-)
> 
> > > >                   }
> > > > 
> > > > Does that work for you?
> > > Yes, it works - sensors are displayed as they should be, with nothing in dmesg.
> > > 
> > > Thank you for so quick response!
> > 
> > Great, I need to turn that into a proper patch; (I might need to wait till
> > Saturday for that, although if someone needs it before then please shout).
> > 
> 
> We'll want this fixed in the next stable release candidate, so I wrote one up
> and submitted it.

Thanks!

Dave

> Thanks,
> Guenter
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/
