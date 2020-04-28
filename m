Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 470B1C83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 20:42:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 218D32085B
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 20:42:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oGKoYPHs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbgD1UmK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 16:42:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726180AbgD1UmJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 16:42:09 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 299F3C03C1AB
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 13:42:09 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id u15so193564ljd.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 13:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5CNxMxqrQ2+AsMwJGB1pKLyTKTfhWImCVydgeMhIOQo=;
        b=oGKoYPHsBGrK71vBETwyLtE+ZEMGm6BJ0HHklgI3BlCjJ9XhrdJBup6YWIM3+c2s28
         JV+wa93/eRibgu56pkBRM199/ie29TQSPu6UrEd9QAEvWaWUhfGtR+gT/n85VOpmrkHy
         KMnEDBAbG/KzA2HIeXL3DOwGSNm6i0iJfz/bYmNtBjeVcG3wbWVtnERX78JEgQfSvyl1
         +Ij41dDmUl3t4MFbZrvK/RL+OGfmn6pxumZ9r0LfzfHB7C+uW7RzCbCNDjCjfraCE/Ie
         D2ddWfhKoRV4Nz1QK157PK25kx4jh737gI/CEI45Dcb71nHfIPYY5TDMXmUmmkOo3ixQ
         NURw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5CNxMxqrQ2+AsMwJGB1pKLyTKTfhWImCVydgeMhIOQo=;
        b=PfyjvLYq0l6JkdUNrYbYB5cE0VTjck6nsTpnSDom79ZB6BQSd/H5IO63NYBWWDrz+5
         Kwo2WZLu1O6e/L47vXtKNT/+st2Y/VQXfFWcrR5awgVGPypJs0Md1Hvq7sjZZ+MwBtO9
         vMXpoogEWnpXUa9Lxqlhgh5QgruqhdeLqGdohdlO9zvecr+TuSWPlqPN9EsPrQXUpMVH
         5HKJK0WfSXU7wRKFAdfz+BNF8D3alvrfQUuXSuwZeFYqThdDMxcPt48sujhCP9g0DLDT
         EJZpXGjA6gazQnCoAhQqReee6uTVKpXlH/DaABC+TgNYqdFGvqRxFjTydRm9ClzXoGdl
         MphA==
X-Gm-Message-State: AGi0Pua4K3Fhk3Cjm2iVotThGkMBrGJHKjZRC3UgbaOjJ7juT6N/18hC
        ES95vSwI/FMmfEW9ow6jiTFc2DLBOKsqQ44UakXyWw==
X-Google-Smtp-Source: APiQypJ5pIHbkCqfVz5L1aiKRMLi9O1XUE3R6yzYVvTsDb3wTGgHiyurRr9DkLx9o91LXp8Xnv3/l4XhFecWJaaTFQ4=
X-Received: by 2002:a2e:2ac2:: with SMTP id q185mr9906041ljq.125.1588106527607;
 Tue, 28 Apr 2020 13:42:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200424154103.10311-1-zhengdejin5@gmail.com> <20200424154103.10311-3-zhengdejin5@gmail.com>
In-Reply-To: <20200424154103.10311-3-zhengdejin5@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 28 Apr 2020 22:41:56 +0200
Message-ID: <CACRpkdYw3r9JSPuPx3zSA45s6LdFtR6K=6hGoXW_UP=4jvpY-Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] gpio: mm-lantiq: Fix small typo
To:     Dejin Zheng <zhengdejin5@gmail.com>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 24, 2020 at 5:41 PM Dejin Zheng <zhengdejin5@gmail.com> wrote:

> Fix a spelling typo in gpio-mm-lantiq.c by codespell
> s/dont/don't/
>
> Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
> Signed-off-by: Dejin Zheng <zhengdejin5@gmail.com>
> ---
> v1 -> v2:
>         - split patch v1 (only one patch) into patches for each driver
>           by Bartosz's suggestion. thanks Bartosz.

Patch applied.

Yours,
Linus Walleij
