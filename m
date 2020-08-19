Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77791C433E3
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 08:45:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40035207BB
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 08:45:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O15PJzAM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726795AbgHSIpn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 04:45:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726630AbgHSIpk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 04:45:40 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B492C061342
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 01:45:39 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id 88so20685347wrh.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 01:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=gYpzXriD9qa+Hy90mg+jPu07uFFXBQMp6JMzrmOupEM=;
        b=O15PJzAMXo/tI4qL1f98U066DYZhIxpTmlOkEvGTMUWCyssJ2JirdleOnOh43PVZGY
         T1VYqTZOxq7Wv+cahO8tnLo2mPNOpF44RpjwezztHLN5F0EKEO3astHpA35CJ2CJR7CP
         KZlBiI1xLdZhggydcN5mO2Gs8v0/SflJ3rzPLZAqwCNKHsBT6p0PBv7ENgrkxzxPVoX+
         qDwlggwuq1Erd86Sy3ZQpAsD7KoJELFKETGQ4Gk/JfgXKl44plkcZhxzCYZ326llRyiI
         G8MP8oc2cJOJZCxUt6HmNkFf8QM65hnm7urbIaT57S2fgYthd7iT3UZ0g2CQGKVpxIiV
         ya1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=gYpzXriD9qa+Hy90mg+jPu07uFFXBQMp6JMzrmOupEM=;
        b=piluB5FZku6/1EPUwX9Uz6yer5akiqO/hga21uRBwiqQeTnHAk37ZRgwCUvECuvejG
         LtkppTO+S56hr3RQJe/FINLERqkyzES+ptCC4T6Gx2987niC+q2D0KXypbpDt+9vVBuW
         Ew/PFxKZNu0EoCcrEydqstmzkYexiy3er1eXiu76BYR2n9vq2qif0woQC++h7AMYgQqd
         UclsEx5Z0K8pH2a6Srvgl4GWNXujXfXt59U+LFDclWtTyjgXn7x8XcytNOo6UUlDpUX/
         Sn9Hr8kP/sxekRs5fdDwHzKw+NoSg0MN2k2DhbBOYblR3xWGRloP73uIqiIEzEMyGmAH
         QRoQ==
X-Gm-Message-State: AOAM5310Ugy9cSj+OrunAY13Nw5ig8mpqpmOWlJLEz9Gn6IhO0fITx5m
        bi9LhZdaK2ZlAOztVZSGx06kZH25fpoIdg==
X-Google-Smtp-Source: ABdhPJx2f0yZ5JvASUZdIfrru1bPsUTf5w7x5TPLkR0bXKwA0ABN/aw+CCfXMj8uA8PwlWBImgXtjQ==
X-Received: by 2002:a5d:464e:: with SMTP id j14mr24327940wrs.361.1597826738345;
        Wed, 19 Aug 2020 01:45:38 -0700 (PDT)
Received: from dell ([95.149.164.62])
        by smtp.gmail.com with ESMTPSA id c15sm4313545wme.23.2020.08.19.01.45.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2020 01:45:37 -0700 (PDT)
Date:   Wed, 19 Aug 2020 09:45:35 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: Kconfig: fix a typo
Message-ID: <20200819084535.GD4354@dell>
References: <42221553381256444745b6c495bb74b97aa23464.1597235340.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <42221553381256444745b6c495bb74b97aa23464.1597235340.git.mchehab+huawei@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Aug 2020, Mauro Carvalho Chehab wrote:

> individul -> individual
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  drivers/mfd/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Fixed the subject line for you and applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
