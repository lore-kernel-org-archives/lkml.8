Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35B80C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 14:49:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12A772074B
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 14:49:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="RXa143qu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726604AbgFBOto (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 10:49:44 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:62612 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726373AbgFBOtn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 10:49:43 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1591109383; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=rlURGUY597TqbB43gaR7bgIPpydKPkFEMWK7XxPMQgc=;
 b=RXa143quTDR7CUXFT7p2ov+UPqxNHknahyAhCAW21Sv7ZvOXjTe41E9J7/9CdQmLjBqy4kVk
 u3IXuXCmpKYahb7DI3eNDbQeIaodyLUH1dY4gmOmtMQUA/u5bRIWp1/eeF4XrAR/zppWp1yw
 E40QQw6ZLdVs1knA+b/Vpe9AdL8=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 5ed666fe2c54998475e15258 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 02 Jun 2020 14:49:34
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 10E51C433CB; Tue,  2 Jun 2020 14:49:34 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: saiprakash.ranjan)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 812F4C433C9;
        Tue,  2 Jun 2020 14:49:33 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 02 Jun 2020 20:19:33 +0530
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
In-Reply-To: <CACvgo50eb5_jp_6B5tkV9cX_X2_y2Xnavu+wvUUhHN5FsV9hiw@mail.gmail.com>
References: <1591009402-681-1-git-send-email-mkrishn@codeaurora.org>
 <CACvgo50eb5_jp_6B5tkV9cX_X2_y2Xnavu+wvUUhHN5FsV9hiw@mail.gmail.com>
Message-ID: <cd61dd742e73b89794fc1b812d9fdcd9@codeaurora.org>
X-Sender: saiprakash.ranjan@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Emil,

On 2020-06-02 19:43, Emil Velikov wrote:
> Hi Krishna,
> 
> On Tue, 2 Jun 2020 at 08:17, Krishna Manikandan 
> <mkrishn@codeaurora.org> wrote:
>> 
>> Define shutdown callback for display drm driver,
>> so as to disable all the CRTCS when shutdown
>> notification is received by the driver.
>> 
>> This change will turn off the timing engine so
>> that no display transactions are requested
>> while mmu translations are getting disabled
>> during reboot sequence.
>> 
>> Signed-off-by: Krishna Manikandan <mkrishn@codeaurora.org>
>> 
> AFAICT atomics is setup in msm_drm_ops::bind and shutdown in
> msm_drm_ops::unbind.
> 
> Are you saying that unbind never triggers? If so, then we should
> really fix that instead, since this patch seems more like a
> workaround.
> 

Which path do you suppose that the unbind should be called from, remove
callback? Here we are talking about the drivers which are builtin, where
remove callbacks are not called from the driver core during 
reboot/shutdown,
instead shutdown callbacks are called which needs to be defined in order 
to
trigger unbind. So AFAICS there is nothing to be fixed.

msm_pdev_shutdown()
  platform_drv_shutdown()
   device_shutdown()
    kernel_restart_prepare()
     kernel_restart()
      __arm64_sys_reboot()

Thanks,
Sai

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a 
member
of Code Aurora Forum, hosted by The Linux Foundation
