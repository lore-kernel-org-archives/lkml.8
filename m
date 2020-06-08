Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3251AC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 11:37:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01F922076A
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 11:37:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="UGm4c4Sl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729596AbgFHLhN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 07:37:13 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:38245 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729310AbgFHLhM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 07:37:12 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1591616231; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=IlRfHBpBKtrda1MuEHBrsq6ZxWbcZj4Up/Z9oS3PIto=; b=UGm4c4Sl1yT5KQd2tdSD2I8DrXUI1SMzNVRBHlGV29BcQO39q07uYnWNVy0jjg2LMSCO+ObX
 CiPlXIcz2x5JtH0g0RkKurVehSa1YtCLm26/0g+/Xi0hcS82IWaOlHosbWGgPEoX63PMXrtn
 SrPFi8LEKXXcxyqDbMR7MjijBk0=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n13.prod.us-east-1.postgun.com with SMTP id
 5ede22e7b01a4d5845a43292 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 08 Jun 2020 11:37:11
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id AA563C43387; Mon,  8 Jun 2020 11:37:10 +0000 (UTC)
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5DE79C433CA;
        Mon,  8 Jun 2020 11:37:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5DE79C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Brian Norris <briannorris@chromium.org>,
        Amit Pundir <amit.pundir@linaro.org>,
        Govind Singh <govinds@codeaurora.org>,
        Rakesh Pillai <pillair@qti.qualcomm.com>,
        lkml <linux-kernel@vger.kernel.org>,
        ath10k <ath10k@lists.infradead.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        John Stultz <john.stultz@linaro.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        Niklas Cassel <niklas.cassel@linaro.org>
Subject: Re: [PATCH] wireless: ath10k: Return early in ath10k_qmi_event_server_exit() to avoid hard crash on reboot
References: <20200602052533.15048-1-john.stultz@linaro.org>
        <CA+ASDXMbNvbBdsC11dzUPX7RkMFYhJev2npPsRD_SnGQB+1hag@mail.gmail.com>
        <CALAqxLVA1ZQjwEdbX5KGbSyLnMBAzm9PoN_Ta_Z7rBf4w3GOvQ@mail.gmail.com>
        <CA+ASDXPddgOvEX___unx7N2YsQctsZN+1vkwPbi8Ab_zfwFfzw@mail.gmail.com>
        <20200603002715.GA5349@Mani-XPS-13-9360>
Date:   Mon, 08 Jun 2020 14:37:05 +0300
In-Reply-To: <20200603002715.GA5349@Mani-XPS-13-9360> (Manivannan Sadhasivam's
        message of "Wed, 3 Jun 2020 05:57:15 +0530")
Message-ID: <87zh9diyam.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org> writes:

> On Tue, Jun 02, 2020 at 01:04:26PM -0700, Brian Norris wrote:
>> On Tue, Jun 2, 2020 at 12:40 PM John Stultz <john.stultz@linaro.org> wrote:
>> > On Tue, Jun 2, 2020 at 12:16 PM Brian Norris <briannorris@chromium.org> wrote:
>> > > On Mon, Jun 1, 2020 at 10:25 PM John Stultz <john.stultz@linaro.org> wrote:
>> > > >
>> > > > Ever since 5.7-rc1, if we call
>> > > > ath10k_qmi_remove_msa_permission(), the db845c hard crashes on
>> > > > reboot, resulting in the device getting stuck in the usb crash
>> > > > debug mode and not coming back up wihthout a hard power off.
>> > > >
>> > > > This hack avoids the issue by returning early in
>> > > > ath10k_qmi_event_server_exit().
>> > > >
>> > > > A better solution is very much desired!
>> > >
>> > > Any chance you can bisect what caused this? There are a lot of
>> > > non-ath10k pieces involved in this stuff.
>> >
>> > Amit had spent some work on chasing it down to the in kernel qrtr-ns
>> > work, and reported it here:
>> >   https://lists.infradead.org/pipermail/ath10k/2020-April/014970.html
>> >
>> > But that discussion seemingly stalled out, so I came up with this hack
>> > to workaround it for us.
>> 
>> If I'm reading it right, then that means we should revert this stuff
>> from v5.7-rc1:
>> 
>> 0c2204a4ad71 net: qrtr: Migrate nameservice to kernel from userspace
>> 
>> At least, until people can resolve the tail end of that thread. New
>> features (ath11k, etc.) are not a reason to break existing features
>> (ath10k/wcn3990).
>
> I don't agree with this. If you read through the replies to the bug report,
> it is clear that NS migration uncovered a corner case or even a bug. So we
> should try to fix that indeed.

I'm with Mani, we should try to fix ath10k instead. Hopefully we can
find a fix soon.

Forcing QCA6390 users to use the userspace qrtr-ns would be bad user
experience, I really would want to avoid that.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
