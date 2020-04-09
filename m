Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F7E6C2D0EA
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 07:59:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4049420678
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 07:59:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbgDIH7j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 03:59:39 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:36931 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbgDIH7j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 03:59:39 -0400
Received: by mail-ot1-f65.google.com with SMTP id g23so9616938otq.4
        for <linux-kernel@vger.kernel.org>; Thu, 09 Apr 2020 00:59:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=odb2Q3M613rxo8OxAhrShA+WmuAEME3Qt4cAGc4SX3o=;
        b=BTjvcRmVtr4B1hwHdox88ZHPDZcca7hdjvj1/FE2n1ZGPB7qGJu44jNUfImZBpw7po
         p0lOTDvAv9CmcvIQ8vqfbcSaARloq4FZL4oWCqtWW2UCLNNigzxMwvLxyEsZFJxXIWWz
         9UVElFX3biro47uaR/B0LLBlVRR5siiSsQUli2E4ekpAI21a56dwc8aUF1kJKOOc5v+6
         Y2LHZPC5oD280QIQJhMKZAYrKdPqXEtT+5Zd69ejgWT2tcuU4pcTRFG8XfOdnUf8zojI
         HKGbKwXHJfoxMzkbc8E2col2wOGCjsvIZynBU6nAaruO6P8Nfxgo8CFQ5efo67yq/+iy
         SrHg==
X-Gm-Message-State: AGi0PubPXKNfmcte41aXXox+YJ2KdxjfFYgwt2q60jW3yIDNUVRs4uZb
        xZOU9FW0DVOQkVwh7W/EYiOk3o6orOLRXHKz1p5+oQ==
X-Google-Smtp-Source: APiQypIwLGFr/jdWrggd9pMzZ8XzR9IDckoirhkGh/VmjMs+c/1i3ULZTSYcpQ0W+PMEd9n07j8F4mPg0hdjK9A8+Ds=
X-Received: by 2002:a05:6830:1e0e:: with SMTP id s14mr1809269otr.107.1586419178787;
 Thu, 09 Apr 2020 00:59:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200408143040.57458-1-max.krummenacher@toradex.com> <20200408143040.57458-3-max.krummenacher@toradex.com>
In-Reply-To: <20200408143040.57458-3-max.krummenacher@toradex.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 9 Apr 2020 09:59:27 +0200
Message-ID: <CAMuHMdV0Yj-ZbjfhhfmsYOfPo-D3ZOUyMJzpFV7n+5GNVLyZdQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] arm64: defconfig: add DRM_DISPLAY_CONNECTOR
To:     Max Krummenacher <max.oss.09@gmail.com>
Cc:     Max Krummenacher <max.krummenacher@toradex.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Will Deacon <will@kernel.org>, Olof Johansson <olof@lixom.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Anson Huang <Anson.Huang@nxp.com>,
        Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Li Yang <leoyang.li@nxp.com>, Shawn Guo <shawnguo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 8, 2020 at 4:30 PM Max Krummenacher <max.oss.09@gmail.com> wrote:
> Add DRM_DISPLAY_CONNECTOR. This got introduced with the bridge rework
> Which renamed among others DRM_DUMB_VGA_DAC.
>
> Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
