Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FE83C433E2
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 10:03:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10DA42064C
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 10:03:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hzWPutTj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730978AbgGOKD5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 06:03:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726023AbgGOKD5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 06:03:57 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2239C061755;
        Wed, 15 Jul 2020 03:03:56 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id t6so2846342pgq.1;
        Wed, 15 Jul 2020 03:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YEDOjAgTw7zWY0d0LxzHZsYswYj4Ul+PN0OhtVXriQ0=;
        b=hzWPutTj0Fti6f4zw9K6dbh2iH0O0m4N+pltRPKsukA1jSQzrwpy+yyxi8hlKNmzsV
         +Itu+yaBZIAzKqIool5HxKLkpq7qRbxnbcM0RmxUlvZFuF6g3nse8lwfjaj22uqi46cg
         CQMRbeeTZc4vMgCFn1B8G2y1FM51sl/dE4JhsjvV6WoHvdsozw3Toi2ECZmrBZDZuxMy
         q8s74jqC8TXh3c5FMTYw5fLpnjG+eBaXsiF6kOw2fmrp8HQwlRLkVCEuaByZzlmu2ELX
         Afx1F4KjU6b6np5efpG4F0Q1O4/d5/akx5+ca0gPKJmkia0duLZkO2j+sIhI9bPriCR+
         Nbsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YEDOjAgTw7zWY0d0LxzHZsYswYj4Ul+PN0OhtVXriQ0=;
        b=a18PG+U5ZvObsJBXva+ZBPPIzA7Y5AfAEMtnJFN+YttlVbsD64r2Zsl1JfQ9glgzUv
         C9Vrr6beY+UfTPqKpCaQVnVRR6p7Uad2pHRv32wrLKBlYxoBvAh9Td8wt9OtG39U8KIT
         WRvOuL8QFXaJuUKtYbireRcuFByDzPOIEgbz6/Pef4guaCAuDhHF+SSc+NExuNUEsi6r
         KK4G6Tf0M1CUesRD0jUeCnNQRgXvhOj1oI+7xhx+njHkHrCGCQY7dR0tpbxmGUnaK0AT
         9zO+nU/8PyjfFyVCo2TP5ZzuZVE/N53ocw4MEPaZC8dGXDSSNOv/sIyuOQy0bWcI2pc4
         qiNw==
X-Gm-Message-State: AOAM530/kw+racTnjhs8oiRe6XZ294dyzarYXOBJRAv8aK9fcNrt/JYU
        OfGj0/YbICG0P3eXqj3tDjaNLZSPyk1bj8cucB4=
X-Google-Smtp-Source: ABdhPJwoHaK/Y4fa9fYzVDnlHksNchcL936VYGXOcGuNji60pcafGnsrIQX1Ybx6Y7K7CJxyN4PFOoRXrd716iJ7Ktk=
X-Received: by 2002:aa7:8bcb:: with SMTP id s11mr7914531pfd.170.1594807436560;
 Wed, 15 Jul 2020 03:03:56 -0700 (PDT)
MIME-Version: 1.0
References: <CAHp75Ve2pPGN3BtMw6x1xR5Cyv8VP=KMJMMJ9qao29ArrxPo9w@mail.gmail.com>
 <20200714190657.47527-1-grandmaster@al2klimov.de>
In-Reply-To: <20200714190657.47527-1-grandmaster@al2klimov.de>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 15 Jul 2020 13:03:40 +0300
Message-ID: <CAHp75VcZ5f0xw9RbV0OZ0DuE6JqCfkTExqO=MJ9AE0TFdCV8Xg@mail.gmail.com>
Subject: Re: [PATCH] platform/x86: acerhdf: Replace HTTP links with HTTPS ones
To:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Cc:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Ayman Bagabas <ayman.bagabas@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 14, 2020 at 10:07 PM Alexander A. Klimov
<grandmaster@al2klimov.de> wrote:
>
> Rationale:
> Reduces attack surface on kernel devs opening the links for MITM
> as HTTPS traffic is much harder to manipulate.
>
> Deterministic algorithm:
> For each file:
>   If not .svg:
>     For each line:
>       If doesn't contain `\bxmlns\b`:
>         For each link, `\bhttp://[^# \t\r\n]*(?:\w|/)`:
>           If neither `\bgnu\.org/license`, nor `\bmozilla\.org/MPL\b`:
>             If both the HTTP and HTTPS versions
>             return 200 OK and serve the same content:
>               Replace HTTP with HTTPS.

So, please unify two Acer patches now into one.

(And don't forget to provide proper version of the patch)

Thanks!

-- 
With Best Regards,
Andy Shevchenko
