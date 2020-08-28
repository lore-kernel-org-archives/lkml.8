Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 444A4C433E6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 13:10:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15C7820665
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 13:10:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="bEVtxYvD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729605AbgH1NKg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 09:10:36 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:31732 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729464AbgH1NHd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 09:07:33 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1598620033; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=bGRSWVd+1qTQA15lyCWdbmVUpGlPN+0NH8eLQ3MDHuQ=;
 b=bEVtxYvDAatI6ZlT6lAZQ/SmVOVJby6piwUKwTKQnsN5Cb/AaW5ffwe54K1OzIT5oxYt15xD
 GGnwZIc80+9dhFZEsSzmH61NCOm9OV4fu7B0PY2QnmIszlf5dK8+BOxpMzvnGy9zoQvvilGc
 XOCKMQNdmCvs1qB+dxpqSlYeefs=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 5f49018108e77d893c985623 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 28 Aug 2020 13:07:13
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 5DA0FC4339C; Fri, 28 Aug 2020 13:07:12 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: govinds)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A4D02C433CA;
        Fri, 28 Aug 2020 13:07:11 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 28 Aug 2020 18:37:11 +0530
From:   Govind Singh <govinds@codeaurora.org>
To:     Kalle Valo <kvalo@codeaurora.org>
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
Subject: Re: [PATCH] wireless: ath10k: Return early in
 ath10k_qmi_event_server_exit() to avoid hard crash on reboot
In-Reply-To: <87ft876ify.fsf@codeaurora.org>
References: <20200602052533.15048-1-john.stultz@linaro.org>
 <CA+ASDXMbNvbBdsC11dzUPX7RkMFYhJev2npPsRD_SnGQB+1hag@mail.gmail.com>
 <CALAqxLVA1ZQjwEdbX5KGbSyLnMBAzm9PoN_Ta_Z7rBf4w3GOvQ@mail.gmail.com>
 <CA+ASDXPddgOvEX___unx7N2YsQctsZN+1vkwPbi8Ab_zfwFfzw@mail.gmail.com>
 <20200603002715.GA5349@Mani-XPS-13-9360> <87zh9diyam.fsf@codeaurora.org>
 <CAMi1Hd3FBRrwysMX6NLhKzjDukm-YPooR7LX64i=HJHDD8_Dvw@mail.gmail.com>
 <87ft876ify.fsf@codeaurora.org>
Message-ID: <8577175552c24b83c80eced09d54e0b3@codeaurora.org>
X-Sender: govinds@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kalle,

On 2020-08-28 18:22, Kalle Valo wrote:
> Amit Pundir <amit.pundir@linaro.org> writes:
> 
>> On Mon, 8 Jun 2020 at 17:07, Kalle Valo <kvalo@codeaurora.org> wrote:
>>> > I don't agree with this. If you read through the replies to the bug report,
>>> > it is clear that NS migration uncovered a corner case or even a bug. So we
>>> > should try to fix that indeed.
>>> 
>>> I'm with Mani, we should try to fix ath10k instead. Hopefully we can
>>> find a fix soon.
>> 
>> Hi Team,
>> 
>> Any updates on this? I can reproduce this hard crash on v5.9-rc1 as 
>> well.
>> 
>> It is not a blocker for us because we switched to a userspace
>> workaround, where we do not wait for modem to shutdown gracefully and
>> SIGKILL it instead, during the shutdown/reboot process. But I'm happy
>> to take a swing at any intermediate/in-progress solution available.
> 
> Govind submitted this patch and later he asked to drop it, but I think
> it would be a good idea to test it anyway:
> 
> ath10k: Move msa region map/unmap to init/deinit path
> 
> https://lkml.kernel.org/r/1591191231-31917-1-git-send-email-govinds@codeaurora.org
> 
> (patchwork is down so I cannot give a patchwork link)

This patchwork is not fixing the issue and changing MSA mapping sequence 
is major design change.
This issue is only seen with DB845 which uses SCM call, newer targets 
QCS404/SC7180/SM8150 will not have this issue as MSA mapping is 
hard-coded in TZ.
Probably changes in qmi layer to give different indication for this 
scenario and changes in FW is required to mitigate this issue 
gracefully.

BR,
Govind
