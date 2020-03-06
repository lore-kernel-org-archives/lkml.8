Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4EDEC3F2CD
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 05:03:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D3472073D
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 05:03:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E8lu+LYm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725935AbgCFFDi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 00:03:38 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:45916 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725847AbgCFFDi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 00:03:38 -0500
Received: by mail-lj1-f195.google.com with SMTP id e18so780895ljn.12
        for <linux-kernel@vger.kernel.org>; Thu, 05 Mar 2020 21:03:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RgxoDxn7isDbqiNeMSbGlbVvXyla56aJBv3ggEco/PY=;
        b=E8lu+LYma2rUzzVLjzv803SdKxb/mmqJINwt+kVzCr50akNjAHIqfLHEHSq3AK1s0d
         LAeVE4fGwQilvoc6vLqK838TwlJt/87H8RzRJ944G1/fmdefzX5Bx9azRIREdMugAOag
         kjCTPr1fgB2tUoJ0L8gVAkYCrwQl/aePJLY/NsPQCuujnSbIfSXUXqZ5e3hTOUaDWYBK
         lNYiInm4uQH092xZHtXJ7YzVpqp4raUa6GMT+lPC7c23ucBCxjqje/4KrDK6dzYOfZb8
         ZuUswKlrv5Fm9ZKOTVijKvnboDaKsCIVP3r93Bv7/OKFjjlQge9aBkyldBOQPusQ+cp7
         jfcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RgxoDxn7isDbqiNeMSbGlbVvXyla56aJBv3ggEco/PY=;
        b=Vyd02lkDUdRXbnOxhyHFanJZCa//X5m2jb1caeDr/Jgfguo+4QC4S8uoCOlGQ+3wC5
         dYzLyA5t6lmAryiBm0y1HlFdg7T3oO4JlWZ+Ei6vPp2yW9Q0oK0h81SyyNqzdE/zORkC
         rD+aqeOjI0SFDhtl2i4yZiPXM62zfrlGX1UhBZYK5NZQf5chH3A4cYPSjJlSg2bD31+V
         6DZ50R3GMIHXCEVqEsCIbK4J+EkEeTaE/QJgtxGxC2c8awvNlJaZgi3jlSfKhN/X01CQ
         te6ohd+PT077ApacJi4aCXLFPBECSx12WcbWf3h/tGFM0PbaOF82bEOA3rA6cQxXp5EC
         dK4w==
X-Gm-Message-State: ANhLgQ17z3kRJxhDHabcwk2J8TpGyRIZnJl0ByyFQGflZL97j3IgrQDw
        dis9h0LjYv2tPcv1OBv+hrt4784z6IDqWMddcR3gvg==
X-Google-Smtp-Source: ADFU+vvo+v3/q5o96URjltWMa+waAoKpdkS+W4orQ4VsY+8ZNMYwVfoC3c1NvIDuXdbsm+Ka3CE7nGsanb6MvI++Jng=
X-Received: by 2002:a2e:9910:: with SMTP id v16mr878221lji.281.1583471015683;
 Thu, 05 Mar 2020 21:03:35 -0800 (PST)
MIME-Version: 1.0
References: <20200305203013.6189-1-lukas.bulwahn@gmail.com>
In-Reply-To: <20200305203013.6189-1-lukas.bulwahn@gmail.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Fri, 6 Mar 2020 10:33:24 +0530
Message-ID: <CAFA6WYOUbacZtMEUuhhTwsVJ7RbQu08a2=-LJfczzbZsyxuOBQ@mail.gmail.com>
Subject: Re: [PATCH v3] MAINTAINERS: adjust to trusted keys subsystem creation
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     James Bottomley <jejb@linux.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        linux-integrity@vger.kernel.org,
        "open list:ASYMMETRIC KEYS" <keyrings@vger.kernel.org>,
        Sebastian Duda <sebastian.duda@fau.de>,
        Joe Perches <joe@perches.com>, kernel-janitors@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Mar 2020 at 02:00, Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
>
> Commit 47f9c2796891 ("KEYS: trusted: Create trusted keys subsystem")
> renamed trusted.h to trusted_tpm.h in include/keys/, and moved trusted.c
> to trusted-keys/trusted_tpm1.c in security/keys/.
>
> Since then, ./scripts/get_maintainer.pl --self-test complains:
>
>   warning: no file matches F: security/keys/trusted.c
>   warning: no file matches F: include/keys/trusted.h
>
> Rectify the KEYS-TRUSTED entry in MAINTAINERS now and ensure that all
> files in security/keys/trusted-keys/ are identified as part of
> KEYS-TRUSTED.
>
> Co-developed-by: Sebastian Duda <sebastian.duda@fau.de>
> Signed-off-by: Sebastian Duda <sebastian.duda@fau.de>
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>

Acked-by: Sumit Garg <sumit.garg@linaro.org>

> ---
> Changes to v1:
>   - use a global pattern for matching the whole security/keys/trusted-keys/
>     directory.
> Changes to v2:
>   - name the correct directory in the commit message
>
> Sumit, please ack.
> Jarkko, please pick this patch v3.
>
>  MAINTAINERS | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 5c755e03ddee..7f11ac752b91 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9276,8 +9276,8 @@ L:        keyrings@vger.kernel.org
>  S:     Supported
>  F:     Documentation/security/keys/trusted-encrypted.rst
>  F:     include/keys/trusted-type.h
> -F:     security/keys/trusted.c
> -F:     include/keys/trusted.h
> +F:     include/keys/trusted_tpm.h
> +F:     security/keys/trusted-keys/
>
>  KEYS/KEYRINGS
>  M:     David Howells <dhowells@redhat.com>
> --
> 2.17.1
>
