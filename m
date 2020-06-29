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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07838C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:42:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D25D92063A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:42:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pgEjwmPm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391384AbgF2Vms (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 17:42:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727891AbgF2Shy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:37:54 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AFCAC02F034
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 08:01:37 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id s21so14608491oic.9
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 08:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ahxuxo5gOP/6pSemDiTgrDkxiqfqJ0tDYXZh9BCcusU=;
        b=pgEjwmPmFDeUiyPDPlH9X6z9QVmt+ceVEj5CqKKlK+r974liwN2rD6vBxMDgKB5z1J
         CLXsnzv+x3wJrq+YxY0c++tkCnLIbvtQMrkZG2gAGI7Tv/F27Dx0EufucPvbAIgpR09E
         /E/m22oMdbYdkBTDMJqD9mdOqsRqPDUOsAVEdb1rQm8PMBrdXDXC7bG0vsDnpk3lYY2P
         eHDLqyg3KBsB6SNchyY2KSg940BiaFf6UBxmxxapot3vbjHqSuDhgB/9IOO8FXEVGTkW
         kr0cQMOBe9I++UffOhx32FHnHShF9NRhlqBTFRYErg7zcmcW89Ilj0rV5eejDPsh/xnk
         QsXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ahxuxo5gOP/6pSemDiTgrDkxiqfqJ0tDYXZh9BCcusU=;
        b=Fsbe6SxLy3BzNAXCABdHW48szlooQeCAYf+3TlAmMzWMoYG42rCj+LB2qhtZGnliJb
         H7OV2uRkdmQx/vbQ2oWht2G/sWf45AdDsMReQJM7Hp1VK8i/ncslsgJf+UVkch/eIy2f
         NZpDGOHjBjYVvqrCKBvMJHOhQASYUjs+VlWx+DsVnJR2uwnC77pCMd0HfxgTLvtmQv7N
         tPxVx+XKXjWMwbvUHYdy4PxQNAKAexG9nC6pfJS4Drc98+ompJI3lEZLxlyfELPkMxqt
         rJh7R4rhFufkMTU9XuMm1zwBJ/DTDvk+QsdL9nqo5bpd3x7o5b1CTBBw+qETOgLD0+DA
         Bn1g==
X-Gm-Message-State: AOAM531jP5iQJBadI9R3k30bG3xSKtQbqIJcvDKE3dlI0s3Wyl377iCe
        wsJ7JVzhiX4+wixLaDwExCs2PNoFyAO70NO6078=
X-Google-Smtp-Source: ABdhPJzBgjgPa0wDMdeeuCMb4s4E2583xwAJ4+rFTBE38Lv72K5jeoZ41XPv4mrIgGAhjsRv1nD1oir8NGL/uHIEPF4=
X-Received: by 2002:aca:f583:: with SMTP id t125mr8385583oih.102.1593442896828;
 Mon, 29 Jun 2020 08:01:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200629140442.1043957-1-lee.jones@linaro.org> <20200629140442.1043957-9-lee.jones@linaro.org>
In-Reply-To: <20200629140442.1043957-9-lee.jones@linaro.org>
From:   Oded Gabbay <oded.gabbay@gmail.com>
Date:   Mon, 29 Jun 2020 18:01:08 +0300
Message-ID: <CAFCwf11J1riDiiHUeZ0po3zHriwZ4suXADizAcJwk3b2MgX=DQ@mail.gmail.com>
Subject: Re: [PATCH 08/20] misc: habanalabs: goya: goya_coresight: Remove set
 but unused variable 'val'
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        Tomer Tayar <ttayar@habana.ai>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 29, 2020 at 5:04 PM Lee Jones <lee.jones@linaro.org> wrote:
>
> No attempt to check the return value of RREG32() has been made
> since the call was introduced a year ago.
>
> Fixes W=3D1 kernel build warning:
>
>  drivers/misc/habanalabs/goya/goya_coresight.c: In function =E2=80=98goya=
_debug_coresight=E2=80=99:
>  drivers/misc/habanalabs/goya/goya_coresight.c:643:6: warning: variable =
=E2=80=98val=E2=80=99 set but not used [-Wunused-but-set-variable]
>  643 | u32 val;
>  | ^~~
>
> Cc: Oded Gabbay <oded.gabbay@gmail.com>
> Cc: Tomer Tayar <ttayar@habana.ai>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/misc/habanalabs/goya/goya_coresight.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/misc/habanalabs/goya/goya_coresight.c b/drivers/misc=
/habanalabs/goya/goya_coresight.c
> index 1258724ea5106..aa51fc71f0a1f 100644
> --- a/drivers/misc/habanalabs/goya/goya_coresight.c
> +++ b/drivers/misc/habanalabs/goya/goya_coresight.c
> @@ -640,7 +640,6 @@ static int goya_config_spmu(struct hl_device *hdev,
>  int goya_debug_coresight(struct hl_device *hdev, void *data)
>  {
>         struct hl_debug_params *params =3D data;
> -       u32 val;
>         int rc =3D 0;
>
>         switch (params->op) {
> @@ -672,7 +671,7 @@ int goya_debug_coresight(struct hl_device *hdev, void=
 *data)
>         }
>
>         /* Perform read from the device to flush all configuration */
> -       val =3D RREG32(mmPCIE_DBI_DEVICE_ID_VENDOR_ID_REG);
> +       RREG32(mmPCIE_DBI_DEVICE_ID_VENDOR_ID_REG);
>
>         return rc;
>  }
> --
> 2.25.1
>

This patch is:
Reviewed-by: Oded Gabbay <oded.gabbay@gmail.com>
