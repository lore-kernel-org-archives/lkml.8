Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D4AAC55185
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 22:27:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDB74206D5
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 22:27:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SuRzLB2b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726321AbgDUW1L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 18:27:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbgDUW1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 18:27:10 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A0AAC0610D5;
        Tue, 21 Apr 2020 15:27:10 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id s10so137441wrr.0;
        Tue, 21 Apr 2020 15:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version:in-reply-to
         :references:content-transfer-encoding;
        bh=TVHvWeq74wndjoMOlZnvOcA7z3YSJVxkE1z/OPyNNNg=;
        b=SuRzLB2b3j0l7SA9g52vOcXLZU+DY7AkvLXrug4oJEGaGU1eVMU7XMlpbZJnjRwoFZ
         oLAiA7SesWSt0lHEDS+ngZtVVaqd78XJ1z3XD30jGYTmfN09E/lo1aZeBayRR27HnCeV
         Yk9JwTLNo7gLSeJWvSUlFbQ939rkU2X2WUK1gAnMdi1NKGJGkQlRNJAI472n7t5D8xRw
         KjuR9p7P3MpOeEWlt/wycmqdIoeURTDfQ9vYTDRDvQ0i5UP9QevhXbBwOWXh3WZfcrME
         i64oOjB9o6Lv9LPK2jEIjopE8X/aoK1Jia+cn5mdGDduBcvJxwfSD6pIDE1qKoqJOv1+
         N14g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :in-reply-to:references:content-transfer-encoding;
        bh=TVHvWeq74wndjoMOlZnvOcA7z3YSJVxkE1z/OPyNNNg=;
        b=IT5v82UtYUhplW/FGCXxGOkAXpZAXjAEmE0BOky/sxc8f6yJNPsSHP1ZdQAmBPUuKY
         o2VgOFW7DDt2QdSMu8yNpDZ5edpokGxOzBK5+PWbd/q0+KikmIwcNZM40Lix4SCCoD+z
         ntgj8X1s/pxeKHM/OJDJ9IWXsD2xwIC3SwH1WUEch0BCJAFb0WRG7+yXIfn1RQw4akWD
         JpLDPKSuIy13bagC71AbyLHUvidg+IOQ/ZSo4h3eMD8wrhdpZpYcSu1fV2N9Gxg1h097
         tdSyLnlyazJNZYXUJ9e2XgXKWdRUjx+XYE+7slkl8MjcXkDU6ZtrixKH1PYPIyposufN
         zyEA==
X-Gm-Message-State: AGi0PuZshN1/90FSvKkXkCTD/7pRw3SPYn9Aofjh4X4nIkQPRwfCciog
        Z8/Vt+RU1A1kut1jknQCMVjHt5q2
X-Google-Smtp-Source: APiQypK4MIoigVzoyOo4KYgWiKq1iD/gZe+idCUURktqF91CKWsp2Lfkii0PRbW23By2Odd7MNOi0Q==
X-Received: by 2002:adf:e4c5:: with SMTP id v5mr27816174wrm.143.1587508028830;
        Tue, 21 Apr 2020 15:27:08 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id n6sm5846206wrs.81.2020.04.21.15.27.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2020 15:27:08 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     bcm-kernel-feedback-list@broadcom.com,
        Vincent =?iso-8859-1?q?Stehl=E9?= <vincent.stehle@laposte.net>,
        devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Stefan Wahren <stefan.wahren@i2se.com>
Subject: Re: [PATCH] ARM: dts: bcm2835-rpi-zero-w: Fix led polarity
Date:   Tue, 21 Apr 2020 15:27:04 -0700
Message-Id: <20200421222704.17546-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
In-Reply-To: <20200418123522.6390-1-vincent.stehle@laposte.net>
References: <20200418123522.6390-1-vincent.stehle@laposte.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 18 Apr 2020 14:35:22 +0200, Vincent Stehlé <vincent.stehle@laposte.net> wrote:
> The status "ACT" led on the Raspberry Pi Zero W is on when GPIO 47 is low.
> 
> This has been verified on a board and somewhat confirmed by both the GPIO
> name ("STATUS_LED_N") and the reduced schematics [1].
> 
> [1]: https://www.raspberrypi.org/documentation/hardware/raspberrypi/schematics/rpi_SCH_ZeroW_1p1_reduced.pdf
> 
> Fixes: 2c7c040c73e9 ("ARM: dts: bcm2835: Add Raspberry Pi Zero W")
> Signed-off-by: Vincent Stehlé <vincent.stehle@laposte.net>
> Cc: Stefan Wahren <stefan.wahren@i2se.com>
> Cc: Florian Fainelli <f.fainelli@gmail.com>
> ---

Applied to devicetree/fixes, thanks!
--
Florian
