Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27C8DC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 15:23:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2D3E2065F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 15:23:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qdbCWZlw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730528AbgEVPXG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 11:23:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729931AbgEVPXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 11:23:03 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60F66C061A0E;
        Fri, 22 May 2020 08:23:03 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id p30so5124168pgl.11;
        Fri, 22 May 2020 08:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+6TOThcfrCoo/dB//49POAXWHMbH0VtQ+5JMYE00jS4=;
        b=qdbCWZlw8zITa3fBX/i9UHBrOQJnVY0QHCf6vjJjBy8gsiQ4glBScKebyHCTVKSPTQ
         BjKzfdIr6Pbo7tFcBa8Matdv7z1sALCJkArYfZ1H4/271Xc58MYM2pjDVf715TMfKfWN
         bSO4C3n2JoUbtgDeZT638utqfz5CJ+vP1fL/nwFM7nGfdgiV59uVdG2qhAKhknGndnmH
         taTlsu+TDfPOdYr49/d70o3Tm0kMw9DtUvJsLXg/VjZjdKUninYV616rrJXAQIa8ZM7G
         jKgN+r35pTkcIIIhDDs1a52zGzGukmjPDwJquuSKF0r8YwoCBn+bjy/s+KcxoeJwc7HF
         haIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+6TOThcfrCoo/dB//49POAXWHMbH0VtQ+5JMYE00jS4=;
        b=kGCMPDSRE/VDwxkLwNrcL4wyZd6FeDqvPApPQL/efUrVRJGM3zEhrXlvFr9EHi0RcI
         x0MM1LPT+L5tGKi/tkLujl9/fGg8o9tylhBoI/OZ24+XCXUueJdbkAG+4zkAFj6V2EgE
         eSS1BaAfIQBpI6r7uG+LaGjS0H+4MxMFsxSjrjmFyEtsU35e45Xp7N/lKD/ywOGJGcpl
         g8vxw/JztUekbY2GjoaITYRVWlFyIJ2QIF8AOYMCaFIygL6bOQnrvkumlVE61xdmeHA3
         XBUE9OaQKfdcKgOC3hiE5COEQmWEcW9ahqcOc5IagegmZENOwxSnCNQs5QNEC7qDX+qn
         pcCA==
X-Gm-Message-State: AOAM530wPQiraiA6tW3SpvY7iot93JRUmz24qM8xw/qLmaGp7SvRIzt9
        U6Wa4F8OHL6eRKoJofd1fwPG2/+AeNlzZfsBf8k=
X-Google-Smtp-Source: ABdhPJxEGo6ljrna1zI7Tc0KBf/r5xRQMfrE2gMH/mp9Uh3KNMV6dDc6OlHXiuYyLoc6qbYYaTsUf3VHiGl22xH/W2A=
X-Received: by 2002:a62:5ec7:: with SMTP id s190mr4243873pfb.130.1590160982872;
 Fri, 22 May 2020 08:23:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200521074946.21799-1-dinghao.liu@zju.edu.cn>
 <CAHp75VfOeUaqRW2vRwyWaz3JJw41hX5jTgE+kZ8pB8E_HtHwqw@mail.gmail.com>
 <5a8a6e7b.bef25.1723b588c7f.Coremail.dinghao.liu@zju.edu.cn> <CAHp75Vem1kQviLrobJ65aVOb_VCmLkAv=5U_iXAdWPNe7n0+Ng@mail.gmail.com>
In-Reply-To: <CAHp75Vem1kQviLrobJ65aVOb_VCmLkAv=5U_iXAdWPNe7n0+Ng@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 22 May 2020 18:22:51 +0300
Message-ID: <CAHp75VexCBc6iCrd_VLj5jXE8cxxdzUUf6pMG6O8LjtNj0J1Aw@mail.gmail.com>
Subject: Re: Re: [PATCH] spi: tegra20-slink: Fix runtime PM imbalance on error
To:     Dinghao Liu <dinghao.liu@zju.edu.cn>
Cc:     Kangjie Lu <kjlu@umn.edu>, Laxman Dewangan <ldewangan@nvidia.com>,
        Mark Brown <broonie@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        linux-tegra@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 22, 2020 at 6:20 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Fri, May 22, 2020 at 10:46 AM <dinghao.liu@zju.edu.cn> wrote:

...

> Moreover, consider below case
>
> CPU1: ...somewhere in the code...
> pm_runtime_get() // with success!
> ...see below...
> pm_runtime_put()
>
> CPU2: ...on parallel thread...
> ret = pm_runtime_get_sync() // failed!
> if (ret)
>   pm_runtime_put() // oi vei, we put device into sleep
>
> So, there is a potential issue.

...and even if it's impossible (no bugs in runtime PM core, etc) the
code with put() looks suspicious.

-- 
With Best Regards,
Andy Shevchenko
