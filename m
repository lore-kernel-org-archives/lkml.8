Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A97CEC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 18:18:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85C4820714
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 18:18:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tQULf6iR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727609AbgCXSSn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 14:18:43 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:38521 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727310AbgCXSSn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 14:18:43 -0400
Received: by mail-ua1-f66.google.com with SMTP id h35so6707317uae.5
        for <linux-kernel@vger.kernel.org>; Tue, 24 Mar 2020 11:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b8cHeEED3Z92a0ymNocC1wM2oY7nKh155USjPtUlk8U=;
        b=tQULf6iRNPtrwhWnpGrNRTC/RGfpdVv1KzNlJastPZALMPGl3mbmj1KkNDkkpF5Mxy
         lixTfrHNpsLM/X4FT9RkxlwmOS3LM/DO+X9aOaor10FOcK6r83pC3mbA+oy2nG2fMr9Z
         TSWgNKpSo4u0YGxvblpb7nv5keNyk+HW7/FiZC+ngRb8+MkN+mzP3tFATaolDmwakHxG
         KD8BsH3xzd9yKISmVML8u6OOOFaTQE7e1jRzcmtFV4xbTa8VcUitt4ddiz6OTA1aCToN
         5/UVt4DhilfXkDTi+MLVQ2VXDWoDB/pDK661FdUgmUssNmKOQ/ACrDQieWFmixwIh8fZ
         Adaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b8cHeEED3Z92a0ymNocC1wM2oY7nKh155USjPtUlk8U=;
        b=MNUky4bA1gVf8zKqZ+jeobkS9A+OkRzB50+g+CSelvjT5DtoRTtU/EoVxzai3mNvP3
         usXyzkNNtNaCcs6DHe3Z13MEVT8/MPFp5wx4SbYza5MGUB49GHep4y36NdpkYpdGuk1n
         FdDByQyLQM4uKfYd2OpnVhy+c2bNkWakvI9X4AYkvWaRz24d9sZmL4Y49fOvpBkDqqTY
         tlaHVUCjbkfRXtekKScGaVuwQD/NFN9zoRd5i0wi1UjwCQh0PIVoY3kymMwO/t9GRKgy
         f13HINBvY4LYNyledre//H4I4nFgtkPHQcJSLTXCMjzHAlLeC/cmTGg7AhMCr24H2RfD
         RrNw==
X-Gm-Message-State: ANhLgQ3hn96OLtHugSxnaVUtd6wa9XqWF8zRrZAcRF6xsbTH16y3DSCr
        JWg3j+RrxJWPQL2kaQQpZ0cjC2MlxF5TI6xOXiypoQ==
X-Google-Smtp-Source: ADFU+vvlSyqmWv0VfXpmbCrbzrodCyzdctPb60GOiITOQ8IyBRoVME1UEIqwWvolQznE5P1J/DvCNwQi1YMBK+tDF/4=
X-Received: by 2002:ab0:7556:: with SMTP id k22mr8587224uaq.104.1585073921836;
 Tue, 24 Mar 2020 11:18:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200324041526.GA1978@asgard.redhat.com>
In-Reply-To: <20200324041526.GA1978@asgard.redhat.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 24 Mar 2020 19:18:05 +0100
Message-ID: <CAPDyKFqEQZU=xSKX8_D3a7JQ7rRKXP8Yq8wwq9j=YYGQsWv4-w@mail.gmail.com>
Subject: Re: [PATCH] drivers: firmware: psci: avoid BIT() macro usage in PSCI_1_0_OS_INITIATED
To:     Eugene Syromiatnikov <esyr@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        "Dmitry V. Levin" <ldv@altlinux.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Mar 2020 at 05:15, Eugene Syromiatnikov <esyr@redhat.com> wrote:
>
> The BIT() macro is not available in UAPI headers, so let's replace
> it with similarly defined _BITUL() macro provided by <linux/const.h>.
>
> Fixes: 60dd1ead65e8 ("drivers: firmware: psci: Announce support for OS initiated suspend mode")
> Signed-off-by: Eugene Syromiatnikov <esyr@redhat.com>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>  include/uapi/linux/psci.h | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/include/uapi/linux/psci.h b/include/uapi/linux/psci.h
> index 2fcad1d..87afdeb 100644
> --- a/include/uapi/linux/psci.h
> +++ b/include/uapi/linux/psci.h
> @@ -12,6 +12,8 @@
>  #ifndef _UAPI_LINUX_PSCI_H
>  #define _UAPI_LINUX_PSCI_H
>
> +#include <linux/const.h>
> +
>  /*
>   * PSCI v0.1 interface
>   *
> @@ -100,7 +102,7 @@
>  #define PSCI_1_0_FEATURES_CPU_SUSPEND_PF_MASK  \
>                         (0x1 << PSCI_1_0_FEATURES_CPU_SUSPEND_PF_SHIFT)
>
> -#define PSCI_1_0_OS_INITIATED                  BIT(0)
> +#define PSCI_1_0_OS_INITIATED                  _BITUL(0)
>  #define PSCI_1_0_SUSPEND_MODE_PC               0
>  #define PSCI_1_0_SUSPEND_MODE_OSI              1
>
> --
> 2.1.4
>
