Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72FFFC433E2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 08:51:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4BD182075F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 08:51:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="N2PxVTmq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726835AbgETIvr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 04:51:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726650AbgETIvr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 04:51:47 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01E93C061A0E
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 01:51:46 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id g12so1089047wrw.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 01:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=RfZdfcc2DeqiyN9D4GMHPVwfFuLz1SqPHKWyIxBlRQE=;
        b=N2PxVTmqc0PIilXf0tfgDq12qP6BuoYEi5jE083XOptOZ4MHgfU8BkVb4Grwgl4NIn
         fBU6HygqUt0Y7EayYWPUa2VQAXhsfWczsuBjBeatxRBzQqZ4c809mi0qNqhqXbfgz2cs
         6VkUVcngrKD1QpnKRDvaJyLXNS9LuPKXZsoKRGOPFkFO/fGiLaNKuvdP/ygjFmYfSi+W
         MPXTMQf5CjoEoYddICmiqJZRujH6+tgZCw/lQSvnA5ravJ9Xb/OJqU0cjm5bOqbn4ySD
         ytarfMarVW50RynUWKK0VjneG9HpAqs2QYT0NEXaq9tLXm+rrE68QzFKDAQdDnxD3+vN
         FMKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=RfZdfcc2DeqiyN9D4GMHPVwfFuLz1SqPHKWyIxBlRQE=;
        b=gNZ9zFwStD2n4A7wEdPi0XEo4B0raNo1zDXBD1mEzBbFc6Cd+cf40ed+YVkz8OycAR
         5ZdE9aJShjKyLb13BfDr4I6y+hpbkOZAngfv9qPW9PgO57nVAsEnhrywBiI7bIY9Z/ec
         SZFcGn1+QinFG8JykVfvEYHOqG70tquk6VTzA54GVllOeX5Eib+hjnYDJu9wUDMZVix6
         drLdZx7ysh4RZutG7YjRI1qWSqCaUt+hoHdXDWZLu8dY5slPVgZoG03HQ7bwyMCaEzxs
         jqygZEGSDWiSBswCJfScx7+Dj5B1wugLorRRYc7t2jyLqfVZ0FEACmTi0Mg5rQVehz6h
         Ubpw==
X-Gm-Message-State: AOAM530jfzaEuhgWtV3tQc2GuSQYtyAOLULW4HIsGjICjeNpdpOj2mAr
        YUgVG2RdZSR1R+izFenqIiZldg==
X-Google-Smtp-Source: ABdhPJy7vTQHZlsjHOUjjA1fY46F7xY4npimGLDwSi4Dq1QjAtAOE3tBVQxTxOSuaD03VnTeasE/QA==
X-Received: by 2002:adf:ee87:: with SMTP id b7mr3292204wro.104.1589964704775;
        Wed, 20 May 2020 01:51:44 -0700 (PDT)
Received: from dell ([95.149.164.102])
        by smtp.gmail.com with ESMTPSA id l9sm984089wrv.32.2020.05.20.01.51.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 01:51:44 -0700 (PDT)
Date:   Wed, 20 May 2020 09:51:42 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Benjamin Gaignard <benjamin.gaignard@st.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.co, alexandre.torgue@st.com,
        linus.walleij@linaro.org, amelie.delaunay@st.com,
        devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org
Subject: Re: [PATCH v3] dt-bindings: mfd: Convert stmfx bindings to
 json-schema
Message-ID: <20200520085142.GD271301@dell>
References: <20200220162246.8334-1-benjamin.gaignard@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200220162246.8334-1-benjamin.gaignard@st.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Feb 2020, Benjamin Gaignard wrote:

> Convert stmfx bindings to json-schema
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> ---
>  .../devicetree/bindings/mfd/st,stmfx.yaml          | 124 +++++++++++++++++++++
>  Documentation/devicetree/bindings/mfd/stmfx.txt    |  28 -----

>  .../devicetree/bindings/pinctrl/pinctrl-stmfx.txt  | 116 -------------------

Linus, anything from you?

>  3 files changed, 124 insertions(+), 144 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mfd/st,stmfx.yaml
>  delete mode 100644 Documentation/devicetree/bindings/mfd/stmfx.txt
>  delete mode 100644 Documentation/devicetree/bindings/pinctrl/pinctrl-stmfx.txt

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
