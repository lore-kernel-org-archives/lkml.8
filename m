Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 831EFC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 18:16:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DA5D2064B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 18:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594836966;
	bh=3W/vYRkDQL6aKPhWWxsyygU3dfIRXjNHOXTdJViH5SM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=SQdL5HNleeGxO6iRetc2wvNxwiUlvvGZDV6H2nNuw+EhvE+qBP3c66ElAfLvTEY3B
	 nlIRo0nRz+VheUCruYerQMt5MFvO2tA6rQJyJ0LBKdWlqJNuH0nNibNYfOJU4Xa8ib
	 2ITtyx836lYx249WufM84j8PYInL3InD63ZLZbGM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbgGOSQF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 14:16:05 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:41401 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725861AbgGOSQF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 14:16:05 -0400
Received: by mail-il1-f194.google.com with SMTP id q3so2808634ilt.8;
        Wed, 15 Jul 2020 11:16:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=F0t0DHQs/G58g3g/RfGfzGlz+9oTkWn+bjS9t57l3Yc=;
        b=TztQA2dJPxXFQfuom08WWuww7i5bNhJFJ0HAvtl+ObpwOzfiiaVY2zf5camPFXanIh
         Wo+bAri5J84aPxPc5DL6sJIdQhjf6oCi4wFedm8oJSC7Vp2dC/i77WOhXHOyiRhRbk6+
         l1I9PFNWDHncCV2j8zHRbw4u//gmOc0hiLrSzXQtn+cARwDu7mAHRochlNVStJpxr55i
         VCgp7+S5YIG9GH5U+FdvEM14F2ccYz+h5bLNrmByJMrCO6Wg5R1ttMLFIT5+sWc0dTlH
         EiPzJUMfT8cnodjjiOfqFJwK9c0Xump3QimUDHqAZuic24JVYHCMmjTvDliyPp8qq2Rw
         nglg==
X-Gm-Message-State: AOAM532i2fm/HzxLh4zD7Oy7nAGRgWOh0kv6rum9vJ53ibwes9oIHb4r
        g0ihBFseNgMINQ7Roj9WOA==
X-Google-Smtp-Source: ABdhPJxInjHwjYXnTC4M1VYr/OH0djk6+aVwKSysUTZSS+t/CPWIvKyR7inUTTJ7KDIP8zL4wzmCRw==
X-Received: by 2002:a92:150d:: with SMTP id v13mr684749ilk.297.1594836964119;
        Wed, 15 Jul 2020 11:16:04 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id 69sm1466626ile.60.2020.07.15.11.16.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 11:16:03 -0700 (PDT)
Received: (nullmailer pid 551710 invoked by uid 1000);
        Wed, 15 Jul 2020 18:16:02 -0000
Date:   Wed, 15 Jul 2020 12:16:02 -0600
From:   Rob Herring <robh@kernel.org>
To:     Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH 3/4] dt-bindings: arm: actions: Document RoseapplePi
Message-ID: <20200715181602.GA551625@bogus>
References: <cover.1592123160.git.cristian.ciocaltea@gmail.com>
 <40f7d54f9502f0d33f2dcf18b02c6de0d55d2ecb.1592123160.git.cristian.ciocaltea@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40f7d54f9502f0d33f2dcf18b02c6de0d55d2ecb.1592123160.git.cristian.ciocaltea@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Jun 2020 03:19:10 +0300, Cristian Ciocaltea wrote:
> Define compatible strings for RoseapplePi, a SBC manufactured
> in Taiwan, based on Actions Semi S500 reference design.
> 
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
> ---
>  Documentation/devicetree/bindings/arm/actions.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
