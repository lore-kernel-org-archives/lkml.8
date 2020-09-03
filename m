Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5F5FC433E9
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 15:47:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8886F20775
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 15:47:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="P1a/YlH8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728525AbgICPrt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 11:47:49 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:34535 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728461AbgICPrm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 11:47:42 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1599148061; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=LIjty3I+rui9Xy7iMwG3DDP6McLv5hVPeKQBSlzDndI=;
 b=P1a/YlH8CyffCbyQYgFTbFnb5rSVUF8dth4uoyBKtISFvaIqil2YcSgSrJwcWIdQ5cpGmvxj
 H3XXf1hB7zyeavJVheFdPXrIqZpFQlbPMP3nkjOCNWiWNIZ+XbGc2vaV/xQ5/deKkjuKcU11
 ZlbFhl3huyZhpynsJJ/HdOUrRBA=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-west-2.postgun.com with SMTP id
 5f5110184ba82a82fdab3a9f (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 03 Sep 2020 15:47:36
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 3D878C43391; Thu,  3 Sep 2020 15:47:36 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: saiprakash.ranjan)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 70D96C433C8;
        Thu,  3 Sep 2020 15:47:35 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Thu, 03 Sep 2020 21:17:35 +0530
From:   Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Isaac J. Manjarres" <isaacm@codeaurora.org>,
        linux-arm-msm-owner@vger.kernel.org
Subject: Re: [PATCHv2] soc: qcom: llcc: Support chipsets that can write to
 llcc registers
In-Reply-To: <CAD=FV=Xt0NTNjCEJ2USfyd2qZ+FfBz9xwctbpv+hSWvvCoAZFg@mail.gmail.com>
References: <20200817144722.6665-1-saiprakash.ranjan@codeaurora.org>
 <CAD=FV=VE6vCPjDvvP0e73tnd8u5rPuMUa-mwvDazrfUpXP+bKQ@mail.gmail.com>
 <2a0c5fa189dbb2e810ba88f59621b65c@codeaurora.org>
 <CAD=FV=X8yS1gUNhhVNyfuRPzDUheG2Rco2g16KMegCG6fKJw7Q@mail.gmail.com>
 <d949bdfa15b133f74a47727401553c76@codeaurora.org>
 <7714ee57f75542839d5c33b28f232aa6@codeaurora.org>
 <CAD=FV=Xt0NTNjCEJ2USfyd2qZ+FfBz9xwctbpv+hSWvvCoAZFg@mail.gmail.com>
Message-ID: <dd60dafcea8b75b10516bf2bc4952abb@codeaurora.org>
X-Sender: saiprakash.ranjan@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-09-03 19:16, Doug Anderson wrote:
> Hi,
> 
> On Thu, Sep 3, 2020 at 2:58 AM Sai Prakash Ranjan
> <saiprakash.ranjan@codeaurora.org> wrote:
>> 
>> Hi,
>> 
>> On 2020-08-18 21:07, Sai Prakash Ranjan wrote:
>> > Hi Doug,
>> >
>> >>
>> >> I guess to start, it wasn't obvious (to me) that there were two
>> >> choices and we were picking one.  Mentioning that the other
>> >> alternative was way-based allocation would help a lot.  Even if you
>> >> can't fully explain the differences between the two, adding something
>> >> to the commit message indicating that this is a policy decision (in
>> >> other words, both work but each have their tradeoffs) would help.
>> >> Something like this, if it's correct:
>> >>
>> >> In general we try to enable capacity based allocation (instead of the
>> >> default way based allocation) since that gives us better performance
>> >> with the current software / hardware configuration.
>> >>
>> >
>> > Thanks, I will add it for next version. Let me also go poke some arch
>> > teams
>> > to understand if we actually do gain something with this selection, who
>> > knows
>> > we might get some additional details as well.
>> >
>> 
>> I got some information from arch team today, to quote them exactly:
>> 
>> 1) What benefits capacity based allocation brings over the default way
>> based allocation?
>> 
>> "Capacity based allows finer grain partition. It is not about improved
>> performance but more flexibility in configuration."
>> 
>> 2) Retain through power collapse, doesn’t it burn more power?
>> 
>> "This feature is similar to the standard feature of retention. Yes, 
>> when
>> we
>> have cache in retention mode it burns more power but it keeps the 
>> values
>> so
>> that when we wake up we can get more cache hits."
>> 
>> 
>> If its good enough, then I will add this info to the commit msg and 
>> post
>> next version.
> 
> Sounds fine to me.  I was mostly looking for a high level idea of what
> was happening here.  I am at least a little curious about the
> retention bit.  Is that retention during S3, or during some sort of
> Runtime PM?  Any idea how much power is burned?  Unless the power is
> miniscule it seems hard to believe that it would be a net win to keep
> a cache powered up during S3 unless you're planning on waking up a
> lot.
> 

The retention setting is based on sub cache id(SCID), so I think its for
runtime pm, the power numbers weren't provided. But I believe these
decisions are made after solid testing and not some random 
approximations.

Thanks,
Sai

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a 
member
of Code Aurora Forum, hosted by The Linux Foundation
