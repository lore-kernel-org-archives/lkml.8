Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98199C2BBFD
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 15:16:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 694D42072C
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 15:16:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IXyX5Dqv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730962AbgDMPQt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 11:16:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729618AbgDMPQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 11:16:47 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3CBFC0A3BDC
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 08:16:46 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id v8so10310621wma.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 08:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=r6UiEvbE1rjGxqv1o7W1IMkMCeQe6MTQHsxVolkgrEM=;
        b=IXyX5DqvbxY264CH/F3eNmCS/hdCeedFlfXvTbxd/Lc6eXN6Tqrswd0c/tdAPy1syl
         0UnwbezT1Uj5x0yqKoH/yms6XPU7YoCB5yw9pIms1/tVWSHyib9tx0UCNQ1ElPjOwXyJ
         dm/kMjzoBQvVd4kp2hxcJujkcgf5WVvHy+eI8etV3wfT2c3uKX7ma7cMbMoMr/uRpjmg
         apugD+5A/RMOUNdK4SbluQZIB4kewFWwdopstVUwJGg3y6r2JYhsPavopRClZsj7+e3j
         kUh3kg4LF9OEPlTt/lonVX9PeYmNHqzJ/JwWyh/+Cfy/JpHBWVwds3JE1emP6/bhvJCK
         DKZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=r6UiEvbE1rjGxqv1o7W1IMkMCeQe6MTQHsxVolkgrEM=;
        b=b+xYqjHlYMtPL5zxn8lvmy5Nsyoquzwze5b5mtDbrYFuhz02OMWycsKl8txnKMg2RB
         GVh6cpdChs/M9RQJuYPxWTa2+yW+SHPhqm5/Bue45erEaFzekrhffDczBTsxw96QAe2Q
         IZLfMlw6b5iDQtmhjioP/0rnf5EteUquKvF5t5OWSK8+mcXm3uqGdM3yINtY+EeQ12gW
         7uSS2oUXHrWak9/N0BZCbVl6NfQh5FySwLyRQcC02E5o/vEr03RXSERYrvdLiArEu6d/
         3iK8eqplFZbUxXNx+JqpiXEB/vjfV4gWVN6phh1nQs1s6aWR5+mULt7S+ldiHxBYePsd
         9FZg==
X-Gm-Message-State: AGi0Puak8ItnIlSPFLBfnniBi9TG33tDlU3zH5RPqKGRDkmhYAVcV3G9
        KRLDTzkwHFaXeBQRHXVdcSd9ODLg+Gnzbjp1QUA=
X-Google-Smtp-Source: APiQypJrQBbCjYEr3VeIs/klvTlCt9CHs6CsKjldb6vT7gM4x1pA8yy3F8VwNa2km5kWAS9nF055I8Da4DqRxQfmOLM=
X-Received: by 2002:a7b:cc8e:: with SMTP id p14mr18695083wma.70.1586791005382;
 Mon, 13 Apr 2020 08:16:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200413143245.23107-1-yanaijie@huawei.com>
In-Reply-To: <20200413143245.23107-1-yanaijie@huawei.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 13 Apr 2020 11:16:33 -0400
Message-ID: <CADnq5_P42xtD-kL6A_eZ4s_vRVTqmsCnuFmQSA_8f+7bZTfcgg@mail.gmail.com>
Subject: Re: [PATCH] drm/radeon: remove defined but not used 'dte_data_tahiti_le'
To:     Jason Yan <yanaijie@huawei.com>
Cc:     "Deucher, Alexander" <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Chunming Zhou <David1.Zhou@amd.com>,
        Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Hulk Robot <hulkci@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  thanks!

Alex

On Mon, Apr 13, 2020 at 10:06 AM Jason Yan <yanaijie@huawei.com> wrote:
>
> Fix the following gcc warning:
>
> drivers/gpu/drm/radeon/si_dpm.c:255:33: warning: =E2=80=98dte_data_tahiti=
_le=E2=80=99
> defined but not used [-Wunused-const-variable=3D]
>  static const struct si_dte_data dte_data_tahiti_le =3D
>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Jason Yan <yanaijie@huawei.com>
> ---
>  drivers/gpu/drm/radeon/si_dpm.c | 18 ------------------
>  1 file changed, 18 deletions(-)
>
> diff --git a/drivers/gpu/drm/radeon/si_dpm.c b/drivers/gpu/drm/radeon/si_=
dpm.c
> index 2cb85dbe728f..a167e1c36d24 100644
> --- a/drivers/gpu/drm/radeon/si_dpm.c
> +++ b/drivers/gpu/drm/radeon/si_dpm.c
> @@ -252,24 +252,6 @@ static const struct si_dte_data dte_data_tahiti =3D
>         false
>  };
>
> -static const struct si_dte_data dte_data_tahiti_le =3D
> -{
> -       { 0x1E8480, 0x7A1200, 0x2160EC0, 0x3938700, 0 },
> -       { 0x7D, 0x7D, 0x4E4, 0xB00, 0 },
> -       0x5,
> -       0xAFC8,
> -       0x64,
> -       0x32,
> -       1,
> -       0,
> -       0x10,
> -       { 0x78, 0x7C, 0x82, 0x88, 0x8E, 0x94, 0x9A, 0xA0, 0xA6, 0xAC, 0xB=
0, 0xB4, 0xB8, 0xBC, 0xC0, 0xC4 },
> -       { 0x3938700, 0x3938700, 0x3938700, 0x3938700, 0x3938700, 0x393870=
0, 0x3938700, 0x3938700, 0x3938700, 0x3938700, 0x3938700, 0x3938700, 0x3938=
700, 0x3938700, 0x3938700, 0x3938700 },
> -       { 0x2AF8, 0x2AF8, 0x29BB, 0x27F9, 0x2637, 0x2475, 0x22B3, 0x20F1,=
 0x1F2F, 0x1D6D, 0x1734, 0x1414, 0x10F4, 0xDD4, 0xAB4, 0x794 },
> -       85,
> -       true
> -};
> -
>  static const struct si_dte_data dte_data_tahiti_pro =3D
>  {
>         { 0x1E8480, 0x3D0900, 0x989680, 0x2625A00, 0x0 },
> --
> 2.21.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
