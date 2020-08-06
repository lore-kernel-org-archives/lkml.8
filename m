Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C654C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 17:11:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A600923119
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 17:11:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596733914;
	bh=x9Ze0cDgQWMYzELAxNCRG4Als/cunFjflbfd4YzRC6A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=rj2WiJXvW/0J3Lr+bJa9qfZv4nQkkn/A2f+MDWvraV+GOF8mzq+JXmoHGlrbu6+xM
	 o+G9xQNwyXDjQ2CDCpuFUalEJ6Sfv4Ru710tn2XSEm0sC2LQcLrQBfWk67m03T01pY
	 6IRaw9CnD+G0yfVXCRcKWaEilMiD9fDdxOwbfnHA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730316AbgHFRLw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 13:11:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730222AbgHFRKJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 13:10:09 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1CC1C00022F;
        Thu,  6 Aug 2020 08:41:56 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id q76so10119076wme.4;
        Thu, 06 Aug 2020 08:41:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ql3hGTHje/p2vwNn/ID8F5Qa5Fp/I/jz2QjpfkMIy8A=;
        b=oC4hbreq4JtGHYgQwcx9rp3aBj+50DSOmOh6Ez8Vl0e8HjTwFxzE7VrHXRzx5RPj7U
         uH7wAPDseF369+ksel4ChAXjM9jrO6nLssTlYd5D3GF/Z7wsAl/gUByCxijkeDOjiIIx
         Db/WBxH1j5nnv1/MBF5XL3uNeiDnXGBdit8NWcbsFyhyb9vv+JgpiSgcQKau34GTiHZf
         +LXUCWjsqA5vsRC7ruhLbL0aEeYA746QFFV0yhsgKMsY/wMIWvJBI0QzdTbW0XhB0BZ9
         yAykGnf17kSMKPLy+a3FWZaSBFnjt1RXi1BsMaT6PCOVKhmjRG/fwqtA3reG55K5xHvK
         6iEg==
X-Gm-Message-State: AOAM531RS+nv6LDU7T/7S2Pa3pOyAw7vlG+RaNayz3XT/HNZPK0iYX9B
        FFUOEreaqUQS18KHOkCPIgZlhka6Zgk=
X-Google-Smtp-Source: ABdhPJwzlHcAKonDnHK5hxlbdBjEHnGGkz382M78Jit2tSdVdrilgnAIiKjPkcJpf0NZhdrkpvAnyA==
X-Received: by 2002:a05:600c:4112:: with SMTP id j18mr7692068wmi.187.1596720810126;
        Thu, 06 Aug 2020 06:33:30 -0700 (PDT)
Received: from pi3 ([194.230.155.117])
        by smtp.googlemail.com with ESMTPSA id f124sm6322725wmf.7.2020.08.06.06.33.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2020 06:33:27 -0700 (PDT)
Date:   Thu, 6 Aug 2020 15:33:25 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     Chanwoo Choi <cw00.choi@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: Re: [PATCH] rtc: max77686: Fix wake-ups for max77620
Message-ID: <20200806133325.GA7685@pi3>
References: <20200806125431.699339-1-jonathanh@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200806125431.699339-1-jonathanh@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 06, 2020 at 01:54:31PM +0100, Jon Hunter wrote:
> Following commit d8f090dbeafd ("rtc: max77686: Do not allow interrupt to
> fire before system resume"), RTC wake-ups stopped working on Jetson TX2
> and Jetson Xavier platforms. The Jetson TX2 uses the max77620 PMIC and
> the Jetson Xavier uses max20024 PMIC. Both of these PMICs have the same
> max77620 RTC controller.
> 
> For the max77620 RTC, the variable 'rtc_irq_from_platform' is defined as
> true in the max77686 driver and because of this the IRQ passed to the
> max77686 driver for RTC is the PMIC IRQ and not the parent. Hence,
> following commit d8f090dbeafd ("rtc: max77686: Do not allow interrupt to
> fire before system resume"), for the max77620 the RTC IRQ within the
> PMIC is now getting disabled on entry to suspend and unable to wake the
> system up. Fix this by only disabling interrupts on entry to suspend
> in the max77686 RTC driver, if the interrupt is the parent interrupt.
> 
> Fixes: d8f090dbeafd ("rtc: max77686: Do not allow interrupt to fire before system resume")
> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
> ---
>  drivers/rtc/rtc-max77686.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)

Acked-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
