Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E94FDC2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 21:50:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C61252076B
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 21:50:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DhsWQxH8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440919AbgDNVut (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 17:50:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2440753AbgDNVtr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 17:49:47 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02DA1C061A10
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 14:49:46 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id z6so16210844wml.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 14:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lLu0lDjOuieHB5rYFFB3f7WiEo1gndmAxrF4xwTxJdI=;
        b=DhsWQxH8nmCAK1PslhefQsGiSmVRGPV2C48zxDbAw+oQWBdo9hCDs8vO1ONpqDN/ZZ
         0bz/HssycdFvoO7X3Iesav1WJkrV/TzZ8z1A2cYIFwxDLpmiHDaHFAWeW1CL6SPLhYmU
         lZHTH7t8+H+50T6hyqE/VczVZrP0k7Yam75JGCk4tqKGgVg/hd8f5PzicIVTsN8l8wf9
         0d7w2hKZQlina8KT9FJPENgYhD12ZaSSfJ9EFc5c82a/zaqtSwByCfK5H7WE/lt/S0RJ
         ZqXOLu6xUN/HVpfbnQ/0i/WvJqbIY+SX3vK/d/QuS5EuF4moAadgaBELrhQpbFEgXMGh
         noPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lLu0lDjOuieHB5rYFFB3f7WiEo1gndmAxrF4xwTxJdI=;
        b=LWpOhJTp5pEiBNffJc/T+Bw17IWI6s3ptfAEAgaQ3+wBNLYwdVkssUttkyrFYMRqUu
         8aJJGdZ85wbzwOuuT86aUYKIJ/OrPeCHEkoHELMJRsKihSEwGyx6915NQwMojgRlqjR3
         dhRaLCFTJkAlT8Z/xXVilDHSJULiaFZPh5LLoKrEFiI1NDaco/+eWjIbzM3XRJu7pcBh
         m19y1eWkTbH2a5BhnjHinBMGrKtfspA6G7nHJ4nAa98nckXSwbV5LGXciX5YEODIHISV
         qDCfqc/gj+ZVEQH9pugRh9YKII104Dva3v+7d4zLQ0Lj71dTWVS6WC6bQl93J8VdjxTX
         8nHQ==
X-Gm-Message-State: AGi0PuaBpSVToAvLTFhOWpgHlU1rT4Eui80gV9trRsBJ3wQ8GUcdNR6V
        cy31TjSWrC+KV3nhb3uAmhlxFqkB5ng=
X-Google-Smtp-Source: APiQypL0+9U7VuiJ8stS+8CjpDdryFrogKFubugLUq0tYDBk79fADkOCK7EquRDegrfCnG/uugEJyQ==
X-Received: by 2002:a1c:1d4b:: with SMTP id d72mr1784657wmd.19.1586900985207;
        Tue, 14 Apr 2020 14:49:45 -0700 (PDT)
Received: from [192.168.0.41] (lns-bzn-59-82-252-135-148.adsl.proxad.net. [82.252.135.148])
        by smtp.googlemail.com with ESMTPSA id b4sm15868876wrv.42.2020.04.14.14.49.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Apr 2020 14:49:44 -0700 (PDT)
Subject: Re: [PATCH v2 2/4] dt-bindings: thermal: Add the idle cooling device
To:     Rob Herring <robh@kernel.org>
Cc:     rui.zhang@intel.com, amit.kucheria@verdurent.com,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20200414162634.1867-1-daniel.lezcano@linaro.org>
 <20200414162634.1867-2-daniel.lezcano@linaro.org>
 <20200414214509.GA10673@bogus>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <882e9605-a2e6-1af8-26e3-b03f2a7bcb5e@linaro.org>
Date:   Tue, 14 Apr 2020 23:49:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200414214509.GA10673@bogus>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/04/2020 23:45, Rob Herring wrote:
> On Tue, 14 Apr 2020 18:26:27 +0200, Daniel Lezcano wrote:

[ ... ]

> My bot found errors running 'make dt_binding_check' on your patch:
> 
> Documentation/devicetree/bindings/thermal/thermal-idle.yaml:  while scanning a block scalar
>   in "<unicode string>", line 39, column 20
> found a tab character where an indentation space is expected
>   in "<unicode string>", line 44, column 1
> Documentation/devicetree/bindings/Makefile:12: recipe for target 'Documentation/devicetree/bindings/thermal/thermal-idle.example.dts' failed
> make[1]: *** [Documentation/devicetree/bindings/thermal/thermal-idle.example.dts] Error 1
> make[1]: *** Waiting for unfinished jobs....
> warning: no schema found in file: Documentation/devicetree/bindings/thermal/thermal-idle.yaml
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/thermal/thermal-idle.yaml: ignoring, error parsing file
> Makefile:1264: recipe for target 'dt_binding_check' failed
> make: *** [dt_binding_check] Error 2
> 
> See https://patchwork.ozlabs.org/patch/1270492
> 
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure dt-schema is up to date:
> 
> pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade
> 
> Please check and re-submit.

Sorry for that, I forgot to re-run the binding check and my editor is
automatically replacing spaces with tabs.



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
