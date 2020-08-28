Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08E09C433E6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 12:53:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE8982086A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 12:53:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="IpyZq3V4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729477AbgH1Mxq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 08:53:46 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:13426 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729172AbgH1MxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 08:53:12 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1598619192; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=Wj2BdT67evytWv+SyfrUVgpdPA51zx+19n8so/CABzM=; b=IpyZq3V4Cse4G1t913ElgCLcPgox7xdXx4fd7RtbjJusAOFIC0r1n0sg6IHkM6NIGowJXD+v
 tJYApfAQF7dHIz4UvSyRJz8FtmZ7Np8iVTun9QYlh90gWwxX+/Jijhj9hv/1bbipckmO9aqX
 abbs7yOJ0p0hiU4cWSMSzob/0CM=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 5f48fe276a801be9b2db42f7 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 28 Aug 2020 12:52:55
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 2FDC1C433C6; Fri, 28 Aug 2020 12:52:55 +0000 (UTC)
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D8DF1C433CA;
        Fri, 28 Aug 2020 12:52:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D8DF1C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Amit Pundir <amit.pundir@linaro.org>
Cc:     Govind Singh <govinds@codeaurora.org>,
        Rakesh Pillai <pillair@qti.qualcomm.com>,
        Brian Norris <briannorris@chromium.org>,
        lkml <linux-kernel@vger.kernel.org>,
        ath10k <ath10k@lists.infradead.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        John Stultz <john.stultz@linaro.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Niklas Cassel <niklas.cassel@linaro.org>
Subject: Re: [PATCH] wireless: ath10k: Return early in ath10k_qmi_event_server_exit() to avoid hard crash on reboot
References: <20200602052533.15048-1-john.stultz@linaro.org>
        <CA+ASDXMbNvbBdsC11dzUPX7RkMFYhJev2npPsRD_SnGQB+1hag@mail.gmail.com>
        <CALAqxLVA1ZQjwEdbX5KGbSyLnMBAzm9PoN_Ta_Z7rBf4w3GOvQ@mail.gmail.com>
        <CA+ASDXPddgOvEX___unx7N2YsQctsZN+1vkwPbi8Ab_zfwFfzw@mail.gmail.com>
        <20200603002715.GA5349@Mani-XPS-13-9360>
        <87zh9diyam.fsf@codeaurora.org>
        <CAMi1Hd3FBRrwysMX6NLhKzjDukm-YPooR7LX64i=HJHDD8_Dvw@mail.gmail.com>
Date:   Fri, 28 Aug 2020 15:52:49 +0300
In-Reply-To: <CAMi1Hd3FBRrwysMX6NLhKzjDukm-YPooR7LX64i=HJHDD8_Dvw@mail.gmail.com>
        (Amit Pundir's message of "Mon, 17 Aug 2020 14:36:09 +0530")
Message-ID: <87ft876ify.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Amit Pundir <amit.pundir@linaro.org> writes:

> On Mon, 8 Jun 2020 at 17:07, Kalle Valo <kvalo@codeaurora.org> wrote:
>> > I don't agree with this. If you read through the replies to the bug report,
>> > it is clear that NS migration uncovered a corner case or even a bug. So we
>> > should try to fix that indeed.
>>
>> I'm with Mani, we should try to fix ath10k instead. Hopefully we can
>> find a fix soon.
>
> Hi Team,
>
> Any updates on this? I can reproduce this hard crash on v5.9-rc1 as well.
>
> It is not a blocker for us because we switched to a userspace
> workaround, where we do not wait for modem to shutdown gracefully and
> SIGKILL it instead, during the shutdown/reboot process. But I'm happy
> to take a swing at any intermediate/in-progress solution available.

Govind submitted this patch and later he asked to drop it, but I think
it would be a good idea to test it anyway:

ath10k: Move msa region map/unmap to init/deinit path

https://lkml.kernel.org/r/1591191231-31917-1-git-send-email-govinds@codeaurora.org

(patchwork is down so I cannot give a patchwork link)

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
