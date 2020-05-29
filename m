Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B0EEC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 22:33:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B3A2208B8
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 22:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590791624;
	bh=DZ1HDwCj+CJ7ngO6dIiPzILmvtMM8AsDswbq/ID7FzA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=NKh4l0vBmvKqMPhunnXqOKAWE9NOUCrN4d4624FKsujTuAOsWf1eVVnrEUOh2YZ8h
	 36nJJ2OY+FH2jam7GR1DLX8U3DY6ykcVV2BUl1c6cBY8zkDrNsYLDR/wtC1Rw4a7MV
	 ArUJ5Iynfq7S2l4ojW4eMpcHTE5O8yNCHT2P9q1s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728349AbgE2Wdn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 18:33:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:57736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726555AbgE2Wdn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 18:33:43 -0400
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AB86D208B8;
        Fri, 29 May 2020 22:33:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590791622;
        bh=DZ1HDwCj+CJ7ngO6dIiPzILmvtMM8AsDswbq/ID7FzA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=QYPOGsk3oeLV0aKww7opPiF8/10mcztg1cLICQxa916usvGPf06xrT+GqWFS/NBEM
         eb8r6RN34SzvpDPJm7vFSGJPJ/Vijhsujx04/Bdv083Nd5aWwvG5KlaFEfWe/QDnGQ
         boxpx5d0YP/XJAKDZRHKWdiLudWPg8EpHyf2RR2Y=
Received: by mail-oi1-f176.google.com with SMTP id b3so3996807oib.13;
        Fri, 29 May 2020 15:33:42 -0700 (PDT)
X-Gm-Message-State: AOAM5328ENDnU3fITbF+VhRiG7bqrRep8+IFIctc7Krq2IulnqRiVKhD
        OLFIQ+xzSlI+N61tWwXp0HcI8YbMcVZb96s2HQ==
X-Google-Smtp-Source: ABdhPJwRV5dVPqJiprfdXK/FwvoQGRu4x3lbanx+BE4Nr4ohpwjk6aELloQAO4wH2FvT0QD278W7CzF0QflsKCrQF6I=
X-Received: by 2002:aca:564a:: with SMTP id k71mr7503532oib.147.1590791622045;
 Fri, 29 May 2020 15:33:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200528085650.1417942-1-joel@jms.id.au>
In-Reply-To: <20200528085650.1417942-1-joel@jms.id.au>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 29 May 2020 16:33:30 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+1dtBtY0fd1XZ0BFqwzwz26WU3cVKwyR7H+MtxE+hJBA@mail.gmail.com>
Message-ID: <CAL_Jsq+1dtBtY0fd1XZ0BFqwzwz26WU3cVKwyR7H+MtxE+hJBA@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] dtc: Improve checks for i2c reg properties
To:     Joel Stanley <joel@jms.id.au>
Cc:     Devicetree Compiler <devicetree-compiler@vger.kernel.org>,
        David Gibson <david@gibson.dropbear.id.au>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 28, 2020 at 2:57 AM Joel Stanley <joel@jms.id.au> wrote:
>
> This is to fix a build warning in the Linux kernel caused by dtc
> incorrectly warning about I2C_OWN_SLAVE_ADDRESS.
>
> v3 fixes the 10 bit size check
> v2 contains a second patch to check for 10 bit vs 7 bit addresses.
>
> Joel Stanley (2):
>   checks: Remove warning for I2C_OWN_SLAVE_ADDRESS
>   checks: Improve i2c reg property checking

Reviewed-by: Rob Herring <robh@kernel.org>

I'll sync the kernel copy when David applies.

Rob
