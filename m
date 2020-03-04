Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22BBBC3F2D1
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 14:58:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F07C820732
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 14:57:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583333880;
	bh=mmQIEtJSNzi4WtTVzf/8bIKeoW0Fm2DWMyxwg87FxQM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ksNr7n/olPzv5U2ocNsp5vT7OOcJt6uAAkixt9L7he9DQUbyjLj3Stz0P1HmPnq+f
	 C0+UK9mtFxoE9oStxyam0I3uSwhZF18Bv1DzmtRerSJ/PjFQejdc73COTqZ6/8C75v
	 pcPArHpvItdMz9zW1kBZw+5QIYzrEPjcvvmAhAbY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388005AbgCDO57 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 09:57:59 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:41846 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725795AbgCDO56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 09:57:58 -0500
Received: by mail-oi1-f196.google.com with SMTP id i1so2337320oie.8;
        Wed, 04 Mar 2020 06:57:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DmcoZNUJxxsS5LTSsyiiqENx6EIP1OPlgM367MTeK8I=;
        b=LfCBzxIQ8WzX+TFAeheZYWPj7a+6aLUYdys0KxSQXX3caQxK7LsvQE3PA+LnNzHJCk
         RSj5rh0tt5JG7Ak0tSdDlnmfNSn5KD33ddWAqUx7ZdL4WH1EHiS9Dcsbyphi9b8jgzFO
         f0pLTUKKXETfUlRv6B+GtFNlJrYgoiKvEeSanuAqU79sYqw0mjQzQlKGPUCsMxm/9NEE
         Uav2xvs2uhnsNLqwH972fMi81mArWIGPill7gsW7HKhta4DLa3j9nX8uLuPcVQhefAkx
         DhAgflMCUEIq+YwPUcQ09inpHIVv/lDlAj00ENChzi4lGnGaeMCXPe+pkJH/G2CYb05/
         ZKpw==
X-Gm-Message-State: ANhLgQ13rwoGGPCvr1hCRwlcdN4+WYajaxIpwsgoly9h2e4tu60kVF2S
        j3I7eYps4qV93iTfB20HtA==
X-Google-Smtp-Source: ADFU+vt4gqhc3KDXQ3ks19GyfY1ioyJVdrTyDw9Oyh68DIp1bWp9tTZzshgCw7rze/fFoCaTdgQKdQ==
X-Received: by 2002:aca:f1c2:: with SMTP id p185mr2037926oih.87.1583333877779;
        Wed, 04 Mar 2020 06:57:57 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id i20sm9072512otp.14.2020.03.04.06.57.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 06:57:57 -0800 (PST)
Received: (nullmailer pid 17602 invoked by uid 1000);
        Wed, 04 Mar 2020 14:57:56 -0000
Date:   Wed, 4 Mar 2020 08:57:56 -0600
From:   Rob Herring <robh@kernel.org>
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        gregkh@linuxfoundation.org, jackp@codeaurora.org, balbi@kernel.org,
        bjorn.andersson@linaro.org, robh@kernel.org,
        linux-kernel@vger.kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
Subject: Re: [PATCH v7 07/18] dt-bindings: usb: dwc3: Add a
 gpio-usb-connector example
Message-ID: <20200304145756.GA17484@bogus>
References: <20200303171159.246992-1-bryan.odonoghue@linaro.org>
 <20200303171159.246992-8-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200303171159.246992-8-bryan.odonoghue@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  3 Mar 2020 17:11:48 +0000, Bryan O'Donoghue wrote:
> A USB connector should be a child node of the USB controller
> connector/usb-connector.txt. This patch adds an example of how to do this
> to the dwc3 binding descriptions.
> 
> It is necessary to declare a connector as a child-node of a USB controller
> for role-switching to work, so this example should be helpful to others
> implementing that.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: linux-usb@vger.kernel.org
> Cc: devicetree@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Acked-by: Felipe Balbi <balbi@kernel.org>
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> ---
>  Documentation/devicetree/bindings/usb/dwc3.txt | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 

Please add Acked-by/Reviewed-by tags when posting new versions. However,
there's no need to repost patches *only* to add the tags. The upstream
maintainer will do that for acks received on the version they apply.

If a tag was not added on purpose, please state why and what changed.
