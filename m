Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLACK autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E91CC43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 03:44:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45EBA20719
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 03:44:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585194281;
	bh=VkmY0zQuX833GQpUGXaOUmvjdZ0nnkB4ejNGiO5v5uU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=nRiNPhbamPSIskN5FK1Ps+yBY18bpdeYxuUPlMFKX7LHkVnw2vWluzFUmsSED8CrZ
	 UYK0O174+kKEqlbOCGqn8KvpwvLTZi0VXy/qIV3TgD1qtQdPXezJQpBzWF/IQyFkNR
	 CnUel4O7Z/0hDQrVYCpi5YrZC+RhJXofWCPzYRzo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727683AbgCZDok (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 23:44:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:59574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727636AbgCZDoj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 23:44:39 -0400
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 985BE20838
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 03:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585194278;
        bh=VkmY0zQuX833GQpUGXaOUmvjdZ0nnkB4ejNGiO5v5uU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=OdeBbNi0UFE6Xf5r9lnfVQhuzp+a/BFXy/IQWDQURZ4DuY9gq+dbEoACf45IaIlCz
         Iq/SLbxgvTZZrQjifMGcmOZ5WJ1yxvDZoqcPVk/JTIHOdDqwzt0TWnKwG9FErPLnjv
         0BMWgiPP8VxMl+NAz3cpZWsYBpwjnBXYv+1nyUTQ=
Received: by mail-wr1-f50.google.com with SMTP id p10so6070321wrt.6
        for <linux-kernel@vger.kernel.org>; Wed, 25 Mar 2020 20:44:38 -0700 (PDT)
X-Gm-Message-State: ANhLgQ0XydzChmU1H7q2LeIXgiKrIZmwr407xowSURSi4l8et95nCkHb
        WzAuYb+AgPslGLpIQrlXuDC32y94/L1qx6y1v+rLnA==
X-Google-Smtp-Source: ADFU+vv0yft2oB0j81+Zpu1bdr8nwdQ3WjfpxQeoXpDnIznLh+VXYsHbOtp609GnoW6l+6LfrrAvNy4IRPTIME3mY5k=
X-Received: by 2002:adf:9dc6:: with SMTP id q6mr6773133wre.70.1585194276996;
 Wed, 25 Mar 2020 20:44:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200325194317.526492-1-ross.philipson@oracle.com> <20200325194317.526492-4-ross.philipson@oracle.com>
In-Reply-To: <20200325194317.526492-4-ross.philipson@oracle.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Wed, 25 Mar 2020 20:44:25 -0700
X-Gmail-Original-Message-ID: <CALCETrUoA9dgi2omjePtzjL9=5AqHKhy57UksnxbohZVdLo_pQ@mail.gmail.com>
Message-ID: <CALCETrUoA9dgi2omjePtzjL9=5AqHKhy57UksnxbohZVdLo_pQ@mail.gmail.com>
Subject: Re: [RFC PATCH 03/12] x86: Add early SHA support for Secure Launch
 early measurements
To:     Ross Philipson <ross.philipson@oracle.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        dpsmith@apertussolutions.com, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, trenchboot-devel@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 25, 2020 at 12:43 PM Ross Philipson
<ross.philipson@oracle.com> wrote:
>
> From: "Daniel P. Smith" <dpsmith@apertussolutions.com>
>
> The SHA algorithms are necessary to measure configuration information into
> the TPM as early as possible before using the values. This implementation
> uses the established approach of #including the SHA libraries directly in
> the code since the compressed kernel is not uncompressed at this point.
>
> The SHA1 code here has its origins in the code in
> include/crypto/sha1_base.h. That code could not be pulled directly into
> the setup portion of the compressed kernel because of other dependencies
> it pulls in. So this is a modified copy of that code that still leverages
> the core SHA1 algorithm.
>
> Signed-off-by: Daniel P. Smith <dpsmith@apertussolutions.com>
> ---
>  arch/x86/Kconfig                        |  24 +++
>  arch/x86/boot/compressed/Makefile       |   4 +
>  arch/x86/boot/compressed/early_sha1.c   | 104 ++++++++++++
>  arch/x86/boot/compressed/early_sha1.h   |  17 ++
>  arch/x86/boot/compressed/early_sha256.c |   6 +
>  arch/x86/boot/compressed/early_sha512.c |   6 +
>  include/linux/sha512.h                  |  21 +++
>  lib/sha1.c                              |   4 +
>  lib/sha512.c                            | 209 ++++++++++++++++++++++++
>  9 files changed, 395 insertions(+)
>  create mode 100644 arch/x86/boot/compressed/early_sha1.c
>  create mode 100644 arch/x86/boot/compressed/early_sha1.h
>  create mode 100644 arch/x86/boot/compressed/early_sha256.c
>  create mode 100644 arch/x86/boot/compressed/early_sha512.c
>  create mode 100644 include/linux/sha512.h
>  create mode 100644 lib/sha512.c
>
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 7f3406a9948b..f37057d3ce9f 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -2025,6 +2025,30 @@ config SECURE_LAUNCH
>           of all the modules and configuration information used for
>           boooting the operating system.
>
> +choice
> +       prompt "Select Secure Launch Algorithm for TPM2"
> +       depends on SECURE_LAUNCH
> +
> +config SECURE_LAUNCH_SHA1
> +       bool "Secure Launch TPM2 SHA1"
> +       help
> +         When using Secure Launch and TPM2 is present, use SHA1 hash
> +         algorithm for measurements.
> +

I'm surprised this is supported at all.  Why allow SHA1?
