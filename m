Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13655C3815B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 19:17:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1C3520771
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 19:17:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=anholt-net.20150623.gappssmtp.com header.i=@anholt-net.20150623.gappssmtp.com header.b="JCVZVhXe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2506447AbgDOTRh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 15:17:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2438416AbgDOTRU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 15:17:20 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FD52C061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 12:17:20 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id 198so3539548lfo.7
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 12:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=anholt-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2Li6Tf7eb/94qSjOO3SfTTxWgQZS96NjwL2/MTelfTs=;
        b=JCVZVhXeCt1StGEKOwQldZeE69vytts+PPBX/IEVT+TCFBmAPjCojq/XLChUGiQcWh
         rn5v+40mBZ7oBZtKcDKjEMJhY4Odhnvn7lLpMeoKRsDCbRpp6oo6+LTHZeebtyMXE0MV
         ipVKSr1WJWA/P62XD4l1DsnxFAUqoo/c+SQi2LkH9cgNH2GNpUgTS5eI6s8tQaknb8eM
         OHXwDebhW8JZLdGF163fgUPSdbM3U94zhx/8Ii3dDwXfQlIXp1QcxXwxwoPOJOMwWR/6
         CrKwEvBWQWuqhAjMf+OUI5ETWs55JmyxbiQSgjvhmFQo1/+wSNF/nqMDsW4Ctsv+3sFk
         U12w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2Li6Tf7eb/94qSjOO3SfTTxWgQZS96NjwL2/MTelfTs=;
        b=dzaxXUtTkLr85BryDBqgD6ZQlPO6RJKU0lXj1pTkFw4WCQTFfdm8b1hsUO57Qm5Itf
         dpwPH/DNY7GPfjvSYclTujGOtGAxdvRUcIpj3x+XURZbtbIWnKZ++ZNSalmNd7OScfQ+
         wnfYNhvbMzvIamvK5Cc+EdhVTildF91bKhleWtwwGbGtJaGEhQP/GkGs4/gMG8KgNoUn
         aVQqTYri0BqStABPf0UQJ9hZh5fY9O3hSyPzM5RsmrYJYEYKNPTzJGYOPEQfLFSvP5xh
         7jcjpqNQjtrrNPW5tbmONBaF6c4SSrVcd3XBPeNT2/vL8ZxwJ2iY/zhmNcomCspdIFja
         EZSQ==
X-Gm-Message-State: AGi0PuZZnYsBJ5uUBF/YUd/NdWflKWAC1mj+nP+SQrFeDwVSNsQNyFmS
        N8C1QsnmGj9TCkzWZ2O1N/gPYLD8iAj7uJDURc58Xg==
X-Google-Smtp-Source: APiQypJw4CeUT45MAbksOXKhbBHlaf00wE31zM5ZLC/zDaXhf/09xcV158G7zniXKFzLj9VS2oryuZ+szRrdLMbITKE=
X-Received: by 2002:a19:d3:: with SMTP id 202mr3873367lfa.24.1586978238610;
 Wed, 15 Apr 2020 12:17:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200415144233.23274-1-nsaenzjulienne@suse.de>
In-Reply-To: <20200415144233.23274-1-nsaenzjulienne@suse.de>
From:   Eric Anholt <eric@anholt.net>
Date:   Wed, 15 Apr 2020 12:17:07 -0700
Message-ID: <CADaigPXwfjd-HoOtBm_fuPQ9eh7AKTaJx+ocLsppPFdL3Cr4jg@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: bcm283x: Disable dsi0 node
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 15, 2020 at 7:42 AM Nicolas Saenz Julienne
<nsaenzjulienne@suse.de> wrote:
>
> Since its inception the module was meant to be disabled by default, but
> the original commit failed to add the relevant property.
>
> Fixes: 4aba4cf82054 ("ARM: dts: bcm2835: Add the DSI module nodes and clocks")
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> ---
>  arch/arm/boot/dts/bcm283x.dtsi | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm/boot/dts/bcm283x.dtsi b/arch/arm/boot/dts/bcm283x.dtsi
> index e1abe8c730cef..b83a864e2e8ba 100644
> --- a/arch/arm/boot/dts/bcm283x.dtsi
> +++ b/arch/arm/boot/dts/bcm283x.dtsi
> @@ -372,6 +372,7 @@ dsi0: dsi@7e209000 {
>                                              "dsi0_ddr2",
>                                              "dsi0_ddr";
>
> +                       status = "disabled";
>                 };

If you've confirmed that vc4 still probes,

Reviewed-by: Eric Anholt <eric@anholt.net>
