Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBC19C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 16:10:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C978E20772
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 16:10:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="c6VLXmGD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726606AbgFBQKZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 12:10:25 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:11551 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726130AbgFBQKY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 12:10:24 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1591114224; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=6WkZkPNZYqHtyoOR3WPRpDqJzCSNDoDiaqF/KoiR35c=;
 b=c6VLXmGDuJyq2XGMFRGTIE9nWPfSMCnv/0dSEcr3dLcNBIK5/0rma2bVoLmiOFh3Aw2pp20B
 NuCLKBEqLNq+dC1K99fUgm64cNxvjpgNA51nH9DtsZVaNJZh8spwMsat0Pr9PsslSvLvtZyX
 F/P15QhyFwnj3pdhOm4wT1nF4tA=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-east-1.postgun.com with SMTP id
 5ed679ee2738686126788cd2 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 02 Jun 2020 16:10:22
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 5E079C43395; Tue,  2 Jun 2020 16:10:21 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: saiprakash.ranjan)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 816A8C433CB;
        Tue,  2 Jun 2020 16:10:20 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 02 Jun 2020 21:40:20 +0530
From:   Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To:     Emil Velikov <emil.l.velikov@gmail.com>
Cc:     Krishna Manikandan <mkrishn@codeaurora.org>,
        ML dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        freedreno@lists.freedesktop.org,
        devicetree <devicetree@vger.kernel.org>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        Sean Paul <seanpaul@chromium.org>, kalyan_t@codeaurora.org,
        "Kristian H . Kristensen" <hoegsberg@chromium.org>,
        mka@chromium.org, devicetree-owner@vger.kernel.org
Subject: Re: [v2] drm/msm: add shutdown support for display platform_driver
In-Reply-To: <CACvgo50b+m2+onak=AZfgihkBXEP9POjMR52087v==-puLdkQQ@mail.gmail.com>
References: <1591009402-681-1-git-send-email-mkrishn@codeaurora.org>
 <CACvgo50eb5_jp_6B5tkV9cX_X2_y2Xnavu+wvUUhHN5FsV9hiw@mail.gmail.com>
 <cd61dd742e73b89794fc1b812d9fdcd9@codeaurora.org>
 <CACvgo50b+m2+onak=AZfgihkBXEP9POjMR52087v==-puLdkQQ@mail.gmail.com>
Message-ID: <8742ac6fbd498fdc22dcd469c3a2d52a@codeaurora.org>
X-Sender: saiprakash.ranjan@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Emil,

On 2020-06-02 21:09, Emil Velikov wrote:
> On Tue, 2 Jun 2020 at 15:49, Sai Prakash Ranjan
> <saiprakash.ranjan@codeaurora.org> wrote:
>> 
>> Hi Emil,
>> 
>> On 2020-06-02 19:43, Emil Velikov wrote:
>> > Hi Krishna,
>> >
>> > On Tue, 2 Jun 2020 at 08:17, Krishna Manikandan
>> > <mkrishn@codeaurora.org> wrote:
>> >>
>> >> Define shutdown callback for display drm driver,
>> >> so as to disable all the CRTCS when shutdown
>> >> notification is received by the driver.
>> >>
>> >> This change will turn off the timing engine so
>> >> that no display transactions are requested
>> >> while mmu translations are getting disabled
>> >> during reboot sequence.
>> >>
>> >> Signed-off-by: Krishna Manikandan <mkrishn@codeaurora.org>
>> >>
>> > AFAICT atomics is setup in msm_drm_ops::bind and shutdown in
>> > msm_drm_ops::unbind.
>> >
>> > Are you saying that unbind never triggers? If so, then we should
>> > really fix that instead, since this patch seems more like a
>> > workaround.
>> >
>> 
>> Which path do you suppose that the unbind should be called from, 
>> remove
>> callback? Here we are talking about the drivers which are builtin, 
>> where
>> remove callbacks are not called from the driver core during
>> reboot/shutdown,
>> instead shutdown callbacks are called which needs to be defined in 
>> order
>> to
>> trigger unbind. So AFAICS there is nothing to be fixed.
>> 
> Interesting - in drm effectively only drm panels implement .shutdown.
> So my naive assumption was that .remove was used implicitly by core,
> as part of the shutdown process. Yet that's not the case, so it seems
> that many drivers could use some fixes.
> 
> Then again, that's an existing problem which is irrelevant for msm.
> -Emil

To give more context, we are actually targeting the clients/consumers
of SMMU/IOMMU here because we have to make sure that before the supplier
(SMMU) shuts down, its consumers/clients need to be shutdown properly.
Now the ordering of this is taken care in the SMMU driver via 
device_link
which makes sure that consumer shutdown callbacks are called first, but 
we
need to define shutdown callbacks for all its consumers to make sure we
actually shutdown the clients or else it would invite the crashes during 
reboot
which in this case was seen for display.

Thanks,
Sai

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a 
member
of Code Aurora Forum, hosted by The Linux Foundation
