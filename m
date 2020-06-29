Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C50D9C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:29:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2578208B6
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:29:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FHOaKahN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729509AbgF2V3A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 17:29:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729022AbgF2Smm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:42:42 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98D49C02F037
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 08:02:52 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id 72so15801915otc.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 08:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L+1Xz44ar6Uipm1PA8hKU1mmGQISJNR16huXvQBXU6I=;
        b=FHOaKahNgiBqalW/HJ7xU6Lci0yyJ1W3j5q7NdKCfei0LGFhxNl66FqNvW578NF/Tp
         Xwon/3JNQgjYAGlkDbo5kfqW3ti/ewtur0uxwVKM5NUQ57dHFpKpn6a7HF0CB4Bi/OaU
         qVX6wx33PATZj2rAQJ6T4gGTP27jbxsH9w4fkPFzbhGgMIX2J4AsQDuBrS2UEUnctgT3
         o63jtCu8cDpkUIsx1jddZM1JCLhG20iDpgn6jTJfjDW1oT5PA/o3Eag38rj3CH8aMoTH
         yMoSN+6rCfEqZb/o59YTB46ceXfNkidS6um7I2w92F0bYK6XQhq9oCVJtrYVXoj71s2E
         mNwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L+1Xz44ar6Uipm1PA8hKU1mmGQISJNR16huXvQBXU6I=;
        b=DGCNbrnJ+JgA+9VCBg2rKCuXEm28DFd3ygjje7Kz6+zA1dEvMgqAXKhDdLpF+bDk15
         t2rbqG5nVDQjoD0JPvVyCdOvi2KyMnRC4Zj0whzBrohe4801iqeY98ShV07BCCXAsSDu
         d5bUhefgFAhKqw2YskulkekjqoW4MYs9eP+7GsgPb0fkJH8DBI7ewxyBvFF8duEazguJ
         Q7hihXwFIu4q7Y9ptxWU8aNr8vxBkjjgSiVDDWYu/XZb6Ooz1LU5qDzYByZURG2Gl2wm
         g6003rYIjzgqD6SPHAKlR4aWhB39SaRl+HZunI41rcC6BhdfwPByfXZscNQvHXM0NRb0
         87Pg==
X-Gm-Message-State: AOAM531sf1WPfTjlJFBUv83Jfx0tQLMJOPSSbdrGVnF0Kq17jyH/DY0L
        vDxrl8JCmQhfmpL0q4C1azMIJmv5B+Py+sxUtB8=
X-Google-Smtp-Source: ABdhPJxAv3nNA07e6BnrRu3LBTJ+LyIE2q/QM8cY6s6i/AdfdMV0lBURqFifSBhRLBv25JuF3dX27RCSg/1khsAd2mw=
X-Received: by 2002:a05:6830:3151:: with SMTP id c17mr14283505ots.143.1593442971967;
 Mon, 29 Jun 2020 08:02:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200629140442.1043957-1-lee.jones@linaro.org> <20200629140442.1043957-11-lee.jones@linaro.org>
In-Reply-To: <20200629140442.1043957-11-lee.jones@linaro.org>
From:   Oded Gabbay <oded.gabbay@gmail.com>
Date:   Mon, 29 Jun 2020 18:02:24 +0300
Message-ID: <CAFCwf11L35U4u-C+rKijJbPNc9VowFOaKWKzx=ZNY4cN=EkyBg@mail.gmail.com>
Subject: Re: [PATCH 10/20] misc: habanalabs: gaudi: gaudi_security: Repair
 incorrectly named function arg
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        Tomer Tayar <ttayar@habana.ai>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 29, 2020 at 5:04 PM Lee Jones <lee.jones@linaro.org> wrote:
>
> audi_pb_set_block()'s argument 'base' was incorrectly named 'block' in
gaudi_pb_set_block()'s

> its function header.
>
> Fixes the following W=1 kernel build warning(s):
>
>  drivers/misc/habanalabs/gaudi/gaudi_security.c:454: warning: Function parameter or member 'base' not described in 'gaudi_pb_set_block'
>  drivers/misc/habanalabs/gaudi/gaudi_security.c:454: warning: Excess function parameter 'block' description in 'gaudi_pb_set_block'
>
> Cc: Oded Gabbay <oded.gabbay@gmail.com>
> Cc: Tomer Tayar <ttayar@habana.ai>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/misc/habanalabs/gaudi/gaudi_security.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/misc/habanalabs/gaudi/gaudi_security.c b/drivers/misc/habanalabs/gaudi/gaudi_security.c
> index 6a351e31fa6af..abdd5ed8f2cf6 100644
> --- a/drivers/misc/habanalabs/gaudi/gaudi_security.c
> +++ b/drivers/misc/habanalabs/gaudi/gaudi_security.c
> @@ -447,8 +447,7 @@ static u64 gaudi_rr_hbw_mask_high_ar_regs[GAUDI_NUMBER_OF_RR_REGS] = {
>   * gaudi_set_block_as_protected - set the given block as protected
>   *
>   * @hdev: pointer to hl_device structure
> - * @block: block base address
> - *
> + * @base: block base address
>   */
>  static void gaudi_pb_set_block(struct hl_device *hdev, u64 base)
>  {
> --
> 2.25.1
>
With the above fix, This patch is:
Reviewed-by: Oded Gabbay <oded.gabbay@gmail.com>
