Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9B37C433E3
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 18:04:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBE2220658
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 18:04:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MJxFnALF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726772AbgHSSEc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 14:04:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726435AbgHSSE1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 14:04:27 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C442C061383
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 11:04:26 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id v15so11776043pgh.6
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 11:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=4uFvlxkD/ZRDxTMNsnxWJlA+7N+RwhZ4TxQPiEuF1gE=;
        b=MJxFnALFZR4uRg7wXdt8xjqU55QzxzS/dwWaI4+wSvJgFASckb4GEN0FdCv4GOYUkK
         w9GAp+Bpw8D+0vhT7p7q2WlvSqtI1M7lWfe4Rcjy0f6wVrjftXJqZ5DRPHsu5/SVof5u
         snMKDG22yHOJaHMPVjifI2G4gNkoHNDQOuZGQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=4uFvlxkD/ZRDxTMNsnxWJlA+7N+RwhZ4TxQPiEuF1gE=;
        b=lwaVjL9wDrOWMmsS35ZIcU0dzhXvC5ty2Q2vZ0Sy9KFeMCdQbRxv4i8gQimxBphbtn
         weLNYpEcMprecs+Rn27ehWt5vD6HyUBzv060c7WWFdIYgnyEBxuhsUniSC6d99bwUW85
         tXUl+eAOzGtu7pDZlLV2SFnZblTGfa8mlpsx9IU+YDeffk5sOSlhj+c0gwMLWLaktdJ/
         TWD3Sla7Y0KAVPEns05i4livJ7vHh0hMI5k/g+hmoVetDmmbx3ZWwKXXVF2OodxmI/jA
         de/AmG7iWonroffcUrcuIWCwBYil4gYttjmV82coSWToEAu/s5fdzzcf5S3CiNYzd2uK
         u04A==
X-Gm-Message-State: AOAM530EUTeiIpQQ1PEu5n2LM6T+SCNKTNiri0J0MDKWMMHoynoSRfPH
        x7Zz4VLqjU+HrBJLWYHKmSXoH2qGWhjlVw==
X-Google-Smtp-Source: ABdhPJx0kvFyp7nSsQsu1b/2/A033TNW80KtT6oVb9fHyPs1AysM4wVBngnpPqdnGnhT+Tbud9VbCw==
X-Received: by 2002:a05:6a00:3:: with SMTP id h3mr19857856pfk.163.1597860265462;
        Wed, 19 Aug 2020 11:04:25 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id e8sm28888008pfd.34.2020.08.19.11.04.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2020 11:04:24 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1597831670-17401-2-git-send-email-mkshah@codeaurora.org>
References: <1597831670-17401-1-git-send-email-mkshah@codeaurora.org> <1597831670-17401-2-git-send-email-mkshah@codeaurora.org>
Subject: Re: [PATCH 1/2] Revert "drivers: qcom: rpmh-rsc: Use rcuidle tracepoints for rpmh"
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        ulf.hansson@linaro.org, dianders@chromium.org,
        rnayak@codeaurora.org, ilina@codeaurora.org, lsrao@codeaurora.org,
        Maulik Shah <mkshah@codeaurora.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        John Stultz <john.stultz@linaro.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
To:     Maulik Shah <mkshah@codeaurora.org>, agross@kernel.org,
        bjorn.andersson@linaro.org
Date:   Wed, 19 Aug 2020 11:04:23 -0700
Message-ID: <159786026353.334488.6206471069270174090@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Maulik Shah (2020-08-19 03:07:49)
> This change was done based on an test results of unmerged series of
> adding RSC power domain and using .power_off callback of genpd to
> invoke rpmh_flush().

Perhaps:

Commit efde2659b0fe ("drivers: qcom: rpmh-rsc: Use rcuidle tracepoints
for rpmh") was written to fix a bug seen in an unmerged series that
implemented a struct generic_pm_domain::power_off() callback calling
rpmh_flush(). See stack trace below.

>=20
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
>=20
> Later the final merged solution is to use CPU PM notification to invoke
> rpmh_flush() and .power_off callback of genpd is not implemented in the
> driver.

I'd also add:

CPU PM notifiers are run with RCU enabled/watching (see cpu_pm_notify()
and how it calls rcu_irq_enter_irqson() before calling the notifiers).

>=20
> Remove this change since RCU will not be idle during CPU PM notifications
> hence not required to use _rcuidle tracepoint. Using _rcuidle tracepoint
> prevented rpmh driver to be loadable module as these are not exported
> symbols.
>=20
> This reverts commit efde2659b0fe835732047357b2902cca14f054d9.
>=20
> Cc: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
> Cc: John Stultz <john.stultz@linaro.org>
> Cc: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Maulik Shah <mkshah@codeaurora.org>
> ---

Otherwise

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
