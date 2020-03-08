Return-Path: <SRS0=tZRF=4Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73E38C10F27
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 22:01:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48B1E2072A
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 22:01:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Fqi5ioWb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbgCHWBB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Mar 2020 18:01:01 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45362 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726332AbgCHWBB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Mar 2020 18:01:01 -0400
Received: by mail-pf1-f193.google.com with SMTP id 2so3897170pfg.12
        for <linux-kernel@vger.kernel.org>; Sun, 08 Mar 2020 15:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Jj+pYaKWaJaTeG0F5AyQyT4b1oSwBJ8WFgHn5sIktlU=;
        b=Fqi5ioWbAO0pDPjAJowbvb9fyLmk+BKKgPKGbUyVLzD71qg+GAKB8pU/1IMbnmNw4J
         tMvoXzOmgdmctc0ywORmdbDHCmOjatbb82qBfG6etyh94dqkUicciky5OnmaLh044W/N
         sbBimcwsgUIMDZxIhsHY4MuFBxfHFzNX8ZilIjG3ayAprv+TcsACtfLavo2hw4HAPWDm
         oBND6cBg3EY8ssfsP6ZIFqszXHNKDfKQcKVfSL2H36GsK+eiYFd/R/DJL/fIqlVv/0u6
         FfnqiNaiIaUybXoOgswiWe+0UvRZfhVp+buBVzhYg4wOF1CaBCU1sLDYjQSHAyrqyHSB
         jPeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Jj+pYaKWaJaTeG0F5AyQyT4b1oSwBJ8WFgHn5sIktlU=;
        b=OcpTd27z60KjSBU23+es8MBVubHi9/wvW9xNMK1ypFoHNUd1w+LXBP0jtGI0LsL9ht
         9156CX2XYhk6TOisnl1vNn+Je8HFQQ01hkY2+LU0YTp1jzs2KpUEYQsV+j73do3Apbke
         8QJmmxnPCRe9AlAW2vU2RaOxgRaOfcfpD//FDgxtcPK1qs0OJex8ci1VquDdMBK7rh9y
         N/CGgbMr06f9FC+wNzujlOPx8FnK0PaoFHJbrkdHxEXq2dgwvpBgS47b+HO/d/CuUEQR
         FuJGQMtkKrvyqJUX+gFGkXrEVSreHHg1+SWsazEkKe5WZ4kKkJzWWdOH+iPQNOicwiCR
         5wig==
X-Gm-Message-State: ANhLgQ3CKZRaU/Uep+obS1nVJORnnBozFHs+Oe/X4+iAk9B9yGG7mGsP
        22EFPSToLIFUkfkEtWeqfzZbIg==
X-Google-Smtp-Source: ADFU+vte8T+v2ZSoXd563AmJO+qtYjLzhk2OSgoaY6ZOhWMEqZV1BwiVLtqBYkvBcIQi+T9cpRvv6Q==
X-Received: by 2002:a63:f752:: with SMTP id f18mr13436739pgk.196.1583704859771;
        Sun, 08 Mar 2020 15:00:59 -0700 (PDT)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id d12sm20434900pfq.87.2020.03.08.15.00.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Mar 2020 15:00:59 -0700 (PDT)
Date:   Sun, 8 Mar 2020 15:00:57 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Stanimir Varbanov <stanimir.varbanov@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-media@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Elliot Berman <eberman@codeaurora.org>
Subject: Re: [PATCH] venus: firmware: Ignore secure call error on first resume
Message-ID: <20200308220057.GA1098305@builder>
References: <20200304155809.19637-1-stanimir.varbanov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200304155809.19637-1-stanimir.varbanov@linaro.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 04 Mar 07:58 PST 2020, Stanimir Varbanov wrote:

> With the latest cleanup in qcom scm driver

I've seen similar issues in other drivers, but I think the culprit is
the following bug fix 'ff34f3cce278 ("firmware: qcom: scm: Ensure 'a0'
status code is treated as signed")', rather than the recent refactoring.

As this is a bug fix it's quite likely to show up in linux-stable as
well and regress older versions, so you should probably Cc stable as
well.

> the secure monitor
> call for setting the remote processor state returns EINVAL when
> it is called for the first time and after another scm call
> auth_and_reset. The error returned from scm call could be ignored
> because the state transition is already done in auth_and_reset.
> 

I'm not sure what the appropriate mechanism is here, but your workaround
seems reasonable.

Acked-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
> ---
>  drivers/media/platform/qcom/venus/firmware.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/media/platform/qcom/venus/firmware.c b/drivers/media/platform/qcom/venus/firmware.c
> index de6812fb55f4..8801a6a7543d 100644
> --- a/drivers/media/platform/qcom/venus/firmware.c
> +++ b/drivers/media/platform/qcom/venus/firmware.c
> @@ -44,8 +44,14 @@ static void venus_reset_cpu(struct venus_core *core)
>  
>  int venus_set_hw_state(struct venus_core *core, bool resume)
>  {
> -	if (core->use_tz)
> -		return qcom_scm_set_remote_state(resume, 0);
> +	int ret;
> +
> +	if (core->use_tz) {
> +		ret = qcom_scm_set_remote_state(resume, 0);
> +		if (resume && ret == -EINVAL)
> +			ret = 0;
> +		return ret;
> +	}
>  
>  	if (resume)
>  		venus_reset_cpu(core);
> -- 
> 2.17.1
> 
