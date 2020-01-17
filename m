Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89427C33CB6
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 09:45:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DA8F20730
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 09:45:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SiiK9OBC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729240AbgAQJpU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 04:45:20 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34505 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726867AbgAQJpS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 04:45:18 -0500
Received: by mail-wr1-f65.google.com with SMTP id t2so22023836wrr.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jan 2020 01:45:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=6JQdJ/Z+v9/vjiZPLWiEeVG/ezp4htSKwWzwxjsSWBY=;
        b=SiiK9OBCwsjczoZlFB2/PbwNzt65xXxwp/2hl7vVy8q1P15e9nwVJOriZ3rt0vu/qk
         ANr7muK6mj79J7aTxzA9hT1uExPNqHVYmvmysFg2FuWEESIUy+VwvZCgW01kwD6FkWd2
         Wk/fEr8phJJCBqm2ojpU4ia4vYW2GLbAsR+jEt5+Uzqa32WFXwRCzxucl6lUBzM9mQDF
         fu6q71nwuUmVqQfkQh3DvFtvX7MtNouyOZbbQ9QfdfACDbyC1VYMBR3nNC1LqoUi7rEf
         O2RB2yyoVHSO5jlmx9Mo39RNV+mZMQ2EDJ4XEBPju+SHhg9afGmpKwCIAjThGhEevGcG
         BZMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=6JQdJ/Z+v9/vjiZPLWiEeVG/ezp4htSKwWzwxjsSWBY=;
        b=QGx4wQ8+xJlY+cm3hgyXtkeCu4vNEIAWtDQWv/mGuGvE+JGUACQMQ2pEKQMY8culqi
         awBF0rmJyjP+ZHDcQjPwEmVTdE6b5l7yjhTel3pYjP/vPrlpYpqJ6zmiG8LBwWXwn50r
         jsOtwOQgu56FqmRdNoFFOd4Bwva63AFz1sFSa6P6/mIBTUxoa7dCSOze8EnO0/YfCPxC
         io10rVNVH2KqSUS4jhnJKc0TfmTZ4qkJeNYWA11icrNOTS+o9GAHEKyCGLEUXCwptgGI
         jIqvWNpyzclphta92vV9pR9yflJ190Zz9Il3tp9q9bxwYjQJuRQpUbJXQcte3LFIfR1E
         TFgQ==
X-Gm-Message-State: APjAAAUD3GAjdCwDsQZVNtK/f7cL68I8rQM8iKHdSPe+9ioc0QXPl+N6
        W1i6BH3wZ9Q76pZpTFDyoBbJxg==
X-Google-Smtp-Source: APXvYqyEk2ExDz5kQ4m2E2esP3TuVG1PMbfYAl7TrlI8nt7Maqc1sYLr4kN4JskI44nke/OUXtlSEw==
X-Received: by 2002:a5d:630c:: with SMTP id i12mr2159617wru.350.1579254315991;
        Fri, 17 Jan 2020 01:45:15 -0800 (PST)
Received: from dell ([2.27.35.221])
        by smtp.gmail.com with ESMTPSA id i5sm8814345wml.31.2020.01.17.01.45.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 01:45:14 -0800 (PST)
Date:   Fri, 17 Jan 2020 09:45:33 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     support.opensource@diasemi.com, robh+dt@kernel.org,
        linus.walleij@linaro.org, Adam.Thomson.Opensource@diasemi.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, linux-gpio@vger.kernel.org,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v4 1/3] dt-bindings: mfd: da9062: add gpio bindings
Message-ID: <20200117094533.GA15507@dell>
References: <20200108104746.1765-1-m.felsch@pengutronix.de>
 <20200108104746.1765-2-m.felsch@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200108104746.1765-2-m.felsch@pengutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 08 Jan 2020, Marco Felsch wrote:

> Add gpio device documentation to make the da9062 gpios available for
> users.
> 
> Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> Reviewed-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
> ---
> Changelog:
> 
> v2:
> - remove sub-node documentation
> - squash gpio properties into mfd documentation
> ---
>  Documentation/devicetree/bindings/mfd/da9062.txt | 10 ++++++++++
>  1 file changed, 10 insertions(+)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
