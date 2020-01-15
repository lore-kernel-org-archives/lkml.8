Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E32D9C33CB2
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 18:19:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B46242187F
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 18:19:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GsPYFTKs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729179AbgAOSTK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 13:19:10 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:32884 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728904AbgAOSTJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 13:19:09 -0500
Received: by mail-vs1-f68.google.com with SMTP id n27so11033044vsa.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jan 2020 10:19:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h013w+9WgJO2kYWk7JjC3zQtUFZXFRw4gnhS7EAhQaM=;
        b=GsPYFTKsSyIh7bghmpg7jcxT0kREYJjrjxEraVDNu3vblrX5fNUroHzHfbMK4mHOkR
         Q6RDy2Ebwieo9D8EG69jUl0YSe/6W7vdUu3/wyUJ2DgDL3ZxXHeBmlp/sCCjeEUJbX94
         2uHj7m/PhttTODgI7RJjxbV1J+1VC5qjnGDXk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h013w+9WgJO2kYWk7JjC3zQtUFZXFRw4gnhS7EAhQaM=;
        b=XfZ4STX8VkbaON+X3r7Vth+JfHvl638ehv2Vbpxi1MAuY1heR7H1WJvxqXpgraSd6J
         v74MA4M7nQwImG5JSnXYLW2hrA4LahCwubutpua+5JH7UpGQ91/HpAxFOXz8kzVdCkE0
         8NxSVi5S8yOwkc4bpTPI/SK7OSMjquEnpcbN5fYhz5yrPYpQwr8jyP57IAJYWfXVYzkt
         EsZ8zCp/8RznZqRhRN5mREQF01Wxy4y1Za/S5c5bkJiFi3pq7Yrf247sy+TlzMkbrn0W
         JCkZjUgoOq2fOBdVxc6njnyRcl3+Uouga6wIkJgRZZGEAXVwf6nfG5d5LVNb/LszkbdQ
         oUog==
X-Gm-Message-State: APjAAAUkc6H1Cm59nBD4u+6vTH3Vc8/m/cQJu3xQ/jsrFgOUzjpMDIQK
        R+whLx0i+QTxfZpu+XWCp6ff8TVxoRg=
X-Google-Smtp-Source: APXvYqz3qGBFN7Io1loaS3Rke2FgrIP/iBBELmurV22bzUIVRShFrKZUyDwQcjdQQ+zkJpCeT/N+Jw==
X-Received: by 2002:a67:e00d:: with SMTP id c13mr5484028vsl.57.1579112348188;
        Wed, 15 Jan 2020 10:19:08 -0800 (PST)
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com. [209.85.222.53])
        by smtp.gmail.com with ESMTPSA id o36sm4899591uao.15.2020.01.15.10.19.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jan 2020 10:19:07 -0800 (PST)
Received: by mail-ua1-f53.google.com with SMTP id c14so6615448uaq.11
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jan 2020 10:19:07 -0800 (PST)
X-Received: by 2002:ab0:5c8:: with SMTP id e66mr15143592uae.120.1579112346977;
 Wed, 15 Jan 2020 10:19:06 -0800 (PST)
MIME-Version: 1.0
References: <20200115013751.249588-1-swboyd@chromium.org>
In-Reply-To: <20200115013751.249588-1-swboyd@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 15 Jan 2020 10:18:55 -0800
X-Gmail-Original-Message-ID: <CAD=FV=XS4iPbxzBNHrmEQYCy5uEzce3Oucu-Jveoycc8hJn10A@mail.gmail.com>
Message-ID: <CAD=FV=XS4iPbxzBNHrmEQYCy5uEzce3Oucu-Jveoycc8hJn10A@mail.gmail.com>
Subject: Re: [PATCH] drivers: qcom: rpmh-rsc: Use rcuidle tracepoints for rpmh
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Jan 14, 2020 at 5:37 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> This tracepoint is hit now that we call into the rpmh code from the cpu
> idle path. Let's move this to be an rcuidle tracepoint so that we avoid
> the RCU idle splat below
>
>  =============================
>  WARNING: suspicious RCU usage
>  5.4.10 #68 Tainted: G S
>  -----------------------------
>  drivers/soc/qcom/trace-rpmh.h:72 suspicious rcu_dereference_check() usage!
>
>  other info that might help us debug this:
>
>  RCU used illegally from idle CPU!
>  rcu_scheduler_active = 2, debug_locks = 1
>  RCU used illegally from extended quiescent state!
>  5 locks held by swapper/2/0:
>   #0: ffffff81745d6ee8 (&(&genpd->slock)->rlock){+.+.}, at: genpd_lock_spin+0x1c/0x2c
>   #1: ffffff81745da6e8 (&(&genpd->slock)->rlock/1){....}, at: genpd_lock_nested_spin+0x24/0x34
>   #2: ffffff8174f2ca20 (&(&genpd->slock)->rlock/2){....}, at: genpd_lock_nested_spin+0x24/0x34
>   #3: ffffff8174f2c300 (&(&drv->client.cache_lock)->rlock){....}, at: rpmh_flush+0x48/0x24c
>   #4: ffffff8174f2c150 (&(&tcs->lock)->rlock){+.+.}, at: rpmh_rsc_write_ctrl_data+0x74/0x270
>
>  stack backtrace:
>  CPU: 2 PID: 0 Comm: swapper/2 Tainted: G S                5.4.10 #68
>  Call trace:
>   dump_backtrace+0x0/0x174
>   show_stack+0x20/0x2c
>   dump_stack+0xc8/0x124
>   lockdep_rcu_suspicious+0xe4/0x104
>   __tcs_buffer_write+0x230/0x2d0
>   rpmh_rsc_write_ctrl_data+0x210/0x270
>   rpmh_flush+0x84/0x24c
>   rpmh_domain_power_off+0x78/0x98
>   _genpd_power_off+0x40/0xc0
>   genpd_power_off+0x168/0x208
>   genpd_power_off+0x1e0/0x208
>   genpd_power_off+0x1e0/0x208
>   genpd_runtime_suspend+0x1ac/0x220
>   __rpm_callback+0x70/0xfc
>   rpm_callback+0x34/0x8c
>   rpm_suspend+0x218/0x4a4
>   __pm_runtime_suspend+0x88/0xac
>   psci_enter_domain_idle_state+0x3c/0xb4
>   cpuidle_enter_state+0xb8/0x284
>   cpuidle_enter+0x38/0x4c
>   call_cpuidle+0x3c/0x68
>   do_idle+0x194/0x260
>   cpu_startup_entry+0x24/0x28
>   secondary_start_kernel+0x150/0x15c
>
> Fixes: a65a397f2451 ("cpuidle: psci: Add support for PM domains by using genpd")
> Reported-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>
> I think the commit that this is "Fixes"ing is a stable commit, but I'm
> not positive.
>
>  drivers/soc/qcom/rpmh-rsc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

I'm not an expert on these code path, but it looks sane to me.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
