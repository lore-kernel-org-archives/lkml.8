Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17BF4C2BA2B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 08:00:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DEC9A206B9
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 08:00:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bUozIsQs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440361AbgDPIAm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 04:00:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2439837AbgDPIAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 04:00:34 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77C59C061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 01:00:34 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id x23so4880085lfq.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 01:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tjVFjiLUKq2dceYjR/sUZuoN+VaM2KkSpDEryVFjJAM=;
        b=bUozIsQsOLIKrmIe04JjO05g7JBKyqXq8AdHzoY9+98g1GkgDs3t0ZDClZymhjwkrp
         MByC50ZFFHYsMPZGUI3oyH1zekRuiC/DmTVL+6fK2pnd31mlDaqeXshW2PrfW6TKGkh5
         dBeBVQy2o/c8U3eusS+I18vX7fIsdLrap/MTuqke74f8h1sfJsA/vNI7QewuTkLGLfiX
         LZDVWtncz77CnlPHYu7z1PwxOXGCgThpfqHN2sydIRa9pH9054gcPx/FnQbBWcbrFCu/
         B2wJoM2zJjIqKJYQ4ZUYjeTBW3+l3o13HlulzKtS/fh5gGg9WHIISWPjKIz6H5cx0w9h
         Nn6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tjVFjiLUKq2dceYjR/sUZuoN+VaM2KkSpDEryVFjJAM=;
        b=bny+xWmTk61stVXZzrPwAAVAnJPqPJvp5DbxQbrhgSRIYkCrp2FOy06orG5hDS3rBY
         yJAZKxxTBoeG52Gupj2F2eutT0FzDHhOTuKDE+9Woi2KvDNVo38ONeIn2AfG/qqlyzTJ
         zxj9a/a1rUiJOt1VjkCm5tnU6xrfMFtfKxteNZ1PWyKV7P4qNDnRVumru7natlk9y2EW
         K5D5tFy8c6LD+JVdfU0CTg8MQK24vrXTx+WyrZmj9bGH9Q9xT+vi564VPocp4dYTn7ma
         c4GIKYPbbCU9e3kVC8REC4v4cp2gGRyfQwgmP8aWqvIkyEhbITtWDGZbT+F6qlJFAXEv
         ETqw==
X-Gm-Message-State: AGi0Pua5ejs28XTzY2djS3CqotMN22YGAgJBuTNlg7gyw5WZfk7hcU7s
        F73qdSWzbTtgPTzt1xq6nfBhkjN0jVLlONmzitpEog==
X-Google-Smtp-Source: APiQypLJmZ97wdSRNvt5K0Vot48JkDgvMOmnFHGu2O4iKZQqqK02fJBxbBO5EYfsbjVxASLotokCg8oMB6V5oELv+9k=
X-Received: by 2002:a05:6512:685:: with SMTP id t5mr5198837lfe.47.1587024032955;
 Thu, 16 Apr 2020 01:00:32 -0700 (PDT)
MIME-Version: 1.0
References: <9feeb04805e5a406fe22a92e3f280abda39ddda4.1586289920.git.sean.wang@mediatek.com>
 <42100afe6f97d28447c153bea6b54ea556cf95ca.1586289920.git.sean.wang@mediatek.com>
In-Reply-To: <42100afe6f97d28447c153bea6b54ea556cf95ca.1586289920.git.sean.wang@mediatek.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 16 Apr 2020 10:00:22 +0200
Message-ID: <CACRpkdbszsyw550SZHBx73SHhUeDsKYC7od4pQRvpH+OdorCHQ@mail.gmail.com>
Subject: Re: [PATCH v7 2/2] pinctrl: mediatek: make MediaTek MT6765 pinctrl
 ready for buiding loadable module
To:     Sean Wang <sean.wang@mediatek.com>
Cc:     "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Light Hsieh <light.hsieh@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 7, 2020 at 10:08 PM <sean.wang@mediatek.com> wrote:

> From: Light Hsieh <light.hsieh@mediatek.com>
>
> This patch make pinctrl-mt6765 ready for building as loadable module.
>
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> Signed-off-by: Light Hsieh <light.hsieh@mediatek.com>
> ---
> v6->v7: remove change-id

Patch applied.

Yours,
Linus Walleij
