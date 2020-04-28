Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6D28C83007
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 20:58:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94AB92137B
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 20:58:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fW8/VJuK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726662AbgD1U6j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 16:58:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726636AbgD1U6h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 16:58:37 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25D86C03C1AC
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 13:58:37 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id rh22so18392501ejb.12
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 13:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OSzO1rJO0R184LhoOiiy43Vbf5CZ5lYIXfcp6IiNMuk=;
        b=fW8/VJuKoPUP7uviDlRt5iWPklR6159dL8OqPXAYkQt9jT0QXQH20Vj9C11FGoyFvc
         OmLtFM7kkC1koJGiB6xpfGZtZ5KQla2TT0FJ0a62xNBnSaBDE5mcnxixIXf215wOmA2x
         bz5s03577i+7pt7SX5d+h4+D+TvfNRIGHm5exgfywa5JPZAkLGGlYKVJ1xOOXfp4y32z
         H/OOSJvk+DvAC9eCBwXFeQ72VKvf6z6DSYPHye8eGQW9zYal4Z7bSHNJMbnI/Ugqef1v
         U6385QbNHByFEDZBtIQhEEYNiVIsvaguzMhSGX7AJ6VGb7NALY801/q3RB/Dl4z90Kza
         Ej5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OSzO1rJO0R184LhoOiiy43Vbf5CZ5lYIXfcp6IiNMuk=;
        b=nci4K0bmrQkfgOw9J7branEgAC+U6jwDcE2vm/xUURCLTw4qvNdLWqfLp4lCodp3Jf
         C2ck+/vK9wmXvwGSgDPPCGbQ68AhZct11xOb6gpqMQ90be03Ise8aGTamFXZVIQooCZ4
         IO2naSjFSsv8h3swMFdbgWIjTiOh6f3ypGUbeO5Jgxwdz8I2HqkT1r6hX1yGuzQA/Pbl
         l9ipIRmW11SqeE6KxhEzdXgh3424wY9k2QAfweJJkpW9xSjit+3ScYOoOppiYfJFrNI3
         eS4PAjySXlTh2ds0SPTSLVakUiRio/QOYP58AdPukMxbKYsZpQ6P7bVBcTm+LBpkm8z+
         lb/A==
X-Gm-Message-State: AGi0PuYoPTeDmkeWOYh4Z6Gecr6OURq1FtUVx0hp6H9WGeuYNSmszRmo
        HWCJu/59tBYXbGgPpg0alfiRYM7vjbOnmz6rMSwqEw==
X-Google-Smtp-Source: APiQypIDmIaYEXVfqX5Ab4PeJvhjul4YnZzP2xIfW1kiZtODLOShV6xLWrmLPJ+wBx6xyCCV+2sKrWG5awxiNEHaSK4=
X-Received: by 2002:a17:906:5918:: with SMTP id h24mr27104025ejq.210.1588107515478;
 Tue, 28 Apr 2020 13:58:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200428181010.170568-1-swboyd@chromium.org> <20200428181010.170568-3-swboyd@chromium.org>
In-Reply-To: <20200428181010.170568-3-swboyd@chromium.org>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Tue, 28 Apr 2020 21:58:24 +0100
Message-ID: <CAJ9a7VjJpZWMJFkwxwnc=w8p1cemx-vM7yrWWWEHp_ThjkJoSA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] coresight: Avoid casting void pointers
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Joe Perches <joe@perches.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by mike.leach@linaro.org

On Tue, 28 Apr 2020 at 19:10, Stephen Boyd <swboyd@chromium.org> wrote:
>
> We don't need to cast void pointers, such as the amba_id data. Assign to
> a local variable to make the code prettier and also return NULL instead
> of 0 to make sparse happy.
>
> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> Cc: Mike Leach <mike.leach@linaro.org>
> Reviewed-by: Joe Perches <joe@perches.com>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>
> Thanks Joe for finding my thinko!
>
>  drivers/hwtracing/coresight/coresight-priv.h | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/hwtracing/coresight/coresight-priv.h b/drivers/hwtracing/coresight/coresight-priv.h
> index 5a36f0f50899..36c943ae94d5 100644
> --- a/drivers/hwtracing/coresight/coresight-priv.h
> +++ b/drivers/hwtracing/coresight/coresight-priv.h
> @@ -215,9 +215,12 @@ cti_remove_assoc_from_csdev(struct coresight_device *csdev) {}
>  /* extract the data value from a UCI structure given amba_id pointer. */
>  static inline void *coresight_get_uci_data(const struct amba_id *id)
>  {
> -       if (id->data)
> -               return ((struct amba_cs_uci_id *)(id->data))->data;
> -       return 0;
> +       struct amba_cs_uci_id *uci_id = id->data;
> +
> +       if (!uci_id)
> +               return NULL;
> +
> +       return uci_id->data;
>  }
>
>  void coresight_release_platform_data(struct coresight_device *csdev,
> --
> Sent by a computer, using git, on the internet
>


-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
