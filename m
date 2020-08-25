Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6860CC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 10:14:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D1FF2068F
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 10:14:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="M/PtUB4K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729824AbgHYKOy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 06:14:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729628AbgHYKOu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 06:14:50 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E47CC0613ED
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 03:14:50 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id t185so3850089pfd.13
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 03:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=7rwFpGB0jqzG4o75dmr4EB0rdrd4ZLlpij1Rdr6z7sQ=;
        b=M/PtUB4KjjTHuTdSYpItjttdYYbS28ynKSnqFUSozz3H8OCLStD3jgywui+4gm+wu6
         8tyfb0/nyW04muJVNiqXLIVBNZpSeQIo5xX5zQ3HzHXqO0Ms00OzVOAAq0lz57jI7VNS
         vjUxHHG2zreutCgU9mn1cn7AJFZ26YUixAxo8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=7rwFpGB0jqzG4o75dmr4EB0rdrd4ZLlpij1Rdr6z7sQ=;
        b=jOE6byonNdSB5/N9OtHDaFJSYWljbjVlkt/Qon34G8OYxP/1MCfEf1WpH0bG8Sv+2d
         9uS2j5XvFXB9wrHgf3DWgmQXQ+PVmWyPeS7WEbCLa0MeqKWj98iqhECJr48Pv3yTyHsl
         rvyi3ydhKdMkDPXizms79wcJPQZfS+xSZcFG2LS9AgGQqxS+7xHBZgF6vTDsQrOa4yb1
         1QvIjjUb/QQXU/e8gYcjt31hAqse4VE6PPkaQlIzuHTaOlfIShIEfSseu3RhUtV1s/5T
         XOkhG8D1gol/MjUUcjrJNQ5FQLq3LcTr8iH6+e4H7pmCgAUdBlrVQuP4KXO9mMY6CW7S
         CJ+Q==
X-Gm-Message-State: AOAM530XxCrdGiFhk7uIpzA/HVcnfsfHcwpftXvq45YwdPIsFFWXWdJ0
        AmXPC7ZI5wHQQJ0Lrj4+36ny84jAdffaFg==
X-Google-Smtp-Source: ABdhPJz9AmR1krMoLgXTaINdzVk9Mmj7SkBUNtvH3DTsMz4galYrk+aWROWLBoUMdxiQdSEgiZiRGA==
X-Received: by 2002:a17:902:b087:: with SMTP id p7mr7119096plr.28.1598350489931;
        Tue, 25 Aug 2020 03:14:49 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id 37sm2385284pjo.8.2020.08.25.03.14.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2020 03:14:49 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1598113021-4149-5-git-send-email-mkshah@codeaurora.org>
References: <1598113021-4149-1-git-send-email-mkshah@codeaurora.org> <1598113021-4149-5-git-send-email-mkshah@codeaurora.org>
Subject: Re: [PATCH v5 4/6] pinctrl: qcom: Set IRQCHIP_ENABLE_WAKEUP_ON_SUSPEND flag
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-gpio@vger.kernel.org, agross@kernel.org, tglx@linutronix.de,
        jason@lakedaemon.net, dianders@chromium.org, rnayak@codeaurora.org,
        ilina@codeaurora.org, lsrao@codeaurora.org,
        Maulik Shah <mkshah@codeaurora.org>
To:     Maulik Shah <mkshah@codeaurora.org>, bjorn.andersson@linaro.org,
        evgreen@chromium.org, linus.walleij@linaro.org, maz@kernel.org,
        mka@chromium.org
Date:   Tue, 25 Aug 2020 03:14:48 -0700
Message-ID: <159835048820.334488.6676713863169872150@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Maulik Shah (2020-08-22 09:16:59)
> Set IRQCHIP_ENABLE_WAKEUP_ON_SUSPEND flag to enable/unmask the
> wakeirqs during suspend entry.
>=20
> Signed-off-by: Maulik Shah <mkshah@codeaurora.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

maybe just squash this with the other patch in this area?
