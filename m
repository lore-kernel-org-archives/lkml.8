Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2B53C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 06:11:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6B5620829
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 06:11:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QLyZNTE5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728205AbgEUGLH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 02:11:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726869AbgEUGLG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 02:11:06 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3E24C061A0E;
        Wed, 20 May 2020 23:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=YCf31mHTKJUJ2rSc/ZizMDYsKG3sbmur+UHa6QauDLI=; b=QLyZNTE5PxTd11WCRmaFk54LrB
        RzY1mNlVeKOym0TeUpg0HGD9x76M46fqKYA6ALsJH1Q3BPoalikEQhyA6jEaymUrCMp2OlYt+4nuK
        hzd6baas9b47MCANI1eNhSMSAS/DqT9d8+3f0fdCCxaYBo86m+BycfJe6irWAO+P21i9KTIKQB5zf
        Pr7RaKlx8OqAm2F6pjHgKspyV1jhnRHvJF+gcMfE0zoqCEJZ3S47OKucgpS5IJTqTa9jiJA3/tiZN
        LcTfrMKEB6m1BOXNCjdmTlrLnRsacRgWL2geqA8er0d8H5K6gXijIuYjw/H07bnCZgvND62lB9pDb
        Ks2iaLww==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jbeQ2-0004hA-PA; Thu, 21 May 2020 06:11:02 +0000
Subject: Re: [PATCH v3/RESEND 0/3] Even moar rpmh cleanups
To:     Stephen Boyd <swboyd@chromium.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Maulik Shah <mkshah@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>
References: <20200521060425.24285-1-swboyd@chromium.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <ad95dcb2-28da-ee31-e635-3c115608f75f@infradead.org>
Date:   Wed, 20 May 2020 23:11:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200521060425.24285-1-swboyd@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/20/20 11:04 PM, Stephen Boyd wrote:
> (Resent with more Ccs and To lines)
> 
> We remove the tcs_is_free() API and then do super micro optimizations on
> the irq handler. I haven't tested anything here so most likely there's a
> bug (again again)!
> 


Subject: s/moar/more/


-- 
~Randy

