Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C66EC43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 00:26:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30C05207FF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 00:26:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pHAONuh2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732881AbgDBA0m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 20:26:42 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:32789 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732619AbgDBA0l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 20:26:41 -0400
Received: by mail-pf1-f194.google.com with SMTP id c138so898069pfc.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Apr 2020 17:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ob50KPPitu/VAsCZRCb3jIgsR0wX/xQsKu6DYbArPO4=;
        b=pHAONuh2cBAam65QtvHR6M5VI4wsm+z8NLQz0FSUy4wl0NcZnViOpfQYIAVwYqo+GZ
         6u/yJcCBkg0GUBhSG+eGb8Z1GJWrDcwH3Wr5Ry3Ms1DEAEk7yD7os4vd6JhSOKjskUG4
         r3wGD+dWECHTN6nYHUIfjqza7scSXkzCDEqQe6q5Jm+B/gCnFnsp+OMy6VjIcO592Sj2
         xXlTkTicFXlyELgXpyjKervJ7cz84gj7hK65zerNKNVET0gcejyJGIFz5ka8k4RL3Hpl
         MhTRtr5Jqi/dTDEmBmUoeRo4kXd5QMl/ivO71/Ze8GThkm01gienkv1OsisOlGAwhZmz
         QbRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ob50KPPitu/VAsCZRCb3jIgsR0wX/xQsKu6DYbArPO4=;
        b=IpdEzWyC7B+sxP/s9jyBJ8gDdOSRp/IPfsndQY0zrmvVmb/7KZ63VZMs+cI7hF6pw/
         WdLJ9o60UxqAzCEDeLGdYCk5VEI5/VXygv7j42dxhgp9jmGjgS72/qNxYWPPMPN4gCa6
         5I+rUZ8k8PhyQU8jGklMCjBVFZFe//pUIGmT/9XdCwtrscea/7TV8KYbuXWbv8tllfkK
         8kSn4/sfdmIWTO5Lx08pOWiYfyvQrS3Rv323Zk0WQ32z1Iy9Gz7qdR3dQx8di+neXF0c
         C5Ol48dhVCNJ5XIpdFfu5EiiKLSczTSqpYaP8uuxxCj/DHWCdHScLhudBSWnlgvwcrpO
         Hq5g==
X-Gm-Message-State: AGi0PuasW3n/MHZL+R9OMC6FTeefUupJwHnfpmGZTc1Dvoj4LImAYTsc
        CMzahzR/kybV0NmNleCAv2rUtSGqDpvNXW4wO1rkxA==
X-Google-Smtp-Source: APiQypKeG0RcaEryHPNpjDE3LJENFRlmFYUd6WwW6EYlUJOuCKtogvsWiFcehG/IvwaDMd5evl8Xm6x6apMH7SD2Ofc=
X-Received: by 2002:a63:a34d:: with SMTP id v13mr837990pgn.10.1585787200467;
 Wed, 01 Apr 2020 17:26:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200311024240.26834-1-elder@linaro.org> <20200401173515.142249-1-ndesaulniers@google.com>
 <3659efd7-4e72-6bff-5657-c1270e8553f4@linaro.org> <CAKwvOdn7TpsZJ70mRiQARJc9Fy+364PXSAiPnSpc_M9pOaXjGw@mail.gmail.com>
 <3c878065-8d25-8177-b7c4-9813b60c9ff6@linaro.org> <CAKwvOdnZ-QNeYQ_G-aEuo8cC_m68E5mAC4cskwAQpJJQPc1BSg@mail.gmail.com>
 <efd2c8b1-4efd-572e-10c5-c45f705274d0@linaro.org> <CAKwvOdnZ9KL1Esmdjvk-BTP2a+C24bOWguNVaU3RSXKi1Ouh+w@mail.gmail.com>
 <5635b511-64f8-b612-eb25-20b43ced4ed3@linaro.org>
In-Reply-To: <5635b511-64f8-b612-eb25-20b43ced4ed3@linaro.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 1 Apr 2020 17:26:29 -0700
Message-ID: <CAKwvOdnO2=yjEerw50b_C2vrgdCh2es6ZRfQpBRVR9RCrvwi6Q@mail.gmail.com>
Subject: Re: [PATCH v3] bitfield.h: add FIELD_MAX() and field_max()
To:     Alex Elder <elder@linaro.org>,
        Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "David S. Miller" <davem@davemloft.net>,
        Johannes Berg <johannes@sipsolutions.net>,
        Jakub Kicinski <kuba@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Network Development <netdev@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 1, 2020 at 4:18 PM Alex Elder <elder@linaro.org> wrote:
>
> On 4/1/20 5:26 PM, Nick Desaulniers wrote:
> >
> > mainline is hosed for aarch64 due to some dtc failures.  I'm not sure
> > how TCWG's CI chooses the bisection starting point, but if mainline
> > was broken, and it jumped back say 300 commits, then the automated
> > bisection may have converged on your first patch, but not the second.
>
> This is similar to the situation I discussed with Maxim this
> morning.  A different failure (yes, DTC related) led to an
> automated bisect process, which landed on my commit. And my
> commit unfortunately has the the known issue that was later
> corrected.
>
> Maxim said this was what started the automated bisect:
> ===
> +# 00:01:41 make[2]: *** [arch/arm64/boot/dts/ti/k3-am654-base-board.dtb] Error 2
> +# 00:01:41 make[2]: *** [arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dtb] Error 2
> +# 00:01:41 make[1]: *** [arch/arm64/boot/dts/ti] Error 2
> +# 00:01:41 make: *** [dtbs] Error 2

DTC thread:
https://lore.kernel.org/linux-arm-kernel/20200401223500.224253-1-ndesaulniers@google.com/

Maxim, can you describe how the last known good sha is chosen?  If you
persist anything between builds, like ccache dir, maybe you could
propagate a sha of the last successful build, updating it if no
regression occurred?  Then that can always be a precise last known
good sha.  Though I don't know if the merge commits complicate this.
-- 
Thanks,
~Nick Desaulniers
