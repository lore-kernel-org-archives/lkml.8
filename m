Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4742C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 17:54:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A82E206B5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 17:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596822842;
	bh=N+GS6F5aVcVbadrPHDZ3S899LD8oJk65T0e735WXVrE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=AGba7HzgM/6MoC5A7CVNwgefIv+VZMo175NVn7YANFlx8uVtpmgsSrpc6g3DpChXn
	 PrrPomSIjGVBBayDHH2FE/tG0Xt2ecmzS9wOJC7uHpC0JErb0CQ106zTJKWZk0e/X1
	 EW4o5EyR+Z4cXrKBOc21kdCeJH0WxZPV2BtFx0Zk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726645AbgHGRyB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 13:54:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbgHGRyA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 13:54:00 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8937EC061756
        for <linux-kernel@vger.kernel.org>; Fri,  7 Aug 2020 10:54:00 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id o18so2944919eje.7
        for <linux-kernel@vger.kernel.org>; Fri, 07 Aug 2020 10:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wGFdCB+GKzD87ayJg5twz22vO2M3+oAnG+AZmdx2+Tw=;
        b=GCOfjs+cadNP985tRMOkg0b9IlsRY8+J6xskzLilbV4gipDWDZWq5J7PTntv9s55c7
         bcx+/eye+O1SxIol+V+cpcPjdB/U6QiD/y5l/VzXIlqlPvd021eERPXLfe1WTQFvpU7E
         wzK9G07x2PKrmcJ1rZ2IxQqa42zF4PX91vFsM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wGFdCB+GKzD87ayJg5twz22vO2M3+oAnG+AZmdx2+Tw=;
        b=WTjOoyqyjXEEO0HF5SSVj631gscRJguqmrOLCDDWDjSg9FQXbtGlgOTlja8NFmZq4y
         FWHfdkIhvMAHIbRv52nYXShnV7dGw/8j/ofKCb3DIu+NoYbc9+mhK12ZKFHCH3jDtMVN
         vNcf2tcQ4upQSZD53ghhrWCCIy5N02Ww1zJWp/EWh9fmGkgaC57TKlWmomuf2JVFsKAo
         1WwwT2tvywUcumf9LTBBckf/Z2GX8XS5ZDeLpUcEjkzW1E9VI8R0emNDdkTII+3g2QFf
         87pZxCVjKBCGkSmz3fckoWApaSABaiA9gdzd8Vv6fB/ToROwrX23wb+QZ5thOKWhcr/f
         /CxA==
X-Gm-Message-State: AOAM531enhzoNseTOilsygogxUe1O9sKczo7Tb6fm1o723c+7Mn4aWWK
        Di8M5uOFbKhUajUzvvDzOcYPY/oVNiM=
X-Google-Smtp-Source: ABdhPJxHWbvmMCbWTCWrgn4Lvuhu9Ca2rsGd9cjyI1rO3nU3NsmoCmedBiBIZYyhi2TNaOyWBhSORg==
X-Received: by 2002:a17:906:a204:: with SMTP id r4mr10227345ejy.552.1596822838930;
        Fri, 07 Aug 2020 10:53:58 -0700 (PDT)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com. [209.85.208.48])
        by smtp.gmail.com with ESMTPSA id a18sm6379907ejt.69.2020.08.07.10.53.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Aug 2020 10:53:58 -0700 (PDT)
Received: by mail-ed1-f48.google.com with SMTP id q4so1837586edv.13
        for <linux-kernel@vger.kernel.org>; Fri, 07 Aug 2020 10:53:58 -0700 (PDT)
X-Received: by 2002:ac2:46d0:: with SMTP id p16mr7083884lfo.142.1596822532290;
 Fri, 07 Aug 2020 10:48:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200807144521.34732-1-linux@roeck-us.net> <20200807173513.GR6750@gaia>
In-Reply-To: <20200807173513.GR6750@gaia>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 7 Aug 2020 10:48:36 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjh1qFxHc2kScvcusv_f3bYangc3cro9s_WCPOvd+biTQ@mail.gmail.com>
Message-ID: <CAHk-=wjh1qFxHc2kScvcusv_f3bYangc3cro9s_WCPOvd+biTQ@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: kaslr: Use standard early random function
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Guenter Roeck <linux@roeck-us.net>, Will Deacon <will@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?RGFuaWVsIETDrWF6?= <daniel.diaz@linaro.org>,
        "Theodore Ts'o" <tytso@mit.edu>, Qian Cai <cai@lca.pw>,
        Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 7, 2020 at 10:35 AM Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
>
> Linus, could you please pick this up directly? Otherwise, it will wait
> until we reach -rc1 to avoid basing a branch on a random commit.

Already done, since I was the cause of the mess. But because I did it
early, your Acked-by didn't get in.

              Linus
