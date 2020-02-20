Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3233C34031
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 06:39:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B36224654
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 06:39:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PwS7hi9X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbgBTGje (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 01:39:34 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:34435 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726165AbgBTGje (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 01:39:34 -0500
Received: by mail-pl1-f194.google.com with SMTP id j7so1159495plt.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 22:39:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=P7JE3+AUYdGAY+4gw0noIs/K/eglkkqEwZt+wo9PhiY=;
        b=PwS7hi9Xyop1B4AUMnrKry8xSBpVmKm9WYF+SP2LNKCWY6Dv/fu6kx0cFTThkxw0cg
         vvHaltqH78aIy6ItrwdOt/3uzzFu8y4szxJdKr46FwfyY/75n577t+sTgIK1nWy1WWy5
         SzyLzbyq49Vb1XNSmh047r52PE6rWG/wMshbO6/uSRTuM8pNAzDYTsrBt6koRDoGJuHY
         ZjboezQPWwQC/kDyPcPtjNsc7a3qYYoNiAq02XqYu8KdPjSTmDC7ymg/C3f/f8rNKQF8
         371Oe//KFpSIg1loHtSD5lBKk+swOjHxGFpEImfjSGpKNDvZco190VL3zHZ154xoxrXu
         b4vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=P7JE3+AUYdGAY+4gw0noIs/K/eglkkqEwZt+wo9PhiY=;
        b=jsXgkQHUVjfhxRU3qg9XftPGfNKAjuGZV8gFSiBl7kQnWqyHMJx/yZLU9l5b6F1bDW
         t+VulssXcrWkx48cMfx+IccAdciDlM2BOe9XlteZrr3dkMFOkIuTSIYXtH2i4slQgnBY
         gmxjZY0o6jPGZ7hWJUlfX7I1BUw0LQ+AScHXhycgMNLK7UbtLMCf4PSGjqnWVt+ch6Sx
         T7AFEioVUlPNCA3p3DmIWr0T+3Q/IGbHAk5FRwz/OdzR7SjCmbbbYy8alooNYkwdwqWy
         2zoVHbyNoKTnrDsMVlBMMABTmLi2H/3TeMXKHhxWkcB2p6d3+33GhMfcpxIf9fyV5hxb
         SfHg==
X-Gm-Message-State: APjAAAW2Nol8EWzTVZVaNLeX3fKNUnR4GGcY9DnUeQa/632ta/4lBYQ1
        ZVVxVnIgfwLY+YA/qSjrJCAxrg==
X-Google-Smtp-Source: APXvYqyheAbf/TWgS0xzFUrctNXMze1bP490xxzqmCvyMspLJKgj9N4Waqg/+Pd0/ch4FPoErFLH1A==
X-Received: by 2002:a17:902:d684:: with SMTP id v4mr31005388ply.14.1582180773310;
        Wed, 19 Feb 2020 22:39:33 -0800 (PST)
Received: from ripper (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id x197sm1888311pfc.1.2020.02.19.22.39.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 22:39:32 -0800 (PST)
Date:   Wed, 19 Feb 2020 22:38:37 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v4 0/3] phy: qcom-qmp: Add SDM845 QMP and QHP PHYs
Message-ID: <20200220063837.GX1908628@ripper>
References: <20200106081821.3192922-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200106081821.3192922-1-bjorn.andersson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 06 Jan 00:18 PST 2020, Bjorn Andersson wrote:

> Add support for the two PCIe PHYs found in Qualcomm SDM845
> 

Kishon, these patches still applies cleanly, could you please pick them
up?

Regards,
Bjorn

> Bjorn Andersson (3):
>   dt-bindings: phy-qcom-qmp: Add SDM845 PCIe to binding
>   phy: qcom: qmp: Add SDM845 PCIe QMP PHY support
>   phy: qcom: qmp: Add SDM845 QHP PCIe PHY
> 
>  .../devicetree/bindings/phy/qcom-qmp-phy.txt  |  10 +
>  drivers/phy/qualcomm/phy-qcom-qmp.c           | 313 ++++++++++++++++++
>  drivers/phy/qualcomm/phy-qcom-qmp.h           | 114 +++++++
>  3 files changed, 437 insertions(+)
> 
> -- 
> 2.24.0
> 
