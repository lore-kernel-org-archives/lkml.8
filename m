Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABFFAC4BA2D
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 22:49:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C9B120658
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 22:49:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BoAb9F5e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727929AbgBZWtq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 17:49:46 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42021 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727857AbgBZWtp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 17:49:45 -0500
Received: by mail-pg1-f195.google.com with SMTP id h8so369769pgs.9
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2020 14:49:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=zrxYK5T4ryzAQ2/Coj4xWlYlr/YB5hTtCncd5uUc0tg=;
        b=BoAb9F5e0xcUz/99univTBiDlbKMXwAMGASi71CgsY4GoUj7vPWfV8OCv9eQS5qo98
         roRqj/8sbWDJNq8uFWg6paTRdw/Qf93w3hbv7lQckpl9Fr8DBSwKdUWsRt5x8nVvz66h
         Kd6cFfvvC8u+EQh0vP0RB7rIXsQ473CE2lHok=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=zrxYK5T4ryzAQ2/Coj4xWlYlr/YB5hTtCncd5uUc0tg=;
        b=rP0j7kdmbVDCUPa8kplaxIQPz3n0IeR/v4gKKgJ3o6WjaBSjAuRG13sRVL5DTnnUPt
         rR7XWh48dr369ovvKAdsLe71SUs3N4F9nIJTZCt8o2j6c9b4j38f3nXCRFmwS3zO/LRu
         S75tKNZaRhKgr/3iK5Qh/kVoexsSHHNqySr/pvwY/fkCRosjKHMRViqhUtVUZwKyMPB2
         E78ERhnOFZkwBBS9gsfluNHt+7JrBMQFxrNcrzzCzWW2V+1RvAN3mENsauQGHK+fCr2d
         RRIzktQ0SRhwn6LYu9SB5j/QUHCO1kn9EsVXRg4pEotXt4tWCNgNlnAvYj6JwGzYVc6V
         JDTw==
X-Gm-Message-State: APjAAAUGz6RG0seeq4ofeX2Jj5w3/YHAv4GVDjvRn5MsFF5qv2DaR5C2
        gXK0IV2QKTaSlbwh6lo/h7FnQLsImdg=
X-Google-Smtp-Source: APXvYqzWSwy1V4i2RZk6mQsWpopxq8C4OV64juHHo4XtneUSiu09Qomzsc0m6YYSZOzAGYVT+e38XQ==
X-Received: by 2002:a63:8f5c:: with SMTP id r28mr1021763pgn.351.1582757384609;
        Wed, 26 Feb 2020 14:49:44 -0800 (PST)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id k1sm2325744pgt.70.2020.02.26.14.49.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2020 14:49:44 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1582694833-9407-4-git-send-email-mkshah@codeaurora.org>
References: <1582694833-9407-1-git-send-email-mkshah@codeaurora.org> <1582694833-9407-4-git-send-email-mkshah@codeaurora.org>
Subject: Re: [PATCH v7 3/3] soc: qcom: rpmh: Invoke rpmh_flush for dirty caches
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        agross@kernel.org, dianders@chromium.org, rnayak@codeaurora.org,
        ilina@codeaurora.org, lsrao@codeaurora.org,
        Maulik Shah <mkshah@codeaurora.org>
To:     Maulik Shah <mkshah@codeaurora.org>, bjorn.andersson@linaro.org,
        evgreen@chromium.org, mka@chromium.org
Date:   Wed, 26 Feb 2020 14:49:43 -0800
Message-ID: <158275738312.177367.16582562675135073777@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Maulik Shah (2020-02-25 21:27:13)
> Add changes to invoke rpmh flush when the data in cache is dirty.
>=20
> This is done only if OSI is not supported in PSCI. If OSI is supported
> rpmh_flush can get invoked when the last cpu going to power collapse

Please write rpmh_flush() so we know it's a function and not a variable.

> deepest low power mode.
>=20
> Signed-off-by: Maulik Shah <mkshah@codeaurora.org>
> Reviewed-by: Srinivas Rao L <lsrao@codeaurora.org>
> ---
>  drivers/soc/qcom/rpmh.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/drivers/soc/qcom/rpmh.c b/drivers/soc/qcom/rpmh.c
> index 83ba4e0..839af8d 100644
> --- a/drivers/soc/qcom/rpmh.c
> +++ b/drivers/soc/qcom/rpmh.c
> @@ -12,6 +12,7 @@
>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/platform_device.h>
> +#include <linux/psci.h>
>  #include <linux/slab.h>
>  #include <linux/spinlock.h>
>  #include <linux/types.h>
> @@ -163,6 +164,9 @@ static struct cache_req *cache_rpm_request(struct rpm=
h_ctrlr *ctrlr,
>  unlock:
>         spin_unlock_irqrestore(&ctrlr->cache_lock, flags);
> =20
> +       if (ctrlr->dirty && !psci_has_osi_support())

Can we introduce a stub function for psci_has_osi_support() when
CONFIG_ARM_PSCI_FW=3Dn? This driver currently has:

  config QCOM_RPMH
        bool "Qualcomm RPM-Hardened (RPMH) Communication"
	depends on ARCH_QCOM && ARM64 || COMPILE_TEST


which implies that this will break build testing once built on something
that isn't arm64.


> +               return rpmh_flush(ctrlr) ? ERR_PTR(-EINVAL) : req;
> +
>         return req;
>  }
> =20
> @@ -391,6 +395,8 @@ int rpmh_write_batch(const struct device *dev, enum r=
pmh_state state,
> =20
>         if (state !=3D RPMH_ACTIVE_ONLY_STATE) {
>                 cache_batch(ctrlr, req);
> +               if (!psci_has_osi_support())
> +                       return rpmh_flush(ctrlr);

While the diff is small it is also sad that we turn around after adding
it to a list and immediately take it off the list and send it. Can't we
do this without having to do the list add/remove dance?

>                 return 0;
>         }
>
