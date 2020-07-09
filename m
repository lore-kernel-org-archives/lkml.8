Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7013C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 18:31:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 981BB2078B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 18:31:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SQr3hTzy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726367AbgGISbS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 14:31:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726116AbgGISbR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 14:31:17 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97151C08C5CE;
        Thu,  9 Jul 2020 11:31:17 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id e8so1336407pgc.5;
        Thu, 09 Jul 2020 11:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QyT05EdzwrOL/sU0vHjmGPMzspiZL3Ee2X4vPjVPFEw=;
        b=SQr3hTzyNvD/L2AeideltLLxoMJTWgvJMzMB8Bnk64CeAZcKoxAF2BbChynPvjngBv
         urRRrkUfyV8r43DUohS5oboZvk47ZFEH9dWpJvcbyjtSIwtGlgva9NFKXddNPcFAQILa
         DfsxCK2qw5gWEL0ZGIzMTMOBZCKGvi/4elf1VIBy5W9yb1DPYe2lwuXefVKYdg4P83KN
         ey3a3RUevfS/8IYTIlfulp4Mc2pS7kJSTZVIRftcQocTQDQYY/l3HihQ0+jc5HRJ3FQR
         wAAZ+E+Ylh6I+y9adl8oyMubc+lYyNjZ20uM/lxKfUbL2qwJVkpf+FmXDwxmQqIXyeyE
         7Jzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QyT05EdzwrOL/sU0vHjmGPMzspiZL3Ee2X4vPjVPFEw=;
        b=S5u9QQ7u9GOToi+POvU4RED/ftDu8B4esf5bt6HZSMnQXmDYMSQ4Rsxz9NIjPUHJ9U
         7GYi44GC60GTVDyZwscDqnZJQsiIUyBAJFJ1AAAPTom2uaIuB1HLv5yFOoIyv1phXjiW
         Yk1PJO0KMa4UVQeBZGh6KHiFB5WFB45wjxas+kLE0d/GOT5GrpN2cz/QSYUyUkutyOIA
         2ja6HR79hL43CtzYXjtoPuX7jda5XGmy6wUt5lvjFOsqVnSgrMX8+kJU1AY2kU7xBMAd
         +wNzhqzBoqBuTQannw29pi5qVdeRoB4DgcNJFWNizBoo49hARXTy9+ecNZJgdxmfn3CJ
         3B0Q==
X-Gm-Message-State: AOAM5303N7jQ+2ZUY0ixXpvYdf3KBSEqm+MjpCx41p4voYJyl3c9luaI
        48lTneZYcCAivfyy0TMTvnkPGuuyYxaxx3Qg30k=
X-Google-Smtp-Source: ABdhPJwHJxAcuWOM1QnoWaFYlm+elJ5b005nJwj8UobnY1pE535e7oJe3KEIprFf29q+UPSbq9KwbdN5FftXLaZUNng=
X-Received: by 2002:a63:924b:: with SMTP id s11mr53396482pgn.74.1594319477184;
 Thu, 09 Jul 2020 11:31:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200702085520.16901-1-aaron.ma@canonical.com> <20200702110740.19880-1-aaron.ma@canonical.com>
In-Reply-To: <20200702110740.19880-1-aaron.ma@canonical.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 9 Jul 2020 21:31:00 +0300
Message-ID: <CAHp75VdZPLzXqO7A8KXq3dT-_TymysCrmZcBc8SAtfCKfBQy5A@mail.gmail.com>
Subject: Re: [v2][PATCH] platform/x86: thinkpad_acpi: not loading
 brightness_init when _BCL invalid
To:     Aaron Ma <aaron.ma@canonical.com>
Cc:     mapengyu@gmail.com,
        Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Thinkpad-acpi devel ML <ibm-acpi-devel@lists.sourceforge.net>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 2, 2020 at 2:07 PM Aaron Ma <aaron.ma@canonical.com> wrote:
>
> When _BCL invalid, disable thinkpad_acpi backlight brightness control.
>
> brightness_enable is already checked at the beginning.
> Most new thinkpads are using GPU driver to control brightness now,
> print notice when enabled brightness control even when brightness_enable = 1.


> +       } else if (!tp_features.bright_acpimode) {
> +               pr_notice("thinkpad_acpi backlight interface not available\n");
> +               return 1;
>         }
>
> +       pr_notice("thinkpad_acpi native brightness control enabled\n");

In both cases don't you see the duplication of module name in the messages?

-- 
With Best Regards,
Andy Shevchenko
