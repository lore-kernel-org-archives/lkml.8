Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E3A0C3F68F
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 09:10:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E83D42081E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 09:10:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=newoldbits-com.20150623.gappssmtp.com header.i=@newoldbits-com.20150623.gappssmtp.com header.b="dkPCnJaj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729260AbgAOJKY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 04:10:24 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:34617 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726472AbgAOJKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 04:10:24 -0500
Received: by mail-lj1-f196.google.com with SMTP id z22so17702594ljg.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jan 2020 01:10:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=newoldbits-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZUooeDiuykCrSEixoglrFzv/NkRqBFJjLlMXld2oNvc=;
        b=dkPCnJajgdZv82TJTfRwIjQT4BzJ0XAJ6EjHOTKTAfRmqA7t7Nm82NV6ZvLY/LtOJo
         MzdbM9Wou0bHJP5bPaCJNwqQ2ZSanKZJG9Q2bQKYSTVYNvVNEcS9jXYRIBiJ959OcNqR
         kc7vIokUwj1LKKCJ30x2X3DqpwnR/FYoj+/2W/YsR85Va2ptlTxsBI6a31zsYDOG0DTb
         Ma+umCg1nqQQ3FkG5pi9XEkI3TLwFfb5/6VDIOJcXQq+KXh4vsPL8AazgKx7wf2+7Vuy
         6Rw9QghTREYiaSILdXpXmfnbzkf1etqMbAJNSS3DKNHvXuc8w2i4OiyJg20HyP8ZtVs0
         4D7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZUooeDiuykCrSEixoglrFzv/NkRqBFJjLlMXld2oNvc=;
        b=IWUwbCpNLwueNvhaasm8oLiXMDCUbmxP4thEMqJARccKPZ7+6iL0Q2y61C0UnHmC5b
         aG1VpIEf3p+oX+AbnnSoTO/Hkz/1Vf1h3u+VVH973KvHgfPJcZN+6ZrchB2n9X68Ela8
         LhFB8HHX57axsFwc4R48vp5GAkfvHT00UBVGUMbg4DOL1F3DT8WQkMh2d5i2nDybhWWv
         VDxfFDZtV92XcMIDxVkbQs8UosSQpf06kpNw1QnfE3CM7xsogr6tHuwuv2nj6h0eWoy8
         z/DbXJqu2qTV0K2An8lnEsiOQ9Ioh6xGrVZFDEDH+LqsnRWx+dHr7Ba9l7eB+gpQ4en8
         5nvg==
X-Gm-Message-State: APjAAAXMKjPp1so1S4Ui3fzxakYAEIcZaKHS0b7iG21W7L/MAU2tIgzR
        7PJveUGofz3SiRkQnXxIZsidoMy3IUOVLYcfr/u6wg==
X-Google-Smtp-Source: APXvYqwmx/kU1fofcAxvjyTJt+wWuHPF02t2nR4PiACn0mxCpKhZ7SIHy9YPRLm7JR5V3fes434obrv1zFT0VcCMZeE=
X-Received: by 2002:a2e:9d89:: with SMTP id c9mr1140551ljj.129.1579079421879;
 Wed, 15 Jan 2020 01:10:21 -0800 (PST)
MIME-Version: 1.0
References: <20200115132325.3ac3ca0f@canb.auug.org.au>
In-Reply-To: <20200115132325.3ac3ca0f@canb.auug.org.au>
From:   Jean Pihet <jean.pihet@newoldbits.com>
Date:   Wed, 15 Jan 2020 10:10:09 +0100
Message-ID: <CAORVsuWs=0su+y2iLfL7zUygW8UgT8WzTXoCJiyBGFp_UG8yFA@mail.gmail.com>
Subject: Re: linux-next: build warning after merge of the spi tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Mark Brown <broonie@kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

I did not have this warning, it may be a combination of compiler
version and build flags. Do you need a fixup patch for it?

Thanks,
Jean

On Wed, Jan 15, 2020 at 3:23 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> After merging the spi tree, today's linux-next build (x86_64 allmodconfig)
> produced this warning:
>
> drivers/spi/spi-ti-qspi.c: In function 'ti_qspi_start_transfer_one':
> drivers/spi/spi-ti-qspi.c:392:8: warning: 'rx_wlen' may be used uninitialized in this function [-Wmaybe-uninitialized]
>   392 |     if (rx_wlen >= 32)
>       |        ^
> drivers/spi/spi-ti-qspi.c:318:12: note: 'rx_wlen' was declared here
>   318 |  u8 rxlen, rx_wlen;
>       |            ^~~~~~~
>
> Introduced by commit
>
>   e7cc5cfbea4c ("spi: spi-ti-qspi: optimize byte-transfers")
>
> Looks like it may be a false positive.
>
> --
> Cheers,
> Stephen Rothwell
