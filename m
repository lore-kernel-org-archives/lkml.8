Return-Path: <SRS0=Atmy=73=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89C96C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 12:34:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DDBC206D7
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 12:34:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m0ZZIiP8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727064AbgFNMc5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jun 2020 08:32:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726925AbgFNMc4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jun 2020 08:32:56 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A09E9C05BD43
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jun 2020 05:32:56 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id i12so5581404pju.3
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jun 2020 05:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SKIiGB83ddT4Ddf/URGledt63KwexOpATWhRUr6iZ8Y=;
        b=m0ZZIiP8vJjqeB8WnbJwEX6O69bNRPk7jEScTtW6TX89Oy+FAJ/mGGk07lesh4fQTZ
         7YE22lbg2t4tE+vwKb2bti/fWPeB1EWep/RB1+fdCFDtZPX2P6c9wDfOeeRt8yCKeqop
         4y2aCD0b7R/aj1+FAGKIw8deDNDVCFBMqOQp/jmf0gYgII0OL2lRkcC0Xnp70KEUBUXU
         PhOWDL7AsPSUnPCU5xDaAXzdNsGBkKEgDmutmXqTMwfv2rGIJ/taO9TN8+0R3VjbwPju
         A+fjhYOxwZ26uVnFCSMoqPFceK/RBPXs2X2OgG4JL1/Pgxa52k0Bh+/5RVBqCSK6R4r1
         UFiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SKIiGB83ddT4Ddf/URGledt63KwexOpATWhRUr6iZ8Y=;
        b=Z9DfB+PQwb2tmwzRIP4HdLdMMeNtwDmxa6yF/PneOs18u8SjW37kndy8LZIE7sy+EH
         PV62s/JPPzovlSFijQtr4w+S+CnYRtmpjV08qKnzFYaa6NEMETz+ig+U5Ijyl/nUVLyw
         XzlIzVMPB/f+C3izY+66umyY52MKh4tPWNvPnb8VXIZ+SoFu3h8HxFixw05XqsUmpTTf
         1Kfo4r+ToityjiZ6V9fisyxOrVr4QMN1or917JejkuKZgn4uopVOYASw+aWK6/ZfvyK5
         Xj1ACx1OYoIVCFpweJTFGLDgjCmaxMZZ40RnBa1c3Din4db+UmIAEL4ihEUBYH/YakX2
         75gw==
X-Gm-Message-State: AOAM5322Nly8GOgJRO5LWkUaaxzyym9Lj0/coX8DUoruTItFBEhDltnq
        7kV6AexOZcmCjsTEJ2Uot4ZiMaSDwvCugIrG1/PCHhsvwNE=
X-Google-Smtp-Source: ABdhPJxhOM2RrPSEzgZnOdeVRmrDxIofOZacsvCIcCvGJ/zYuUL5WOCQZlyn5zn1ZB+WmB9mX/EI9G+T201BR0MAMgE=
X-Received: by 2002:a17:902:7288:: with SMTP id d8mr16491452pll.18.1592137975872;
 Sun, 14 Jun 2020 05:32:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200614065251.94106-1-navid.emamdoost@gmail.com>
In-Reply-To: <20200614065251.94106-1-navid.emamdoost@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 14 Jun 2020 15:32:39 +0300
Message-ID: <CAHp75VfGHab7Oy5hhW+6rWxkcB5ZHif2hK7inbbdvfF-k0wX0A@mail.gmail.com>
Subject: Re: [PATCH] drm/vc4: fix ref count leak in vc4_dsi_encoder_enable
To:     Navid Emamdoost <navid.emamdoost@gmail.com>
Cc:     Eric Anholt <eric@anholt.net>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Navid Emamdoost <emamd001@umn.edu>, wu000273@umn.edu,
        Kangjie Lu <kjlu@umn.edu>, Stephen McCamant <smccaman@umn.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 14, 2020 at 9:55 AM Navid Emamdoost
<navid.emamdoost@gmail.com> wrote:
>
> in vc4_dsi_encoder_enable, the call to pm_runtime_get_sync increments
> the counter even in case of failure, leading to incorrect
> ref count. In case of failure, decrement the ref count before returning.

...

> +out:
> +       pm_runtime_put(dev);

Better to use pm_runtime_put_noidle() for error case.
And here is a change of semantics, i.e. before your patch there was no
put at all. How did you test this?

-- 
With Best Regards,
Andy Shevchenko
