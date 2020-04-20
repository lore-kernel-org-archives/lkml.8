Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68C24C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 07:34:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4376820BED
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 07:34:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pAtkxvUG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726055AbgDTHeb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 03:34:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725994AbgDTHeb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 03:34:31 -0400
Received: from mail-ua1-x943.google.com (mail-ua1-x943.google.com [IPv6:2607:f8b0:4864:20::943])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43F3BC061A10
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 00:34:31 -0700 (PDT)
Received: by mail-ua1-x943.google.com with SMTP id c24so3228125uap.13
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 00:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=opCQWgYuAFYxLdRztezYqwdg+lsU+kLFUGlLQxUPDrg=;
        b=pAtkxvUGU+urLdOoGr0lXgvyKlRl16BlV9bPojdE8r0nGdNQq0Sf8j3kDMPzqsRTNX
         /LFbidWy/e3DGc29eEF6nu6yj59jxfAxBjHAb2EgMa+bg+B48EiqCITZNUxpRSsLnMrT
         1pAPf2rlHJV8chg1gtTC1AdvdJrNEq9jnheHYXDf0XqoLc1k7T/9W8DO+0mdau7N8LYG
         DLjtMznlnI3ljgsnfWjLUkhC+8JsNwrM8EnL6vcMmUgkJr/2MQGjDEJQS8mgEpIeVW0x
         b34kleywutIxcGdICiWzOZaLbd2j2BLBRJKRpKtHFv0Q+/EHjk5AYIBWRS5G/u16KQBh
         z7zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=opCQWgYuAFYxLdRztezYqwdg+lsU+kLFUGlLQxUPDrg=;
        b=GNYnappPQVa5+G/EC98p35ONM416y2KWe530y/d3+/K0diZaP2GgsmUXyRDKQPzNsG
         fNMJWNionP+3koxvv8ScvxPDo/E+OlyfZDWXa07FAy+fkkSfoyfGLX7Jz/T0uS90T9n4
         FJrctUijhydIRjGAcnZ1ZrXWE5+eGng1G3XXydHdoCQpnRDfb5/Jj95DFPxMTPC6Wvbh
         Dk6lwK5wY/MjZPjkeZWmSqTNU6KaRjq5JFbRy47MPVf8nuUoj96cYF3CQnKxQe+xn+W3
         hYokyigK0d3o1E6mG4AZRUFNHMd3pLtQ9cJfteJvLZZG+NchhkdXxCXK7Z0aOntHaHPJ
         qEow==
X-Gm-Message-State: AGi0PubVFOLOWpbpO9Hf4NDGa2lYI49WHerzSYWlCA/5sfvYolM7onkE
        UAhiUiGKXc5zYptryX0iSsZwJZpDZVWgJYIqH6VOhA==
X-Google-Smtp-Source: APiQypIP0+2cZRffzlocpbxn2ONEPkD5ue7l25ETDalvg1y0d5aVMpH/wBvI56nsmtEm2deJhKL1tD2ouDEFeELmEvY=
X-Received: by 2002:ab0:3343:: with SMTP id h3mr272200uap.19.1587368070353;
 Mon, 20 Apr 2020 00:34:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200417154901.112236-1-colin.king@canonical.com>
In-Reply-To: <20200417154901.112236-1-colin.king@canonical.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 20 Apr 2020 09:33:54 +0200
Message-ID: <CAPDyKFocu+ckJE5WpMWuNTMJiwkfgQ4Ha-AXCF4mRJKMrhFa0A@mail.gmail.com>
Subject: Re: [PATCH][next] sdhci: arasan: fix uninitialized value being
 returned as error code
To:     Colin King <colin.king@canonical.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Manish Narani <manish.narani@xilinx.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        kernel-janitors@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Apr 2020 at 17:49, Colin King <colin.king@canonical.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> Currently the error return value in variable ret is not being initialized
> and so a successful return path is returning a garbage value. Since ret
> is not being used the simple fix is just return 0 on a successful return.
>
> Addresses-Coverity: ("Uninitialized scalar variable")
> Fixes: f73e66a36772 ("sdhci: arasan: Add support for Versal Tap Delays")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Thanks for the patch, but this time I have already applied [1] an
earlier fix for it.

Kind regards
Uffe

[...]

[1] https://patchwork.kernel.org/patch/11493633/
