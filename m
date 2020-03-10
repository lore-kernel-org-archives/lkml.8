Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92872C18E5A
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 09:12:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 600EE2467F
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 09:12:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="Cqg12LMT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726403AbgCJJMA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 05:12:00 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:16894 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726331AbgCJJMA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 05:12:00 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1583831519; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=f+FiBYtKZwNeerwm6XB/ry8mbUFti3dsX1e/rZgQbTI=; b=Cqg12LMTmUFaPlz+TLqydxXox1Ob6ipgctlxcc1hQ+MOspAoptFzicyeERR8pSHTnZ8U89SH
 cBUrsNSbUjdhAvYxJ6RbK8Fr1ni72g5FJRtiN9SlPijJv2WLwbxxVAKPASZNYBT1mgyujnbi
 b6G6CeIb1HvnneIJ9Ivf/s1dxno=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e6759dd.7f060ada33e8-smtp-out-n01;
 Tue, 10 Mar 2020 09:11:57 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id AB6A4C43637; Tue, 10 Mar 2020 09:11:56 +0000 (UTC)
Received: from [192.168.0.103] (unknown [183.83.137.145])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mkshah)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3EEF1C433BA;
        Tue, 10 Mar 2020 09:11:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3EEF1C433BA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=mkshah@codeaurora.org
Subject: Re: [PATCH v9 3/3] soc: qcom: rpmh: Invoke rpmh_flush() for dirty
 caches
To:     Doug Anderson <dianders@chromium.org>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Evan Green <evgreen@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Andy Gross <agross@kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Lina Iyer <ilina@codeaurora.org>, lsrao@codeaurora.org
References: <1582889903-12890-1-git-send-email-mkshah@codeaurora.org>
 <1582889903-12890-4-git-send-email-mkshah@codeaurora.org>
 <CAD=FV=V92fFH8q+yvMk2sWdgi_xjFyvt3rMu14O+sO5zLp2kGg@mail.gmail.com>
 <7704638e-b473-d0cf-73ab-2bdb67b636ba@codeaurora.org>
 <CAD=FV=XL631dpEY8iB=gzjnh1cZVk6AKRafkQ7ke++AfXtuHNA@mail.gmail.com>
 <c65ec56b-6cd2-8593-7d25-23eb2f3672d0@codeaurora.org>
 <CAD=FV=VNaqwiti+UB8fLgjF5r2CD2xeF_p7qHS-_yXqf+ZDrBg@mail.gmail.com>
From:   Maulik Shah <mkshah@codeaurora.org>
Message-ID: <fb50ee6c-b8f9-6685-c4bd-43bcca5a1553@codeaurora.org>
Date:   Tue, 10 Mar 2020 14:41:49 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAD=FV=VNaqwiti+UB8fLgjF5r2CD2xeF_p7qHS-_yXqf+ZDrBg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/6/2020 3:48 AM, Doug Anderson wrote:
> Hi,
>
> On Thu, Mar 5, 2020 at 1:41 AM Maulik Shah <mkshah@codeaurora.org> wrote:
>  >> There are other cases like below which also gets impacted if driver
>>>> don't cache anything...
>>>>
>>>> for example, when we don’t have dedicated ACTIVE TCS ( if we have below
>>>> config with ACTIVE TCS count 0)
>>>>      qcom,tcs-config = <ACTIVE_TCS  0>,
>>>>                            <SLEEP_TCS   3>,
>>>>                            <WAKE_TCS    3>,
>>>>
>>>> Now to send active data, driver may re-use/ re-purpose few of the sleep
>>>> or wake TCS, to be used as ACTIVE TCS and once work is done,
>>>> it will be re-allocated in SLEEP/ WAKE TCS pool accordingly. If driver
>>>> don’t cache, all the SLEEP and WAKE data is lost when one
>>>> of TCS is repurposed to use as ACTIVE TCS.
>>> Ah, interesting.  I'll read the code more, but are you expecting this
>>> type of situation to work today, or is it theoretical for the future?
>> yes, we have targets which needs to work with this type of situation.
> My brain is still slowly absorbing all the code, but something tells
> me that targets with no ACTIVE TCS will not work properly with non-OSI
> mode unless you change your patches more.  Specifically to make the
> zero ACTIVE TCS case work I think you need a rpmh_flush() call after
> _ALL_ calls to rpmh_write() and rpmh_write_batch() (even those
> modifying ACTIVE state).  rpmh_write_async() will be yet more
> interesting because you'd have to flush in rpmh_tx_done() I guess?
> ...and also somehow you need to inhibit entering sleep mode if an
> async write was in progress?  Maybe easier to just detect the
> "non-OSI-mode + 0 ACTIVE TCS" case at probe time and fail to probe?
>
>
> -Doug
No, it shouldn’t break with "non-OSI-mode + 0 ACTIVE TCS"

After taking your suggestion to do rpmh start/end transaction in v13, rpmh_end_transaction()
invokes rpmh_flush() only for the last client and by this time expecting all of rpmh_write()
and rpmh_write_batch() will be already “finished” as client first waits for them to finish
and then only invokes end.

So driver is good to handle rpmh_write() and rpmh_write_batch() calls.

Regarding rpmh_write_async() call, which is a fire-n-forget request from SW and client driver
may immediately invoke rpmh_end_transaction() after this.

this case is also handled…
Lets again take an example for understanding this..

1.    Client invokes rpmh_write_async() to send ACTIVE cmds for targets which has zero ACTIVE TCS

    Rpmh driver Re-purposes one of SLEEP/WAKE TCS to use as ACTIVE, internally this also sets
    drv->tcs_in_use to true for respective SLEEP/WAKE TCS.

2.    Client now without waiting for above to finish, goes ahead and invokes rpmh_end_transaction()
    which calls rpmh_flush() (in case cache become dirty)

    Now if re-purposed TCS is still in use in HW (transaction in progress), we still have
    drv->tcs_in_use set. So the rpmh_rsc_invalidate() (invoked from rpmh_flush()) will keep on
    returning -EAGAIN until that TCS becomes free to use and then goes ahead to finish its job.
   
Thanks,
Maulik

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
