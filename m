Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C913AC433E4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 03:39:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A378E2063A
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 03:39:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KmghUthG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbgHSDjV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 23:39:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726627AbgHSDjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 23:39:17 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A4D4C061343
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 20:39:16 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id m8so10988884pfh.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 20:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=LqLEg6Ld5QuLtOzu6BqXxZNLCj7RTFYiQgIAyF8gU70=;
        b=KmghUthGvojy07h9BZsorKl+jQO7wKGLOev2rzAcomRYp9sMfs6Gjktbt33K26LekA
         Qxkv14xQTsOxA9Bw0STh5x8cRg2HTa8mDrsoUOptFIhGGhBev4tXpiniG3TiTd2zRraw
         V/Eoz0F5NCVs1RDrHgfuHBOh77xH2S+T3Pt0k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=LqLEg6Ld5QuLtOzu6BqXxZNLCj7RTFYiQgIAyF8gU70=;
        b=I/cgLLYXmwvXxbAT6NC4/1UQXqKyqZC2d3y/EYT7jC7I/4zg2jYqe3u2Q+c6kBt7sM
         hlOf6WJ80gMaLsYcAntRq1AsAPD8aJZHgsYNghG4BRwvmmyuJTIqrFLUZRGC1Qi2f7JL
         wbl1beUAPHE/cSgLxHt4f1DwFLGV8NZkt6hGuIto18JgjnwTW86uq7ztEhKQSAT9C1kT
         EXw4ktnmHN+qv2wR31Oq/7YgARdVQYEX40yBHA+16Svr2NQ6Kcsjh0jMjvdvZvbx/h8b
         HBgu7Tu7p3LQWbYupz5rRE3mLiHcf4ivAUjnjLPuoiXujMWZ7OM87AtleJP+WwxNn6QM
         6Qxg==
X-Gm-Message-State: AOAM530v2XIPuXkGDzEowtikSuY7w2nmSPXQ5q2HGIZmLotpUdyzRBK0
        E8Lk5Mtye6jRKPSWWgX0EvptXw==
X-Google-Smtp-Source: ABdhPJw/fbapbqyEK3EQuuI/goR68Bo71kvM1Fo115OGCAsLxKKL/EFMEBHhZev14vQUxfKm+79SNw==
X-Received: by 2002:a65:68d6:: with SMTP id k22mr8267707pgt.136.1597808355900;
        Tue, 18 Aug 2020 20:39:15 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id a193sm26557771pfa.105.2020.08.18.20.39.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2020 20:39:15 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200814095540.32115-2-rojay@codeaurora.org>
References: <20200814095540.32115-1-rojay@codeaurora.org> <20200814095540.32115-2-rojay@codeaurora.org>
Subject: Re: [PATCH 1/2] i2c: i2c-qcom-geni: Add tx_dma, rx_dma and xfer_len to geni_i2c_dev struct
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     dianders@chromium.org, saiprakash.ranjan@codeaurora.org,
        gregkh@linuxfoundation.org, mka@chromium.org,
        akashast@codeaurora.org, msavaliy@qti.qualcomm.com,
        skakit@codeaurora.org, rnayak@codeaurora.org, agross@kernel.org,
        bjorn.andersson@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        sumit.semwal@linaro.org, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        Roja Rani Yarubandi <rojay@codeaurora.org>
To:     Roja Rani Yarubandi <rojay@codeaurora.org>, wsa@kernel.org
Date:   Tue, 18 Aug 2020 20:39:13 -0700
Message-ID: <159780835380.334488.10270114810481187992@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Roja Rani Yarubandi (2020-08-14 02:55:39)
> Adding tx_dma, rx_dma and xfer length in geni_i2c_dev struct to
> store DMA mapping data to enhance its scope. For example during
> shutdown callback to unmap DMA mapping, these new struct members
> can be used as part of geni_se_tx_dma_unprep and
> geni_se_rx_dma_unprep calls.

Please read about how to write commit text from kernel docs[1]. Hint,
use imperative mood.

