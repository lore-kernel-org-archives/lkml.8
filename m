Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75463C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 14:35:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55392206A2
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 14:35:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s0xFI8Ix"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726167AbgFCOfE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 10:35:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725986AbgFCOfD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 10:35:03 -0400
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6148DC08C5C0
        for <linux-kernel@vger.kernel.org>; Wed,  3 Jun 2020 07:35:03 -0700 (PDT)
Received: by mail-yb1-xb43.google.com with SMTP id u17so1191576ybi.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jun 2020 07:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DE4Qdo45tnQcrOP8BGlsXcR06aBEw4ALNvR7nQhQdtw=;
        b=s0xFI8Ixf1kEV+hot6DqwXAV1qRq58bZb6yVrWkiEy0SorN9zNWefznQLZQGcbGkOW
         +TD+U7tKHzloGnDAQ0eLYRu0PxsAUSN74VBQvS2PXS3otizdVG7pTfK672vYG7sevN8P
         YkOPceSwGvAOfSEcbOnYSg5E3/hup3mVwIMPOf9cJgPPmmF9hp6d0VKAV2+XEi7kgIhA
         5+PCdUf4TTdj6hl+TcdyFXdkd8ZGO1iNfB4+Dav8qMSdqzAggucZO5BVEFq/3w+tyguK
         t8ZMNMm+zg8k/glrglTudCCh9/RCO/WWUqsWcXD05vRfhOZp2HSC80AIBz0bv+OKQJ4B
         tnmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DE4Qdo45tnQcrOP8BGlsXcR06aBEw4ALNvR7nQhQdtw=;
        b=CniT3nU0FdD0+xE9VPRaRYP8drUr1DNYFRMkL+Smp8hZkNCQzt8IPfERVPLH+PiI2w
         GVE8qQ7pUSifFQ8M7huIEShe21JtFp28jn3McSZl7AzAM8pO5fmnb5n5rNkGGlQWajn4
         EwvJaNIS/ouMwQCHHtv5XNgWHziqff6FSnnwHqFbsEaUMlVxt8LXEEbNIgmy5X3SDXCt
         2MzaTa2/NE63cm4jHqjtBVVJ65bMo4KlEPtR1INl7ZqEv5Fi4OLpx9DsT/RNygvDBlFN
         zc8ShfWzfuZrMM/3ftf803JGbIu5PeoyRHUfs09p5V/06dAEX53/evW57dzFoC6jHvos
         T+1Q==
X-Gm-Message-State: AOAM530GVUzVK939P8rXKOgA7yizW96d6IS+tS64TlSclWOcbXiHC64y
        5GDQulo9PxVVUSPgUjygvNf69PKjPC31Dc/VeUeXiw==
X-Google-Smtp-Source: ABdhPJzLcTXLNWzPmCqKZlvAAqM/oxUtHizdLhJ5MKn/rIKB0VDXPkLIVu1557Zs4dycNGv/fBSQj6i2PE4CEjX6Hl0=
X-Received: by 2002:a25:3851:: with SMTP id f78mr340459yba.212.1591194902581;
 Wed, 03 Jun 2020 07:35:02 -0700 (PDT)
MIME-Version: 1.0
References: <1591183888-11101-1-git-send-email-sumit.garg@linaro.org>
In-Reply-To: <1591183888-11101-1-git-send-email-sumit.garg@linaro.org>
From:   Maxim Uvarov <maxim.uvarov@linaro.org>
Date:   Wed, 3 Jun 2020 17:34:51 +0300
Message-ID: <CAD8XO3Z-JvCYxqbbeGRmjc-KskpykrcfWEGKH9eO6mvG7zHc6Q@mail.gmail.com>
Subject: Re: [PATCH] Documentation: tee: Document TEE kernel interface
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     Jens Wiklander <jens.wiklander@linaro.org>, corbet@lwn.net,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        "tee-dev @ lists . linaro . org" <tee-dev@lists.linaro.org>,
        linux-doc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        op-tee@lists.trustedfirmware.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Sumit,

if this doc is for driver developers it might be useful to add some
code examples how to register drivers on tee bus.

Best regards,
Maxim.

On Wed, 3 Jun 2020 at 14:31, Sumit Garg <sumit.garg@linaro.org> wrote:
>
> Update documentation with TEE bus infrastructure which provides an
> interface for kernel client drivers to communicate with corresponding
> Trusted Application.
>
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> ---
>  Documentation/tee.txt | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
>
> diff --git a/Documentation/tee.txt b/Documentation/tee.txt
> index c8fad81..428d3b5 100644
> --- a/Documentation/tee.txt
> +++ b/Documentation/tee.txt
> @@ -53,6 +53,28 @@ clients, forward them to the TEE and send back the results. In the case of
>  supplicants the communication goes in the other direction, the TEE sends
>  requests to the supplicant which then sends back the result.
>
> +The TEE kernel interface
> +========================
> +
> +Kernel provides a TEE bus infrastructure where a Trusted Application is
> +represented as a device identified via Universally Unique Identifier (UUID) and
> +client drivers register a table of supported device UUIDs.
> +
> +TEE bus infrastructure registers following APIs:
> +-  match(): iterates over the client driver UUID table to find a corresponding
> +   match for device UUID. If a match is found, then this particular device is
> +   probed via corresponding probe API registered by the client driver. This
> +   process happens whenever a device or a client driver is registered with TEE
> +   bus.
> +-  uevent(): notifies user-space (udev) whenever a new device is registered on
> +   TEE bus for auto-loading of modularized client drivers.
> +
> +TEE bus device enumeration is specific to underlying TEE implementation, so it
> +is left open for TEE drivers to provide corresponding implementation.
> +
> +Then TEE client driver can talk to a matched Trusted Application using APIs
> +listed in include/linux/tee_drv.h.
> +
>  OP-TEE driver
>  =============
>
> @@ -112,6 +134,14 @@ kernel are handled by the kernel driver. Other RPC messages will be forwarded to
>  tee-supplicant without further involvement of the driver, except switching
>  shared memory buffer representation.
>
> +OP-TEE device enumeration
> +-------------------------
> +
> +OP-TEE provides a pseudo Trusted Application: drivers/tee/optee/device.c in
> +order to support device enumeration. In other words, OP-TEE driver invokes this
> +application to retrieve a list of Trusted Applications which can be registered
> +as devices on the TEE bus.
> +
>  AMD-TEE driver
>  ==============
>
> --
> 2.7.4
>
