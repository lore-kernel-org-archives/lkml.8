Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D90F9C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 06:37:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A178820774
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 06:37:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HneRXMMo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728093AbgHKGhL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 02:37:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727845AbgHKGhK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 02:37:10 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94243C061756
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 23:37:10 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id r2so10351967wrs.8
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 23:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=x5FBMHKZkPQA4hEWyfkPIYXDU01mkVtVLPdybqPOuRs=;
        b=HneRXMMo2ug6nvDJFJXs3QTP2D796MRWPSBPzBFLnmi9zl3hWyPHTa3qSn8b8UWCSn
         aPDtEJsBUcZjTz9I+Q5jfg3drgjUL28RkFTh7v8QimCZwsEjdoxVEUqHA9KzpSy4kiBT
         pDPIDda6jLqIoAm42WvTIX+4pJDFdnFBhKFOqycocgC4JlcsleiqLVKCDbccZLgAvoL5
         Ia7Zz3PLyAsJQn4hERdVMp188kAJ+JgBOecsT8oyxu8whDK2xRKEZtKCgvodes09tvlf
         Qu19y53SUQDfEklbq/0rCBQgpBtGHa45kZPBUXQv8fhcMo+SUwAuScMvdXO+I/lkjL4B
         yxCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=x5FBMHKZkPQA4hEWyfkPIYXDU01mkVtVLPdybqPOuRs=;
        b=jNSaZt9u3w6IWzycE4urWMIwRwofQbp4UFS3AZmfGa1UM20RVSqei+Oc0HZZyMxH+2
         IpbvL9S/2/e664GsjnQpk2TPRInCCt9sXb6+YxIr7CFNcTNSKmEJ6puTcsYwKolOPhe+
         DTz2T0T7oPgsZpI4rYE62u3aGMBTvs8wi/RDXgtKSK4wmp6sUHNgxF3kKH+nMn8PziLe
         DzCMTzqYD396n9dGCjkbtPTvGkyPzO+3o264mEzFULFjnybB7WWOvW/MhJC33R0HE77v
         imyEgz9W5Pf2hTLS9yf8994YWwr3UWFg7vDEC0Za5ZXzkHEjuQ5uC6l0QLZ5KNkdRmbj
         feHw==
X-Gm-Message-State: AOAM531WGs4XFqKKfMKHdhPfRmXMlXlPQ7pICqRgqc2ONi85aeRMOgmL
        eyVSUa/fG6Mz5pe2NTEA80O9Kw==
X-Google-Smtp-Source: ABdhPJwsEyKno0MqJ9fO8lldQanSuw2/L/xFkbnxSsLpEiiGx4RbVGJtu2YU9kUdL+EEtXEzMmmgrw==
X-Received: by 2002:adf:ec04:: with SMTP id x4mr26466689wrn.28.1597127828922;
        Mon, 10 Aug 2020 23:37:08 -0700 (PDT)
Received: from dell ([2.27.167.73])
        by smtp.gmail.com with ESMTPSA id b139sm3570352wmd.19.2020.08.10.23.37.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2020 23:37:08 -0700 (PDT)
Date:   Tue, 11 Aug 2020 07:37:06 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-pwm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Linux-imx@nxp.com
Subject: Re: [PATCH V2 1/3] pwm: imx-tpm: Use dev_err_probe() to simplify
 error handling
Message-ID: <20200811063706.GD4411@dell>
References: <1597127072-26365-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1597127072-26365-1-git-send-email-Anson.Huang@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Aug 2020, Anson Huang wrote:

> dev_err_probe() can reduce code size, uniform error handling and record the
> defer probe reason etc., use it to simplify the code.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
> changes since V1:
> 	- remove redundant return value print.
> ---
>  drivers/pwm/pwm-imx-tpm.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)

Acked-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
