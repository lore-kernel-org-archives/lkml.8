Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE7A5C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 08:28:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8DB52072F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 08:28:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CHvGvOzN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726342AbgFBI2T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 04:28:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725907AbgFBI2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 04:28:18 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86103C061A0E;
        Tue,  2 Jun 2020 01:28:17 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id y17so1057708plb.8;
        Tue, 02 Jun 2020 01:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GmJnjfSc4JBo+pcTz02oCEU40mYDg3IUGWJSm6oIOSY=;
        b=CHvGvOzNEpuC5aopZ+9w47SY1ODLARyi1kPMyiV44kKQrQPgaNy+y/f/jccKQNzP6T
         JxT9hhqr3egPf86ZTMCIDoaFHd0wiXdMowqMfgdfd/ljrhxtStssCkYTC7p/ft219IJM
         75MTbE6040w9ApY/zUJjtTXvoAxFf01vfuu91tZSsmq+OUhO1bUfRiVDZgIrd5Uc7XIz
         GHtbNsC8PSk9HSO1NtOtzLk1PD5nuRTRUcSSrq6kdUWpL/2f8bevSSzkTJVfdSqq2LcJ
         VbbWdybSbnwLggmYwBnLrhNYUPzhL3+fy9yBd2GkP+ANz9+uWrpfJrr138q5IkMFMOeu
         OKHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GmJnjfSc4JBo+pcTz02oCEU40mYDg3IUGWJSm6oIOSY=;
        b=cect+Nyuet0fryAjitH3+UuNDrcCM0b//15PZGEaaGNNm7pWjDTetm8izLp96RwIyB
         +9mk+eWcKbTlkxTNbtEPLpNNdTRVPdQBy3rFOBt4anGA3WYwvR68ZG2ez5e8Osq8yDIe
         KBsgEupEqgYon0k2lex76Qa6miKUpg3yesmcBT8iLy5xYk4oD6UKKLXDtyDG+yn5nYBS
         /vzobBVLQPTsiWE4/ZfvXHp7kEmLf8aYSSWhirY1nK05eR+38pavBNwabVfOLTHS9fMd
         ec24Bv2+Pbl9ewjaOUi04lA9/o0QqlqLxtx3+/IQ8Pk/Nzs1RY4TtFuNC+faTOwox15J
         WvEw==
X-Gm-Message-State: AOAM532Y9ofu+Fli0X/5XGCLB9maXam3qdigZYL2k6+9SHvJgH60CJbL
        TDhwa2dYLhMvbUEH3x1z34jOi7Ono0SWezoO4Wg=
X-Google-Smtp-Source: ABdhPJwbEC5BfYvqjmzMKP1TQIXVgmT9GY8Ac1hjhh+ZnJX1g/6lHNX5Kz73qoFMIzif+uAI62amVjQULYQY4vLLmEE=
X-Received: by 2002:a17:90a:220f:: with SMTP id c15mr4260914pje.129.1591086496966;
 Tue, 02 Jun 2020 01:28:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200528085650.1417942-1-joel@jms.id.au> <20200528085650.1417942-3-joel@jms.id.au>
 <20200602080104.4vqobktck357j52v@mobilestation>
In-Reply-To: <20200602080104.4vqobktck357j52v@mobilestation>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 2 Jun 2020 11:28:05 +0300
Message-ID: <CAHp75VdkBbDhFSYQYxuej=XH1MYAq-p6AWZZRLpW_iKt9D31_w@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] checks: Improve i2c reg property checking
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Joel Stanley <joel@jms.id.au>,
        Serge Semin <fancer.lancer@gmail.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        devicetree-compiler@vger.kernel.org,
        David Gibson <david@gibson.dropbear.id.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 2, 2020 at 11:03 AM Serge Semin
<Sergey.Semin@baikalelectronics.ru> wrote:
> On Thu, May 28, 2020 at 06:26:50PM +0930, Joel Stanley wrote:

...

> > +#define I2C_TEN_BIT_ADDRESS  (1 << 31)
>
> As Andy neatly pointed out here:
> https://lore.kernel.org/lkml/20200527133656.GV1634618@smile.fi.intel.com/
> (1 << 31) is UB.

Thanks, Serge. Yes, we have to use 1U in the definitions (for 31 is
necessary, for the rest is for the sake of consistency).

-- 
With Best Regards,
Andy Shevchenko
