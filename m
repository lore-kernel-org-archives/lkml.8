Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F861C33CA2
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 11:13:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34F3920721
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 11:13:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="dsekrWCk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727771AbgAJLNU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 06:13:20 -0500
Received: from mail-qv1-f66.google.com ([209.85.219.66]:34792 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727733AbgAJLNU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 06:13:20 -0500
Received: by mail-qv1-f66.google.com with SMTP id o18so554510qvf.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jan 2020 03:13:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=CiGz35L0V9Auq+B4EaNe1Z4ZWRbPZysYPkdJ0WZ7was=;
        b=dsekrWCkonGEpwQszzLZLwPzaaGTCOnxRZf8Ql1fxCu/YNGOhchf4gSlgHLnaoZgdn
         4HJNQum2sOEc0fsiVBZDuWZwsiYzpDTx2Ic5suD+WOx5/OTHtYoihzC5EtG11HuA/gty
         hNAKSJsmD2sfg+XQvt+oNwUFhexMWviizz5Q3scJoAggYOpw3AKZNfOBPto5+KC5k+v9
         +iQW5duiEpXFd5MCWFCrPm6VkM8Mgc8GscWzzzWshLcrBmgM5bUrq2dT2nNAbBa0e3mF
         CsLnWo0BQo4SZrZC6cVZs6L/jbY03DB0+ifE3AWElGdbRFA+J6sxor4URPMnoc0eDM4E
         79Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=CiGz35L0V9Auq+B4EaNe1Z4ZWRbPZysYPkdJ0WZ7was=;
        b=GUJOzrt7wJrxuy5IE4sDIJO8JuRwMm381hIx3347SrY+uzxREGEh/sruKsO6MJQq4A
         R/7OiuWL/gqVAy4riYO/ghdD3+fqoK9tyrByf+itNK1jne8rAeDtdWAIO5G2L2cK8C1q
         N9Sh3HNQbitvULgx7nT1938ThAEfcC+J5RLI36p+UniElW/kE5VmpvOZfrKI4rV+6+2a
         muTYhHFD3qdQDxvt9/4KBG2I88XlXUpJG2uTtaO+aNKLsSYiJJ15PDMuXmnHyhsumiDI
         kJl1Hd49liKfGvodSR34KwyscX0VwWG/skWUxqNDLyiphl1oAQW6/E7ZWm+KZBlZB02d
         ovtw==
X-Gm-Message-State: APjAAAWLFTL7by2Q6vovZxBNIU5SDayaK7mNH1jZ+LIUb+ZJymINJWg6
        uiqcQxuGrMGGrZ/MhhMgLj2iPFKA44S1RHz9SYVxgQ==
X-Google-Smtp-Source: APXvYqw8jsitDlp+zVEU4AwEbZLwo5k0YemNyfMQp1k/4EdZLXMpfoICHBbzrl7xnqqKLcNrLoTGU7Io5YGTNSpD6dk=
X-Received: by 2002:ad4:5429:: with SMTP id g9mr2110377qvt.134.1578654798994;
 Fri, 10 Jan 2020 03:13:18 -0800 (PST)
MIME-Version: 1.0
References: <20200110082441.8300-1-brgl@bgdev.pl> <ea048751-2a4a-31c9-0b46-849d77356a71@linaro.org>
In-Reply-To: <ea048751-2a4a-31c9-0b46-849d77356a71@linaro.org>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Fri, 10 Jan 2020 12:13:08 +0100
Message-ID: <CAMpxmJXtbW0R375m41KTE+D+OQpvadR+yBbZREVRyAuG8G-nMw@mail.gmail.com>
Subject: Re: [PATCH -next] nvmem: fix a 'makes pointer from integer without a
 cast' build warning
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>,
        Khouloud Touil <ktouil@baylibre.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        LKML <linux-kernel@vger.kernel.org>,
        kbuild test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pt., 10 sty 2020 o 11:16 Srinivas Kandagatla
<srinivas.kandagatla@linaro.org> napisa=C5=82(a):
>
> Thanks for the patch.
>
> On 10/01/2020 08:24, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >
> > nvmem_register() returns a pointer, not a long int. Use ERR_CAST() to
> > cast the struct gpio_desc pointer to struct nvmem_device.
> >
> > Reported-by: kbuild test robot <lkp@intel.com>
> > Fixes: 2a127da461a9 ("nvmem: add support for the write-protect pin")
> > Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > ---
>
> Acked-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>

Thanks. This is rather uncontroversial, so applied right away.

Bart
