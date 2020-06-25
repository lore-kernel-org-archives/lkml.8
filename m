Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E92C1C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 19:42:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C525520781
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 19:42:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pYiQVql9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406860AbgFYTmb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 15:42:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406069AbgFYTma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 15:42:30 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCE0CC08C5C1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 12:42:29 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id o4so3869195lfi.7
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 12:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qqOtE9pf+vADynm60513eX4noVoy/Y+X3v6nlzQzbtQ=;
        b=pYiQVql9Rw2juLICgPCa1oGJ7iBQQ4226I524m4p+uW6aOkcQrOckSzd8MlLM667j+
         Qla0189UJHHFDOGdFKtAy9MQh5kO34fAaSYqA/4XBbi9s+N145R6+TkOfUutfeA7DkwR
         2UPSdF9AKmz+y29uVhNr01/fqh1CXbeUckJ91jfQ/6jZ8M9M4tOIRs1v4r2xXXn4Mg4x
         y+Xy4tzBq4BfordUDR38y4H+6HQ/GZfHvQq/O3J4VTmYwlgBEnD5uobXkfb48T9IOYtu
         zrdNPo2yTwj2WCi/N9ip+y+JyVUFj3y9Z5ZANUycqWTQ+YWC1ZK37zaoiQqTkQWB1RKK
         GUyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qqOtE9pf+vADynm60513eX4noVoy/Y+X3v6nlzQzbtQ=;
        b=nrdLbaFYb0aatiDuJ63cGDfvkk7837dIJIZe09ux1QUiIJlDIrY35j9rNgkKNUZ5FA
         fWrEXFPuXUZZNCuNubtphQbFopsGtaKrlfHNrcQljMlhstrbhd4zpGq7IWkxIjA7y11L
         tZHwcZsWtOHl6iQM2XFHOLq6hjYYHxoquJ6Yr2Rgpmz+SihqokLWKWn0baCz0sD8cdeQ
         FvVEDQ/dfB36PzC7dXbHl1HU25m8NMO/MgsAE8XQuAFa8i6NeuMI4AA09ZyLU9dA19w6
         hpnSiFplHE2WFAH1Z4+28cc8Uz/YW6duks/I1aJUMANC6imRKNGfObVxHKbAk9FUF8II
         hVnw==
X-Gm-Message-State: AOAM5330EUZpzSff2+xN5Ddi35mX6p+iKl51CcLmpKdow112OXGNBsgY
        LAloSGgQ4dElfY6u7lDIEUWUcBPha/I=
X-Google-Smtp-Source: ABdhPJyhkNBhO+MljMG+su9jY4L/TwP6XUf7v6nKmEa7JlRT+pUqOYmjpSbNk0AEtJteaIhp0/m6iA==
X-Received: by 2002:ac2:4550:: with SMTP id j16mr19306070lfm.37.1593114147133;
        Thu, 25 Jun 2020 12:42:27 -0700 (PDT)
Received: from [192.168.1.211] ([188.162.64.162])
        by smtp.gmail.com with ESMTPSA id l16sm6158085lfg.2.2020.06.25.12.42.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jun 2020 12:42:26 -0700 (PDT)
Subject: Re: [PATCH 3/3] phy: qcom-qmp: Add QMP V4 USB3 PHY support for sm8250
To:     Jonathan Marek <jonathan@marek.ca>, linux-arm-msm@vger.kernel.org
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        "open list:GENERIC PHY FRAMEWORK" <linux-kernel@vger.kernel.org>
References: <20200524021416.17049-1-jonathan@marek.ca>
 <20200524021416.17049-4-jonathan@marek.ca>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Message-ID: <47e016a4-b7c8-e8c1-f9fd-b6b049e9e0b7@linaro.org>
Date:   Thu, 25 Jun 2020 22:42:25 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200524021416.17049-4-jonathan@marek.ca>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/05/2020 05:14, Jonathan Marek wrote:
> Add both the DP and UNI PHY for primary/secondary usb controllers.
> 
> The tables are very similar to sm8150 (serdes_tbl is identical), but there
> are some differences.
> 
> Signed-off-by: Jonathan Marek <jonathan@marek.ca>

Tested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry
