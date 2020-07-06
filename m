Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 775E8C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 13:50:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45A1B2070C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 13:50:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ptGYskGv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729165AbgGFNuk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 09:50:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728961AbgGFNuk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 09:50:40 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE69FC061755
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jul 2020 06:50:39 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id y18so22603941lfh.11
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jul 2020 06:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=bZa4D2WVaPlaakSVKPmHAJSxY8fXE4lQvmGAH+tBorA=;
        b=ptGYskGv1m95IZBNJzIfZnin0DxW2ky4zsTAvaGQ7qCdVYqxtkWr3YkNMJk00OU6jl
         rjKibEAOvR21dG93X0GtNYsFXtdyCoswPKAWlXqg2qf9GnSLKRldJRdkeOi2FdbkZ/Qx
         oBmxb+zeaFCaQBqDONAmIphaLQdDp8JiZLLj4dNZr6UmY8/IvS5VTU7uzX0guza42Gem
         EbPFPQQuDDIow4BRrJRDptF5BQQbJ8x6mVhfZ2c1LlG0UxYRjJP+7WS7YrjND9Fu8SGM
         edJ1njN1w1Jdvoye53BRFDo6ju+wjPybEaRYR8Zi9JzZzYTe5v45cEWicsJMP9jH+KjG
         1azA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=bZa4D2WVaPlaakSVKPmHAJSxY8fXE4lQvmGAH+tBorA=;
        b=QGvcz8lc1ikEQPQZFbHX0jNOoRwMW45scP14qYgn5G9REqQWUxqzyhIfY5pRJnfdMW
         4LuojcVxwiIKZOn8yzicq48Bwy5ArGoDy5btVzvA3wEYgjlV3HHqQkZk6Mw6RBITy9m4
         6rhQHnbFP1PWPytsUuRqTungCIixF4yKNgX2l8a5IF6TLc/KmdOpCmYMEZvkBfbrPQhq
         kcJO8WfQtqKSNEbfJMxCMXN0hvPIj7orcg8m+p+ANs2c9wWJvF983cZprRnuC2FUJsZF
         GfbUrETvSEkr2ZHUFc/k+cEr7d7xY+Zd4MiUgT3o8hVgiuipyGoE6GafHDciV2WLP+u0
         +Kmw==
X-Gm-Message-State: AOAM532cuTIvNdyQZCQ+w1HkG+zFszpBScyhn1DlMa55MiYgaEFz0eh7
        dXgriqtQz7d+elFii2/s/aSdIwOSGWFn7YqkfMGTgg==
X-Google-Smtp-Source: ABdhPJyE/i5NtJKyl94ORQWnZwkdrc7UJFTX3szYTfRnZPwJk3XM4Xzi3d1UQ20PCIRJq2mGQ94KPFghCdzVZx15ftU=
X-Received: by 2002:a05:6512:3107:: with SMTP id n7mr30947798lfb.63.1594043438117;
 Mon, 06 Jul 2020 06:50:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200706133341.476881-1-lee.jones@linaro.org> <20200706133341.476881-27-lee.jones@linaro.org>
In-Reply-To: <20200706133341.476881-27-lee.jones@linaro.org>
From:   Jann Horn <jannh@google.com>
Date:   Mon, 6 Jul 2020 15:50:11 +0200
Message-ID: <CAG48ez3c98x7dEpKcSnhHKbHKfF6=XOdU5WGL8FtvdqsrYMNhg@mail.gmail.com>
Subject: Re: [PATCH 26/32] usb: early: xhci-dbc: Supply missing 'xhci-dbgp.h' headerfile
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-usb@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 6, 2020 at 3:34 PM Lee Jones <lee.jones@linaro.org> wrote:
> If the header file containing a function's prototype isn't included by
> the sourcefile containing the associated function, the build system
> complains of missing prototypes.
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  drivers/usb/early/ehci-dbgp.c: In function =E2=80=98early_dbgp_write=E2=
=80=99:
>  drivers/usb/early/ehci-dbgp.c:915:13: warning: variable =E2=80=98ret=E2=
=80=99 set but not used [-Wunused-but-set-variable]
>  915 | int chunk, ret;
>  | ^~~
>  drivers/usb/early/xhci-dbc.c:600:12: warning: no previous prototype for =
=E2=80=98early_xdbc_parse_parameter=E2=80=99 [-Wmissing-prototypes]
>  600 | int __init early_xdbc_parse_parameter(char *s)
>  | ^~~~~~~~~~~~~~~~~~~~~~~~~~
>  drivers/usb/early/xhci-dbc.c:653:12: warning: no previous prototype for =
=E2=80=98early_xdbc_setup_hardware=E2=80=99 [-Wmissing-prototypes]
>  653 | int __init early_xdbc_setup_hardware(void)
>  | ^~~~~~~~~~~~~~~~~~~~~~~~~
>  drivers/usb/early/xhci-dbc.c:910:13: warning: no previous prototype for =
=E2=80=98early_xdbc_register_console=E2=80=99 [-Wmissing-prototypes]
>  910 | void __init early_xdbc_register_console(void)
>  | ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> Cc: Jann Horn <jannh@google.com>
> Cc: Lu Baolu <baolu.lu@linux.intel.com>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Reviewed-by: Jann Horn <jannh@google.com>
