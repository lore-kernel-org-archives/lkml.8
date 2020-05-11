Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05D85C54E8D
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 23:05:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CAE9420714
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 23:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589238339;
	bh=ebxSEPhPoT6znp/xAMrvjEzxTayg+GYc9BOyEzk4xPM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=nM8fL7QhkVT0CVKgMNrZ/hbf5SpR3ses9iW1cGfrSjCHCZFNHCU7NZUWSWsJ83Kpn
	 s/SnJAdrSnntTCEWc4so6gaDLCSYMQuJWFvUmKHE5/6tLnZN4dAee7d/8Ij40oyu3W
	 GeStKBcaXxL90J0lRKYlPHD4UcKWXXP9n3DssC5Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728037AbgEKXFj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 19:05:39 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:36551 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbgEKXFi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 19:05:38 -0400
Received: by mail-oi1-f193.google.com with SMTP id x7so15730423oic.3;
        Mon, 11 May 2020 16:05:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uQPtZnlk6tVZCxmnEPskW6TpGbRAQgAZrpD/f0dkcoA=;
        b=PW9hOHLMeomgn1/vgqpawvQr2qXknAgCe6u64YyLAdSgHMiJJRWTcsafZrmfTX3/GD
         Q+XK/4F80PI3Gca+beYJbBIl4uA5Bk/jad4J4ucuWE3ojoP34kt2DIF5IFyCuwzT6y/s
         A/lVcXBVikkyljv/CdKxxUp0kJ+qjWAAK7TOVL3Z5wMdRhmIo20d7WE6cG/3OWOPGqPs
         tKZiWyTZ8BYGnwInLdQrJm/jTVDq7LEOvcfeORmFGELS/b+E3UCd89UK7E5UPHJpviki
         TLZS/Y3NaGnBTPwULN/aAah6b891zbJ87psLOkaIckJdTPtc1/8wwYMfS6495fAswqCq
         xOHg==
X-Gm-Message-State: AGi0PuYAD5kN/qeLOYx8wCgT/ZkLyd9Cu5EZ195AzwBC8vXQ2vAVijVg
        9xfSVkuV3KjUPHLBX6kOmQ==
X-Google-Smtp-Source: APiQypKnBJSyR/IWwACxzGz7RWmKQhCKJO8hffRYERtZ/2ymbdXAqGeJp/Hg0+RfGyBC13R2O6Y9tw==
X-Received: by 2002:aca:4e10:: with SMTP id c16mr21483560oib.140.1589238338044;
        Mon, 11 May 2020 16:05:38 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id t10sm3152164oou.38.2020.05.11.16.05.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 16:05:37 -0700 (PDT)
Received: (nullmailer pid 23889 invoked by uid 1000);
        Mon, 11 May 2020 23:05:36 -0000
Date:   Mon, 11 May 2020 18:05:36 -0500
From:   Rob Herring <robh@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>, Andy Gross <agross@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH] soc: qcom: aoss: Add SM8250 compatible
Message-ID: <20200511230536.GA23509@bogus>
References: <20200427054202.2822144-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200427054202.2822144-1-bjorn.andersson@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 26 Apr 2020 22:42:02 -0700, Bjorn Andersson wrote:
> Add SM8250 compatible to the qcom_aoss binding and driver.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>  Documentation/devicetree/bindings/soc/qcom/qcom,aoss-qmp.txt | 1 +
>  drivers/soc/qcom/qcom_aoss.c                                 | 1 +
>  2 files changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
