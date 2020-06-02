Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37A15C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 12:26:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09937206A2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 12:26:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="RN8nRSL4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728083AbgFBM0m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 08:26:42 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:28185 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726636AbgFBM0l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 08:26:41 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1591100801; h=In-Reply-To: Content-Type: MIME-Version:
 References: Message-ID: Subject: Cc: To: From: Date: Sender;
 bh=C4vFOy2XJsfD6EIUJxjhKj637Wme6MC/O/edb1rZV9s=; b=RN8nRSL4mnkz1UpK9pvZ9c9FSg5bNWK3pLCAslqJKnGxOj0RsJzclQG8go3f44bmrWwGGTtK
 SvW23JzMhsSyPy9rNwrthQNXeJ/7o5hF9TxIPX/mSq/HbODPu9w4KMNu3xDdePDp1MDM4v2p
 Xnu2kr0WR6RHsZUfC6j0yEMTWOE=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n09.prod.us-west-2.postgun.com with SMTP id
 5ed6456eeca06aba7ef97485 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 02 Jun 2020 12:26:22
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 8F03CC43387; Tue,  2 Jun 2020 12:26:21 +0000 (UTC)
Received: from codeaurora.org (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: groverm)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 875C2C433C6;
        Tue,  2 Jun 2020 12:26:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 875C2C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=groverm@codeaurora.org
Date:   Tue, 2 Jun 2020 17:56:00 +0530
From:   Mayank Grover <groverm@codeaurora.org>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        MSM <linux-arm-msm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Neeraj Upadhyay <neeraju@codeaurora.org>
Subject: Re: [PATCH] pinctrl: msm: Add check for pinctrl group is valid
Message-ID: <20200602122600.GA10584@codeaurora.org>
References: <1589817025-21886-1-git-send-email-groverm@codeaurora.org>
 <20200519013813.GU2165@builder.lan>
 <CACRpkdbSsVcy=6Bo42SnPqgKoa+jNanmBEXix_yv6aNK8VcreQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdbSsVcy=6Bo42SnPqgKoa+jNanmBEXix_yv6aNK8VcreQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 25, 2020 at 11:02:14AM +0200, Linus Walleij wrote:
> On Tue, May 19, 2020 at 3:39 AM Bjorn Andersson
> <bjorn.andersson@linaro.org> wrote:
> 
> > @Linus, we started off with something similar for GPIOs and ended up
> > with the logic in the core code. Should we somehow try to do the same
> > for pinctrl?
> 
> msm_pingroup_is_valid() looks very reusable but I'm afraid I do not
> understand the implicit assumptions around it, but I guess yes,
> if it can be properly documented etc.
> 
> Yours,
> Linus Walleij

Hi Bjorn,

Can you please help guide further on this ?
we can validate group using request calls similar to pinmux_ops here.

-Mayank
