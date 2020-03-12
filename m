Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E183BC10DCE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 20:07:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B79FF205F4
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 20:07:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PjKn4Njk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726883AbgCLUHG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 16:07:06 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54107 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726114AbgCLUHF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 16:07:05 -0400
Received: by mail-wm1-f66.google.com with SMTP id 25so7520333wmk.3;
        Thu, 12 Mar 2020 13:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=oVJZ06Uat8mghcu7FmlV2FCnZk1gGTm1Au0/PhDgTnc=;
        b=PjKn4NjkuLiy7uWakk8HvhwWjS1OXn5oxiCD9mtJRTQ8OlPVnZk70yx+b7yYhseQrj
         Gh1WVF6zuwIAwbE6U1zpM8evpUKpcqjf0Bk+0oSF8E6UVjuqQV6m+MyxbC8QAzGdVxyB
         gYuhOyMLXB3Hzjpx7dkBLswfazkSX/j+M8sWv3zCr+AEmISa/z/NE3qLjrWOtznzbp4w
         OTSgG83s7qXf5ypTh9yLQ6xWnv0cjpUKcxC2XuTeqrQdvk64V7PDm/qMdcKKDvn+RGtA
         duVRq9WqEr87kW0q+1/jCJbsBANvk6NWU0fejP6uSPbzJYKBZY4Pw+/G2aF0NERW+fzX
         XyTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=oVJZ06Uat8mghcu7FmlV2FCnZk1gGTm1Au0/PhDgTnc=;
        b=nCKfY+Z0woxhfCM3o8XRTUGDXPyuEKyEVaH1CCClc1brmGlsyxZJ2l2t0LShK3oYpL
         u/zNGGvyprIpI+ojbK/UmpLoe5TnVUVjqsYetBBftEoaUPeStXj9h2KDa/i5RwDvgmCF
         zrChOncvqAURgtsWtPz4lYg3v+J7LIGYOr2EMtz3rnC7E0OM+hgUgUTvo4Ln7yVp5IrW
         K9WUkmGxNZDTs8wOu4iHfaie1I9Pg5FosS71/nF3RuEpkbgMmA8we2t2hGGVRhz9Q2zY
         aKLf8xaJbRr/UAgjge7LaubmGEE8gJlTu6Sm5v8cXy4fS9g2s0pmpsVpCZ8VnWfn1cn8
         J7hQ==
X-Gm-Message-State: ANhLgQ06I8tviVAl6gt5OhZ6acBqAZoPeHJNdQXyF6rx6IKZRcAE40WY
        uo6WLYEHawMfCXrJWY4kiBNwTb9B
X-Google-Smtp-Source: ADFU+vvVXeFdPNIKq+5cMb0R2iF5gaF0tUh2Ro93R4QnS32tWw4dVHH1UygFTwc2lyHDAKyIy5y32Q==
X-Received: by 2002:a1c:5502:: with SMTP id j2mr5138310wmb.93.1584043623255;
        Thu, 12 Mar 2020 13:07:03 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id k18sm26530240wru.94.2020.03.12.13.06.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2020 13:07:01 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     bcm-kernel-feedback-list@broadcom.com,
        Nick Hudson <skrll@netbsd.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: bcm2835-rpi-zero-w: Add missing pinctrl name
Date:   Thu, 12 Mar 2020 13:06:57 -0700
Message-Id: <20200312200658.4524-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200312090345.8352-1-skrll@netbsd.org>
References: <20200312090345.8352-1-skrll@netbsd.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Mar 2020 09:03:45 +0000, Nick Hudson <skrll@netbsd.org> wrote:
> Define the sdhci pinctrl state as "default" so it gets applied
> correctly and to match all other RPis.
> 
> Fixes: 2c7c040c73e9 ("ARM: dts: bcm2835: Add Raspberry Pi Zero W")
> Signed-off-by: Nick Hudson <skrll@netbsd.org>
> ---

Applied to devicetree/fixes, thanks!
--
Florian
