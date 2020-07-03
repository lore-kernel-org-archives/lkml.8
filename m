Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 572E3C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 05:38:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3584C20771
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 05:38:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J3F5FQqs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726118AbgGCFiO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 01:38:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725764AbgGCFiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 01:38:14 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98277C08C5C1;
        Thu,  2 Jul 2020 22:38:13 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id t25so30860303lji.12;
        Thu, 02 Jul 2020 22:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h1uov+K62u5A2Se07Lu66mXTgr+CeyaHsNEFRryVUCI=;
        b=J3F5FQqsHYXDVpCtakrUvENojvM4ntGLPwjd/zGE+M21LLOxzopPHDUDpbC6A/86C4
         VImEqaBWgh5wi8GYyEywGyHGBkd1itq92gnI845ZiplPdIYAyOeMWz99zFpJvnEx/3yX
         000oNf/Gr0pazRRfJRs95BhRFgZo0QVYJM5lzI7++kj7EpdMp52m8OUUFwrOogLsicRc
         sHEU2hTv0k50KJUm/tRb0Xs3y2PnECzUFgo7YgHL1C6meVe9f5Lyk1Qs284yVT++exBF
         MW207H6QLvLYWlWb8Q4VA4kPlQiqYUNIEpxjQz3fUgFzx8lIO7G1duAh3p4RoBBboW1y
         cQZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h1uov+K62u5A2Se07Lu66mXTgr+CeyaHsNEFRryVUCI=;
        b=aEuuNv15VO2VQLKeOSO0KYdVI9ILcrln90b67CpmzkaZ0QqkQEByNapwC2NiY2Nohf
         gQ+APHuK8pmiVhXPHekDdm+0bJL9yPQBfM7knOrtj5h/U14arpJpvblQPA8Sn/CmxfKk
         +ExrNrWG40ozvO2+I2PiAhLOTzUMJzPBnYrI/gxnNkrWsS2mEHLr1cusGUxfxiOlpeOI
         S78m6gnHPzoE4InypY0Kxwt0CRS/DtNARTmWavXs8Wl2rhYBXz26SDii5hhekgKrt9cb
         m/f765T263wAMfSb2GZcvpECIy9zM57hgJjNLocSnrwd71FzI2D/OMEQb9P00D5VWtg6
         NEJg==
X-Gm-Message-State: AOAM533VzO7Hgqsu1A/bvr2Pc1C60BPBB5TJvVPCUUQJwzHQbn+mufJG
        YFDR0zn4jk5c9c+vcWaiqRFtHCV756epNooHP/uotCws
X-Google-Smtp-Source: ABdhPJxP3uH1PK4Lckdl4XWlAy7SFlm4hc3q+1jBe7fnm/4zvIYv5uC6h5ovGK/hwuJIcydl1w2gmHlwZFnOBp89Ksw=
X-Received: by 2002:a2e:b167:: with SMTP id a7mr9502975ljm.83.1593754691988;
 Thu, 02 Jul 2020 22:38:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200703001212.207565-1-danny@kdrag0n.dev>
In-Reply-To: <20200703001212.207565-1-danny@kdrag0n.dev>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Fri, 3 Jul 2020 07:38:01 +0200
Message-ID: <CANiq72k2rrByxzj1c4azAVJq-V7BqQcmBwtm3XM9T8r3r3-ysQ@mail.gmail.com>
Subject: Re: [PATCH] editorconfig: Add automatic editor configuration file
To:     Danny Lin <danny@kdrag0n.dev>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andy Whitcroft <apw@canonical.com>,
        Joe Perches <joe@perches.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Danny,

On Fri, Jul 3, 2020 at 2:16 AM Danny Lin <danny@kdrag0n.dev> wrote:
>
> +[*]
> +charset = utf-8
> +end_of_line = lf

While UTF-8 and LF are probably OK for all files, I am not 100% sure about:

> +insert_final_newline = true
> +indent_style = tab
> +indent_size = 8

for other languages and non-code files we may have around. Perhaps it
is best to avoid `[*]` unless we are sure?

Cheers,
Miguel
