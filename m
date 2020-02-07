Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB194C352A2
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 12:38:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FFA520715
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 12:38:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="kuLckCUB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727018AbgBGMiq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 07:38:46 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:11397 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726861AbgBGMiq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 07:38:46 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1581079126; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=qzairh/+yw4wEAbV6wFRDDG7JyWfCMeJmBCkct0T2fc=;
 b=kuLckCUBy6u9CFWfKnjXHAqKTcyI4ARj9v6iT87gLfJOi87PyC/oy9hfehyvMhW4/upYnCSS
 rBlfIeMElaxIJolMVEoHAU0T6BYoe9gmJWEl9jNXrgsFaRXO2zXxDuDYwM9Hl49Dulwj83S1
 cVcMOO7aL5CtdVX8s/t2MH8MLKs=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e3d5a50.7f5eb23fa5e0-smtp-out-n01;
 Fri, 07 Feb 2020 12:38:40 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 61BBAC433A2; Fri,  7 Feb 2020 12:38:40 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: harigovi)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E5976C43383;
        Fri,  7 Feb 2020 12:38:39 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 07 Feb 2020 18:08:39 +0530
From:   harigovi@codeaurora.org
To:     Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
Cc:     "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        MSM <linux-arm-msm@vger.kernel.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        DTML <devicetree@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Rob Clark <robdclark@gmail.com>, nganji@codeaurora.org,
        Sean Paul <seanpaul@chromium.org>, kalyan_t@codeaurora.org,
        "Kristian H. Kristensen" <hoegsberg@chromium.org>
Subject: Re: [Freedreno] [v1] drm/msm/dsi/pll: call vco set rate explicitly
In-Reply-To: <CAOCk7Nr9n-xLtWq=LEM-QFhJcY+QOuzazsoi-yjErA9od2Jwmw@mail.gmail.com>
References: <1580980321-19256-1-git-send-email-harigovi@codeaurora.org>
 <CAOCk7Nr9n-xLtWq=LEM-QFhJcY+QOuzazsoi-yjErA9od2Jwmw@mail.gmail.com>
Message-ID: <2f5abc857910f70faa119fea5bda81d7@codeaurora.org>
X-Sender: harigovi@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-02-06 20:29, Jeffrey Hugo wrote:
> On Thu, Feb 6, 2020 at 2:13 AM Harigovindan P <harigovi@codeaurora.org> 
> wrote:
>> 
>> For a given byte clock, if VCO recalc value is exactly same as
>> vco set rate value, vco_set_rate does not get called assuming
>> VCO is already set to required value. But Due to GDSC toggle,
>> VCO values are erased in the HW. To make sure VCO is programmed
>> correctly, we forcefully call set_rate from vco_prepare.
> 
> Is this specific to certain SoCs? I don't think I've observed this.

As far as Qualcomm SOCs are concerned, since pll is analog and the value 
is directly read from hardware if we get recalc value same as set rate 
value, the vco_set_rate will not be invoked. We checked in our idp 
device which has the same SOC but it works there since the rates are 
different.
