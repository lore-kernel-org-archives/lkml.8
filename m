Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F390AC2D0F1
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 17:38:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD10C20BED
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 17:38:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="UFKNoN4+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727125AbgCaRi3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 13:38:29 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:57343 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725958AbgCaRi3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 13:38:29 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1585676308; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=A68oC8U79UBpdukiOxjd0RuIgv72CKAYZ4hNjVAU4J4=;
 b=UFKNoN4+pwVUJFK2PSmSqN1RtpSyw0PIHS7Hi34ZLeRlUytymE9Hias6I7mNkjs4LHl3qaVD
 EAniWV0GbD6wU4x/dYWiXarG8X8rAJwG328kANsCBuW2iDSglh+y1C69jbhjKyNrG8IJeQ5b
 T6sQvRRKnEcWYBQuhMsh986wtJ0=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e838013.7f249de50e30-smtp-out-n01;
 Tue, 31 Mar 2020 17:38:27 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 6F137C43637; Tue, 31 Mar 2020 17:38:26 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: rishabhb)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C0B3BC433F2;
        Tue, 31 Mar 2020 17:38:24 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 31 Mar 2020 10:38:24 -0700
From:   rishabhb@codeaurora.org
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-remoteproc <linux-remoteproc@vger.kernel.org>,
        Ohad Ben-Cohen <ohad@wizery.com>, psodagud@codeaurora.org,
        tsoni@codeaurora.org, Siddharth Gupta <sidgup@codeaurora.org>,
        linux-remoteproc-owner@vger.kernel.org
Subject: Re: [PATCH 1/2] remoteproc: Add userspace char device driver
In-Reply-To: <CANLsYkxEA66kGZh1rToSn79fpgPHqEjMZsSw74Rx3OLwG2k35w@mail.gmail.com>
References: <1585241440-7572-1-git-send-email-rishabhb@codeaurora.org>
 <1585241440-7572-2-git-send-email-rishabhb@codeaurora.org>
 <20200330221245.GA17782@xps15> <20200330224554.GD215915@minitux>
 <CANLsYkxEA66kGZh1rToSn79fpgPHqEjMZsSw74Rx3OLwG2k35w@mail.gmail.com>
Message-ID: <30f8b41df8831d19ce6efd0a28862708@codeaurora.org>
X-Sender: rishabhb@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-03-31 09:47, Mathieu Poirier wrote:
> On Mon, 30 Mar 2020 at 16:45, Bjorn Andersson
> <bjorn.andersson@linaro.org> wrote:
>> 
>> On Mon 30 Mar 15:12 PDT 2020, Mathieu Poirier wrote:
>> [..]
>> > > +   struct rproc *rproc;
>> > > +
>> > > +   rproc = container_of(inode->i_cdev, struct rproc, char_dev);
>> > > +   if (!rproc)
>> > > +           return -EINVAL;
>> > > +
>> > > +   rproc_shutdown(rproc);
>> >
>> > The scenario I see here is that a userspace program will call
>> > open(/dev/rproc_xyz, SOME_OPTION) when it is launched.  The file stays open
>> > until either the application shuts down, in which case it calls close() or it
>> > crashes.  In that case the system will automatically close all file descriptors
>> > that were open by the application, which will also call rproc_shutdown().
>> >
>> > To me the same functionality can be achieved with the current functionality
>> > provided by sysfs.
>> >
>> > When the application starts it needs to read
>> > "/sys/class/remoteproc/remoteprocX/state".  If the state is "offline" then
>> > "start" should be written to "/sys/.../state".  If the state is "running" the
>> > application just crashed and got restarted.  In which case it needs to stop the
>> > remote processor and start it again.
>> >
>> 
>> A case when this would be useful is the Qualcomm modem, which relies 
>> on
>> disk access through a "remote file system service" [1].
>> 
>> Today we register the service (a few layers ontop of rpmsg/GLINK) then
>> find the modem remoteproc and write "start" into the state sysfs file.
>> 
>> When we get a signal for termination we write "stop" into state to 
>> stop
>> the remoteproc before exiting.
>> 
>> There is however no way for us to indicate to the modem that rmtfs 
>> just
>> died, e.g. a kill -9 on the process will result in the modem continue
>> and the next IO request will fail which in most cases will be fatal.
I have this scenario written down in the cover letter for this patchset
  "[PATCH 0/2] Add character device interface to remoteproc"
I'll add it to the commit text as well.
> 
> The modem will crash when attempting an IO while rmtfs is down?
> 
>> 
>> So instead having rmtfs holding /dev/rproc_foo open would upon its
>> termination cause the modem to be stopped automatically, and as the
>> system respawns rmtfs the modem would be started anew and the two 
>> sides
>> would be synced up again.
> 
> I have a better idea of what is going on now - thanks for writing this 
> up.
> 
> I would make this feature a kernel configurable option as some people
> may not want it.  I also think having "/dev/remoteprocX" is fine, so
> no need to change anything currently visible in sysfs.
Ok. Makes sense.
> 
> Mathieu
> 
>> 
>> [1] https://github.com/andersson/rmtfs
>> 
>> Regards,
>> Bjorn
