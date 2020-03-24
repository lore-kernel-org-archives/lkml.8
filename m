Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6788C4332B
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 09:06:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDC56205ED
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 09:06:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LbrZCbzm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbgCXJGZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 05:06:25 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:42865 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726565AbgCXJGY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 05:06:24 -0400
Received: by mail-lj1-f196.google.com with SMTP id q19so17673432ljp.9
        for <linux-kernel@vger.kernel.org>; Tue, 24 Mar 2020 02:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uXJW3NYqkzBJPg9G4K5LGYBd3XGQpGvoVNtbcm5Oumc=;
        b=LbrZCbzmZx+Kfb1Pm57HvFHXuRgH444WCs3KnlNJ9YLTcdWzcACe0XYOMLFNxSnkVH
         wN88biDhrK+6HtUJj35VD4dFzg9cGhbGQzAhpXmOrRsqZITX0hTej20qj+VRoR4uNBfZ
         3tUJpYkAFikVpIS6Bp8KePAb0Bq5MOTC1YBDjTrdFWYIi4okAdmrkjf7eH+cDjfvswnY
         eNJfCdKTpTYuGH9iE99z6qcWe86ldjM8DxZknJTAJcGlNvFpAvX0Pfg/dQO7bRVTt3WB
         AbQPQpSOS9CCHsoTsEYTkgwyICLIzP9k6ivxee5YATXOa10Axoo/TbZqZvmtGqKAQxpo
         32Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uXJW3NYqkzBJPg9G4K5LGYBd3XGQpGvoVNtbcm5Oumc=;
        b=ZHZYMEycSvXlh1SYuEa83numRzWQ4ztkYxWhGgi3YuZvOMCb1a0AkAmYVe6Q3UzLHH
         o2gacF8tIMMcgoriiVmvxsyVaf8pYmTOgMSj53cnU1Ki7d0ZGAW2bDgXho195uXMtCJo
         O/ZZCH2j0ZiuaujZvscE8qTeLdsDtFin9Y0IZ2ZWzPV6MCrVxH1x1R0AYOQRQ6u5YZc/
         JxhrX5nJl8PPKDWR855KFkHarsY7A9YQTP8kU1qvZig4wC7GiEutuHXJ44H/MMhfACKS
         7spv7cCfAhW+sfdqQbnOdE0MNdzmyre8NS2ieLh64eyuiBhrGgdM0YdYpKHw70vddIY9
         Mfwg==
X-Gm-Message-State: ANhLgQ0CYOasTtnTwXfETIpAmKANiD3GOXq29quJQyB6AL/iqMWD6udN
        a3VvOtCgXZYaOkPTRUABPLbhZVykVyPMe+Wo+OXCxQ==
X-Google-Smtp-Source: ADFU+vsS0Vgh95i3gLQkXN72OAT1r7M91nH8bLgfI97o39Kb3z7Gj4YEOvUgl0V1KX45mkYxQ/82vB1+XBwxrugyzW4=
X-Received: by 2002:a2e:8ecf:: with SMTP id e15mr17140251ljl.223.1585040782184;
 Tue, 24 Mar 2020 02:06:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200323184501.5756-1-lukas.bulwahn@gmail.com>
In-Reply-To: <20200323184501.5756-1-lukas.bulwahn@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 24 Mar 2020 10:06:10 +0100
Message-ID: <CACRpkdYUURewhao=uDbKOmn2OnhBN6G6qnjUXgN2OBH_w_u2Qw@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: adjust entry to ICST clocks YAML schema creation
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Rob Herring <robh@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Joe Perches <joe@perches.com>, kernel-janitors@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 23, 2020 at 7:45 PM Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:

> Commit 78c7d8f96b6f ("dt-bindings: clock: Create YAML schema for ICST
> clocks") transformed arm-integrator.txt into arm,syscon-icst.yaml, but did
> not adjust the reference to that file in the ARM INTEGRATOR, VERSATILE AND
> REALVIEW SUPPORT entry in MAINTAINERS.
>
> Hence, since then, ./scripts/get_maintainer.pl --self-test complains:
>
>   warning: no file matches \
>   F: Documentation/devicetree/bindings/clock/arm-integrator.txt
>
> Update the file entry in MAINTAINERS to the new transformed yaml file.
>
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>

Thanks!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
