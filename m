Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8867FC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 15:09:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 646762074A
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 15:09:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594739371;
	bh=BJa6fLKmJwuRF1O/mc37Kc4DY7nUta/3nl09dK0slaA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=Y4EeY+AMa9YvbBdeTHUNTIuBpenzTUNaVkigLd/XGuvzciQxTnG6jgmBi/coPt1P7
	 IavW5WVEonQwHgy2u4sEwjQIPTKxxev14yzScmbjlkn7L6VqPqDOmJdwRSl5ePgxPN
	 7m3wck07g/mqa3GvXfyc5MYbYIHmTJpNeyG4HGJI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728822AbgGNPJa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 11:09:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:41998 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725876AbgGNPJ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 11:09:29 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 24AE120663;
        Tue, 14 Jul 2020 15:09:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594739369;
        bh=BJa6fLKmJwuRF1O/mc37Kc4DY7nUta/3nl09dK0slaA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=zN+hQ9++SyHoH7aDcnQWGcJMzpKxXH941BOoyLFyBt5b+1JepfWlx2voN0SR4Hv+A
         BmnXBYK4jvMIyVIc8tP7HdCIn57cRhd2d1YW6TxOV8eOLZVKYvqoaSkigu9wK4ZCk7
         ZMokTGFkZi5LRAFJ1n9b4MDqxx814lpYtRTOB7YI=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jvMYh-00Bipk-FQ; Tue, 14 Jul 2020 16:09:27 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 14 Jul 2020 16:09:27 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     linus.walleij@linaro.org, rnayak@codeaurora.org,
        mkshah@codeaurora.org, ilina@codeaurora.org, cychiang@chromium.org,
        swboyd@chromium.org, bjorn.andersson@linaro.org, agross@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] pinctrl: qcom: Handle broken/missing PDC dual edge
 IRQs on sc7180
In-Reply-To: <20200714080254.v3.1.Ie0d730120b232a86a4eac1e2909bcbec844d1766@changeid>
References: <20200714080254.v3.1.Ie0d730120b232a86a4eac1e2909bcbec844d1766@changeid>
User-Agent: Roundcube Webmail/1.4.5
Message-ID: <ac694b7ad8ff6b7563475e014acde1cb@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: dianders@chromium.org, linus.walleij@linaro.org, rnayak@codeaurora.org, mkshah@codeaurora.org, ilina@codeaurora.org, cychiang@chromium.org, swboyd@chromium.org, bjorn.andersson@linaro.org, agross@kernel.org, linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-07-14 16:04, Douglas Anderson wrote:
> Depending on how you look at it, you can either say that:
> a) There is a PDC hardware issue (with the specific IP rev that exists
>    on sc7180) that causes the PDC not to work properly when configured
>    to handle dual edges.
> b) The dual edge feature of the PDC hardware was only added in later
>    HW revisions and thus isn't in all hardware.
> 
> Regardless of how you look at it, let's work around the lack of dual
> edge support by only ever letting our parent see requests for single
> edge interrupts on affected hardware.
> 
> NOTE: it's possible that a driver requesting a dual edge interrupt
> might get several edges coalesced into a single IRQ.  For instance if
> a line starts low and then goes high and low again, the driver that
> requested the IRQ is not guaranteed to be called twice.  However, it
> is guaranteed that once the driver's interrupt handler starts running
> its first instruction that any new edges coming in will cause the
> interrupt to fire again.  This is relatively commonplace for dual-edge
> gpio interrupts (many gpio controllers require software to emulate
> dual edge with single edge) so client drivers should be setup to
> handle it.
> 
> Fixes: e35a6ae0eb3a ("pinctrl/msm: Setup GPIO chip in hierarchy")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Reviewed-by: Marc Zyngier <maz@kernel.org>

Linus, I assume you will get this one via the pinctrl tree once you
are happy with it?

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
