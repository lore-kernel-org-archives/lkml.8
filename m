Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9989DC3F2D1
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 04:43:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 595232146E
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 04:43:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Jlh/X/YE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725946AbgCEEna (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 23:43:30 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:40047 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725861AbgCEEn3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 23:43:29 -0500
Received: by mail-lj1-f195.google.com with SMTP id 143so4516316ljj.7
        for <linux-kernel@vger.kernel.org>; Wed, 04 Mar 2020 20:43:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0ig10XyduVsZjw4w3HMmJwxDdosoLr+guVyiHfv8gK0=;
        b=Jlh/X/YEDONR3IOXn6nxoGLEnIeUJ3iyKiyAQ8f2QzEuxov1wR2zT1eYqvUS/AYq5F
         9xHKaOXV0yEACS/FXpwgnh2EKdpPwjrEPNNO38PqKTEuWZ+CgHMEwxD+HkI/LrROg0hB
         YR3i/KCqEdPBTwRaDSSs6L8tGCWX06xKdweZavMUm33yUpnoFnrH4RYiYlcaChAFOVvZ
         KMPno2mNmtNw9VAltjQmUnFMUWGuvmu27lO9GnhA3PQ9MW/a3wqk5feEPtyUZOVBJWrn
         cSfYJGa9xuYJA+pyDxU4wQ67Y1qe43jCIoAmUSBHTThkEO5AzWYbhrpNVcYGxEe+uP/M
         Dk9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0ig10XyduVsZjw4w3HMmJwxDdosoLr+guVyiHfv8gK0=;
        b=eGF5pGkhqhTWNhlNK187HMT2eQ6Y7epW+9JDsq2r73lhK3ehArqYum5kfiJQQcSJm5
         lcnQO1YvkZivDDFNqyDyLruJn4WL3jTL4b83QMQ00+1N8dJVidcJD1FZMkIvxKxTxOK7
         xulXcq/86JlvrSb3BB4fHnBgQcqb4c+i++hdnlwkjBzT3R1GKCuP53gk0TbgxB8TZidB
         xk/e4XohjPSt/NlzAxL/KQHBg5BdbMhxadA5wSDb+4DKAv6rauT/LHmBP7ykdxCO8gDe
         xVUjVN3wiXp8eVehHyNgKnjsTU5PTtew0qKRT3l4Pq9U1rZfoAV1Lb4enKWQXvSbeA0v
         DnFg==
X-Gm-Message-State: ANhLgQ3E9zyjm3GQt3SJvixW8+0prxw9cGihVybWeO4ChMpVaeMrZIsO
        remt3VjteZKkXh4RJvezH/FzhWkj3waSS6x/UoRg5Ai1gFA=
X-Google-Smtp-Source: ADFU+vsdtsIPN/hjdmMTRmXabwL436fmEFM1KY5oGBIXd3XKcqkjLBih3S1oNvDRDLlp88m5djXZztpTsxX2PHnpxUg=
X-Received: by 2002:a05:651c:147:: with SMTP id c7mr3817550ljd.206.1583383407161;
 Wed, 04 Mar 2020 20:43:27 -0800 (PST)
MIME-Version: 1.0
References: <20200304211254.5127-1-lukas.bulwahn@gmail.com>
In-Reply-To: <20200304211254.5127-1-lukas.bulwahn@gmail.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Thu, 5 Mar 2020 10:13:15 +0530
Message-ID: <CAFA6WYOfLONAM8qAhpiikrGkmDkLq0qcw_eGUTzG1AdgP0TB+w@mail.gmail.com>
Subject: Re: [PATCH v2] MAINTAINERS: adjust to trusted keys subsystem creation
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

On Thu, 5 Mar 2020 at 02:43, Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
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
> files in security/keys/ are identified as part of KEYS-TRUSTED.
>

I guess you meant here security/keys/trusted-keys/ instead of security/keys/.

-Sumit

> Co-developed-by: Sebastian Duda <sebastian.duda@fau.de>
> Signed-off-by: Sebastian Duda <sebastian.duda@fau.de>
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
> Changes to v1:
> - use a global pattern for matching the whole security/keys/ directory.
> Sumit, please ack.
> James or Jarkko, please pick this patch v2.
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
