Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D53CFC47259
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 08:02:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7408206B9
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 08:02:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cbLyXUbn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728422AbgEEIC0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 04:02:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725766AbgEEICW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 04:02:22 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0673C061A0F;
        Tue,  5 May 2020 01:02:21 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id f12so1001909edn.12;
        Tue, 05 May 2020 01:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZHJL/wGmA1GyknYa9LMPwyUmT5ntJmA/lvZzR1e4zDk=;
        b=cbLyXUbnbqNHYqTiQjFmduESXf4qSe5tDFHsdxZZXZk/l62hp5Pgk+zqPkbPvIFzqk
         amS3lkjHZuOoEWea/p+sm4wB2QLJ4WgjBjk5amoM04xJwgnbsuXq2/Ym5MuihL15/169
         vOb4XfI9vcGlYFZcIZS6LMs2ekJScUhjxoWZ8iQAkWU4MyU3kLvKN2o9x+2g9VKp6Hz9
         YbBtZJiyl+2UF8aHcB/ErrK0/tE8lWDESUdzH5nyd+5Qg8RI2NOkKCnK1/Uw0DwlD6xt
         xICn3Nt9+D6KnW8L9dsUo3NZuXS6HywNOf3LrySnfjEFoqAaz92T+KzrQgDnQD25UoGw
         ASQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZHJL/wGmA1GyknYa9LMPwyUmT5ntJmA/lvZzR1e4zDk=;
        b=mJy1SM2engl6Db1qPe/HH3BEJEWjadHKsmLOXq+uPhl6Z5zZa3V2ywFNdFlpM6vGDp
         v8Yavi/VjUbTFLvBDq7oapPF8gGA3xLAs11XAT4KWzXlghS090JQ/lBVATc69QNcHvsw
         lnxeaRAFrWxexpyNWMD7yl9LwJ1/ThfW9xBBCQPyx2/p9UOWghAEsqh3a2HXa+WZsfgr
         1UjDYYh0BBzdESad3HxhKCibcWKdCaAcOg6fynWU3TUH9x/zhyg7CqrkN7JuL4PyYeUh
         yshqIqwShdBEc7YWjeSjXeDlAHjJEkS67CFOtWbwVLEIMFIU6M/NrvlrtLeYWmi2/Jsm
         B+lQ==
X-Gm-Message-State: AGi0PubwQt1/QQ86jzYoWnPtdwFw0tr/s40tRY378VV4f3wsytuLyZCh
        4O3J27UvMmoVGKrixY5vviONZYlUf+PJPQlFymijtYp7
X-Google-Smtp-Source: APiQypLAbEUiBKhR7J4oihPY5/Cw3SuGUar4Ny8CfFZU1JA3gTWXTGBKmn8SMdIoMJ1FxTfxf998ZFXhw5+I0wPhexs=
X-Received: by 2002:a05:6402:22ea:: with SMTP id dn10mr1489129edb.70.1588665740372;
 Tue, 05 May 2020 01:02:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200501203505.144362-1-konradybcio@gmail.com>
 <20200501203505.144362-3-konradybcio@gmail.com> <20200505035543.GA5765@bogus>
In-Reply-To: <20200505035543.GA5765@bogus>
From:   Konrad Dybcio <konradybcio@gmail.com>
Date:   Tue, 5 May 2020 10:01:44 +0200
Message-ID: <CAMS8qEUF-M13Mn91DDWLqqPLwD=t6W4BqTd+BZ9q1oa7MCo8cg@mail.gmail.com>
Subject: Re: [PATCH 2/2] dt-bindings: media: Document MSM8939 Venus
To:     Rob Herring <robh@kernel.org>
Cc:     skrzynka@konradybcio.pl, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-media@vger.kernel.org, DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ah, mea culpa!

I completely forgot to mention that this depends on the MSM8939 GCC
driver that has been sent a few days ago, sorry.. [1]

Have you found any additional mistakes in this patch that I should
correct besides this one?


[1] https://lwn.net/Articles/818486/

Konrad
