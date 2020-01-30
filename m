Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D17CC33CB3
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 18:36:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76A3A20702
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 18:36:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EgiscpUZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727730AbgA3Sgj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 13:36:39 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45961 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727393AbgA3Sgj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 13:36:39 -0500
Received: by mail-wr1-f68.google.com with SMTP id a6so5334579wrx.12
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jan 2020 10:36:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nxOm33nBoQ951BS1wuIg4vUOUtrE7fNhIJifAOgimy0=;
        b=EgiscpUZcNg/uQV40kNR1mI8E2cAbOC5WOnuSQYuP8DgyFwZgcie/n2AC5zhOE6dML
         RTzpOWCThdFJel22VW0FBSRcT4STT9IptAe4liugxThmFiKKVb9UmzVDI+4vnVmCVbKh
         /vo0JvGjcQsbN5TPjH1riLpXfG1Jx2TFk87NFenMIR7dnDzk0nZgxlLMq9JQOCXphzOG
         bZJX1zfmlzbwCUI+dE8CXTbW5YLxDnNKlXyFlb64nEDDgQscq6aMUtyiOQxG2YXffdQq
         EmiQ5z69NdkLS3iPIxIeL0EPBq5ZBcPl8UIID5TA9BAh5el3gWwQ/ymkgwHUh73t1FnV
         3wIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nxOm33nBoQ951BS1wuIg4vUOUtrE7fNhIJifAOgimy0=;
        b=ub3Y8no7iIW9TKgDAUcywzyzD0OjdSufUBou/BZ0a6Xj480AToosnLuKVxzPvDnurF
         PCTTCLeWwCOu6IekfOFrtgKGWiZXS1s4r/oPJZRuRqrG5tyfcgkS0jSQ7el24wJxSaP3
         yKfmkjxWKolhUafhmt4IjCC0aMBmeHjGiK8Ncods7q8TnK98d2y1yb89z2yYjvceoZyg
         SJyDT62jqGFKU6hEco9BB5k6+MagtsUfAurlrcVpkG8dpboU+xzRaBl0nO6fHg2nJin4
         cdCm/+s/GvivazQKMIzzVd5Aaod4AD98RdfsQxfd69j4g1YzoVjCarQ55jNr+f4iIFPT
         mEpA==
X-Gm-Message-State: APjAAAVRBQ3uVoLvTuJ3tHRKoqdenAANug1UqSl/722cYH3XqRyQV51q
        Pqy/QN0Zp1gzIn2yTUC05m6lJZWpq70Tmy99J6g=
X-Google-Smtp-Source: APXvYqx2TzHXCb6BKa82GXdtX4Wu+vDT/+VJdGzjhuQ9HifgSYooKyQNebZQAjfJYETs1lqSs58NYc3eQ8q6xsd+0Pw=
X-Received: by 2002:adf:ec4c:: with SMTP id w12mr7381485wrn.124.1580409397096;
 Thu, 30 Jan 2020 10:36:37 -0800 (PST)
MIME-Version: 1.0
References: <20200130012435.49822-1-natechancellor@gmail.com>
In-Reply-To: <20200130012435.49822-1-natechancellor@gmail.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 30 Jan 2020 13:36:25 -0500
Message-ID: <CADnq5_MzvC=7pLufULN3nGDAwBE7Th7oWcUKXbYFouv0729GwA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Fix implicit enum conversion in gfx_v9_4_ras_error_inject
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 30, 2020 at 3:33 AM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> Clang warns:
>
> ../drivers/gpu/drm/amd/amdgpu/gfx_v9_4.c:967:35: warning: implicit
> conversion from enumeration type 'enum amdgpu_ras_block' to different
> enumeration type 'enum ta_ras_block' [-Wenum-conversion]
>         block_info.block_id = info->head.block;
>                             ~ ~~~~~~~~~~~^~~~~
> 1 warning generated.
>
> Use the function added in commit 828cfa29093f ("drm/amdgpu: Fix amdgpu
> ras to ta enums conversion") that handles this conversion explicitly.
>
> Fixes: 4c461d89db4f ("drm/amdgpu: add RAS support for the gfx block of Arcturus")
> Link: https://github.com/ClangBuiltLinux/linux/issues/849
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>

Applied.  thanks!

Alex

> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_4.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4.c
> index e19d275f3f7d..f099f13d7f1e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4.c
> @@ -964,7 +964,7 @@ int gfx_v9_4_ras_error_inject(struct amdgpu_device *adev, void *inject_if)
>         if (!amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__GFX))
>                 return -EINVAL;
>
> -       block_info.block_id = info->head.block;
> +       block_info.block_id = amdgpu_ras_block_to_ta(info->head.block);
>         block_info.sub_block_index = info->head.sub_block_index;
>         block_info.inject_error_type = amdgpu_ras_error_to_ta(info->head.type);
>         block_info.address = info->address;
> --
> 2.25.0
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
