Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6148C3F2D2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 23:25:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B853C2469C
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 23:25:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hd8jSV8z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726603AbgB1XZz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 18:25:55 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:43237 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725957AbgB1XZz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 18:25:55 -0500
Received: by mail-lf1-f68.google.com with SMTP id s23so3302402lfs.10
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2020 15:25:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dGzWMu4XBpH6ZuiaOU4SkMnEwOu+vcJlnvYgz7BApTg=;
        b=hd8jSV8zpXXGza6L6G3ymjxMJXgY+rMSU6HHDbrcrq2BxjPzx9wUvpBoLGUSD6XIH3
         9JwP8OgYtNI4RNyLQcfPcaMDlPO60XS6yo/jiSQV154OMAfGv6WFbnrKf0Sl8XOK6wyM
         ccPmgyBxa4bM4bsaqkqxtcKyWDu9RpQ7Oc5OpJcRgCxWI3ZSmIQHKt0CQALV+IbUBHD5
         O9PHjECPcWgnrVRXaLzhF+rEmGhD3aQSr3AiBdrKiSr/yZuIb+5C0tk27ZhUNNYW6J2i
         i1sMaTN1TVImUppa0bK0vUA8gUYG4msYyDfgXvPQpENzXkaffwYOzO4XElnAH22OuRkD
         BZ8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dGzWMu4XBpH6ZuiaOU4SkMnEwOu+vcJlnvYgz7BApTg=;
        b=ViKkctezBIOOsEQZ228dxt3wQGcf1mwQcQckofSmT1lllj3DoUR+nKrMenu0TqUNqo
         SMFFmRF7mGJc47uIIAEYpwd0YGm/9jrpnteQto+wamMRE/JI885SIP83HwPlb36hpsD9
         gQswAdZMCICyyjn0y5LUPU86QmXa/BoiBiPnbJRb/xTanlkZpE5N6qJk8XEQnrEQeX8F
         edomZdZNC7kuXLN3kgVXfkeLKRYZ9vSyy1LCnUT7NA7tgoK7XLeuSiRhd/XEA4XDxTIY
         GViIvxM0iYJ4rtwtd38OiaE24agmrkXq/89qMThbqoVX35DsY5Y2+qtRyjrqu4T/GrZs
         YKoQ==
X-Gm-Message-State: ANhLgQ3WvkEj9FoDGXL+XG4miJrUnMYz4CYWCd4rgHu97bVANG/TH9+v
        XGA/Lx1/MxuYBiGlP/pXfOaynAPtGrniXuOdh6ciqw==
X-Google-Smtp-Source: ADFU+vt22lyrw7moxExhDGl8n/IQ3BjuLK/mIfpVH1gfOaJRjaKyKXYZdA+gW+XCRueBh3uOay0x6spXFd7hMrj0mKY=
X-Received: by 2002:ac2:44a5:: with SMTP id c5mr3643708lfm.4.1582932351327;
 Fri, 28 Feb 2020 15:25:51 -0800 (PST)
MIME-Version: 1.0
References: <f4e7e20afacb23e6fa7a6b33ea4319b2b3492840.1582776447.git.baolin.wang7@gmail.com>
In-Reply-To: <f4e7e20afacb23e6fa7a6b33ea4319b2b3492840.1582776447.git.baolin.wang7@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 29 Feb 2020 00:25:40 +0100
Message-ID: <CACRpkdab7YLq-VoNZkB5uWSPLbFW3CyTkB+eCNgFG8KC9G3Msg@mail.gmail.com>
Subject: Re: [PATCH 1/2] pinctrl: Export some needed symbols at module load time
To:     Baolin Wang <baolin.wang7@gmail.com>
Cc:     Orson Zhai <orsonzhai@gmail.com>,
        Lyra Zhang <zhang.lyra@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 27, 2020 at 5:13 AM Baolin Wang <baolin.wang7@gmail.com> wrote:

> Export the pin_get_name()/pinconf_generic_parse_dt_config() symbols needed
> by the Spreadtrum pinctrl driver when building it as a module.
>
> Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>

Patch applied.

Yours,
Linus Walleij
