Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CB9BC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 11:48:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13D2B20657
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 11:48:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="r1UHOryz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728232AbgGPLsq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 07:48:46 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:13263 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728175AbgGPLsq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 07:48:46 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1594900125; h=Content-Transfer-Encoding: Content-Type:
 MIME-Version: Message-ID: Date: Subject: In-Reply-To: References: Cc:
 To: From: Sender; bh=aM87sqkNzeJ/91w1iSJM0tfB/by6oEdZCg93yCjk6SY=; b=r1UHOryzRGkNt/xKdOLm8+b5VChLfaPYG4FlLJTkFkoh7OoRBYROrV00KcgQHaQGwZINB6d6
 T0kBlbP0tahS61JprRCKA8P5WoAPL+ve1rEpNU9K2KpS6ZRGhO0Upq2P8W8O1M/3WMCzzhwy
 EzrVApD5V1n2kXW0LzopQArxW2M=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 5f103e91d3d65084220a440f (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 16 Jul 2020 11:48:33
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id DA00CC43395; Thu, 16 Jul 2020 11:48:32 +0000 (UTC)
Received: from Pillair (unknown [183.83.71.149])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: pillair)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5140DC433C9;
        Thu, 16 Jul 2020 11:48:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5140DC433C9
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=pillair@codeaurora.org
From:   "Rakesh Pillai" <pillair@codeaurora.org>
To:     "'Ben Greear'" <greearb@candelatech.com>,
        <ath10k@lists.infradead.org>
Cc:     <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1593238973-23237-1-git-send-email-pillair@codeaurora.org> <926301ed-e27f-0d8f-0177-6484bfffa40c@candelatech.com> <000201d64d0a$b3d39d10$1b7ad730$@codeaurora.org> <859a8ffb-6108-81f3-b379-4a0adfa064fe@candelatech.com>
In-Reply-To: <859a8ffb-6108-81f3-b379-4a0adfa064fe@candelatech.com>
Subject: RE: [PATCH] ath10k: Add history for tracking certain events
Date:   Thu, 16 Jul 2020 17:18:22 +0530
Message-ID: <008501d65b67$0743a0c0$15cae240$@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJ0JDYcv05C8nhyAbHgeWn72AC7twKruW4sAhHRnKMBmbwe6KebyyaA
Content-Language: en-us
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Ben Greear <greearb@candelatech.com>
> Sent: Sunday, June 28, 2020 10:56 PM
> To: Rakesh Pillai <pillair@codeaurora.org>; ath10k@lists.infradead.org
> Cc: linux-wireless@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH] ath10k: Add history for tracking certain events
> 
> 
> 
> On 06/27/2020 10:12 PM, Rakesh Pillai wrote:
> >
> >
> >> -----Original Message-----
> >> From: Ben Greear <greearb@candelatech.com>
> >> Sent: Saturday, June 27, 2020 8:58 PM
> >> To: Rakesh Pillai <pillair@codeaurora.org>; ath10k@lists.infradead.org
> >> Cc: linux-wireless@vger.kernel.org; linux-kernel@vger.kernel.org
> >> Subject: Re: [PATCH] ath10k: Add history for tracking certain events
> >>
> >>
> >>
> >> On 06/26/2020 11:22 PM, Rakesh Pillai wrote:
> >>> For debugging many issues, a history of the
> >>> below mentioned events can help get an idea
> >>> of what exactly was going on just before any
> >>> issue occurred in the system. These event
> >>> history will be collected only when the host
> >>> driver is run in debug mode (i.e. with the
> >>> config ATH10K_DEBUG enabled).
> >>
> >> This should be disabled by default unless user specifically pokes some
> >> debugfs
> >> value to turn it on so that it does not impact performance.
> >
> > Hi Ben,
> > This history is enabled only if the user compiles the kernel with
> > ATH10K_DEBUG.
> > Making it runtime, adds a lot of "if" conditions for this history
record.
> > Do you suggest to add support to enable/disable it runtime even in
> > ATH10K_DEBUG ?
> 
> Yes, because you are adding lots of locks/unlocks.  That is way more
> expensive
> than an if statement.  You can add an 'unlikely' to the if check as well,
so
> compiler will optimize for this feature not being enabled.


Hi Ben,
I missed this mail somehow.
Yes sure, I will make the necessary changes and upload a new patchset.

Thanks,
Rakesh Pillai.


> 
> Thanks,
> Ben
> 
> >
> >>
> >> Thanks,
> >> Ben
> >>
> >>>
> >>> Add history for tracking the below events
> >>> - register read
> >>> - register write
> >>> - IRQ trigger
> >>> - IRQ Enable
> >>> - IRQ Disable
> >>> - NAPI poll
> >>> - CE service
> >>> - WMI cmd
> >>> - WMI event
> >>> - WMI tx completion
> >>>
> >>> This will help in debugging any crash or any
> >>> improper behaviour.
> >>
> >>
> >> --
> >> Ben Greear <greearb@candelatech.com>
> >> Candela Technologies Inc  http://www.candelatech.com
> >
> 
> --
> Ben Greear <greearb@candelatech.com>
> Candela Technologies Inc  http://www.candelatech.com

