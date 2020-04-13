Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BBFFC2BA2B
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 14:22:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5359F2075E
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 14:22:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="Ruql8tTs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730602AbgDMOW3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 10:22:29 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:11837 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730591AbgDMOW1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 10:22:27 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1586787746; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=/CMwSKjSNr5MBsMhcpYGaT73+vv7cUPjTm+FRYfaILs=; b=Ruql8tTsw0Q5m3BVeT4SkSr19dOphwLm5Q2/HSABQh5w2rGbHeArAM6b9aIvYbAs7IavTu7S
 0odSn6L8WiFfUIZWXkCc49VuLPjaGxNJlI/xB6r4m4W4Cxc2g9o7nUga0+9Ly01WgLE8GjoH
 +Ujwci6FlJ09NlUbdVsWjiX+iAI=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e94759b.7f8e866eea08-smtp-out-n02;
 Mon, 13 Apr 2020 14:22:19 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 94B38C432C2; Mon, 13 Apr 2020 14:22:19 +0000 (UTC)
Received: from [10.111.193.245] (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 13B76C433F2;
        Mon, 13 Apr 2020 14:22:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 13B76C433F2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
Subject: Re: [PATCH 02/21] tty: serial: qcom_geni_serial: Use OPP API to set
 clk/perf state
To:     Jun Nie <jun.nie@linaro.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, sboyd@kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        agross@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Akash Asthana <akashast@codeaurora.org>,
        linux-serial@vger.kernel.org, Matthias Kaehlcke <mka@chromium.org>
References: <1586353607-32222-1-git-send-email-rnayak@codeaurora.org>
 <1586353607-32222-3-git-send-email-rnayak@codeaurora.org>
 <20200409174511.GS199755@google.com>
 <CABymUCNdX=K1vFuC0Rt-u0h-CRYcKtXogyOkAiGZpDfKSVAYqA@mail.gmail.com>
From:   Rajendra Nayak <rnayak@codeaurora.org>
Message-ID: <13907000-e3b0-12d6-0768-fd8a7ab100d9@codeaurora.org>
Date:   Mon, 13 Apr 2020 19:52:11 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CABymUCNdX=K1vFuC0Rt-u0h-CRYcKtXogyOkAiGZpDfKSVAYqA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/10/2020 2:06 PM, Jun Nie wrote:
>>> @@ -961,7 +962,7 @@ static void qcom_geni_serial_set_termios(struct uart_port *uport,
>>>                goto out_restart_rx;
>>>
>>>        uport->uartclk = clk_rate;
>>> -     clk_set_rate(port->se.clk, clk_rate);
>>> +     dev_pm_opp_set_rate(uport->dev, clk_rate);
> 
> Hi Rajendra,

Hi Jun,

> I see lowest rpmhpd_opp_low_svs opp is for 75MHz. It is a bit higher
> for a serial.
> I am just curious about this.

Well these OPP tables are technically what we call as fmax tables, which means
you can get the clock to a max of 75MHz at that perf level. You need to go
to the next perf level if you want to go higher.
That however does not mean that serial cannot run at clocks lower than 75Mhz.

> I also want to confirm that the rpmhpd_opp_low_svs voltage restriction
> is for serial
> controller, not for clock controller? Because I see there is similar
> restriction to clock
> controller on another platform, the restriction is for branch clock,
> not leaf clock that
> consumer device will get.

yes, its a serial controller restriction and not of the clock provider.
On your note on the branch clock vs leaf clock I am not sure I understand
the point you are making.

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
