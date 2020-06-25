Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62ADFC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 19:41:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F7072076E
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 19:41:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IJEluxN5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406698AbgFYTl3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 15:41:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406116AbgFYTl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 15:41:28 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59382C08C5DB
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 12:41:28 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id h22so682274lji.9
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 12:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0zChu5NuqK8iQIUSN8hc0V6TgI7jS8t8rrc66RrTyMg=;
        b=IJEluxN5ynq0LgPGOYBOvKULgCl5INb0OLYzWbyx+0W0SCmpcuiXuHILiZ0lMhqt3s
         GNPoTUQOirD6NBSicG79/NGxt2qaplIrFoe6mGjhqfQ0ChVaghjL+t79fI5t+gn3vIBZ
         ImuTzMnodSyyKZH1+cAbw/iBrBebnKVEInFUyCQrevpxVTE8ScP/ZpN90ZgYHPo0gSGe
         ULTzWcwBwlDDvfnWxhTRiTqV6cOxCdGmsiSUcoij1XxBb8H+ZONZNZzAlJBtR9AoJrB2
         trXlHnAP9U+O2XbsdPn5oAPh026OQG0YbwySQFlt6Tiw8Qttz5s1wD3ghAsLaiM+I0Et
         X4aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0zChu5NuqK8iQIUSN8hc0V6TgI7jS8t8rrc66RrTyMg=;
        b=WkbF4BJKXb53fAaFCSveaY02meJP1eVZLDxshzHnd1UOoixEvfBRg7MugkQB7cOZ7K
         +YZVhU/oKbGADDHJqmizhX2nzcapMGELzf7q4/fT3WLeoTOewehObOkZ3HAKxpAKIaQc
         5+U97GAoNspO0Cj5D8h0mBc/OoyESHGyVODKph4ieGwb/9gwiECxUKNz7DZov5OOMvmp
         iww1vvKroxcFPv9I4Lgo3qKNfRSS1EqWxaiF8waxTlaAcf7Vw89s9lhLdcY5jxqWSvgi
         U2gbkO0EFqvNYuZ7k/Sbm63DKjNYLfhmaprJNkknP+00wXCnV+6ILNozNxO5u658WLdM
         sgwQ==
X-Gm-Message-State: AOAM533q9jrrTo9VAoknUg51B9AwYfP1AGVvcFgm84flldWX4PCudaNT
        blRlw8uoPw23gUcHEQN+fmyIJBNe2do=
X-Google-Smtp-Source: ABdhPJxWlayAdWCqXaDjcJJF3JFPeAfVeVjewllhoyJZXszj3c3iBM9r3KCGLR2HjEB4QptldoNOFA==
X-Received: by 2002:a2e:859a:: with SMTP id b26mr17894874lji.191.1593114086377;
        Thu, 25 Jun 2020 12:41:26 -0700 (PDT)
Received: from [192.168.1.211] ([188.162.64.162])
        by smtp.gmail.com with ESMTPSA id f9sm4226746ljf.27.2020.06.25.12.41.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jun 2020 12:41:25 -0700 (PDT)
Subject: Re: [PATCH 1/3] phy: qcom-qmp: Allow different values for second lane
To:     Jonathan Marek <jonathan@marek.ca>, linux-arm-msm@vger.kernel.org
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        "open list:GENERIC PHY FRAMEWORK" <linux-kernel@vger.kernel.org>
References: <20200524021416.17049-1-jonathan@marek.ca>
 <20200524021416.17049-2-jonathan@marek.ca>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Message-ID: <fa5edd52-cce3-e9b6-ec8a-57bb8a676fff@linaro.org>
Date:   Thu, 25 Jun 2020 22:41:24 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200524021416.17049-2-jonathan@marek.ca>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/05/2020 05:14, Jonathan Marek wrote:
> The primary USB PHY on sm8250 sets some values differently for the second
> lane. This makes it possible to represent that.
> 
> Signed-off-by: Jonathan Marek <jonathan@marek.ca>

Tested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry
