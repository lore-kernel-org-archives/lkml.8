Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2144C3F2D1
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 17:13:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA95B21775
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 17:13:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QYElvh60"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730000AbgCDRN5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 12:13:57 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:32837 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729978AbgCDRN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 12:13:57 -0500
Received: by mail-io1-f67.google.com with SMTP id r15so3271459iog.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Mar 2020 09:13:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4gG3qMsij+Zo/aEE0RJ5aXLnI0RJBhpPpMw/2lBOTbU=;
        b=QYElvh60Cyyn7Y11uZwaVwCuwHUF2lUxPZZFVwXIyOoPle1lfUfdIGhc0pVks7+RrN
         WSlaQacGeMOUoXrTP7pW88wNBfAN9wlCFUj4pvq0RHRtFZf9t9vByx9lZKHPFhA2m9Jj
         JfjAsKvvf+MfcFnD+IMJbV0C4HJonC5kGkJ5/u9yeuEwNBL506h+MOiJ2ed3579CTVlg
         PXndErOXThORJ6OOckQpkShznq7uU5mOapRDuLejjvmLWOA7cB81NTnC+YTfLaDMLvXt
         +CQ67q5o8KfwknVXcRpaHGSuSgXciyyCmzX7FpPl0F0KM9b214VsOIIW8pUV+b4jEjUl
         de9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4gG3qMsij+Zo/aEE0RJ5aXLnI0RJBhpPpMw/2lBOTbU=;
        b=EvfExTlnPvbnVhPNsarWjIbEBQdcA3SOzCCNk/MrhHT213o7a1JjTgVkUN1RiXiZbs
         v5Ew6i3pNa0VwNuQZ00CcGXYxcVlKLizsx71PWBsdXmeHKUD5JaJGjAKaXMjrdIsXkEz
         eDs34H1+kCymRGUcDwurJN8ChXn1Bh9PBAABvv1GbKpvTW99NNLw+ejnp5jZ+LH8IIJI
         DS2X2Vr/0lLk48R8TOHhXPZD3ChXzitske0JpYzKIJEu+0xLBFoHIzpa28aBHhyH8E3F
         Ey7lOqO6tWWp21u+o4fqKnx3CUf11VSvfDl8JCsgl+pciVDttxxrCwtiLaYD2lBSuMTC
         1oUQ==
X-Gm-Message-State: ANhLgQ3jICdhnJ+AkK0d22tl1zb9LyFTxstot0gbOb5HSL7vMr9fXs3z
        pZxc3djDmNVuuChRkNVKp4VbORv7c9e6xgLcjT1W3A==
X-Google-Smtp-Source: ADFU+vuOPyKswOKZ61JIBgIoF+EANBFdB2xJk1AnRf0YUvp8KcQ7eG7l91fFfZagGVEMzsrhnPlGrjJNth+JpCUF/ic=
X-Received: by 2002:a6b:8b8c:: with SMTP id n134mr2899306iod.58.1583342036746;
 Wed, 04 Mar 2020 09:13:56 -0800 (PST)
MIME-Version: 1.0
References: <20200302213402.9650-1-natechancellor@gmail.com>
In-Reply-To: <20200302213402.9650-1-natechancellor@gmail.com>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Wed, 4 Mar 2020 10:13:45 -0700
Message-ID: <CANLsYkz_kh2BWoVy-YervDTRWUT+p8M+-_vUrsu--WF3fjDBPQ@mail.gmail.com>
Subject: Re: [PATCH] coresight: cti: Remove unnecessary NULL check in cti_sig_type_name
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 Mar 2020 at 14:34, Nathan Chancellor <natechancellor@gmail.com> wrote:
>
> Clang warns:
>
> drivers/hwtracing/coresight/coresight-cti-sysfs.c:948:11: warning:
> address of array 'grp->sig_types' will always evaluate to 'true'
> [-Wpointer-bool-conversion]
>         if (grp->sig_types) {
>         ~~  ~~~~~^~~~~~~~~
> 1 warning generated.
>
> sig_types is at the end of a struct so it cannot be NULL.
>
> Fixes: 85b6684eab65 ("coresight: cti: Add connection information to sysfs")
> Link: https://github.com/ClangBuiltLinux/linux/issues/914
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>  drivers/hwtracing/coresight/coresight-cti-sysfs.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/hwtracing/coresight/coresight-cti-sysfs.c b/drivers/hwtracing/coresight/coresight-cti-sysfs.c
> index abb7f492c2cb..214d6552b494 100644
> --- a/drivers/hwtracing/coresight/coresight-cti-sysfs.c
> +++ b/drivers/hwtracing/coresight/coresight-cti-sysfs.c
> @@ -945,10 +945,8 @@ cti_sig_type_name(struct cti_trig_con *con, int used_count, bool in)
>         int idx = 0;
>         struct cti_trig_grp *grp = in ? con->con_in : con->con_out;
>
> -       if (grp->sig_types) {
> -               if (used_count < grp->nr_sigs)
> -                       idx = grp->sig_types[used_count];
> -       }
> +       if (used_count < grp->nr_sigs)
> +               idx = grp->sig_types[used_count];
>         return sig_type_names[idx];
>  }

Applied - thanks,
Mathieu

>
> --
> 2.25.1
>