>=20
> Signed-off-by: Roja Rani Yarubandi <rojay@codeaurora.org>
> ---
>  drivers/i2c/busses/i2c-qcom-geni.c | 23 +++++++++++++----------
>  1 file changed, 13 insertions(+), 10 deletions(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-=
qcom-geni.c
> index 7f130829bf01..53ca41f76080 100644
> --- a/drivers/i2c/busses/i2c-qcom-geni.c
> +++ b/drivers/i2c/busses/i2c-qcom-geni.c
> @@ -86,6 +86,9 @@ struct geni_i2c_dev {
>         u32 clk_freq_out;
>         const struct geni_i2c_clk_fld *clk_fld;
>         int suspended;
> +       dma_addr_t tx_dma;
> +       dma_addr_t rx_dma;
> +       u32 xfer_len;

Why not size_t?

>  };
> =20
>  struct geni_i2c_err_log {
> @@ -352,12 +355,11 @@ static void geni_i2c_tx_fsm_rst(struct geni_i2c_dev=
 *gi2c)
>  static int geni_i2c_rx_one_msg(struct geni_i2c_dev *gi2c, struct i2c_msg=
 *msg,
>                                 u32 m_param)
>  {
> -       dma_addr_t rx_dma;
>         unsigned long time_left;
>         void *dma_buf =3D NULL;
>         struct geni_se *se =3D &gi2c->se;
> -       size_t len =3D msg->len;
> =20
> +       gi2c->xfer_len =3D msg->len;

I'd prefer to keep the local variable and then have=20

	len =3D gi2c->xfer_len =3D msg->len;

>         if (!of_machine_is_compatible("lenovo,yoga-c630"))
>                 dma_buf =3D i2c_get_dma_safe_msg_buf(msg, 32);
> =20
> @@ -366,9 +368,10 @@ static int geni_i2c_rx_one_msg(struct geni_i2c_dev *=
gi2c, struct i2c_msg *msg,
>         else
>                 geni_se_select_mode(se, GENI_SE_FIFO);
> =20
> -       writel_relaxed(len, se->base + SE_I2C_RX_TRANS_LEN);
> +       writel_relaxed(gi2c->xfer_len, se->base + SE_I2C_RX_TRANS_LEN);

So that all this doesn't have to change.

> =20
> -       if (dma_buf && geni_se_rx_dma_prep(se, dma_buf, len, &rx_dma)) {
> +       if (dma_buf && geni_se_rx_dma_prep(se, dma_buf, gi2c->xfer_len,
> +                                          &gi2c->rx_dma)) {
>                 geni_se_select_mode(se, GENI_SE_FIFO);
>                 i2c_put_dma_safe_msg_buf(dma_buf, msg, false);
>                 dma_buf =3D NULL;
> @@ -384,7 +387,7 @@ static int geni_i2c_rx_one_msg(struct geni_i2c_dev *g=
i2c, struct i2c_msg *msg,
>         if (dma_buf) {
>                 if (gi2c->err)
>                         geni_i2c_rx_fsm_rst(gi2c);
> -               geni_se_rx_dma_unprep(se, rx_dma, len);
> +               geni_se_rx_dma_unprep(se, gi2c->rx_dma, gi2c->xfer_len);
>                 i2c_put_dma_safe_msg_buf(dma_buf, msg, !gi2c->err);
>         }
> =20
> @@ -394,12 +397,11 @@ static int geni_i2c_rx_one_msg(struct geni_i2c_dev =
*gi2c, struct i2c_msg *msg,
>  static int geni_i2c_tx_one_msg(struct geni_i2c_dev *gi2c, struct i2c_msg=
 *msg,
>                                 u32 m_param)
>  {
> -       dma_addr_t tx_dma;
>         unsigned long time_left;
>         void *dma_buf =3D NULL;
>         struct geni_se *se =3D &gi2c->se;
> -       size_t len =3D msg->len;
> =20
> +       gi2c->xfer_len =3D msg->len;

Same comment.

>         if (!of_machine_is_compatible("lenovo,yoga-c630"))
>                 dma_buf =3D i2c_get_dma_safe_msg_buf(msg, 32);
> =20

[1] https://www.kernel.org/doc/html/latest/process/submitting-patches.html#=
describe-your-changes
