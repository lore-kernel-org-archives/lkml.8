Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B40B1C38A2A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 10:04:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B4532073A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 10:04:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="xRJO/OCH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbgEGKE3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 06:04:29 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:57423 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725834AbgEGKE3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 06:04:29 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1588845868; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=1GMwknV/Hnx3pGwGQw2fgiF5fV1yZjKvADEF8GPIB3k=;
 b=xRJO/OCHQxjhykYpGeEbXVfD5hVhN13KtnhnsWlNLYfKbvHo+6gsJ16nRoYs7FUDdIjdYvdq
 8bsZ6fj0YN2P1h5coWdjBNXnFLH/g61/vc3qaOpGIZOHYYYSbRuK8EWcclqdv8gdm5UFnVzH
 QuFd7wGGVpSpOnJ9DcES0+GFHoA=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5eb3dd20.7f3116e7d8b8-smtp-out-n01;
 Thu, 07 May 2020 10:04:16 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 2C6D9C43637; Thu,  7 May 2020 10:04:16 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: saiprakash.ranjan)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 81A1BC433F2;
        Thu,  7 May 2020 10:04:15 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 07 May 2020 15:34:15 +0530
From:   Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To:     Doug Anderson <dianders@chromium.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        "list@263.net:IOMMU DRIVERS , Joerg Roedel <joro@8bytes.org>," 
        <iommu@lists.linux-foundation.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Subject: Re: [PATCHv2] iommu/arm-smmu: Make remove callback message more
 informative
In-Reply-To: <CAD=FV=U0Hhae3D1-P8kbcZafHeuqng11BNAbOb2YWPx+M7X5Gw@mail.gmail.com>
References: <20200423095531.9868-1-saiprakash.ranjan@codeaurora.org>
 <CAD=FV=W=d=KrTwgMOO-ukFc7ZhkE92qGYumUEDrtjmhQOpdWbg@mail.gmail.com>
 <CAD=FV=U0Hhae3D1-P8kbcZafHeuqng11BNAbOb2YWPx+M7X5Gw@mail.gmail.com>
Message-ID: <0b5098c28360d018f390a97155b9776c@codeaurora.org>
X-Sender: saiprakash.ranjan@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2020-05-07 05:40, Doug Anderson wrote:
> Hi,
> 
> On Thu, Apr 23, 2020 at 7:35 AM Doug Anderson <dianders@chromium.org> 
> wrote:
>> 
>> Hi,
>> 
>> On Thu, Apr 23, 2020 at 2:55 AM Sai Prakash Ranjan
>> <saiprakash.ranjan@codeaurora.org> wrote:
>> >
>> > Currently on reboot/shutdown, the following messages are
>> > displayed on the console as error messages before the
>> > system reboots/shutdown as part of remove callback.
>> >
>> > On SC7180:
>> >
>> >   arm-smmu 15000000.iommu: removing device with active domains!
>> >   arm-smmu 5040000.iommu: removing device with active domains!
>> >
>> > Make this error message more informative and less scary.
>> >
>> > Reported-by: Douglas Anderson <dianders@chromium.org>
>> > Suggested-by: Robin Murphy <robin.murphy@arm.com>
>> > Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
>> > ---
>> >  drivers/iommu/arm-smmu.c | 2 +-
>> >  1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> 
> Is this patch waiting on anything in particular now?  Do we need
> reviews from Robin and/or Will?
> 

Waiting for their reviews as they are the maintainers/reviewers :)

-Sai
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a 
member
of Code Aurora Forum, hosted by The Linux Foundation
