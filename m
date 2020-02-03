Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFE02C3F68F
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 09:48:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C6D720842
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 09:48:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580723286;
	bh=/YnR0gNee/udTt/+8UwpBt6xjr3OsBiOajv2a3BGgO4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Y4X1uCDUSKhlCfh4AMTuH9Dwk5mib6trPwD7P9Zeje7ufa2oaiEIrw2FMV8ePXyIN
	 ji7RDf/7202As+9HwNyYNqcMwfbDfolYayHEHQg6ZDEhz4RyK1qHrdWQDBH4tN0v5N
	 dJr4V2GTOWWc06C0U5vOcLI9MwqdIfbrvkCoyIlk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727970AbgBCJsG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 04:48:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:40068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727225AbgBCJsF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 04:48:05 -0500
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1AACD20721;
        Mon,  3 Feb 2020 09:48:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580723285;
        bh=/YnR0gNee/udTt/+8UwpBt6xjr3OsBiOajv2a3BGgO4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=IGuBirssdtgzyD0dn1VavC3zT28Cbe+sKG4ESV6NuyNFN8LSN9NVOLF6jfdd2hAhh
         s31phKhRFOt4v/lftV4lOpepsQ1xhidNWSK/FqO5CG78XE3AZ38wMm7K9oMMl7iVRJ
         aujnLbkhDGnQOEt7xevrs5MlvS1kotd4oSoq0xKk=
Received: by mail-qt1-f180.google.com with SMTP id c24so10932536qtp.5;
        Mon, 03 Feb 2020 01:48:05 -0800 (PST)
X-Gm-Message-State: APjAAAVQwtwdEt8UrySUz3mQwOKuF/AKdtlBTQK8ig6d4hCt2D5KJRZQ
        6fZJCRBpivbHS4MKMTC1kDgky6GqfKipwz1pYw==
X-Google-Smtp-Source: APXvYqxrmmcnfXw+ftAZK0AeZXfN2/SIkqjT9bA6aObc2yIfmHHIvH662w6kA5cQ78pG9DxWcntHxLcYZCyspZIK6XE=
X-Received: by 2002:ac8:1415:: with SMTP id k21mr23019321qtj.300.1580723284238;
 Mon, 03 Feb 2020 01:48:04 -0800 (PST)
MIME-Version: 1.0
References: <20200202043949.213427-1-swboyd@chromium.org>
In-Reply-To: <20200202043949.213427-1-swboyd@chromium.org>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 3 Feb 2020 09:47:53 +0000
X-Gmail-Original-Message-ID: <CAL_Jsq+tU8--9C065qPb9bvN5X=edJtD6Q6XjkS71k1S-hVHrQ@mail.gmail.com>
Message-ID: <CAL_Jsq+tU8--9C065qPb9bvN5X=edJtD6Q6XjkS71k1S-hVHrQ@mail.gmail.com>
Subject: Re: [PATCH v2] dt-bindings: tpm: Convert cr50 binding to YAML
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, Andrey Pronin <apronin@chromium.org>,
        Douglas Anderson <dianders@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 2, 2020 at 4:39 AM Stephen Boyd <swboyd@chromium.org> wrote:
>
> This allows us to validate the dt binding to the implementation. Add the
> interrupt property too, because that's required but nobody noticed when
> the non-YAML binding was introduced.
>
> Cc: Andrey Pronin <apronin@chromium.org>
> Cc: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>
> Changes from v1:
>  * Dropped spi-max-frequency as required
>  * Capped spi-max-frequency at 1MHz
>  * Added interrupt-parent to example to be realistic
>
>  .../bindings/security/tpm/google,cr50.txt     | 19 -------
>  .../bindings/security/tpm/google,cr50.yaml    | 50 +++++++++++++++++++
>  2 files changed, 50 insertions(+), 19 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/security/tpm/google,cr50.txt
>  create mode 100644 Documentation/devicetree/bindings/security/tpm/google,cr50.yaml

Reviewed-by: Rob Herring <robh@kernel.org>
