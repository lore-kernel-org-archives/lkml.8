Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EADCC2D0F0
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 23:05:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4889920733
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 23:05:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585609507;
	bh=fRDc6Xk28BTZDk1X4bdEY2EM4SCqhy1qmgwW6MV+7XM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=rbs9z4+yxaho5JYS8zcoCw6o3sPohZqhILySZ7Im7+2yEFbgFB242OdJ8BATp+WXk
	 YlB0FlF78tZelPwb8tvzcN3EAGdFGhk+nJq0qDnQYNMOMqilcJy7fBciAwe2eUJ1SG
	 xEeBM3t2uj2dC6vMUhm4IKamPcaSgfYTXCYWNCwo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729817AbgC3XFG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 19:05:06 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:37256 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728876AbgC3XFG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 19:05:06 -0400
Received: by mail-io1-f67.google.com with SMTP id q9so19739256iod.4;
        Mon, 30 Mar 2020 16:05:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Hg3MFEW1h1HeRiEBjv8wSxOFZQ/ZC2zyXucOt0y4fkk=;
        b=E3yZpToPZBK7diHWeYTzNKV0HR4nzs7UZVnL/m3b1DkaCG5tegrJuAzOHxGwZF+fjx
         A1INllO9eSsVfw15gY7RWxjgStisKyqFxGylTZsgfzxTp7Ig18ucGQy7FTsFI2LtQqC1
         DoWtEbUAcy4oPXUwWI7YBaDA2mFfPjdzWK0+hpy14Fz/bV3FtjxsJPDLBsxw/s1yaGC6
         mAeclTIg6hU+giEoCtH/iuhqXKyE0azR0qMUp2GnSfduTgIAorgsALBY2/+gw4pkDAWB
         Y5c9+JmwyV2Qrn1PLzLFHE+dIahMP7doPaTmQMsEGEBiJayZ2eYccqgtJEXamfej6/Qw
         2bIg==
X-Gm-Message-State: ANhLgQ1HmRJuayo2FlKLkt7iy7ECkY5KKb4+FXuI2yhInFky1zqwfjSb
        Prn/Eo3407GIqP4jAInDgw==
X-Google-Smtp-Source: ADFU+vvgSxUIVaT6sR2eCibpXrqhfW+vpgKtK8JohpcQGYc7CSt7z0ytze1qTGSmBfyoyG/F5myd7Q==
X-Received: by 2002:a02:ce91:: with SMTP id y17mr1441537jaq.36.1585609505433;
        Mon, 30 Mar 2020 16:05:05 -0700 (PDT)
Received: from rob-hp-laptop ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id h12sm2968141ilq.66.2020.03.30.16.05.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2020 16:05:04 -0700 (PDT)
Received: (nullmailer pid 26818 invoked by uid 1000);
        Mon, 30 Mar 2020 23:05:03 -0000
Date:   Mon, 30 Mar 2020 17:05:03 -0600
From:   Rob Herring <robh@kernel.org>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, sibis@codeaurora.org,
        swboyd@chromium.org, dianders@chromium.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: arm: cpus: Add kryo468 compatible
Message-ID: <20200330230503.GA26765@bogus>
References: <cd0f3d35ca0fc2944fd97e030a28318ff82dd5c1.1584516925.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cd0f3d35ca0fc2944fd97e030a28318ff82dd5c1.1584516925.git.amit.kucheria@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Mar 2020 14:38:16 +0530, Amit Kucheria wrote:
> Kryo468 is found in sc7180, so add it to the list of cpu compatibles
> 
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> ---
>  Documentation/devicetree/bindings/arm/cpus.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
