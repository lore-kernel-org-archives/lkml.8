Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2B9CC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 13:26:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C204E2070A
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 13:26:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=0x0f.com header.i=@0x0f.com header.b="If79azyx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728612AbgG0N0P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 09:26:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbgG0N0O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 09:26:14 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EB92C061794
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 06:26:14 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id c80so14163118wme.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 06:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YKKPREYGILmYMp+eFqNko6F6lq+cuK/i7WSSQ2ZE3Hk=;
        b=If79azyxEjSToi9pX7xfDR5zdO751BfDriT825U/Wm2MnWThGzXL8GXxesxQGSt9/M
         LFQ0Y5kC3trqO9DaR9nhDUvgdjurd4U352pKO7LAdFJeytzk4XsnIBp69bxd8umvgGay
         P/5N3cJ/AxvibOoV5EHu3aXbvB/0FhvSeiCiY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YKKPREYGILmYMp+eFqNko6F6lq+cuK/i7WSSQ2ZE3Hk=;
        b=b/g9InIbhfmWVW7s45bdeDg1M1KgcK+xJSSdiORPc02Kzd95gC1xvJeOds/qFZSxUt
         MTKl6Txg+cg0j5c/M2keMkI0fOI8pKS0AP8Hoj0LQeA+6958oM7PszsDmGi80O+9Ut9Y
         JBx319mcG8mTt0c6GFyrmmoMnG83pufNACAYOqvQnyxSp2wyOuTs8aQpj2UcJmu9z8nv
         SYGoHNXLtEX4QLsuniM4P/2EMArBasUkCRseJHsn3r6SSOTFdZ66X4G2wmTYFC3Qbd+l
         YH7zInWB7DW+1aNGRz/ZCUvWKwesTtyhhq56LqCIF61svm3BzgxgcCuZ5g0ZfiJZK72D
         NDmA==
X-Gm-Message-State: AOAM533nQbXhcSrW7ikTNxXyVJykonNwMruLNueXFjUdE8KytOS7DRib
        eEMLYRkFwuCsv2bfxlCj96/cEjGjXUsVi7TEgrGQKbRlwwA=
X-Google-Smtp-Source: ABdhPJxSF+Jp4nC/8wSlCQEWqZdDHaZcKdANlkvQY0cAmuU3OOzEHENuPDjtFwhuf0H0MXGapAolehqexgaYL7kFc2Y=
X-Received: by 2002:a7b:c0c8:: with SMTP id s8mr6220474wmh.4.1595856373273;
 Mon, 27 Jul 2020 06:26:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200726043948.1357573-1-daniel@0x0f.com> <CAK8P3a0K6LmNkGPdKeBcFTgi5wJz8T0rzO=Kg2Fmz=NtyFWAfQ@mail.gmail.com>
In-Reply-To: <CAK8P3a0K6LmNkGPdKeBcFTgi5wJz8T0rzO=Kg2Fmz=NtyFWAfQ@mail.gmail.com>
From:   Daniel Palmer <daniel@0x0f.com>
Date:   Mon, 27 Jul 2020 22:26:02 +0900
Message-ID: <CAFr9PXmJwKaKUO-nTNY=4X7EyifZF8HbXcfsaZaYaouTr1ZJDg@mail.gmail.com>
Subject: Re: [PATCH 0/7] ARM:mstar: DT filling out
To:     Arnd Bergmann <arnd@arndb.de>
List-Id: <soc.lore.kernel.org>
Cc:     SoC Team <soc@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On Mon, 27 Jul 2020 at 21:33, Arnd Bergmann <arnd@arndb.de> wrote:

> I had one comment for the last commit in this list and have therefore
> not applied the series (yet).

I was going to wait for other comments before making a v2 but it seems like
it was just the pmsleep syscon that needs changes. I'll fix that up and send
a v2.

> I also noticed that the subject lines are slightly inconsistent, please
> add  a space between "ARM:" and "mstar:" as you did for the first
> set of patches.

Oops sorry about that. Not sure why I did that. I'll fix for the next version.

Thanks,

Daniel
