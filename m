Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD2E5C2D0E5
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 18:04:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE97C212CC
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 18:04:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727335AbgC0SEY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 14:04:24 -0400
Received: from foss.arm.com ([217.140.110.172]:50356 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726275AbgC0SEY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 14:04:24 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B1F2730E;
        Fri, 27 Mar 2020 11:04:23 -0700 (PDT)
Received: from [10.57.60.204] (unknown [10.57.60.204])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D425B3F71E;
        Fri, 27 Mar 2020 11:04:22 -0700 (PDT)
Subject: Re: [PATCH] iommu: Lower severity of add/remove device messages
To:     Ezequiel Garcia <ezequiel@collabora.com>,
        Joerg Roedel <joro@8bytes.org>
Cc:     iommu@lists.linux-foundation.org, kernel@collabora.com,
        linux-kernel@vger.kernel.org
References: <20200323214956.30165-1-ezequiel@collabora.com>
 <20200327095029.GB11538@8bytes.org>
 <9e863f96cd9a188db84ae8bc5a0d49287b4b4922.camel@collabora.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <6db3bcfb-c778-7190-a936-836eaba4bb73@arm.com>
Date:   Fri, 27 Mar 2020 18:04:22 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <9e863f96cd9a188db84ae8bc5a0d49287b4b4922.camel@collabora.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-03-27 1:02 pm, Ezequiel Garcia wrote:
> Hello Joerg,
> 
> Thanks for reviewing.
> 
> I understand this change bears some controversy
> for IOMMU, as developers are probably used to see these
> messages.
> 
> On Fri, 2020-03-27 at 10:50 +0100, Joerg Roedel wrote:
>> On Mon, Mar 23, 2020 at 06:49:56PM -0300, Ezequiel Garcia wrote:
>>> These user messages are not really informational,
>>> but mostly of debug nature. Lower their severity.
>>
>> Like most other messages in the kernel log, that is not a reason to
>> lower the severity.
>>
>> These messages are the first thing to look at when
>> looking into IOMMU related issues.
>>
> 
> Sure, but the messages are still here, you can
> always enable them when you are looking at IOMMU issues :-)

That still begs the question of who "you" is and how they know they're 
debugging an IOMMU issue in the first place. When all the developer has 
to go on is a third-hand bugzilla attachment from a distro user's vague 
report of graphics corruption/poor I/O performance/boot 
failure/whatever, being able to tell straight away from a standard dmesg 
dump whether an IOMMU is even in the picture or not saves a lot of 
protracted back-and-forth for everyone involved.
> The idea is to reduce the amount of verbosity in the kernel.

Under what justification? Users with slow consoles or who just want a 
quiet boot are already free to turn down the loglevel; a handful of 
messages at boot-time and device hotplug seem hardly at risk of drowning 
out all the systemd audit spam anyway. Note that the IOMMU subsystem is 
by nature a little atypical as a lot of what it does is only visible as 
secondary effects on other drivers and subsystems, without their 
explicit involvement or knowledge. In that respect, hiding its activity 
can arguably lead to more non-obvious situations than many other subsystems.

> If all subsystems would print messages that are useful
> when looking at issues, things would be quite nasty verbose.

 From a personal standpoint, can we at least eradicate all the "Hi! I'm 
a driver/subsystem you don't even have the hardware for!" messages 
first, then maybe come back and reconsider the ones that convey actual 
information later?

Robin.
