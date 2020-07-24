Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B85BC433E3
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 20:24:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65128206F0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 20:24:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="ZcLYsNHx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbgGXUYW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 16:24:22 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:42146 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726083AbgGXUYV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 16:24:21 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1595622261; h=In-Reply-To: Content-Type: MIME-Version:
 References: Message-ID: Subject: Cc: To: From: Date: Sender;
 bh=F8/f//Q8SasxWgFDNAajtQ3g4nbJXEB+ZHsieUxxAJU=; b=ZcLYsNHxbq0JfSA3JXXppoJ4lbCBFlykXaT3i3KHVla84EI1OMMDpvhL3trPzi8ak5iQDZ78
 GA90rs8as7eUjDXkFWhPolNpyAZSJzDDkj77ERnYfXgXicKnSQl1agcqWmdNNfMlgFSD7M/U
 ZBhmykxWRuTBuk77TE1Bj8zPkuY=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 5f1b435aca57a65d47a6fbef (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 24 Jul 2020 20:23:54
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id ED705C433C6; Fri, 24 Jul 2020 20:23:53 +0000 (UTC)
Received: from localhost (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: ilina)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id CD03EC433C9;
        Fri, 24 Jul 2020 20:23:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CD03EC433C9
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
Date:   Fri, 24 Jul 2020 14:23:51 -0600
From:   Lina Iyer <ilina@codeaurora.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Doug Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Maulik Shah <mkshah@codeaurora.org>
Subject: Re: [PATCH] soc: qcom: rpmh-rsc: Sleep waiting for tcs slots to be
 free
Message-ID: <20200724202351.GK9185@codeaurora.org>
References: <20200723010137.3127584-1-swboyd@chromium.org>
 <CAD=FV=WtjyYY+bmocc17S9NbRs6inkAWjj7=c9qBsVf3LtG99Q@mail.gmail.com>
 <159561988523.3847286.14763422711224252201@swboyd.mtv.corp.google.com>
 <CAD=FV=WH1vKKe=MPVdtBJZWnSzxNLO0uyM02GFG6oCJfSEwehQ@mail.gmail.com>
 <159562087212.3847286.9484527206999948907@swboyd.mtv.corp.google.com>
 <20200724200841.GJ9185@codeaurora.org>
 <159562149056.3847286.11191144133990578500@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <159562149056.3847286.11191144133990578500@swboyd.mtv.corp.google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 24 2020 at 14:11 -0600, Stephen Boyd wrote:
>Quoting Lina Iyer (2020-07-24 13:08:41)
>> On Fri, Jul 24 2020 at 14:01 -0600, Stephen Boyd wrote:
>> >Quoting Doug Anderson (2020-07-24 12:49:56)
>> >> Hi,
>> >>
>> >> On Fri, Jul 24, 2020 at 12:44 PM Stephen Boyd <swboyd@chromium.org> wrote:
>> >I think Lina was alluding to this earlier in this
>> >thread.
>> I was thinking more of threaded irq handler than a kthread to post the
>> requests. We went away from post-thread approach a few years ago.
>>
>
>Ok, got it. Why was the kthread approach abandoned?

Simplification mostly, I think. Also, somebody requested that when the
async call returns they would atleast be guaranteed that the request has
been posted not necessarily processed at the remote end.

