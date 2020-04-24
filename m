Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29D13C55186
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 17:12:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03A842071E
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 17:12:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Fg7ouCwC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728768AbgDXRMW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 13:12:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726698AbgDXRMV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 13:12:21 -0400
Received: from mail-ua1-x941.google.com (mail-ua1-x941.google.com [IPv6:2607:f8b0:4864:20::941])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 867EFC09B047
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 10:12:21 -0700 (PDT)
Received: by mail-ua1-x941.google.com with SMTP id u12so10177990uau.10
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 10:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y4x/EibMxQc7fPoEcBMgM921gNbQOy6kQZP/OouoL7w=;
        b=Fg7ouCwC8QZ4cEnJO4hNfllKuJFP5aegTkmybs5rxcq6KjwVGXjvpkRS6a4tt7W6HH
         XmSko4GsOMX+6qp+K9Ss+3TyVPYAFqTDwYWIeTmtTTu3KV7KYGHVkWaeEkTbzqfmjoRE
         DDyaev+BbAk4jc6lE0gV2WxXUQcYpK8D1MEGE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y4x/EibMxQc7fPoEcBMgM921gNbQOy6kQZP/OouoL7w=;
        b=OhMZkiv+LmGG415h1wxSi2x9/1O4j5VHnljgE4Uq48BoZt32L7cqYzsuZyP4mMuwob
         U/kcwIFRGBJICwobOoexu1XonqIJGm9ZIzLXQVs5IwQQp1NCs5vqdeTChlxSI2muyMbB
         vj6bgBZaw5gbuEaTB2NS2oTNgbB+3iKRUJouXBU8z5jZDUXoZyBEJWaNBnNZ/WlEpiv1
         4DjtiCqTbvhrnBW54m8jrtcXlJrbV816CaCJ5s4WmnxWa3A9GpLcin+7yhNaajOb0343
         1knjOejrLj7KtWPSaTTTEc/M2vUpHXBl2/q7aXfkr1mHPlWnG2Iv6F1HGkZ8pwbuEF8k
         VHxw==
X-Gm-Message-State: AGi0PuYkidvSUBNTNex4BPOacsRwNVMPUNiCiiellt302KV+KRKwnq+k
        +8Wb6hYvzJo1ehYLg8hdPdZonFsxbGY=
X-Google-Smtp-Source: APiQypLxkovhZ7ZqmWstTpcW/VHj+rzhj2Qf1rHuAi8e/V99KSDOVWJssZ2RszdSvqYnY7nvRC3JSQ==
X-Received: by 2002:a67:fa85:: with SMTP id f5mr8185641vsq.65.1587748340187;
        Fri, 24 Apr 2020 10:12:20 -0700 (PDT)
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com. [209.85.222.54])
        by smtp.gmail.com with ESMTPSA id x25sm1555504vso.5.2020.04.24.10.12.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Apr 2020 10:12:18 -0700 (PDT)
Received: by mail-ua1-f54.google.com with SMTP id v24so10194343uak.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 10:12:18 -0700 (PDT)
X-Received: by 2002:a9f:3244:: with SMTP id y4mr8649776uad.49.1587748337637;
 Fri, 24 Apr 2020 10:12:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200424045414.133381-1-swboyd@chromium.org> <20200424045414.133381-2-swboyd@chromium.org>
