Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAAD7C2BA2B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 01:21:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9DA7D221E8
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 01:21:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OkffA5YA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728454AbgDQBVM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 21:21:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727799AbgDQBVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 21:21:12 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B066CC061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 18:21:11 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id f8so451782lfe.12
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 18:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LaONKWgXr8zyDwWe0+sivX1BYZmtza8MMh1LlYTiEOE=;
        b=OkffA5YA/RaFqQiMJeitAab2djlVP8l0eVmlFvlB6GTDn3+tWPcEAodKyovkZtTM3T
         FKAffdCQltGEEfdJj4fxDzc0ppZAsWnj91a9y2hgfQTgAdXt/ILpVpty+LWe2QKIYrtD
         /71n6hpyHc6teTTY7W8I4aiRIzaJTlALpwZs8YY8Zz304GAs12TnjQP+ssu/qaqhbTp2
         aibN9Fs6zwmz95TfDbRyCD9fjooyXEndwbDNOpwJAhyjDuMh9P69GP2yGdci4MsHsKZu
         M3aTXJI24iPOpO0PaLdk2KQjXvCxBJXHyg0WSBh+ZRKI4dPNqxHijiEisb8nrbtFsJif
         wzzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LaONKWgXr8zyDwWe0+sivX1BYZmtza8MMh1LlYTiEOE=;
        b=kyXZbkshZV0OYOdCBGog+4jvGqNI+c05sC8D38jGAIwBaXl1V75ynu4Mux4kVycFUa
         wuxDfjGk+djosqljnbYZCv1/ZaD5X7twXZYxV8b1RFxPItiN1PjVSKCE35jcjyn0HUZn
         aW5nnm90JwR1GuaFLWliVG8L73mqjgVx5otXVTcQ8MtqyV2jo0mTnc+zk7Emi2OrasL3
         WZw6XPDwKNRjAGLw3HDjz87LGuxkaW9KlIjGjsUb8w972ADGZeRGcly5GC/Vslz/dmtb
         buC52ONO9HtinGW8es5yENrb9zGLaiL34UwJZ70BYsrcXvIp8d9f940K9HRF8Ed3eKOW
         n5pw==
X-Gm-Message-State: AGi0PuYALKaZjQDhkhvHLfqEMwu/764T9YgizodzuOe/d6Z1oMj8h/0b
        vJNlJRdrTE08Ma2OWYPQwkuzdENugVvDHyVIBeQ=
X-Google-Smtp-Source: APiQypL5UmwCU7kYx64cxx72h3wLekm2xKFL92eRjwC5e9YvbuJU5LL0Fk0b64YTTqT0vjhwSgT9zblFm8wfy8//wHA=
X-Received: by 2002:a05:6512:10c9:: with SMTP id k9mr365986lfg.183.1587086470112;
 Thu, 16 Apr 2020 18:21:10 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1586757922.git.baolin.wang7@gmail.com> <ca403b816af38eae68ca7399640c82d0345a2296.1586757922.git.baolin.wang7@gmail.com>
 <CAK8P3a06fed_WVmO84iod2VpY386_3J+V=A-M+W7yE57N04a8w@mail.gmail.com>
 <CADBw62r06X6mMTx3eLY1iU5KLOK644d1vA49Kp9JXzUtm2CpCw@mail.gmail.com>
 <CAK8P3a3jnpRDjWwAOJa1EmbMzu+vKXmG3DBzhjHtVFz8NHfP8A@mail.gmail.com>
 <CADBw62oNApMo_rCz1W6_tG8Z72ENjrAtHkWZ1Z4NsN0qWFctXg@mail.gmail.com> <CAK8P3a07n=5X5Cv7crAu_XCzoLA=o1wZjmO5r6=bwdGr2nHSwQ@mail.gmail.com>
In-Reply-To: <CAK8P3a07n=5X5Cv7crAu_XCzoLA=o1wZjmO5r6=bwdGr2nHSwQ@mail.gmail.com>
From:   Baolin Wang <baolin.wang7@gmail.com>
Date:   Fri, 17 Apr 2020 09:20:59 +0800
Message-ID: <CADBw62pg6F4PiD=jJnrFDmaMN6yh76PSJ1=2_DZjwMJVQ+pFdQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 3/3] soc: sprd: Add Spreadtrum special bits
 updating support
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Lyra Zhang <zhang.lyra@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 16, 2020 at 10:38 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Thu, Apr 16, 2020 at 3:49 PM Baolin Wang <baolin.wang7@gmail.com> wrote:
>
> >
> > OK, I think adding a Spreadtrum compatible string will be an easy and
> > clear way, so what about below sample code?
> >
> > DT:
> > ap_ahb_regs: syscon@20210000 {
> >          compatible = "sprd,sc9860-syscon", "syscon";
> >          reg = <0 0x20210000 0 0x10000>;
> > };
> >
> > /* The Spreadtrum syscon need register a real physical regmap bus with
> > new bits updating method. */
> > if (of_device_is_compatible(np, "sprd,sc9860-syscon") && syscon_phy_regmap_bus)
> >        regmap = regmap_init(NULL, syscon_phy_regmap_bus, base, &syscon_config);
> > else
> >        regmap = regmap_init_mmio(NULL, base, &syscon_config);
>
> Ok, sounds good. Maybe also define another compatible string that
> is more generic than "sprd,sc9860-syscon" (but less generic than
> "syscon") so you can still identify the chip specific syscon area if
> necessary, while not having to list each future chip individually.

OK.

>
> Something like
>
> compatible = "sprd,sc9860-syscon", "sprd,atomic-syscon", "syscon";
>
> Also I'd add an IS_ENABLED() check so it gets the 'else' path
> at compile-time when CONFIG_ARCH_SPRD is disabled.

Sure. Will do in next version. Thanks for your good suggestion.

-- 
Baolin Wang
