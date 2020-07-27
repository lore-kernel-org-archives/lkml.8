Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE0D6C433F1
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 04:32:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A57B420714
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 04:32:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="D8HCNvbb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726719AbgG0Ec2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 00:32:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726541AbgG0EcX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 00:32:23 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD4D2C0619D4
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jul 2020 21:32:22 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id m15so7572772lfp.7
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jul 2020 21:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y2MT8K7LJP0h4HIjUSHIF3kx72ZyLwnnER3/s7uorqE=;
        b=D8HCNvbbfeCXTArUC4WY1QDrs9HjLspd9XS6l+ZIduQcykgLo9mIag8AEPoxijQdxx
         N0I6GZ6ggif98PyvczFJQTezcR085wLtKWpW32z+fnl1YcUMRliE2ieD4PCcJ+Af9qM5
         XgNj7w46y1O7ff2pkN657Rpag5lZjbuv52oqk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y2MT8K7LJP0h4HIjUSHIF3kx72ZyLwnnER3/s7uorqE=;
        b=M8Kl3aTyNyi0mlLxLZd6rHlxgqgy9CZfXhp5KX0olqHVrDs65Ai6enlvDmVpQVWz6L
         pjNsPpCtpPLLY+eQ6U73I2Ka6pO8MDkzW+dQNLvg8dVzcnTk0/znbtQFYszl/QFX9+zW
         Y9AVgPMd+GZ1CcA045jbObWprvKosYXapMJlRLxfidLUB3f3lMsf+2qxs4Zp5oACRWhw
         HqcrTZqRayAuSaatrEDY1qEZBsenelHpRxPQWr7NENYg87CY97SrfzCxmU8PRhYeJKK4
         TVbE7kD6CHnld4kHBBVRa69E+E+UfRFuF+Afuy/5jTGDXmOfi4RkFNj3fia5W40Kke5y
         heMw==
X-Gm-Message-State: AOAM530kUm0Qp88NVcYCI38HySwS9wxwodKhAaN0aJBHugYxwsR8Mie9
        siQUQ4Q6wmgpEsKtcVyuQYFq/8LZLG5RfStbL6iWzA==
X-Google-Smtp-Source: ABdhPJyPqCU/OdRwDZPqwlMkGbnhgQCLKdZNaMgRtj9kGkbaFfHHszQybGc/isZ4yrfqqymo2EzDGJjUEh54mtwmKWg=
X-Received: by 2002:ac2:5502:: with SMTP id j2mr9290650lfk.50.1595824340928;
 Sun, 26 Jul 2020 21:32:20 -0700 (PDT)
MIME-Version: 1.0
References: <1595115599-100054-1-git-send-email-dphadke@linux.microsoft.com>
 <116ac90c-8b49-ca89-90a4-9a28f43a7c50@broadcom.com> <20200722104128.GK1030@ninjato>
 <5048cf44-e2c2-ee31-a9fb-b823f16c2c7d@broadcom.com> <20200725101815.GA1519@ninjato>
In-Reply-To: <20200725101815.GA1519@ninjato>
From:   Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
Date:   Mon, 27 Jul 2020 10:02:09 +0530
Message-ID: <CAHO=5PF6WmgTYAA8vVd86cx0YTx0CKouJ2k+13hNVCPiEtMVYA@mail.gmail.com>
Subject: Re: [PATCH] i2c: iproc: fix race between client unreg and isr
To:     Wolfram Sang <wsa@kernel.org>
Cc:     Ray Jui <ray.jui@broadcom.com>,
        Dhananjay Phadke <dphadke@linux.microsoft.com>,
        linux-i2c <linux-i2c@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ray Jui <rjui@broadcom.com>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 25, 2020 at 3:48 PM Wolfram Sang <wsa@kernel.org> wrote:
>
>
> > I think the following sequence needs to be implemented to make this
> > safe, i.e., after 'synchronize_irq', no further slave interrupt will be
> > fired.
> >
> > In 'bcm_iproc_i2c_unreg_slave':
> >
> > 1. Set an atomic variable 'unreg_slave' (I'm bad in names so please come
> > up with a better name than this)
> >
> > 2. Disable all slave interrupts
> >
> > 3. synchronize_irq
> >
> > 4. Set slave to NULL
> >
> > 5. Erase slave addresses
>
> What about this in unreg_slave?
>
> 1. disable_irq()
>         This includes synchronize_irq() and avoids the race. Because irq
>         will be masked at interrupt controller level, interrupts coming
>         in at the I2C IP core level should still be pending once we
>         reenable the irq.
>
> 2. disable all slave interrupts
>
> 3. enable_irq()
>
> 4. clean up the rest (pointer, address)
>
> Or am I overlooking something?

This sequence will take care of all cases.

@Dhananjay Phadke is it possible to verify this from your side once.

Best regards,
Raaygonda
