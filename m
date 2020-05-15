Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A758C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 08:42:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F05FD2054F
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 08:42:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589532160;
	bh=+wlsUC7AekfE9cPMQivKTfEw+c/Vi1tbnbrhUvLkjic=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=g/Gm9YYF7zO2n2bgbTOte9Gf3i81UwPa7ncCbpJw89mSR0tLPgx/DgFgldQWckukp
	 NJZHBlB0Ns1nsJxJQNQckioibCpU+96BzNSugUSy6mDcnmxET9T6Hl9MvhOKK12fE+
	 F6FEqWa9r2d7rfEsmfqyWMQVR4rc/TDBhKCK82IA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727990AbgEOImj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 04:42:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:41126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726922AbgEOImi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 04:42:38 -0400
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F3622207BB
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 08:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589532158;
        bh=+wlsUC7AekfE9cPMQivKTfEw+c/Vi1tbnbrhUvLkjic=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=YvfODXaG/5LnxsITe7hu9FrWkUcI2KANLVHkcrvI3dwQ877NLgobtrwJ073/j0xZn
         8GyvYBC9HjGYHjjPTsPImO0KYlmi7R2MxvDB5EssFZ6foDBv3zZP/DNU9znV9CYyrI
         FvNPLylAw9gdI6xdCEbBxDojXG4YFfF+G6+1vC6Y=
Received: by mail-lf1-f44.google.com with SMTP id a9so1120625lfb.8
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 01:42:37 -0700 (PDT)
X-Gm-Message-State: AOAM531GHRXGN7lYv7k3/Og34LaBapDxicBleJxvQNCgvyPr9qqX9LG2
        dHe1mbtqUVGe7BN+N+EGFIOPnG437paW9bv2I2c=
X-Google-Smtp-Source: ABdhPJxrOJjUeXqe4EQxacNb+3MBPLLyw3JMQa80YtUpWVmkGjh1BatCzeFvu4HIEtk1kIKuuWsxa7DPBFcoY1SZeO0=
X-Received: by 2002:a05:6512:44d:: with SMTP id y13mr1616831lfk.118.1589532156020;
 Fri, 15 May 2020 01:42:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200515070742.14151-1-steves.lee@maximintegrated.com>
In-Reply-To: <20200515070742.14151-1-steves.lee@maximintegrated.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Fri, 15 May 2020 10:42:24 +0200
X-Gmail-Original-Message-ID: <CAJKOXPf-Q-e_K-puR-N2NRwQCmaKD=EczzON4rBymvV2CyoiTg@mail.gmail.com>
Message-ID: <CAJKOXPf-Q-e_K-puR-N2NRwQCmaKD=EczzON4rBymvV2CyoiTg@mail.gmail.com>
Subject: Re: [V5 PATCH 2/2] ASoC: max98390: Added Amplifier Driver
To:     Steve Lee <steves.lee.maxim@gmail.com>
Cc:     lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, ckeepax@opensource.cirrus.com,
        geert@linux-m68k.org, rf@opensource.wolfsonmicro.com,
        shumingf@realtek.com, srinivas.kandagatla@linaro.org,
        dmurphy@ti.com, jack.yu@realtek.com, nuno.sa@analog.com,
        steves.lee@maximintegrated.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        alsa-devel@alsa-project.org, ryan.lee.maxim@gmail.com,
        ryans.lee@maximintegrated.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 May 2020 at 09:08, Steve Lee <steves.lee.maxim@gmail.com> wrote:
>
> This is the initial amplifier driver for max98390.
>
> Signed-off-by: Steve Lee <steves.lee@maximintegrated.com>

Hi,

Your "From" address still does not match the Signed-off-by. Set the
author of commit to the signed-off person.

Best regards,
Krzysztof
