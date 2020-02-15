Return-Path: <SRS0=OX35=4D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 254D0C3F68F
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Feb 2020 07:33:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2F332084E
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Feb 2020 07:33:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AWIz6DVL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726137AbgBOHd0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Feb 2020 02:33:26 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44145 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725810AbgBOHdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Feb 2020 02:33:25 -0500
Received: by mail-pg1-f193.google.com with SMTP id g3so6098767pgs.11
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2020 23:33:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=j2dlqe8IHtaY+LXzB/pHVq0hnRV+mre/jg+PwqEvcS8=;
        b=AWIz6DVLJIdQMqoVfz3wRh+Vy3/YO6Rj8qdKR2ACR5688rL4INQjtCNtispusY7Ghb
         l+/zlkPJOyc9OvjpGe49NyVv5RN8BXhSxij1ywTbneVx/yeJdoAa72TerVGYvsoeQ21Z
         pVzSt2aZvqMDeByl6BvVzbktr7TDkoQelaONUM1M9diTwokpM62mCAkUc9qZB47sT9xJ
         dVUf2Wv+swFD0uj4xCzd/YNgHJKupqzR3fKOVgabOZbexx6idJNwtj3FU8ZjZu25PoY5
         ebMGD+wkA41u48Ku7MC8KpJuVLez9j01fvFOUtnauOxGJopZHIA9iFIcVof484y/BJJP
         71sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=j2dlqe8IHtaY+LXzB/pHVq0hnRV+mre/jg+PwqEvcS8=;
        b=Gix6QwP+WFW2bC84ABtzosDAU8ml2TGyWiycRGatKMZXfoKnf4suTaxClx3LmQycb5
         0yy3I975QhH2IG6w05/eJPF9Uw/QgMDC2Mfqt5oT+O5oaqdL+bfM88/ULbbE5REw80ep
         rTjXAtTg+QcByfhFQbPQRPcWkWJSYzeSgk1tWG0/JeS5QvggO+q1QeRKx1tb5D0tKAq6
         R+mmJqer0PNLU3tdOPhGV4Yx7k3LJyossKhyNom1PweTZqhu7eVLjlb76FJCCJwpX7xM
         Whp+ypECI93hPqd19GMZoO3BLtN1oXDHIzExvBwRXeJJoUYZbSkJOoIASlFxdPq6Qeqn
         I+yQ==
X-Gm-Message-State: APjAAAXjaplLGKtZEEI+UkXrkas6P0gA0q45DygfG0UbF67gk7SNdpmw
        MQRG449Ad65EL8dpXnt5SWYXJg==
X-Google-Smtp-Source: APXvYqwzKt7r8ABDtNBtoVyypViXPLxmsWx0rlgyfwfvOampDMUmR5cQA/VWM5u3tqLUqTrYXWhqjg==
X-Received: by 2002:a63:df0a:: with SMTP id u10mr7715505pgg.282.1581752005210;
        Fri, 14 Feb 2020 23:33:25 -0800 (PST)
Received: from ripper (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id t16sm9912477pgo.80.2020.02.14.23.33.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2020 23:33:24 -0800 (PST)
Date:   Fri, 14 Feb 2020 23:32:33 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Mike Tipton <mdtipton@codeaurora.org>
Cc:     sboyd@kernel.org, tdas@codeaurora.org, mturquette@baylibre.com,
        agross@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: qcom: clk-rpmh: Wait for completion when enabling
 clocks
Message-ID: <20200215073233.GR955802@ripper>
References: <20200215021232.1149-1-mdtipton@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200215021232.1149-1-mdtipton@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 14 Feb 18:12 PST 2020, Mike Tipton wrote:

> The current implementation always uses rpmh_write_async, which doesn't
> wait for completion. That's fine for disable requests since there's no
> immediate need for the clocks and they can be disabled in the
> background. However, for enable requests we need to ensure the clocks
> are actually enabled before returning to the client. Otherwise, clients
> can end up accessing their HW before the necessary clocks are enabled,
> which can lead to bus errors.
> 
> Use the synchronous version of this API (rpmh_write) for enable requests
> in the active set to ensure completion.
> 
> Completion isn't required for sleep/wake sets, since they don't take
> effect until after we enter sleep. All rpmh requests are automatically
> flushed prior to entering sleep.
> 
> Fixes: 9c7e47025a6b ("clk: qcom: clk-rpmh: Add QCOM RPMh clock driver")
> Signed-off-by: Mike Tipton <mdtipton@codeaurora.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
>  drivers/clk/qcom/clk-rpmh.c | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/clk/qcom/clk-rpmh.c b/drivers/clk/qcom/clk-rpmh.c
> index 12bd8715dece..3137595a736b 100644
> --- a/drivers/clk/qcom/clk-rpmh.c
> +++ b/drivers/clk/qcom/clk-rpmh.c
> @@ -143,6 +143,19 @@ static inline bool has_state_changed(struct clk_rpmh *c, u32 state)
>  		!= (c->aggr_state & BIT(state));
>  }
>  
> +static int clk_rpmh_send(struct clk_rpmh *c, enum rpmh_state state,
> +			 struct tcs_cmd *cmd, bool wait_for_completion)
> +{
> +	int ret;
> +
> +	if (wait_for_completion)
> +		ret = rpmh_write(c->dev, state, cmd, 1);
> +	else
> +		ret = rpmh_write_async(c->dev, state, cmd, 1);
> +
> +	return ret;
> +}
> +
>  static int clk_rpmh_send_aggregate_command(struct clk_rpmh *c)
>  {
>  	struct tcs_cmd cmd = { 0 };
> @@ -159,7 +172,8 @@ static int clk_rpmh_send_aggregate_command(struct clk_rpmh *c)
>  			if (cmd_state & BIT(state))
>  				cmd.data = on_val;
>  
> -			ret = rpmh_write_async(c->dev, state, &cmd, 1);
> +			ret = clk_rpmh_send(c, state, &cmd,
> +				cmd_state && state == RPMH_ACTIVE_ONLY_STATE);
>  			if (ret) {
>  				dev_err(c->dev, "set %s state of %s failed: (%d)\n",
>  					!state ? "sleep" :
> @@ -267,7 +281,7 @@ static int clk_rpmh_bcm_send_cmd(struct clk_rpmh *c, bool enable)
>  	cmd.addr = c->res_addr;
>  	cmd.data = BCM_TCS_CMD(1, enable, 0, cmd_state);
>  
> -	ret = rpmh_write_async(c->dev, RPMH_ACTIVE_ONLY_STATE, &cmd, 1);
> +	ret = clk_rpmh_send(c, RPMH_ACTIVE_ONLY_STATE, &cmd, enable);
>  	if (ret) {
>  		dev_err(c->dev, "set active state of %s failed: (%d)\n",
>  			c->res_name, ret);
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
