Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	BODY_QUOTE_MALF_MSGID,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59350C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 14:02:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33593206E7
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 14:02:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AiOurE6E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728214AbgG0OC1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 10:02:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726298AbgG0OC1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 10:02:27 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A032C061794
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 07:02:27 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id z18so11452355wrm.12
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 07:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=zOqkerDrdn9vlD/gwQA8/RReYXl1a8hHd175h8KJrac=;
        b=AiOurE6ElgW2rXkMTDBSstfE+k4Vc00fc8vo3xfcDMLup+XhcGNb4SNSRI/WirBEHP
         2uEx8j+26V3vwWD2TsCfRc7tw6YUXfEvDDnZbGyHBp2VA8d7MbtWdjKPuh7HYIYeZBbE
         Sxv1PaL7iA2ci6sB4zQsgfcFg+S7lXJBsR/UVoFhtp3JWtP+kcIHprF/eX+cHzRxpzht
         WXTmbbfr5Zz3H+p892+D8OzE/JL1GpIfSv/McxmcQYaHZ+eU3Zu7b6agCQ/YEWtTHhBy
         uNitL+IWwT7Cgp400dApTLTj3Fqb2BvCjiklYkqVU0HsExNA4+ZL/p2oDZyaiiEc4sWE
         5cww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=zOqkerDrdn9vlD/gwQA8/RReYXl1a8hHd175h8KJrac=;
        b=taIKJ3B56OL2l4cvwgh6TlowgbYdM6OWDZ0haTXCuG3ELuMik9cdLGCbg7ikRx7o8P
         9BKU8BH7q18k6ELoeyzj+xG0dCNN12ScjThY/8fcYqiKg2IudUQPOVw+3Lofl4sBG/mj
         kwyS+TPOVV12ael6qNwYjVnpIA4TzCgUUNwzQP7LoNF0xVymV6JP8wiFIsyqE54CLU88
         g+wHc8EEwaFOtt2/5MWeVoX+/OzAyxHKVYl3SwFvLx4/fZhbY8AOSzMb/D1eXBOZJkoU
         26zO4oevtdrUpcuZDNYtmmFCRqCh2enymielOl//JH0s3Jz542j/rXTyKPviFAEuHoon
         YCFQ==
X-Gm-Message-State: AOAM533JcHjT3iJKtvGVmOuUD5KM/Nwf9sTQbU6S27sCONs50nBT1M6M
        bJdMl1fLcFD5eoG04xE/poH5jw==
X-Google-Smtp-Source: ABdhPJwjJSVz3g1CL5VuhRU+Lqk2xwjvdNqUmy20hjhFOaKUrZshvaRQ4TG2DVzzGCIvVfqbG5CGmA==
X-Received: by 2002:adf:9404:: with SMTP id 4mr19951626wrq.367.1595858545754;
        Mon, 27 Jul 2020 07:02:25 -0700 (PDT)
Received: from dell ([2.27.167.73])
        by smtp.gmail.com with ESMTPSA id f9sm12514999wru.47.2020.07.27.07.02.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2020 07:02:25 -0700 (PDT)
Date:   Mon, 27 Jul 2020 15:02:23 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
Subject: Re: [RESEND PATCH v3 2/2] mfd: madera: Improve handling of regulator
 unbinding
Message-ID: <20200727140223.GT1850026@dell>
References: <20200723105459.5530-1-ckeepax@opensource.cirrus.com>
 <20200723105459.5530-2-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200723105459.5530-2-ckeepax@opensource.cirrus.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Jul 2020, Charles Keepax wrote:

> The current unbinding process for Madera has some issues. The trouble
> is runtime PM is disabled as the first step of the process, but
> some of the drivers release IRQs causing regmap IRQ to issue a
> runtime get which fails. To allow runtime PM to remain enabled during
> mfd_remove_devices, the DCVDD regulator must remain available. In
> the case of external DCVDD's this is simple, the regulator can simply
> be disabled/put after the call to mfd_remove_devices. However, in
> the case of an internally supplied DCVDD the regulator needs to be
> released after the other MFD children depending on it.
> 
> Use the new MFD mfd_remove_devices_late functionality to split
> the DCVDD regulator off from the other drivers.
> 
> Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> ---
>  drivers/mfd/madera-core.c | 23 +++++++++++++++--------
>  1 file changed, 15 insertions(+), 8 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
