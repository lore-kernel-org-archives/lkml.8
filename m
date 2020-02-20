Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEFC3C11D09
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 13:57:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B77D6208C4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 13:57:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="lbzZua+l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728295AbgBTN5P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 08:57:15 -0500
Received: from mx.treblig.org ([46.43.15.161]:58356 "EHLO mx.treblig.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727943AbgBTN5P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 08:57:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
        ; s=bytemarkmx; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID
        :Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID
        :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
        Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe
        :List-Post:List-Owner:List-Archive;
        bh=trUk9QAGVy5As5jSzYabMW2A4UtLFgQM2O2KVgrb3Uk=; b=lbzZua+lp4FneaeF9HxEZAiZ8n
        txrzLS1g5swfhpFMClAwzbtSIRCHSeM6M5LaXiRzYn+1eJRDaESRRwrDK8pMhE9JENZVKfByUYRoJ
        kA5MHJGE+GaUXoYAMGLSdtt+h8pYVj2VMehH78Mi33dGqS+CXpMyUfjDCaq5fueURPZy4KhkTmyF1
        HwX/r1B7HAqBGL7Fj4Moa+W44BY0/5Py48sZ50hVRnzvVFctIZCA8ZnFeRMA+wk9jZ6K3hglfEnVW
        zZXS2lsex+R9BQskT+pk7qYxuiN1ILpFhKjp/XAzs9uzTajHas2ga1zNKNn8oPeDS8/VI4QAq+azM
        qpq9plMA==;
Received: from dg by mx.treblig.org with local (Exim 4.92)
        (envelope-from <dg@treblig.org>)
        id 1j4mKD-0006Wb-Kt; Thu, 20 Feb 2020 13:57:09 +0000
Date:   Thu, 20 Feb 2020 13:57:09 +0000
From:   "Dr. David Alan Gilbert" <linux@treblig.org>
To:     Meelis Roos <mroos@linux.ee>, linux@roeck-us.net
Cc:     linux-hwmon@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Chen Zhou <chenzhou10@huawei.com>
Subject: Re: w83627ehf crash in 5.6.0-rc2-00055-gca7e1fd1026c
Message-ID: <20200220135709.GB18071@gallifrey>
References: <434212bb-4eb9-7366-3255-79826d0e65bc@linux.ee>
 <20200220121451.GA18071@gallifrey>
 <6050ed14-f7a6-cb99-7268-072129226d48@linux.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6050ed14-f7a6-cb99-7268-072129226d48@linux.ee>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/4.19.0-5-amd64 (x86_64)
X-Uptime: 13:55:25 up 172 days, 14:15,  1 user,  load average: 0.00, 0.00,
 0.00
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Meelis Roos (mroos@linux.ee) wrote:
> > It looks like not all chips have temp_label, so I think we need to change w83627ehf_is_visible
> > which has:
> > 
> >                  if (attr == hwmon_temp_input || attr == hwmon_temp_label)
> >                          return 0444;
> > 
> > to
> >                  if (attr == hwmon_temp_input)
> >                          return 0444;
> >                  if (attr == hwmon_temp_label) {
> >                          if (data->temp_label)
> > 				return 0444;
> > 			else
> > 				return 0;
> >                  }
> > 
> > Does that work for you?
> Yes, it works - sensors are displayed as they should be, with nothing in dmesg.
> 
> Thank you for so quick response!

Great, I need to turn that into a proper patch; (I might need to wait till
Saturday for that, although if someone needs it before then please shout).

Dave

> 
> -- 
> Meelis Roos <mroos@linux.ee>
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/
