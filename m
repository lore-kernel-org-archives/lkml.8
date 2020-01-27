Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22F38C33CB1
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 15:41:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE06622522
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 15:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580139677;
	bh=aCVSdoa3+eJc6HvLzy31vDS61hBgZ1rz55uMI+NoCmo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=BcSqtSYmfqa9Fjl22Vdw7z9G/xHSz/WzBs70ffq6HZIaRAJUgVi63VutfK0p21/hl
	 9ojxJLPokXk4hsdoIblzGpOLD6WG+NAfU9b4VMmOJE6CWroA8sjQj3o6MYQaYA6OgS
	 jbppfS1KP2DSdxOBqUxCI8Jic6X44nLszmsa/+Js=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729611AbgA0PlQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 10:41:16 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:36436 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729133AbgA0PlQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 10:41:16 -0500
Received: by mail-ot1-f65.google.com with SMTP id g15so8795436otp.3;
        Mon, 27 Jan 2020 07:41:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SSAka/+unOWdID+dlGzjX+fU3/o5RpQNSVZW5gnH3WE=;
        b=UlpyH7xThF7e1EYysadA9L2V2vXr1nkFatKIQ1TjP1FT7lrVkoQECL2VLMmtvuUyqo
         /BP3SYJtFyM1F7siuTvj0ObQJvpQOv0REFnWioXRqT3LmfAnnzj75RDKpvWw2Sgt61Uv
         0pL84X3+nLckUa3XUxiTdAs78pBmaZUs9puqxwO6NLiwkrWp3tl3iGAY4OMiKUcDprCH
         wJAQri32q/ZlrEQJ/55TsOwlXfn/E71LE1i4egik3xto7O8AQ3obrNNQgw8yJBG81Ql4
         V7MrQYqIz7jR2Tpy8202RYjwt1Gjk0n/HIbeORciom35cemdbTxZAviF04SD0FiceZxA
         cbPA==
X-Gm-Message-State: APjAAAVS6urqASPpWWr7gDyz2cXmCIV2neyciQpo1jbTo93AIZ2Mj8vJ
        er3GwspdAzwM1xRG7ZCtqg==
X-Google-Smtp-Source: APXvYqyFSBoR7e0fQ95loR0phVN8/LbKEX99IjMFvGvg6Ft5a0R3Rhk1dKI6rdHuGUXnQJKSH+UUPA==
X-Received: by 2002:a9d:68d1:: with SMTP id i17mr12360581oto.367.1580139675043;
        Mon, 27 Jan 2020 07:41:15 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id l207sm247662oih.25.2020.01.27.07.41.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2020 07:41:14 -0800 (PST)
Received: (nullmailer pid 6960 invoked by uid 1000);
        Mon, 27 Jan 2020 15:41:13 -0000
Date:   Mon, 27 Jan 2020 09:41:13 -0600
From:   Rob Herring <robh@kernel.org>
To:     Sricharan R <sricharan@codeaurora.org>
Cc:     agross@kernel.org, devicetree@vger.kernel.org,
        linus.walleij@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-soc@vger.kernel.org,
        robh+dt@kernel.org, sivaprak@codeaurora.org,
        sricharan@codeaurora.org,
        Rajkumar Ayyasamy <arajkuma@codeaurora.org>,
        Selvam Sathappan Periakaruppan <speriaka@codeaurora.org>
Subject: Re: [PATCH V6 1/5] dt-bindings: pinctrl: qcom: Add ipq6018 pinctrl
 bindings
Message-ID: <20200127154113.GA6904@bogus>
References: <1579439601-14810-1-git-send-email-sricharan@codeaurora.org>
 <1579439601-14810-2-git-send-email-sricharan@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1579439601-14810-2-git-send-email-sricharan@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 19 Jan 2020 18:43:17 +0530, Sricharan R wrote:
> Add device tree binding Documentation details for ipq6018
> pinctrl driver.
> 
> Co-developed-by: Rajkumar Ayyasamy <arajkuma@codeaurora.org>
> Signed-off-by: Rajkumar Ayyasamy <arajkuma@codeaurora.org>
> Co-developed-by: Selvam Sathappan Periakaruppan <speriaka@codeaurora.org>
> Signed-off-by: Selvam Sathappan Periakaruppan <speriaka@codeaurora.org>
> Co-developed-by: Sivaprakash Murugesan <sivaprak@codeaurora.org>
> Signed-off-by: Sivaprakash Murugesan <sivaprak@codeaurora.org>
> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
> Signed-off-by: Sivaprakash Murugesan <sivaprak@codeaurora.org>
> ---
> [V6] 
>   * Addressed review comments form Rob.
>  .../bindings/pinctrl/qcom,ipq6018-pinctrl.yaml     | 153 +++++++++++++++++++++
>  1 file changed, 153 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,ipq6018-pinctrl.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
