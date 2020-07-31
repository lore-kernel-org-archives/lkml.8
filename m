Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1D1EC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 02:05:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D11B620829
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 02:05:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jBa+2bim"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731106AbgGaCF5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 22:05:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730904AbgGaCF5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 22:05:57 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA624C061574;
        Thu, 30 Jul 2020 19:05:56 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id 2so23435040qkf.10;
        Thu, 30 Jul 2020 19:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=i1QyVPNifl3QjxH5nvaDLQ3b4H6Y0SRuASS7QiD7pvY=;
        b=jBa+2bimj10N2QUadnPQoQbL5Xkp1Fa+6vvOGfuCTrl/RJMXjx449rzMWAsrlnNv8T
         3f7Gj8FroRaQPjBYT2Vito0ySIHeYaHPKRKH2XYRsv2aGLa5PWC87iCR35zjxyEWmWEi
         FQrZ4vko9kA6cBRxFXbZf31TirTtrhO1rdw3pyWs8AhmrnGvul+BKDP/YCEaur4l5M7x
         dT1xRMV2toaYPDn7TWMqsPa2Vt5rHDH1ERBIqBegE48K0dyZK9WrTKGPt+p5juKNcpsH
         /LlN5il62Oiafmjcrl2NuUbWIVAPA5cfMBG2gjUqtjvdnGOjEjXhJwvmVqgPE3Ia/wos
         Jr6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=i1QyVPNifl3QjxH5nvaDLQ3b4H6Y0SRuASS7QiD7pvY=;
        b=Aj2pD9u22x5XpglN23GS5c/Wro6eNPn7l0b9KnEMLRiP9mQUJPOL8KIiAcHpo0eJDN
         qRmCDD1r19BEglqKUtLMs7ilchT4T7sPrCvGEFzsMFQQsFCgAUkavdOsTYlpegxVbj7Z
         eNv9D/hROBMBSt0kcvbRg4SnzoFZFjKPEo5y1F0SEKhwMUKgNYeMpp72BGIHUXy+x4YD
         7U2aDaL9zDhP5ITsHzQ9wUAcAdoHWo5BzU5H8ffnkc/p+Z2dX5pjjazP0RcQonZDzMNh
         2LODzPPEJO19fD4u/2TelKXumAmbdcwrrVOz7SxeICiaER1rUo6M/As3MMhAbEmtTOmA
         KhRg==
X-Gm-Message-State: AOAM5307SEhX5iVbdSq7VfUNZFQkNNmRvFZPYDU3EaNk2qRsNsudRs1X
        4HHHF8svXgr7YZ5vRCZrTfU=
X-Google-Smtp-Source: ABdhPJzCS1HwBM6mrSflCoyKkTQvL/yTVNmELH1OWT+K+PGcqI3ub3AmSpE7BPNqrmqHX17HiUYIYQ==
X-Received: by 2002:a37:aa56:: with SMTP id t83mr1993883qke.150.1596161155820;
        Thu, 30 Jul 2020 19:05:55 -0700 (PDT)
Received: from ubuntu-n2-xlarge-x86 ([2604:1380:45d1:2600::1])
        by smtp.gmail.com with ESMTPSA id c5sm3349233qtp.62.2020.07.30.19.05.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2020 19:05:55 -0700 (PDT)
Date:   Thu, 30 Jul 2020 19:05:53 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Eric Anholt <eric@anholt.net>,
        Stefan Wahren <wahrenst@gmx.net>,
        Matthias Brugger <mbrugger@suse.com>, pbrobinson@gmail.com,
        kernel-list@raspberrypi.com,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] clk: bcm2835: Do not use prediv with bcm2711's PLLs
Message-ID: <20200731020553.GA3762310@ubuntu-n2-xlarge-x86>
References: <20200730182619.23246-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200730182619.23246-1-nsaenzjulienne@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 30, 2020 at 08:26:19PM +0200, Nicolas Saenz Julienne wrote:
> Contrary to previous SoCs, bcm2711 doesn't have a prescaler in the PLL
> feedback loop. Bypass it by zeroing fb_prediv_mask when running on
> bcm2711.
> 
> Note that, since the prediv configuration bits were re-purposed, this
> was triggering miscalculations on all clocks hanging from the VPU clock,
> notably the aux UART, making its output unintelligible.
> 
> Fixes: 42de9ad400af ("clk: bcm2835: Add BCM2711_CLOCK_EMMC2 support")
> Reported-by: Nathan Chancellor <natechancellor@gmail.com>
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>

I updated to the latest version of the firmware
(668419cb9876474053574b2b1dc20ca996e14cc8) and my serial console
works :) thank you for the quick fix!

Tested-by: Nathan Chancellor <natechancellor@gmail.com>
