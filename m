Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C297C2BB85
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 19:34:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F7912051A
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 19:34:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jx7XlSJ4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbgDITeZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 15:34:25 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45572 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726707AbgDITeZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 15:34:25 -0400
Received: by mail-pf1-f196.google.com with SMTP id r14so4580850pfl.12
        for <linux-kernel@vger.kernel.org>; Thu, 09 Apr 2020 12:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=1/Ya+QtKcRpkMO5L+OVhHFCN4pIxugi14ksnOnlBROQ=;
        b=jx7XlSJ4M/6PnQzbIIUuevI0BuVrVwXZ/Sc1VEop+ig1SDYs0IcFtvRvqs1X1xOjAp
         9j+pcKvKonLf3DcG1zkKnJSvmpr4dUWgqJKIk5OdEggAr48hgEo2XPllceIsLJ2V8gLB
         544uFuCCJb6hBOo5UUKfTAItvfSnPI5ePf1HY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=1/Ya+QtKcRpkMO5L+OVhHFCN4pIxugi14ksnOnlBROQ=;
        b=Ld3PrbMuVPnZfh8DzKAn1nx8DgwCCHkOscfwJCIF7j/iAkRG2xuUh8u1Cb5dLpw+rn
         2/ll5RHBQvKPvVMEX+DdfmeITHXvIcrQISGtuqopf0R9lVgf9j8IOfJliEyVRkX1JLxm
         rjkNq4gsSOAMZasdUWlRKfX1xElOgLSLBE89INaoos0jMLFAgKtV6JsmP4DFDO3qQgn4
         p/ZkBFujagGTVru/v/vudddGMwR74ga+8E86Zezih1Z/82rgMeJGSPbK+zq7fOZuyOBO
         YgsS902nUfbkx2J59tFK0jkqm1pD25jtvGUKMfw7Qx9qYt95CkJPF6FE4t8P6Bzq93Vh
         spuQ==
X-Gm-Message-State: AGi0PuZbrX1+AIeZkyo+TPRHJ5behLJmsBv8mu7pgfwEB3cW9DBNZ+I1
        9JhsWLiT9818WNQLcGyDTNcPQQ==
X-Google-Smtp-Source: APiQypJaE149E9NVXPyDN7sUtJ95tAnrr/bsf+utPigo+nVxEnJuRB77gP8AkUxYHUC6bWjTW9rrmw==
X-Received: by 2002:aa7:9695:: with SMTP id f21mr1219522pfk.93.1586460864774;
        Thu, 09 Apr 2020 12:34:24 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id d7sm19924914pfa.106.2020.04.09.12.34.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2020 12:34:24 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200409113538.5008-1-saiprakash.ranjan@codeaurora.org>
References: <20200409113538.5008-1-saiprakash.ranjan@codeaurora.org>
Subject: Re: [PATCH] coresight: tmc: Read TMC mode only when TMC hw is enabled
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        mike.leach@linaro.org
Date:   Thu, 09 Apr 2020 12:34:23 -0700
Message-ID: <158646086329.126188.18130247986266503723@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Sai Prakash Ranjan (2020-04-09 04:35:38)
> Reading TMC mode register in tmc_read_prepare_etb without
> enabling the TMC hardware leads to async exceptions like
> the one in the call trace below. This can happen if the
> user tries to read the TMC etf data via device node without
> setting up source and the sink first which enables the TMC
> hardware in the path. So make sure that the TMC is enabled
> before we try to read TMC data.
>=20
>  Kernel panic - not syncing: Asynchronous SError Interrupt
>  CPU: 7 PID: 2605 Comm: hexdump Tainted: G S                5.4.30 #122
>  Call trace:
>   dump_backtrace+0x0/0x188
>   show_stack+0x20/0x2c
>   dump_stack+0xdc/0x144
>   panic+0x168/0x36c
>   panic+0x0/0x36c
>   arm64_serror_panic+0x78/0x84
>   do_serror+0x130/0x138
>   el1_error+0x84/0xf8
>   tmc_read_prepare_etb+0x88/0xb8
>   tmc_open+0x40/0xd8
>   misc_open+0x120/0x158
>   chrdev_open+0xb8/0x1a4
>   do_dentry_open+0x268/0x3a0
>   vfs_open+0x34/0x40
>   path_openat+0x39c/0xdf4
>   do_filp_open+0x90/0x10c
>   do_sys_open+0x150/0x3e8
>   __arm64_compat_sys_openat+0x28/0x34
>   el0_svc_common+0xa8/0x160
>   el0_svc_compat_handler+0x2c/0x38
>   el0_svc_compat+0x8/0x10
>=20
> Fixes: 4525412a5046 ("coresight: tmc: making prepare/unprepare functions =
generic")
> Reported-by: Stephen Boyd <swboyd@chromium.org>
> Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
> ---

Tested-by: Stephen Boyd <swboyd@chromium.org>