In-Reply-To: <20200424045414.133381-2-swboyd@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 24 Apr 2020 10:12:04 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WT1rw9H34GjQSjbubR6y61=v-jR-gEvRtN4tU_NwviHA@mail.gmail.com>
Message-ID: <CAD=FV=WT1rw9H34GjQSjbubR6y61=v-jR-gEvRtN4tU_NwviHA@mail.gmail.com>
Subject: Re: [PATCH 1/3] soc: qcom: rpmh-rsc: Remove tcs_is_free() API
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Maulik Shah <mkshah@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Apr 23, 2020 at 9:54 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> This API does very little. Let's replace all the callsites with the
> normal operations that would be done on top of the bitmap that
> tcs_in_use is. This simplifies and reduces the code size.
>
> Cc: Maulik Shah <mkshah@codeaurora.org>
> Cc: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  drivers/soc/qcom/rpmh-rsc.c | 56 +++++++++++--------------------------
>  1 file changed, 17 insertions(+), 39 deletions(-)
>
> diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
> index 060be10bc491..76e0294a672c 100644
> --- a/drivers/soc/qcom/rpmh-rsc.c
> +++ b/drivers/soc/qcom/rpmh-rsc.c
> @@ -172,22 +172,6 @@ static void write_tcs_reg_sync(struct rsc_drv *drv, int reg, int tcs_id,
>         }
>  }
>
> -/**
> - * tcs_is_free() - Return if a TCS is totally free.
> - * @drv:    The RSC controller.
> - * @tcs_id: The global ID of this TCS.
> - *
> - * Returns true if nobody has claimed this TCS (by setting tcs_in_use).
> - *
> - * Context: Must be called with the drv->lock held.
> - *
> - * Return: true if the given TCS is free.
> - */
> -static bool tcs_is_free(struct rsc_drv *drv, int tcs_id)
> -{
> -       return !test_bit(tcs_id, drv->tcs_in_use);
> -}
> -
>  /**
>   * tcs_invalidate() - Invalidate all TCSes of the given type (sleep or wake).
>   * @drv:  The RSC controller.
> @@ -500,7 +484,7 @@ static void __tcs_buffer_write(struct rsc_drv *drv, int tcs_id, int cmd_id,
>   *
>   * Return: 0 if nothing in flight or -EBUSY if we should try again later.
>   *         The caller must re-enable interrupts between tries since that's
> - *         the only way tcs_is_free() will ever return true and the only way
> + *         the only way tcs_in_use will ever be updated and the only way
>   *         RSC_DRV_CMD_ENABLE will ever be cleared.
>   */
>  static int check_for_req_inflight(struct rsc_drv *drv, struct tcs_group *tcs,
> @@ -508,17 +492,14 @@ static int check_for_req_inflight(struct rsc_drv *drv, struct tcs_group *tcs,
>  {
>         unsigned long curr_enabled;
>         u32 addr;
> -       int i, j, k;
> -       int tcs_id = tcs->offset;
> +       int j, k;
> +       int i = tcs->offset;
>
> -       for (i = 0; i < tcs->num_tcs; i++, tcs_id++) {
> -               if (tcs_is_free(drv, tcs_id))
> -                       continue;
> -
> -               curr_enabled = read_tcs_reg(drv, RSC_DRV_CMD_ENABLE, tcs_id);
> +       for_each_set_bit_from(i, drv->tcs_in_use, tcs->offset + tcs->num_tcs) {
> +               curr_enabled = read_tcs_reg(drv, RSC_DRV_CMD_ENABLE, i);
>
>                 for_each_set_bit(j, &curr_enabled, MAX_CMDS_PER_TCS) {
> -                       addr = read_tcs_cmd(drv, RSC_DRV_CMD_ADDR, tcs_id, j);
> +                       addr = read_tcs_cmd(drv, RSC_DRV_CMD_ADDR, i, j);
>                         for (k = 0; k < msg->num_cmds; k++) {
>                                 if (addr == msg->cmds[k].addr)
>                                         return -EBUSY;
> @@ -536,18 +517,18 @@ static int check_for_req_inflight(struct rsc_drv *drv, struct tcs_group *tcs,
>   *
>   * Must be called with the drv->lock held since that protects tcs_in_use.
>   *
> - * Return: The first tcs that's free.
> + * Return: The first tcs that's free or -EBUSY if all in use.
>   */
>  static int find_free_tcs(struct tcs_group *tcs)
>  {
> -       int i;
> +       const struct rsc_drv *drv = tcs->drv;
> +       unsigned long i;
>
> -       for (i = 0; i < tcs->num_tcs; i++) {
> -               if (tcs_is_free(tcs->drv, tcs->offset + i))
> -                       return tcs->offset + i;
> -       }
> +       i = find_next_zero_bit(drv->tcs_in_use, MAX_TCS_NR, tcs->offset);

Rather than passing MAX_TCS_NR would it be legit to pass "tcs->offset
+ tcs->num_tcs"?  You are passing that as "size" above in
check_for_req_inflight().


> +       if (i > tcs->offset + tcs->num_tcs)

Should the above be ">=" ?  Oh, I guess Bjorn found the same thing.  ;-)


> +               return -EBUSY;
>
> -       return -EBUSY;
> +       return i;
>  }
>
>  /**
> @@ -744,8 +725,8 @@ int rpmh_rsc_write_ctrl_data(struct rsc_drv *drv, const struct tcs_request *msg)
>   */
>  static bool rpmh_rsc_ctrlr_is_busy(struct rsc_drv *drv)
>  {
> -       int m;
> -       struct tcs_group *tcs = &drv->tcs[ACTIVE_TCS];
> +       unsigned long set;
> +       const struct tcs_group *tcs = &drv->tcs[ACTIVE_TCS];
>
>         /*
>          * If we made an active request on a RSC that does not have a
> @@ -756,12 +737,9 @@ static bool rpmh_rsc_ctrlr_is_busy(struct rsc_drv *drv)
>         if (!tcs->num_tcs)
>                 tcs = &drv->tcs[WAKE_TCS];
>
> -       for (m = tcs->offset; m < tcs->offset + tcs->num_tcs; m++) {
> -               if (!tcs_is_free(drv, m))
> -                       return true;
> -       }
> +       set = find_next_bit(drv->tcs_in_use, MAX_TCS_NR, tcs->offset);

Similar to above, can you pass "tcs->offset + tcs->num_tcs" instead of
MAX_TCS_NR?
