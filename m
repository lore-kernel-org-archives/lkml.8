Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4567C2BB1D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 14:42:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADA3220658
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 14:42:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="qt3qSv5I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731898AbgCPOm0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 10:42:26 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:18186 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731642AbgCPOmZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 10:42:25 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 48gzXt6JwWzw;
        Mon, 16 Mar 2020 15:42:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1584369742; bh=2ns96Yjlk6CyI7sqauauOfnPPcjHEnd9dp1VnEEEGnE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qt3qSv5IYlp/Ocv0e40GrF1C6d694xdlijScCOwP5wJDVawaNXcIyoo6FY7xBw8Qy
         kZHJYWEFCkBxj3jSSO5CwtfHRYwbQC7euEpKWVLYZ279skYgO/wRqUhyy9xDiCcF4+
         9EIviLxKjOgDlEQOB5FW6llnpqMzJ0n/E5+/ajjijLwE5HNV5sSNI+a+0fD9ihzU1Y
         iJYn00O9QTf2Kf56fpFgGDtpBmFfT6m/olxis71OwdWDxjQkrgNvcj2Pfp8EzkGq4v
         JKY6Nv8ElRdlDXsobPnYKT3QOLe+VzNyrtUFbp9PVuhEnXEX9/i45NrYjJkWfCvt2r
         swobIPU3b6OUg==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.2 at mail
Date:   Mon, 16 Mar 2020 15:42:21 +0100
From:   =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Ludovic Desroches <ludovic.desroches@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i2c: at91: support atomic write xfer
Message-ID: <20200316144221.GC19141@qmqm.qmqm.pl>
References: <c05f76f74cd6a7ec2735c96861f9d5933631c112.1584296795.git.mirq-linux@rere.qmqm.pl>
 <9924dd54-dd8b-d130-9607-2bbbc65675d5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9924dd54-dd8b-d130-9607-2bbbc65675d5@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 15, 2020 at 11:46:33PM +0300, Dmitry Osipenko wrote:
> 15.03.2020 21:27, Michał Mirosław пишет:
> > Implement basic support for atomic write - enough to get a simple
> > write to PMIC on shutdown. Only for chips having ALT_CMD register,
> > eg. SAMA5D2.
> > 
> > Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
> > ---
> 
> Hello Michał,
> 
> ...
> > +	ret = pm_runtime_get_sync(dev->dev);
> > +	if (ret < 0)
> > +		goto out;
> 
> Runtime PM can't be used while interrupts are disabled, unless
> pm_runtime_irq_safe() is used and driver's RPM callback is IRQ-safe.

I didn't get any warnings from lockdep and friends, but I'll double
check if this is by luck.

> ...
> > +	timeout = jiffies + (2 + msg->len) * HZ/1000;
> > +	for (;;) {
> > +		stat = at91_twi_read(dev, AT91_TWI_SR);
> > +		if (stat & AT91_TWI_TXCOMP)
> > +			break;
> > +		if (time_after(jiffies, timeout)) {
> > +			ret = -ETIMEDOUT;
> > +			goto out;
> > +		}
> > +		udelay(100);
> > +	}
> 
> Jiffies can't be used with the disabled interrupts because jiffies are
> updated by timer's interrupt.
> 
> Either ktime() API or iterator-based loop should be used.

Thanks for the pointers. In my use-case power is cut from the CPU at this
point so it didn't matter that the loop was infinite.

Best Regards
Michał Mirosław
