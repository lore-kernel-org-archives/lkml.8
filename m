Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2B6EC43461
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 16:25:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95B2E206E7
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 16:25:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="a40DB3ao";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="ABHiFHsK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730591AbgIGQZm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 12:25:42 -0400
Received: from a27-11.smtp-out.us-west-2.amazonses.com ([54.240.27.11]:59240
        "EHLO a27-11.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729821AbgIGQMR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 12:12:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1599495137;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:MIME-Version:Content-Type;
        bh=5LQKIMfvX9HJRYKU2mde8fU8lzIvJMwQKf6/plslzvA=;
        b=a40DB3aocBb07ZqZ/Q4NSyeHTHdqjAfVJsxInjb7DjC/RStAiuFTsHFhSSNy6VrC
        Kp7iUQHAry7EI/7vJt8pvhPuXcYVWttpvJlNKy4FA6wMR1Qld55EjnN7DtSkNNGGTgD
        njgiaTGpf1/iUNwJAPN7arc6cze+KYCFMh57ykhU=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=hsbnp7p3ensaochzwyq5wwmceodymuwv; d=amazonses.com; t=1599495137;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:MIME-Version:Content-Type:Feedback-ID;
        bh=5LQKIMfvX9HJRYKU2mde8fU8lzIvJMwQKf6/plslzvA=;
        b=ABHiFHsKI/jA9woBIzSitiPqxEHfbR9t3htMRg+UvdDRkQ5MU55OC5jghnD+oWSy
        ncSk+YNCk+NLsrKNwiVLDU81kG/S1Hc/DFJTiMwZfbL5W5GmJmTEmMK8vg1TbY0v5yK
        361VaTUdsPVX+n/wvUMpZ6xhXkQmUnvaYI2bZzDg=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 68CEDC35A23
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Govind Singh <govinds@codeaurora.org>
Cc:     Amit Pundir <amit.pundir@linaro.org>,
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
        <87ft876ify.fsf@codeaurora.org>
        <8577175552c24b83c80eced09d54e0b3@codeaurora.org>
Date:   Mon, 7 Sep 2020 16:12:17 +0000
In-Reply-To: <8577175552c24b83c80eced09d54e0b3@codeaurora.org> (Govind Singh's
        message of "Fri, 28 Aug 2020 18:37:11 +0530")
Message-ID: <010101746956e552-1a6831c4-6a53-4452-9e13-00e689924032-000000@us-west-2.amazonses.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-SES-Outgoing: 2020.09.07-54.240.27.11
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Govind Singh <govinds@codeaurora.org> writes:

> On 2020-08-28 18:22, Kalle Valo wrote:
>> Amit Pundir <amit.pundir@linaro.org> writes:
>>
>>> On Mon, 8 Jun 2020 at 17:07, Kalle Valo <kvalo@codeaurora.org> wrote:
>>>> > I don't agree with this. If you read through the replies to the bug report,
>>>> > it is clear that NS migration uncovered a corner case or even a bug. So we
>>>> > should try to fix that indeed.
>>>>
>>>> I'm with Mani, we should try to fix ath10k instead. Hopefully we can
>>>> find a fix soon.
>>>
>>> Hi Team,
>>>
>>> Any updates on this? I can reproduce this hard crash on v5.9-rc1 as
>>> well.
>>>
>>> It is not a blocker for us because we switched to a userspace
>>> workaround, where we do not wait for modem to shutdown gracefully and
>>> SIGKILL it instead, during the shutdown/reboot process. But I'm happy
>>> to take a swing at any intermediate/in-progress solution available.
>>
>> Govind submitted this patch and later he asked to drop it, but I think
>> it would be a good idea to test it anyway:
>>
>> ath10k: Move msa region map/unmap to init/deinit path
>>
>> https://lkml.kernel.org/r/1591191231-31917-1-git-send-email-govinds@codeaurora.org
>>
>> (patchwork is down so I cannot give a patchwork link)
>
> This patchwork is not fixing the issue and changing MSA mapping
> sequence is major design change. This issue is only seen with DB845
> which uses SCM call, newer targets QCS404/SC7180/SM8150 will not have
> this issue as MSA mapping is hard-coded in TZ. Probably changes in qmi
> layer to give different indication for this scenario and changes in FW
> is required to mitigate this issue gracefully.

Oh, bad news :/ Can anyone look at that in detail? Even a quick hack
patch would get this forward.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
