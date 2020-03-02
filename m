Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77555C3F2D1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 16:31:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EA1E214DB
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 16:31:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="eoSemUK7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727201AbgCBQbM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 11:31:12 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53150 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727093AbgCBQbL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 11:31:11 -0500
Received: by mail-wm1-f68.google.com with SMTP id p9so11970141wmc.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Mar 2020 08:31:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=9ekD/wZU2juB89x3ikSs3OkvRfctZBZxxFo0UhHx8JY=;
        b=eoSemUK7ZEaNlKrg4HP6Fdxa2bm/AR3bYZEjvkL17es58SixQJTcPwvyZwNOpDQ8A/
         MQG1tGVsfuxNYI4m+NO7zBAFHQJmYENCdyK126T8b/+5n0RtMHVIIRFI3KCqz1cZ47cu
         ymX4QQ8l8KrH+NmiJS8zfmW0n9b6efekoW9GjqwPf1dHmurPNtTQ/bwcogGAuRZ5Kslc
         67wzNcuxqJnr8n4Ibt5O7nzmF+gMa81KoaNWC7OJdB3nWYNkVVKZZ+TVtLC6ORZ6eDA/
         ep5tQy1soUtgwjVcNFtV34CG7UMIljnWx4rgW1tykurhCb0F+8LSFTJ3Mj9v+xvo+Lss
         gJJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=9ekD/wZU2juB89x3ikSs3OkvRfctZBZxxFo0UhHx8JY=;
        b=agSSCgrhTTBm7fxrcyFCIt+ZMdAvh1+BjA4NjDVNgozN3r/j9Y2sm6QS8vmzxvpFHk
         XryWzcEQn1tHwIh+LkGeZU1RrGWRGhV7GHcQgHiryYviq6c8rYI1I3DApxT+lTKbNrud
         I5rubUsVyjd9j7LHUWs+5LKS0GOcm7lh6U/Wco5BD9tqt8dD8qJR001ysF1wsCpbz8Vw
         /9j2MJch3ocaivRxSlAeL5fv+tJFSrnhk4mSXak7NzqMvUCP5Nmuy/mh4ScLjwrs2r3f
         XL6TaVcFVWsSo2iDKJLyCZM4WJiucOv/T1pWsGG+NyJ3fQR4J2PRAyCT1e+DPUmDAgE8
         pE8g==
X-Gm-Message-State: ANhLgQ1eaYxol2ujTJTmNoWq/qTpIATNPYypGmt/PiduvwCPzzI+ZcRO
        qctOcByOBDdRcpWZgomo3nU0kQ==
X-Google-Smtp-Source: ADFU+vsO4oMThfxe4T+3k8CrA3b+cufx1zE37BxkfjQy0S1+vSAU7EwEHK50HsH3LU0tLqS86uSXvw==
X-Received: by 2002:a7b:c183:: with SMTP id y3mr250047wmi.0.1583166667736;
        Mon, 02 Mar 2020 08:31:07 -0800 (PST)
Received: from localhost (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id v131sm17357885wme.23.2020.03.02.08.31.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 02 Mar 2020 08:31:07 -0800 (PST)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Jianxin Pan <jianxin.pan@amlogic.com>,
        linux-amlogic@lists.infradead.org
List-Id: <soc.lore.kernel.org>
Cc:     Jianxin Pan <jianxin.pan@amlogic.com>, SoC Team <soc@kernel.org>,
        "Stephen Rothwell" <sfr@canb.auug.org.au>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] dt-bindings: power: Fix dt_binding_check error
In-Reply-To: <1583164448-83438-1-git-send-email-jianxin.pan@amlogic.com>
References: <1583164448-83438-1-git-send-email-jianxin.pan@amlogic.com>
Date:   Mon, 02 Mar 2020 17:31:06 +0100
Message-ID: <7hsgiqra5x.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jianxin,

Jianxin Pan <jianxin.pan@amlogic.com> writes:

> Missing ';' in the end of secure-monitor example node.
>
> Fixes: 165b5fb294e8 ("dt-bindings: power: add Amlogic secure power domains bindings")
> Reported-by: Rob Herring <robh+dt@kernel.org>
> Signed-off-by: Jianxin Pan <jianxin.pan@amlogic.com>
> ---
>  Documentation/devicetree/bindings/power/amlogic,meson-sec-pwrc.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/power/amlogic,meson-sec-pwrc.yaml b/Documentation/devicetree/bindings/power/amlogic,meson-sec-pwrc.yaml
> index af32209..bc4e037 100644
> --- a/Documentation/devicetree/bindings/power/amlogic,meson-sec-pwrc.yaml
> +++ b/Documentation/devicetree/bindings/power/amlogic,meson-sec-pwrc.yaml
> @@ -36,5 +36,5 @@ examples:
>              compatible = "amlogic,meson-a1-pwrc";
>              #power-domain-cells = <1>;
>          };
> -    }
> +    };

Thanks for the fix.  Queued for v5.7.

@Arnd, @Olof: you can ignore this one.  I requested Jianxin to send to
you thinking this was a fix for something you already queued, but it's
not.  I'll handle it.

Kevin
