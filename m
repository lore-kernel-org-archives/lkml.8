Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DCFFC2BB85
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 14:39:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 438D321D94
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 14:39:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392873AbgDPOjA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 10:39:00 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:34155 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732580AbgDPOiv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 10:38:51 -0400
Received: from mail-qt1-f172.google.com ([209.85.160.172]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MKbTo-1jfVWG3kB2-00KxGH for <linux-kernel@vger.kernel.org>; Thu, 16 Apr
 2020 16:38:49 +0200
Received: by mail-qt1-f172.google.com with SMTP id w29so16128436qtv.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 07:38:48 -0700 (PDT)
X-Gm-Message-State: AGi0PubxvvZNa9v1HqkW4O1DPrl4b/ItjBgYc8o2bT9OnuQt8l87x1fK
        wuI0AGmyhIfhIQ1ClQsK6VfUkeMQxxs7sgBMnK4=
X-Google-Smtp-Source: APiQypJqoo+1YOH8+oD0uoPKYpCZrmu3MnpzPZdEK0zTPXl6sPogVi+91etn3KKCDHnoj/lu3Amws5JqCt4BpnbxgJI=
X-Received: by 2002:ac8:296f:: with SMTP id z44mr24605980qtz.18.1587047927805;
 Thu, 16 Apr 2020 07:38:47 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1586757922.git.baolin.wang7@gmail.com> <ca403b816af38eae68ca7399640c82d0345a2296.1586757922.git.baolin.wang7@gmail.com>
 <CAK8P3a06fed_WVmO84iod2VpY386_3J+V=A-M+W7yE57N04a8w@mail.gmail.com>
 <CADBw62r06X6mMTx3eLY1iU5KLOK644d1vA49Kp9JXzUtm2CpCw@mail.gmail.com>
 <CAK8P3a3jnpRDjWwAOJa1EmbMzu+vKXmG3DBzhjHtVFz8NHfP8A@mail.gmail.com> <CADBw62oNApMo_rCz1W6_tG8Z72ENjrAtHkWZ1Z4NsN0qWFctXg@mail.gmail.com>
In-Reply-To: <CADBw62oNApMo_rCz1W6_tG8Z72ENjrAtHkWZ1Z4NsN0qWFctXg@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 16 Apr 2020 16:38:24 +0200
X-Gmail-Original-Message-ID: <CAK8P3a07n=5X5Cv7crAu_XCzoLA=o1wZjmO5r6=bwdGr2nHSwQ@mail.gmail.com>
Message-ID: <CAK8P3a07n=5X5Cv7crAu_XCzoLA=o1wZjmO5r6=bwdGr2nHSwQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 3/3] soc: sprd: Add Spreadtrum special bits
 updating support
To:     Baolin Wang <baolin.wang7@gmail.com>
Cc:     Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Lyra Zhang <zhang.lyra@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:u8MUkaFRBnn+Lh0FCWK5uE3WsHRFKrzXU/QFJKoRktJgghEzUug
 21Bguzy20iAF47/PfCadC8wWzQnEpwO8bKWLb1SYG5LK1y62zbRPfdQhS98MH3Fb9hZcGtZ
 LHJtsm7tCPfNFt8VeDyafEAwxqZhsxXgCU5Jg/p1qLDi9PK8mJ+Ct4gr3MhLLUOKjAmpJ1L
 L7iksVCsbawZadAivta7w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:kO7/9jTZSIA=:KEDcyi4N67of5W1DkUlfJS
 5LCkVVYTRlWDHaV/opCaKfEBcd2KB8Ke9woSarVpCzZQ5oEoOKje8Z6eQWRRPwxMjfGiO1fOJ
 9fdjddmJMA6CYInhyShpdFVNjCP6BCNiO7zRZCVqQGSs8eKpFc1/01WSYk0tO7g/48lgQbBQz
 tTxMI9W1Fl4rdcjPPrC3LoyfyvknqJlgV8EaCn3KOhBKlYLpIOlgEPaQpxgsbnHGK9uF4Aw/Q
 8dRana6vkwTkZVQCXuki3LERksSim/LEL703PklqiZIPC8iFWosc/VWgsCHJMlh5BH7YNxRWs
 JRSi+Myustp/xHeQ/zHnhCKJCoPlpdOlsWzeIptQLKgkkx3JJOqMVRMkWIjjEqNBdMEGWprm7
 ljb7GfFtkqiWGSsKzjs0Fq+it7cVOgx2vibebNGo7lU0WNw7cKUOihILxzC7zisE7LaQn3ZE7
 nBlKQCkJ/RqVlT0inYNtKlNOtk2fFC06O1ItSrT3p+jPJQRRMJaX2qxHvbxWZXRS6ydevtZNH
 xCmBfcDifd9IXCaSgkPDm/0LhOTnI9esy6P2dpTlQE6iuOY1QCNRSAanDcyuwVNLIPJMeUP4r
 sbcdN8qZSiCPi/Je0OQlhR5Nq4PiXD6uRxAhTF5HbD1EPVOSG3OOQ2Z3/vlfcmGUc2GemVrCc
 kxQYBNKPQbxBxgQNBpquMPTv9PA54M/3bCNUnCUQxVMw1rjU6YoMS4QWQc1cCfKhU8EJVObrT
 qcUwiyXRGNILDfwWUkKBffUwEq6zNjrJ5OUFcMFSPjcwFWmriflJHkDJtT/1q2uZamPkVWE4A
 FjiX3ErNhEYTz9ZlrjTvBqrOHGeSSriGr66nNx7zkzgaerPMqY=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 16, 2020 at 3:49 PM Baolin Wang <baolin.wang7@gmail.com> wrote:

>
> OK, I think adding a Spreadtrum compatible string will be an easy and
> clear way, so what about below sample code?
>
> DT:
> ap_ahb_regs: syscon@20210000 {
>          compatible = "sprd,sc9860-syscon", "syscon";
>          reg = <0 0x20210000 0 0x10000>;
> };
>
> /* The Spreadtrum syscon need register a real physical regmap bus with
> new bits updating method. */
> if (of_device_is_compatible(np, "sprd,sc9860-syscon") && syscon_phy_regmap_bus)
>        regmap = regmap_init(NULL, syscon_phy_regmap_bus, base, &syscon_config);
> else
>        regmap = regmap_init_mmio(NULL, base, &syscon_config);

Ok, sounds good. Maybe also define another compatible string that
is more generic than "sprd,sc9860-syscon" (but less generic than
"syscon") so you can still identify the chip specific syscon area if
necessary, while not having to list each future chip individually.

Something like

compatible = "sprd,sc9860-syscon", "sprd,atomic-syscon", "syscon";

Also I'd add an IS_ENABLED() check so it gets the 'else' path
at compile-time when CONFIG_ARCH_SPRD is disabled.

        Arnd
