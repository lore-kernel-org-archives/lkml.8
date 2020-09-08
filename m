Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCE25C2BBD0
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 08:49:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D60B215A4
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 08:49:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gzIgARw0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730184AbgIHIt4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 04:49:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729790AbgIHIty (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 04:49:54 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FF0DC061573;
        Tue,  8 Sep 2020 01:49:54 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id k15so10377178pfc.12;
        Tue, 08 Sep 2020 01:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3r9LzOgZvLPGhR01bi3/V4T//sW9SnWvvRP9YTkAmXI=;
        b=gzIgARw0PImrLpbOmnZv4pm10Co9clgvk2tYt8tfrWJdq69L9EeuYThFVfbk4L4VDw
         Ft+aKhD0K7cNlSHUz3/lEINgZi7sOz9zZt8QcVrpppEHKblhnR3298MuvLlkSCgVf2dU
         QYZZZmK0cK5vK934MGyb5fDB9yI5jEvAF0JYjtc2rB6rP9o6xNi2zWUrDaHzR7p5k9fw
         aJh5j7lgqZAot+IU+bZIFJ+vwGzq1PodlMUinKbbscv5FJqosXAHLvDy0wq3H5I8+Wa4
         2RgNupIPpTOKkWoRivgmBVHrKON4uWGXVmGXHiEe9YjrulSz/K8pJ7rWnfQBNv8yJspl
         ch6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3r9LzOgZvLPGhR01bi3/V4T//sW9SnWvvRP9YTkAmXI=;
        b=KH95Lv/OT/DDzMqGHeIXC5XBiOs7ZqrooINXf5sDvgdoVjckIVUZqVYE3U9kgHfmQs
         KEVqyn387z8qQ4Norj0VmQvflfcMFnPB2ji8Ujaqpys6BikVJzoitpLlzUwlANAPx6CI
         mSwOmYai4xbiBEYj9IE0uqgTRYsBzrQKE8GsfcEw8+/uGbEeZBna+VmxADWBnzz1Q5Ok
         c3Mdk9sZOIiCQTUqhGIcN1NhagxZ3HCQcDO+slzoHN3yh677/QRI7WnT5i3NKUMxIIV2
         SRF3WmgakW753+645PafroFmYezwHePv7L70j7o8uJaKhBhOOpfRh7Quqaw4h3eT+fnG
         eddQ==
X-Gm-Message-State: AOAM5312ZX4a0r7+JoUIra6GCI+RJQB0koQ0zd3sEnp/na9XIg79Q1kq
        9J5diTtDmORE2VwsHSxwF/EYLRhcqojbz4GRsiE=
X-Google-Smtp-Source: ABdhPJxOIHDvJCbLQ1a6HPQ0ujVbg1sElZig16a+Dtzxy7FqHOSIaNj8VQoJPmXAgVr2q4eYbzuQvvHyeBAQlHNC7/U=
X-Received: by 2002:a17:902:d312:: with SMTP id b18mr2266961plc.0.1599554994025;
 Tue, 08 Sep 2020 01:49:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200908021021.9123-1-digetx@gmail.com> <20200908021021.9123-26-digetx@gmail.com>
In-Reply-To: <20200908021021.9123-26-digetx@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 8 Sep 2020 11:49:36 +0300
Message-ID: <CAHp75Vehn_19KA3DyshXd8ASWZN2CbyFdDiUHLMnB=qd7YpTaA@mail.gmail.com>
Subject: Re: [PATCH v6 25/35] i2c: tegra: Factor out error recovery from tegra_i2c_xfer_msg()
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        linux-i2c <linux-i2c@vger.kernel.org>,
        linux-tegra@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 8, 2020 at 5:11 AM Dmitry Osipenko <digetx@gmail.com> wrote:
>
> Factor out error recovery code from tegra_i2c_xfer_msg() in order to
> make this function easier to read and follow.

Ordering issue.
You have a patch that replaces int -> unsigned int or so, which
obviously has less impact (severity) than this one.
Can you revisit the entire series and rethink ordering one more time?

-- 
With Best Regards,
Andy Shevchenko
