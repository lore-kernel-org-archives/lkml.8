Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 831ECC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 06:08:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61C372076A
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 06:08:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594361310;
	bh=blnFmOCbcj7GlYVM5qLLg3maWpJyP/hMJGZDDez7ibI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=X121S2Y3uvX41jVRgbjHd/cZ0nP/rz6Uwso2dIcXSfvJ58sloj5wBQ6gp8zRiGHAt
	 ooICiAPTiKJO2LnucpAsHpZFce9fNk/ijsjuNIHjU4G4BEWNNwivL0FhcYezTT1bNr
	 mZnDahtr1r7znVS85wbJ+blNNGuXgOIkYAoFzB2I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727785AbgGJGI2 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 02:08:28 -0400
Received: from mail-ej1-f68.google.com ([209.85.218.68]:42725 "EHLO
        mail-ej1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725851AbgGJGI1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 02:08:27 -0400
Received: by mail-ej1-f68.google.com with SMTP id f12so4762562eja.9;
        Thu, 09 Jul 2020 23:08:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=sZWbg5n4QuCPXZ3uCh/ygFqQbxWrFH3XWXvFripTxS8=;
        b=KWmu6k0Ex4bXaHzUlouaUdzaRdqW9yI9AW3cUjQeNuRGsM2LLE0MBdXQOYzpDlS6YC
         50MkrG+EWjW9RZgYlUa2SIMsnMm5alq2Mob3beWEpMlUZ2SiZxH9SuI+8iEdajKmF/pa
         HA5GHpC6UN6s0rLla+og9aDHE731g0jA000PYcksHvVrUHhibKzDL/r9PwiIzOxSZ7AF
         QaGnQWAktrzFfGgbMlATsT5RTsbqSdulk1wwu6dT64LpUz3woRPKENijBZFJkg3M89FO
         rR5xabhLq4AAx0m5qlzP5odNCvJJT3XoiWGJNo8QSC+XqG+T/lnaIMEYih2I7LR1pZbd
         lc6g==
X-Gm-Message-State: AOAM531ZlKxnbFDfxwhAkiAJ9ulXxyPC2wyNCrto/Lw0lmGRihM+XThf
        NFd/OrNbaRWaZG/MUlmYyZOlQocyTikt0Uf6FCI=
X-Google-Smtp-Source: ABdhPJxdUrgp68rxovcdZIrJ5SI2MVqjC9OM5no2eX8hPvILncnfI9RiixNPMhVNOwVR+yxcWDbMzdf9vSFJ56vaUJU=
X-Received: by 2002:a17:906:284e:: with SMTP id s14mr58791027ejc.498.1594361305183;
 Thu, 09 Jul 2020 23:08:25 -0700 (PDT)
MIME-Version: 1.0
References: <250d35cb489c3c4c066f7ce256d27f36712a1979.1591618255.git.baolin.wang7@gmail.com>
In-Reply-To: <250d35cb489c3c4c066f7ce256d27f36712a1979.1591618255.git.baolin.wang7@gmail.com>
From:   Barry Song <baohua@kernel.org>
Date:   Fri, 10 Jul 2020 18:08:14 +1200
Message-ID: <CAGsJ_4y25psj9vAyjstFQiGwAd_TfTdyeNt41YbXfphOXoFVig@mail.gmail.com>
Subject: Re: [PATCH] hwspinlock: sirf: Remove the redundant 'of_match_ptr'
To:     Baolin Wang <baolin.wang7@gmail.com>
Cc:     Ohad Ben-Cohen <ohad@wizery.com>, bjorn.andersson@linaro.org,
        linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Baolin Wang <baolin.wang7@gmail.com> 于2020年6月9日周二 上午12:22写道：
>
> Remove the the redundant 'of_match_ptr' macro to fix below warning
> when the CONFIG_OF is not selected.
>
> All warnings:
> drivers/hwspinlock/sirf_hwspinlock.c:87:34: warning: unused variable
> 'sirf_hwpinlock_ids' [-Wunused-const-variable]
>
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>
> ---
>  drivers/hwspinlock/sirf_hwspinlock.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/hwspinlock/sirf_hwspinlock.c b/drivers/hwspinlock/sirf_hwspinlock.c
> index 823d3c4f621e..a3f77120bad7 100644
> --- a/drivers/hwspinlock/sirf_hwspinlock.c
> +++ b/drivers/hwspinlock/sirf_hwspinlock.c
> @@ -94,7 +94,7 @@ static struct platform_driver sirf_hwspinlock_driver = {
>         .probe = sirf_hwspinlock_probe,
>         .driver = {
>                 .name = "atlas7_hwspinlock",
> -               .of_match_table = of_match_ptr(sirf_hwpinlock_ids),
> +               .of_match_table = sirf_hwpinlock_ids,

is it better to do?

#ifdef CONFIG_OF
static const struct of_device_id sirf_hwpinlock_ids[] = {
        { .compatible = "sirf,hwspinlock", },
        {},
};
MODULE_DEVICE_TABLE(of, sirf_hwpinlock_ids);
#endif

>         },
>  };
>
> --
> 2.17.1

Thanks
barry
