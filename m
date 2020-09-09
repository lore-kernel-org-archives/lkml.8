Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A297C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 17:27:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C210221556
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 17:27:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="LGv8YOJ+";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="TMBUsllJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730022AbgIIR1w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 13:27:52 -0400
Received: from a27-10.smtp-out.us-west-2.amazonses.com ([54.240.27.10]:38312
        "EHLO a27-10.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729014AbgIIR1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 13:27:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1599672466;
        h=MIME-Version:Content-Type:Content-Transfer-Encoding:Date:From:To:Cc:Subject:In-Reply-To:References:Message-ID;
        bh=5st0RDaC03w5ECvRoWQObucitG8ndSbU87ypht1Rn4g=;
        b=LGv8YOJ+I/v6U418EsEuFW2k2EaGzAZ9AyDS8BFEfZofTdev/Y8GgH9wcLZayH0I
        AhyOk0Y8mCGEeaNVRs8QGtziGPGbEuDd/JW3AkyvBWw5KKKJpWFQAav/tWLNq/VdEZ5
        A+Jg0mEwkScaW4T23feyHCy2Hhqza71FOvmqO4U0=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=hsbnp7p3ensaochzwyq5wwmceodymuwv; d=amazonses.com; t=1599672465;
        h=MIME-Version:Content-Type:Content-Transfer-Encoding:Date:From:To:Cc:Subject:In-Reply-To:References:Message-ID:Feedback-ID;
        bh=5st0RDaC03w5ECvRoWQObucitG8ndSbU87ypht1Rn4g=;
        b=TMBUsllJv+4rcx6ozvKQjue4pEb/jQU2VRuOK0i4Q0xpejL6zt7b/ERggEre9TTr
        PbukI6r38OIvknzglLCqeDNiFlp17/AtrsE4rkcUpKKYIlDOMBubTun0hErrp1UMczP
        /Ezcr1mP43fGMnbNjWZ7m4bs85uAO0hX3WFNpRKk=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 9 Sep 2020 17:27:45 +0000
From:   rishabhb@codeaurora.org
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        tsoni@codeaurora.org, psodagud@codeaurora.org,
        sidgup@codeaurora.org, linux-remoteproc-owner@vger.kernel.org
Subject: Re: [PATCH v2 0/3] Expose recovery/coredump configuration from sysfs
In-Reply-To: <20200904220213.GA404035@xps15>
References: <1598557731-1566-1-git-send-email-rishabhb@codeaurora.org>
 <20200901220542.GA121362@xps15> <20200903235944.GC3715@yoga>
 <20200904220213.GA404035@xps15>
Message-ID: <0101017473e8b87b-d40d1102-822a-4791-9f49-5d8e0d5d9753-000000@us-west-2.amazonses.com>
X-Sender: rishabhb@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
X-SES-Outgoing: 2020.09.09-54.240.27.10
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-09-04 15:02, Mathieu Poirier wrote:
> On Thu, Sep 03, 2020 at 06:59:44PM -0500, Bjorn Andersson wrote:
>> On Tue 01 Sep 17:05 CDT 2020, Mathieu Poirier wrote:
>> 
>> > Hi Rishabh,
>> >
>> > On Thu, Aug 27, 2020 at 12:48:48PM -0700, Rishabh Bhatnagar wrote:
>> > > From Android R onwards Google has restricted access to debugfs in user
>> > > and user-debug builds. This restricts access to most of the features
>> > > exposed through debugfs. This patch series adds a configurable option
>> > > to move the recovery/coredump interfaces to sysfs. If the feature
>> > > flag is selected it would move these interfaces to sysfs and remove
>> > > the equivalent debugfs interface.
>> >
>> > What I meant wast to move the coredump entry from debugfs to sysfs and from
>> > there make it available to user space using a kernel config.
>> 
>> Why would we not always make this available in sysfs?
> 
> At this time the options are in debugfs and vendors can decide to make 
> that
> available on products if they want to.  The idea behind using a kernel
> configuration once moved to sysfs was to give the same kind of options.
> 
>> 
>> > But thinking further on this it may be better to simply provide an API
>> > to set the coredump mode from the platform driver, the same way
>> > rproc_coredump_set_elf_info() works.
>> 
>> Being able to invoke these from the platform drivers sounds like a new
>> feature. What would trigger the platform drivers to call this? Or are
>> you perhaps asking for the means of the drivers to be able to select 
>> the
>> default mode?
> 
> My ultimate goal is to avoid needlessly stuffing things in sysfs.  My 
> hope in
> suggesting a new API was that platform drivers could recognise the kind 
> of
> build/environment they operate in and setup the coredump mode 
> accordingly.  That
> would have allowed us to leave debugfs options alone.
> 
>> 
>> Regarding the default mode, I think it would make sense to make the
>> default "disabled", because this is the most sensible configuration in 
>> a
>> "production" environment. And the sysfs means we have a convenient
>> mechanism to configure it, even on production environments.
>> 
> 
> I am weary of changing something that hasn't been requested.
> 
>> > That will prevent breaking a fair amount of user space code...
>> >
>> 
>> We typically don't guarantee that the debugfs interfaces are stable 
>> and
>> if I understand the beginning of you reply you still want to move it
>> from debugfs to sysfs - which I presume would break such scripts in 
>> the
>> first place?
> 
> Correct - I am sure that moving coredump and recovery options to sysfs 
> will
> break user space scripts.  Even if debugfs is not part of the ABI it 
> would be
> nice to avoid disrupting people as much as possible.
> 
>> 
>> 
>> I would prefer to see that we don't introduce config options for every
>> little thing, unless there's good reason for it.
> 
> I totally agree.  It is with great reluctance that I asked Rishab to 
> proceed
> the way he did in V3.  His usecase makes sense... On the flip side this 
> is
> pushed down on the kernel community and I really like Christoph's 
> position about
> fixing Android and leaving the kernel alone.
> 
Well, removing debugfs is conscious decision taken by android due to 
security
concerns and there is not we can fix there.
Would it be a terrible idea to have recovery and coredump exposed from 
both
sysfs and debugfs instead of choosing one and breaking userspace code?
>> 
>> Regards,
>> Bjorn
>> 
>> > Let me know if that can work for you.
>> >
>> > Thanks,
>> > Mathieu
>> >
>> > > 'Coredump' and 'Recovery' are critical
>> > > interfaces that are required for remoteproc to work on Qualcomm Chipsets.
>> > > Coredump configuration needs to be set to "inline" in debug/test build
>> > > and "disabled" in production builds. Whereas recovery needs to be
>> > > "disabled" for debugging purposes and "enabled" on production builds.
>> > >
>> > > Changelog:
>> > >
>> > > v1 -> v2:
>> > > - Correct the contact name in the sysfs documentation.
>> > > - Remove the redundant write documentation for coredump/recovery sysfs
>> > > - Add a feature flag to make this interface switch configurable.
>> > >
>> > > Rishabh Bhatnagar (3):
>> > >   remoteproc: Expose remoteproc configuration through sysfs
>> > >   remoteproc: Add coredump configuration to sysfs
>> > >   remoteproc: Add recovery configuration to sysfs
>> > >
>> > >  Documentation/ABI/testing/sysfs-class-remoteproc |  44 ++++++++
>> > >  drivers/remoteproc/Kconfig                       |  12 +++
>> > >  drivers/remoteproc/remoteproc_debugfs.c          |  10 +-
>> > >  drivers/remoteproc/remoteproc_sysfs.c            | 126 +++++++++++++++++++++++
>> > >  4 files changed, 190 insertions(+), 2 deletions(-)
>> > >
>> > > --
>> > > The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
>> > > a Linux Foundation Collaborative Project
>> > >
