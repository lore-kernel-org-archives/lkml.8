Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD3E6C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 18:17:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 860EB206C3
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 18:17:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="Fu/N7sB+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730376AbgFDSRi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 14:17:38 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:42332 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729856AbgFDSRh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 14:17:37 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1591294657; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=Sy6oxi6dVwjeydEC93CEgvW6xjF1Nhp3WKKAo+y1MfI=;
 b=Fu/N7sB+5NZPSCm6DJPjuIJ/Ysj+1WR2g5Gfzzd4CvcPWgePAsMBvmWqdnC3ooJwyRGGV3yS
 JVDBaCZl8/+be0NZNPAdfqulntxXI5r32ze8Kx0jT4NckqciCv6hTfuEynx2RVGJ5ZCe/OG1
 1OU74cTF75u6H/J1xBAuEbp+9W4=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-east-1.postgun.com with SMTP id
 5ed93ab044a25e0052dcd58b (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 04 Jun 2020 18:17:20
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 679C6C43387; Thu,  4 Jun 2020 18:17:19 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: sibis)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id ADA4AC433C6;
        Thu,  4 Jun 2020 18:17:18 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 04 Jun 2020 23:47:18 +0530
From:   Sibi Sankar <sibis@codeaurora.org>
To:     govinds@codeaurora.org
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Brian Norris <briannorris@chromium.org>,
        John Stultz <john.stultz@linaro.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Rakesh Pillai <pillair@qti.qualcomm.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        Amit Pundir <amit.pundir@linaro.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        ath10k <ath10k@lists.infradead.org>,
        linux-kernel-owner@vger.kernel.org
Subject: Re: [PATCH] wireless: ath10k: Return early in
 ath10k_qmi_event_server_exit() to avoid hard crash on reboot
In-Reply-To: <4e0642b9882c41f4c10963b265bf6d9f@codeaurora.org>
References: <20200602052533.15048-1-john.stultz@linaro.org>
 <CA+ASDXMbNvbBdsC11dzUPX7RkMFYhJev2npPsRD_SnGQB+1hag@mail.gmail.com>
 <CALAqxLVA1ZQjwEdbX5KGbSyLnMBAzm9PoN_Ta_Z7rBf4w3GOvQ@mail.gmail.com>
 <CA+ASDXPddgOvEX___unx7N2YsQctsZN+1vkwPbi8Ab_zfwFfzw@mail.gmail.com>
 <20200603002715.GA5349@Mani-XPS-13-9360>
 <4e0642b9882c41f4c10963b265bf6d9f@codeaurora.org>
Message-ID: <40a7d87e5774d56d9ca31e4de0c17831@codeaurora.org>
X-Sender: sibis@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-06-03 15:37, govinds@codeaurora.org wrote:
> Hi Mani,
> 
> On 2020-06-03 05:57, Manivannan Sadhasivam wrote:
>> On Tue, Jun 02, 2020 at 01:04:26PM -0700, Brian Norris wrote:
>>> On Tue, Jun 2, 2020 at 12:40 PM John Stultz <john.stultz@linaro.org> 
>>> wrote:
>>> > On Tue, Jun 2, 2020 at 12:16 PM Brian Norris <briannorris@chromium.org> wrote:
>>> > > On Mon, Jun 1, 2020 at 10:25 PM John Stultz <john.stultz@linaro.org> wrote:
>>> > > >
>>> > > > Ever since 5.7-rc1, if we call
>>> > > > ath10k_qmi_remove_msa_permission(), the db845c hard crashes on
>>> > > > reboot, resulting in the device getting stuck in the usb crash
>>> > > > debug mode and not coming back up wihthout a hard power off.
>>> > > >
>>> > > > This hack avoids the issue by returning early in
>>> > > > ath10k_qmi_event_server_exit().
>>> > > >
>>> > > > A better solution is very much desired!
>>> > >
>>> > > Any chance you can bisect what caused this? There are a lot of
>>> > > non-ath10k pieces involved in this stuff.
>>> >
>>> > Amit had spent some work on chasing it down to the in kernel qrtr-ns
>>> > work, and reported it here:
>>> >   https://lists.infradead.org/pipermail/ath10k/2020-April/014970.html
>>> >
>>> > But that discussion seemingly stalled out, so I came up with this hack
>>> > to workaround it for us.
>>> 
>>> If I'm reading it right, then that means we should revert this stuff
>>> from v5.7-rc1:
>>> 
>>> 0c2204a4ad71 net: qrtr: Migrate nameservice to kernel from userspace
>>> 
>>> At least, until people can resolve the tail end of that thread. New
>>> features (ath11k, etc.) are not a reason to break existing features
>>> (ath10k/wcn3990).
>> 
>> I don't agree with this. If you read through the replies to the bug 
>> report,
>> it is clear that NS migration uncovered a corner case or even a bug. 
>> So we
>> should try to fix that indeed.
>> 
>> Govind: Did you get chance to work on fixing this issue?
>> 
> 
> I have done basic testing by moving msa map/unmap from qmi service
> callbacks to init/de-init path.
> I will send patch for review.
> Reason for del_server needs to investigated from rproc side.

Govind,
On receiving SIGTERM, rmtfs would try
to perform a graceful shutdown of the
modem, that should be the source of
the del_server.

> 
>> Thanks,
>> Mani
>> 
>>> 
>>> Brian
> 
> Thanks,
> Govind

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project.
