Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEC9FC3815B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 18:54:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90B9420782
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 18:54:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Qf/ecC7L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726827AbgDTSyR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 14:54:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726328AbgDTSyR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 14:54:17 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8D52C061A0F
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 11:54:16 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id b2so5769120ljp.4
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 11:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tFwuNr0TgSQRNNXpMtC3V2slHHf02xlAMZDjaN+7RAc=;
        b=Qf/ecC7Lp+kohe1FrviknG4/IQqC/abCMx7cMJ8Qh/SH7PU6FDeUEAPzC0J/Du8RJZ
         L080nkD48kiih0pnK6PLPLWsJGLm6S1RVXu/dcSHWNi9AViGgBDdLNWUx/C05aivFcZa
         FUUpFkc0Q4n7UHOZTdTU+Tuts0aAXCfIAirO8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tFwuNr0TgSQRNNXpMtC3V2slHHf02xlAMZDjaN+7RAc=;
        b=Ls9zdj+YeYKk9oAIxscPEZakFs8meOZck/QVpDiJhllR1KrB4TbwSixsGv+eMMdcBY
         ZyY6Sa5dGFFsdXr9cWdOSXw2jhxlwmt22hbt+T0yQ8uDnuA0HhZnaMKtoS8dDl0gdxBZ
         +0XfwpptPr+N6VlE8mDw2Em8s7JPRXz9uz7a2NbvIo2s2zpWCoCXz2pe7tBXDsKHA/y7
         6vaRJ4mwAdvScbWADU8Rzg6/WnvuDtTyNwOdsEiTSSZQExpK6OJWPvkDywKqnD1n4O62
         Gc/S73pwdWcBmz3nlOGphFyC33xwYsZNCnmK+hSo2RR/W/n5eioskz/hVDbJ2919Rz5K
         4Onw==
X-Gm-Message-State: AGi0PublrbFtKhEH8oX93ecLNEyzRwSQuXUVivp0qOFTY9O1rhdnlIIT
        FAblooB3NWZ2W+zFKnulgCmYXuOmcXI=
X-Google-Smtp-Source: APiQypL8NKYbJmU2XxaJfSrFedMFWSMKg/W3XstSvsHVqi91OqlUSOEsiNXTPtGiMhY3BOJP7IZObQ==
X-Received: by 2002:a2e:7308:: with SMTP id o8mr3172903ljc.16.1587408854794;
        Mon, 20 Apr 2020 11:54:14 -0700 (PDT)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id z9sm237771lfd.9.2020.04.20.11.54.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Apr 2020 11:54:13 -0700 (PDT)
Received: by mail-lj1-f174.google.com with SMTP id z26so11217743ljz.11
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 11:54:13 -0700 (PDT)
X-Received: by 2002:a2e:b0f5:: with SMTP id h21mr6912419ljl.3.1587408852757;
 Mon, 20 Apr 2020 11:54:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200415071619.6052-1-sibis@codeaurora.org> <20200415071619.6052-2-sibis@codeaurora.org>
In-Reply-To: <20200415071619.6052-2-sibis@codeaurora.org>
From:   Evan Green <evgreen@chromium.org>
Date:   Mon, 20 Apr 2020 11:53:36 -0700
X-Gmail-Original-Message-ID: <CAE=gft4NK8vXGwJFEtXwKroKfoSO8wPxq=fv35AVC6vSQk02ig@mail.gmail.com>
Message-ID: <CAE=gft4NK8vXGwJFEtXwKroKfoSO8wPxq=fv35AVC6vSQk02ig@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] remoteproc: qcom_q6v5_mss: Remove unused
 q6v5_da_to_va function
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-remoteproc@vger.kernel.org, Ohad Ben Cohen <ohad@wizery.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 15, 2020 at 12:16 AM Sibi Sankar <sibis@codeaurora.org> wrote:
>
> Remove unsed q6v5_da_to_va function as the mss driver uses a per segment
> dump function.
>
> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
> ---
>  drivers/remoteproc/qcom_q6v5_mss.c | 14 --------------
>  1 file changed, 14 deletions(-)
>
> diff --git a/drivers/remoteproc/qcom_q6v5_mss.c b/drivers/remoteproc/qcom_q6v5_mss.c
> index b781fc8de3597..6a19e0e77236e 100644
> --- a/drivers/remoteproc/qcom_q6v5_mss.c
> +++ b/drivers/remoteproc/qcom_q6v5_mss.c
> @@ -196,7 +196,6 @@ struct q6v5 {
>
>         phys_addr_t mpss_phys;
>         phys_addr_t mpss_reloc;
> -       void *mpss_region;

Hm, this doesn't build for me on our Chrome tree:

  CC [M]  drivers/remoteproc/qcom_q6v5_mss.o
/mnt/host/source/src/third_party/kernel/v5.4/drivers/remoteproc/qcom_q6v5_mss.c:1118:16:
error: no member named 'mpss_region' in 'struct q6v5'
                ptr = qproc->mpss_region + offset;
                      ~~~~~  ^
/mnt/host/source/src/third_party/kernel/v5.4/drivers/remoteproc/qcom_q6v5_mss.c:1520:9:
error: no member named 'mpss_region' in 'struct q6v5'
        qproc->mpss_region = devm_ioremap_wc(qproc->dev,
qproc->mpss_phys, qproc->mpss_size);
        ~~~~~  ^
/mnt/host/source/src/third_party/kernel/v5.4/drivers/remoteproc/qcom_q6v5_mss.c:1521:14:
error: no member named 'mpss_region' in 'struct q6v5'
        if (!qproc->mpss_region) {
             ~~~~~  ^
