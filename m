Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B2E9C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 12:48:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34866206E2
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 12:48:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C8GJ0AEZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728110AbgGGMsW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 08:48:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbgGGMsV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 08:48:21 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0C51C061755
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 05:48:20 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id b25so46131860ljp.6
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 05:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gwFkr9PneqZ4BhGceqJcWLMBZ8ayMTmUffDRY3KogpM=;
        b=C8GJ0AEZDliCyMztSZ1Ndjq2eS0XawACLjHxvQBVSC41f1JQyvBNO0ltCwFvJ+V3Wp
         FuocpbPZlCwKmG9B0Znl774ZjJ61Hdrthc/ejy+RptFvHBL39dz0DnJyE64ihYHgm1ib
         TiabjcFpoEc8J08Rk8lLIbNiPp74m4juJnhe7M2q+WvfkKJ7TAaGI2tPqMg6JhvX6kxk
         1m6LRktdHE2kCLlVyuIeUdKDj6ThiAmxEyLUB9uzWDwB3CqACC33zI3jM5PJfTp4Upxe
         HgTmMk9Q9BOFOY62P6KR2fJV/CJVSakQ2J2x5L5OB4lsIXDCJPAAR1TgixQgdDONKE8S
         aQKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gwFkr9PneqZ4BhGceqJcWLMBZ8ayMTmUffDRY3KogpM=;
        b=kWQHg+SInCGZsDtXeeXSYQGDeHJZ/ksmJpeYmYQDmU5mpBpLdlfo20FEvoA2E+Awav
         zH0M+xf3KadxgsmxwE5tftLZSXCHBaBSQyrtvUgodJFEXYlh+LMdiwrq4amq/cSxlkW+
         lp6bm4vA6kq6vFf5a6BEwX3gmi/FLfjfYwsnhyPq9+FXEEpDKoI4osiW4lnCZwYyg5ng
         KhIhjcsvha9A5lRbqUZRXvZQLt10oVyPKe86jFHC2RsxHu89R2mfaA1fGRnyKCB5zrm8
         m5RHa6yKdg4SFfx5c6gqczdrtG4cfZmX5G41aiTtvmWvpGMMuLGydYWeeB+HeT9LfOTy
         6YaA==
X-Gm-Message-State: AOAM5313z1aDxXI/oZCtmnWJ8d64ESuEXE5PAZLI2If2kbNiofv6q9eG
        ctu/8Aor8hJv/2YErn2qrkCu+IqJHRxi+xllvBxysqmy344=
X-Google-Smtp-Source: ABdhPJw9YFOFLjB0RSApXXWHfC49AyKtASlEPy7NeIw7/vvd9BnOj3rZCXjqZMc1E4Q/oQmgHVx15nwCJxmyXW+poWg=
X-Received: by 2002:a2e:9c3:: with SMTP id 186mr31300548ljj.293.1594126099519;
 Tue, 07 Jul 2020 05:48:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200627192833.217531-1-bartosz.dudziak@snejp.pl>
In-Reply-To: <20200627192833.217531-1-bartosz.dudziak@snejp.pl>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 7 Jul 2020 14:48:08 +0200
Message-ID: <CACRpkdangAYj6_M7=P5yVncATozZUtb=Fo3zNKYCa9FwHLFfxw@mail.gmail.com>
Subject: Re: [PATCH 0/2] Qualcomm MSM8226 TLMM binding and driver
To:     Bartosz Dudziak <bartosz.dudziak@snejp.pl>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        MSM <linux-arm-msm@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 27, 2020 at 9:34 PM Bartosz Dudziak
<bartosz.dudziak@snejp.pl> wrote:

> Binding and driver for the Qualcomm MSM8226 TLMM pinctrl block

This looks good to me, but I'm waiting for Bjorn to review it before applying.

Yours,
Linus Walleij
