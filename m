Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CFC3C433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 01:53:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DA392087D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 01:53:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zpdN6bcB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726939AbgH0Bxp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 21:53:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726790AbgH0Bxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 21:53:44 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A332C06135C
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 18:53:44 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id i11so3178216otr.5
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 18:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RdiGNBR/8z5xpwMCADnLtCh6bNy5eovU3k77J+KywCo=;
        b=zpdN6bcBFFVol272Lv8V+Eh6X/QETawk4wb+c9PC07QIRMgLm7Z+EueBpUKKtGOI4r
         KoYoQX9DHfB8FQDEnFq3OIaiR15facyT1Z4BrLWVaPKXf1miIoUO43N8I2yRx97uKj0a
         rmCkvhdbGmgy4LpDKgmsk/Vs+Dr2ue5v+8bAeSY/PJwEalR1AiresH+TkaZuJ5W32Fan
         jaVHzuLAgnBX8S0mJO3raCGWc2FgpM9HYp3S/H7boaozvhPRIr9cMfUR0YI/QGZcJcA/
         1tZj0RCiXWfd8uuZB5WiwJypTrauhBSsoSp2DSzYZCEMvysfTCC7P1QlF1N6ZjfkgCVN
         lM7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RdiGNBR/8z5xpwMCADnLtCh6bNy5eovU3k77J+KywCo=;
        b=Q9ijCRKThskDh2zod9B62sGagsd2yvXvGXQKvaqxyqno0N95u5cFHrzNyqRXK8Imrk
         +reRyOl4k389xhWQVRaaG3BiNGTRp1Fv+uDtetjNuN6Hs7Z6DKm8bW9HD8PaTPB+YvU+
         JFfXQWXfVe5Dhrb1SKCfrpdR4XJR5gpQudzHSH3uGorNAYFeIlqg6KaLcCtVNCV3Dvsf
         8+D1+PcTpZvamwK/F8AY0ZuVzzqQaY3j3QNtY8JhNXugfwUHR/kfevVlvSBqB+dwAI4R
         CaPXvt9iDIaiKIQ/8Q1hVEHMnLvlZA2iUhJDUiRly4PBUw2qecp6LKISrYT9bLeDUcvQ
         mctA==
X-Gm-Message-State: AOAM530rHLsdOmPIGdWRfTkNullR2aKOJU8PnFJpwwqYEKoSFsZE7tOa
        jnHV4jbdReHZ4yj7ihreMFLyFQ==
X-Google-Smtp-Source: ABdhPJz6EIUh03cmq18qoY0qsjYMI8alrYY8vvs8oWqlzFXUYEbjoiwXmytxm7wnApukujzRZv0yBg==
X-Received: by 2002:a9d:77d4:: with SMTP id w20mr11204840otl.182.1598493223853;
        Wed, 26 Aug 2020 18:53:43 -0700 (PDT)
Received: from yoga ([2605:6000:e5cb:c100:8898:14ff:fe6d:34e])
        by smtp.gmail.com with ESMTPSA id y18sm175096ool.16.2020.08.26.18.53.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2020 18:53:43 -0700 (PDT)
Date:   Wed, 26 Aug 2020 20:53:36 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Maulik Shah <mkshah@codeaurora.org>
Cc:     andy.gross@linaro.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, ulf.hansson@linaro.org,
        swboyd@chromium.org, dianders@chromium.org, rnayak@codeaurora.org,
        ilina@codeaurora.org, lsrao@codeaurora.org,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        John Stultz <john.stultz@linaro.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH v2 1/2] Revert "drivers: qcom: rpmh-rsc: Use rcuidle
 tracepoints for rpmh"
Message-ID: <20200827015336.GG3715@yoga>
References: <1598354482-15491-1-git-send-email-mkshah@codeaurora.org>
 <1598354482-15491-2-git-send-email-mkshah@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1598354482-15491-2-git-send-email-mkshah@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 25 Aug 06:21 CDT 2020, Maulik Shah wrote:

> Commit efde2659b0fe ("drivers: qcom: rpmh-rsc: Use rcuidle tracepoints
> for rpmh") was written to fix a bug seen in an unmerged series that
> implemented a struct generic_pm_domain::power_off() callback calling
> rpmh_flush(). See stack trace below.
> 
>      Call trace:
>       dump_backtrace+0x0/0x174
>       show_stack+0x20/0x2c
>       dump_stack+0xc8/0x124
>       lockdep_rcu_suspicious+0xe4/0x104
>       __tcs_buffer_write+0x230/0x2d0
>       rpmh_rsc_write_ctrl_data+0x210/0x270
>       rpmh_flush+0x84/0x24c
>       rpmh_domain_power_off+0x78/0x98
>       _genpd_power_off+0x40/0xc0
>       genpd_power_off+0x168/0x208
> 
> Later the final merged solution is to use CPU PM notification to invoke
> rpmh_flush() and power_off() callback of genpd is not implemented in the
> driver.
> 
> CPU PM notifiers are run with RCU enabled/watching (see cpu_pm_notify()
> and how it calls rcu_irq_enter_irqson() before calling the notifiers).
> 
> Remove this change since RCU will not be idle during CPU PM notifications
> hence not required to use _rcuidle tracepoint. Using _rcuidle tracepoint
> prevented rpmh driver to be loadable module as these are not exported
> symbols.
> 
> This reverts commit efde2659b0fe835732047357b2902cca14f054d9.
> 
> Cc: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
> Cc: John Stultz <john.stultz@linaro.org>
> Cc: Stephen Rothwell <sfr@canb.auug.org.au>
> Reviewed-by: Stephen Boyd <swboyd@chromium.org>
> Reviewed-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> Signed-off-by: Maulik Shah <mkshah@codeaurora.org>
> ---
>  drivers/soc/qcom/rpmh-rsc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
> index ae66757..fabe390d 100644
> --- a/drivers/soc/qcom/rpmh-rsc.c
> +++ b/drivers/soc/qcom/rpmh-rsc.c
> @@ -495,7 +495,7 @@ static void __tcs_buffer_write(struct rsc_drv *drv, int tcs_id, int cmd_id,
>  		write_tcs_cmd(drv, RSC_DRV_CMD_MSGID, tcs_id, j, msgid);
>  		write_tcs_cmd(drv, RSC_DRV_CMD_ADDR, tcs_id, j, cmd->addr);
>  		write_tcs_cmd(drv, RSC_DRV_CMD_DATA, tcs_id, j, cmd->data);
> -		trace_rpmh_send_msg_rcuidle(drv, tcs_id, j, msgid, cmd);
> +		trace_rpmh_send_msg(drv, tcs_id, j, msgid, cmd);
>  	}
>  
>  	write_tcs_reg(drv, RSC_DRV_CMD_WAIT_FOR_CMPL, tcs_id, cmd_complete);
> -- 
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> of Code Aurora Forum, hosted by The Linux Foundation
> 
