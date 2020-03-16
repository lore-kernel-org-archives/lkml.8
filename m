Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0535DC0044D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 11:02:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD80820719
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 11:02:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Zem311Tm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730822AbgCPLCY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 07:02:24 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:33626 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730811AbgCPLCX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 07:02:23 -0400
Received: by mail-vs1-f67.google.com with SMTP id y138so3138627vsy.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Mar 2020 04:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HYXCjPHfs8dDfhMy2nCW/5veOTWbVHj4w+BgbYglN9w=;
        b=Zem311Tm82+PW9OL0vHqTxopdfny3jc3ZE+5GcIB/k1E6y26PuHdotm31jnVEgAu2b
         yYWBSFnKG1yumWYVwPsTOthW1KXvZzj8qOFYZn8U/LSQPeQvBWgSEzaWyUl29RslaE22
         OoDm8bwT1CbaIQ4FEs8oahpIjPMC5ERkBHvsM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HYXCjPHfs8dDfhMy2nCW/5veOTWbVHj4w+BgbYglN9w=;
        b=c+0gwoWbdld8ZW3hu5akkcQK7sq8xzsI592kW3ZrsWsheYtzP+swahpsXnyfkD8Z/3
         gah6vTtatf5eZc9TojgkKIul+f1RUdP6HVjTZwCSYNzX/svHF/J7T9HnyBKfoiLFmVU9
         0irF8SnBg1dOdyp2IURxEqk24kglWCWF0OpeNmaxPR6WAgmzN97mMvk+NdKjqMUZcYuK
         gJtQHaUz38+LSp2XnwZL7+ux8dNjZaF7ofjobQzpoNEk4pI4Qk20qvaMeS6f6CW3atpJ
         9ma3enkFxRBl5yh97Mk/2VUMBVtP8Yz1d18Xc31cPhzWwLo0CwfOtBOA9NShJKdc9w27
         bhNg==
X-Gm-Message-State: ANhLgQ0HBR17rg/1kLIxZ1XvtptWhrIrIy8Y2TLAUbYMP9FM6gg72JTv
        vmXJrBgD5SEqZ3/aIcU/SrGoMUr/oPTL9uPx+u600h0fkcY=
X-Google-Smtp-Source: ADFU+vslL7SUJTVlPVk2d8S7a0jEhOnlOTTT7KU8Dg+Uf7BqOBjcuL5F5OWDFxyBWnAFO5VFRqBRQWH6xWxqn5a3M3c=
X-Received: by 2002:a05:6102:392:: with SMTP id m18mr15598517vsq.79.1584356542437;
 Mon, 16 Mar 2020 04:02:22 -0700 (PDT)
MIME-Version: 1.0
References: <1584345050-3738-1-git-send-email-hanks.chen@mediatek.com>
In-Reply-To: <1584345050-3738-1-git-send-email-hanks.chen@mediatek.com>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Mon, 16 Mar 2020 19:02:11 +0800
Message-ID: <CANMq1KA1ngYhr7XO0k3xb0h7L-DX+TjiekvnGGOTRqz=BQPREA@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] dt-bindings: cpu: Add a support cpu type for cortex-a75
To:     Hanks Chen <hanks.chen@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>, wsd_upstream@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 16, 2020 at 3:51 PM Hanks Chen <hanks.chen@mediatek.com> wrote:
>
> Add arm cpu type cortex-a75.

Already in Rob's tree here:
https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git/commit/?h=dt/next&id=5c2614e995de07b41eb355155eb5e0e3d593718b

> Signed-off-by: Hanks Chen <hanks.chen@mediatek.com>
> ---
>  Documentation/devicetree/bindings/arm/cpus.yaml |    1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/arm/cpus.yaml b/Documentation/devicetree/bindings/arm/cpus.yaml
> index c23c24f..51b75f7 100644
> --- a/Documentation/devicetree/bindings/arm/cpus.yaml
> +++ b/Documentation/devicetree/bindings/arm/cpus.yaml
> @@ -128,6 +128,7 @@ properties:
>        - arm,cortex-a57
>        - arm,cortex-a72
>        - arm,cortex-a73
> +      - arm,cortex-a75
>        - arm,cortex-m0
>        - arm,cortex-m0+
>        - arm,cortex-m1
> --
> 1.7.9.5
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
