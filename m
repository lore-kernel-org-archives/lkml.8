Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB497C433E1
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 12:31:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8836620774
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 12:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594211492;
	bh=TahPmUy/RGum1P5A7lNK6A9ncBfj7QLgbsxh85+qZiM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ajRAD27wGAF8dNJAey75jY9mKiRoZ6HyvymCJBS8aaCN2BbbuCO2XaLIi6TXmLRNE
	 Fn2IqIvfOZ/hCFurWShHl16uoc5AsJhcy0sBaGsfRFL9Iu33xwYcFdlGqq18Z51zzz
	 VvvEeUduYOJqMKOc9K9B8ch5S0lO05YK+h1mdQpo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729053AbgGHMbb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 08:31:31 -0400
Received: from mail-ej1-f65.google.com ([209.85.218.65]:43524 "EHLO
        mail-ej1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728969AbgGHMbb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 08:31:31 -0400
Received: by mail-ej1-f65.google.com with SMTP id l12so50261670ejn.10;
        Wed, 08 Jul 2020 05:31:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ygzArpvH7RPCySBUWiISobL+c+Ql9Y19rwAtWfABm8U=;
        b=As/H1ov45md0P7YcaeeU9Ma1oYI0Ng0kD8nIvd3Yrf3nvuBq+TIkjmkhinxiax60yN
         4gdAjgrzQtUrCvq+TZ42SXMKMRMUc5lzL2NxWZVnpdwmRUt4HpXXpagz9/iEdLrSGCNa
         v8bAj+uxSL+DzVRoOR2StFDYvrUhaIpYDjNb/Ma+ljJx4fC/8t0lwh6qEPPpHDZuECEY
         Z9T1oQg1Z8zsjp9ap7PTRQABG7xrgn0pyuRi0roBnFwGvilTsouFteZ6xajJAcYhIBMM
         nN7lSqbxfeQJdL6XuREjdhDLFLAxS8AonmmH+P56PZ2M4hNyjcfahGGNI0R6IbDulo1R
         X1+Q==
X-Gm-Message-State: AOAM530yJsZltftkoHvSBFVws3CNrGo94T6iV39oKlsrj3XYRDPDsWng
        T/Cjvv0IjganSmSWWzbNm5I=
X-Google-Smtp-Source: ABdhPJx5kRIHY/+y31r0ade1Fiq6aBAnXwe+tb2On86JyklMR4m3oRE71PGbxQPALItMwlHHg+k/VQ==
X-Received: by 2002:a17:907:1190:: with SMTP id uz16mr50778637ejb.385.1594211489188;
        Wed, 08 Jul 2020 05:31:29 -0700 (PDT)
Received: from kozik-lap ([194.230.155.195])
        by smtp.googlemail.com with ESMTPSA id q3sm23853098eds.41.2020.07.08.05.31.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 08 Jul 2020 05:31:28 -0700 (PDT)
Date:   Wed, 8 Jul 2020 14:31:26 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Anand Moon <linux.amoon@gmail.com>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-samsung-soc@vger.kernel.org,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>, Kukjin Kim <kgene@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH v3] phy: samsung: Use readl_poll_timeout function
Message-ID: <20200708123126.GA29033@kozik-lap>
References: <20200707095908.372-1-linux.amoon@gmail.com>
 <20200707113645.GA27280@kozik-lap>
 <CANAwSgQ_LXx=oHuu1dcHBZqo0zr-mHYWKnVPFJn+_G44JRarPA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CANAwSgQ_LXx=oHuu1dcHBZqo0zr-mHYWKnVPFJn+_G44JRarPA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 08, 2020 at 01:59:46PM +0530, Anand Moon wrote:
> > Still you did not mention that you convert the function to use sleeping
> > primitive.  You also did not mention whether it is actually allowed in
> > this context and I am not sure if you investigated it.
> >
> OK, I am not sure how to resolve your query.
> I learned some new things.
> 
> So here are some points.
> -- Yes read_poll_timeout internally used might_sleep if sleep_us != 0
> under some condition.
> -- None of the code in phy-exynos5-usbdrd.c is called using kernel
> synchronization
>      methods like spinlock / mutex.

More important is rather the call to calibrare() as this is the place
where affected code is used.

It is not only about synchronisation primitives used in the driver but
also in the phy core. I guess there should not be a problem. I just
stated the fact that you did not mention anything about it.

> -- I have checked this function is called non atomic context.

Great!

Best regards,
Krzysztof
