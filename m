Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF399C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 19:47:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DFE9A2086A
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 19:47:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="PF5pZvM0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726233AbgHFTrT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 15:47:19 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:34191 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725272AbgHFTrS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 15:47:18 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1596743237; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=/B6mEs/W9A3x/s02MzsmbrVTWOdpSU8P9ZPpHWSNhQ8=;
 b=PF5pZvM0wRfKj47lWg2KJvnuT0b8pHm4jbBe2OS/syY3w3dNQ6EbnT/2wc95+exGE9n4cwMN
 iXRne6Y0Fy//6tgDtnDHqk/opUnNc2jsFh75S5lgzVXpXCOdKNPJVm+jX1rV61/fkCXcrc/+
 eCDT9KhvFUuue+GMTBJ9MpVLvao=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n11.prod.us-east-1.postgun.com with SMTP id
 5f2c14f348ee73b1c786f26e (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 06 Aug 2020 14:34:25
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id D55BDC43391; Thu,  6 Aug 2020 14:34:24 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: sibis)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id F0D8BC433C9;
        Thu,  6 Aug 2020 14:34:23 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 06 Aug 2020 20:04:23 +0530
From:   Sibi Sankar <sibis@codeaurora.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Doug Anderson <dianders@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Alex Elder <elder@linaro.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Andy Gross <agross@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-kernel-owner@vger.kernel.org
Subject: Re: [PATCH 1/2] soc: qcom: aoss: Don't wait for IRQ if we might be in
 suspend/resume noirq
In-Reply-To: <159666852526.1360974.3062132560884413001@swboyd.mtv.corp.google.com>
References: <20200805091141.1.I86b3faaecb0d82997b599b1300f879606c71e116@changeid>
 <159664899840.1360974.7548807728313161626@swboyd.mtv.corp.google.com>
 <CAD=FV=UK+xHV6qsr2AsPB=BzmzN77AT-du8G2tt1QZMQUpGgKg@mail.gmail.com>
 <159666852526.1360974.3062132560884413001@swboyd.mtv.corp.google.com>
Message-ID: <4c40db0fe88dd9aff6897ebc103aa3e9@codeaurora.org>
X-Sender: sibis@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-08-06 04:32, Stephen Boyd wrote:
> +Sibi who wrote the code
> 
> Quoting Doug Anderson (2020-08-05 13:24:06)
>> 
>> On Wed, Aug 5, 2020 at 10:36 AM Stephen Boyd <swboyd@chromium.org> 
>> wrote:
>> >
>> > Why is the genpd being powered off at all? It looks like the driver is
>> > written in a way that it doesn't expect this to happen. See where
>> > adsp_pds_disable() is called from. Looks like the remoteproc "stop"
>> > callback should be called or the driver should be detached.
>> >
>> > It sort of looks like the genpd is expected to be at the max level all
>> > the time (it sets INT_MAX in adsp_pds_enable(), cool).
>> 
>> In general in Linux there are some things that, at suspend time, get
>> done behind a driver's back.  The regulator API, for instance, allows
>> for regulators to be turned off in suspend even if a driver leaves
>> them on.  Sure, it's good practice for a driver to be explicit but the
>> regulator suspend states do allow for the more heavy-handed approach.
>> 
>> I guess I assume that genpd is a bit similar.  If a driver leaves a
>> genpd on all the time then it will still be turned off at suspend time
>> and then turned back on at resume time.  It seems like it must be part
>> of the genpd API.  Specifically genpd_sync_power_off() says: "Check if
>> the given PM domain can be powered off (during system suspend or
>> hibernation) and do that if so."  That makes it seem like it's how
>> genpd works.
>> 
>> Reading all the descriptions of things like GENPD_FLAG_ALWAYS_ON,
>> GENPD_FLAG_ACTIVE_WAKEUP, GENPD_FLAG_RPM_ALWAYS_ON makes me even more
>> convinced that it's normal (unless otherwise specified) for genpds to
>> get turned off in suspend even if a driver just blindly left them on.
>> 
>> Presumably if this "modem" genpd is supposed to stay on in suspend
>> time it should have been marked "always on"?  I'd guess we'd need to
>> add "GENPD_FLAG_ALWAYS_ON" in some (or all?) cases in qmp_pd_add() if
>> this was true?
> 
> Agreed. I can't read the mind of Sibi so I can only guess that Sibi
> wasn't expecting this behavior by reading the driver structure. That
> could be a wrong assumption.
> 
>> 
>> 
>> > Maybe we need to
>> > add some sort of suspend hooks to the remote proc driver instead? Where
>> > those suspend hooks are called earlier and drop the genpd performance
>> > state request but otherwise leave it enabled across suspend?
>> 
>> I think you're saying:
>> 
>> a) You think it's a bug today that the "modem" genpd is being powered
>> off in suspend.  Any evidence to back this up?
>> 
>> b) Assuming it's a bug today, we should mark the "modem" as
>> GENPD_FLAG_ALWAYS_ON.
>> 
>> c) If there are genpds that sometimes should be left on in suspend but
>> sometimes not (and that doesn't match up with what
>> GENPD_FLAG_ACTIVE_WAKEUP does), then we'd have to pass
>> GENPD_FLAG_ALWAYS_ON as a flag and then add suspend hooks to make the
>> decision for us.

Doug/Stephen,

Yes this is a bug, we wouldn't want
to disable aoss_qmp genpd for modem
during suspend (when the modem is
running). The qmp send for modem
is the primary means through which
aoss determines whether to wait for
modem before proceeding to sleep. So
looks like updating the flag with
GENPD_FLAG_ACTIVE_WAKEUP is the way
to go. But introducing another flag
that doesn't touch genpd's during
suspend/resume should also work.


>> 
>> Did I understand that correctly?
>> 
>> ...or are you suggesting that we work around the fact that
>> qmp_pd_power_off() can't be called at "noirq" time by forcing it to
>> suspend earlier?
>> 
>> ...or am I just totally confused and you meant something else?
>> 
>> 
>> > I know this isn't clearing the land mine that is calling this code from
>> > noirq phase of suspend, but I'm just looking at the driver and thinking
>> > that it never expected to be called from this phase of suspend to begin
>> > with.
>> 
>> You're saying that qmp_pd_power_off() wasn't expecting to be called
>> from the noirq phase of suspend?  Sure, I guess not given the bug.
>> ...but once we fix the bug, it works fine, doesn't it?  ...and it
>> appears that it's part of the genpd API to be able to be called from
>> the noirq phase.  To me that means that, even if we were supposed to
>> be keeping this particular PD on during suspend we should take my
>> patch.
>> 
>> 
>> So the summary is: I still think my patch is correct, but I could
>> certainly still be convinced otherwise.
>> 
> 
> I'm trying to say that the driver looks like it expects to power off 
> the
> genpd in the adsp_stop() callback. That same callback sends some sort 
> of
> message to the modem saying that it is being stopped (see
> qcom_q6v5_request_stop()). Turning the performance state down, or
> turning the power domain off completely, without telling the modem that
> it's happening like as is done in adsp_stop() looks wrong. But who
> knows, maybe the modem is happy with that and doesn't care?
> 
> In general, the whole thing looks weird to me because I would expect 
> the
> modem to take care of its own power requirements, including this
> "load_state" one. Anyway, I hope Sibi can clarify what's going on.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project.
