Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D291C5ACC4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 22:18:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64359206EF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 22:18:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582150732;
	bh=0i1ndzBN59fSht4S6INk+5rj3E8rhaA9bzXAqf/zrs0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=UsZ1izqWfyIryq+TTP/cOODraSBB7MyKLwiApCOPm9H2WWZJOBktMJJOHaoJOawEf
	 skb2px39HI6RgYomdnSBfCyOFIWh1SOZ6cxIFqe2aOd6ncwZSEwsv7jhh/vheqAB3t
	 rqghRPgQXSOOcNTQwU+tA4lOb5lRYj0YSU8dZ5Bw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727802AbgBSWSv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 17:18:51 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:38236 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726760AbgBSWSu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 17:18:50 -0500
Received: by mail-oi1-f193.google.com with SMTP id r137so5911184oie.5;
        Wed, 19 Feb 2020 14:18:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Lb8z6pmbJJ2LJeHbmRGrWhVRqC/aW6CAMpmAMz1gxTk=;
        b=AcroxdroS4ZlXmUajS7qeyXYTCRnG7+hY5+1dY8e/J6X/cCxbkN/rC7rphrkRqukSq
         ctjnP0TYiLUWfQ718+g8wowVBDowpiUOPwxdaHrA4q1RBoqwVFupwCnfpLyp7ynYB6wC
         zV3ShcJFYYWYTHomfmYkqQitX6LZCiyJcXGYfTyFOO4JtknyI/xrzusE2imGYD5jl1Y0
         E3rkHI/kM/3scO8lwuQfgj9xhSBq6BUgQ9kz/WJ+O+3UdixsoYi8RQdwVHtoxRSyRgY/
         PfLZSvxQOUX63KYo1prWC3yqYKZAXZ26fRFiXIY3MEUovD7m5GSW7yjeM7zNk9DaGM5N
         SdQw==
X-Gm-Message-State: APjAAAXiKh1Bpx3cJd8DTjFxoDO/SR+LWl1czBHhR/m/JN5HbjwLi3mU
        l63YWFUnnd8SkdcHeFL4mg==
X-Google-Smtp-Source: APXvYqzHJyK1DAI0qeUN2NlIkEGccyceEGasZSdf75idALGhOVUFySZL04o4JBQ0SR/eiD5nh9G9cQ==
X-Received: by 2002:a05:6808:3ae:: with SMTP id n14mr6210097oie.63.1582150729704;
        Wed, 19 Feb 2020 14:18:49 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id p184sm428899oic.40.2020.02.19.14.18.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 14:18:49 -0800 (PST)
Received: (nullmailer pid 6936 invoked by uid 1000);
        Wed, 19 Feb 2020 22:18:48 -0000
Date:   Wed, 19 Feb 2020 16:18:48 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Anand Moon <linux.amoon@gmail.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Felipe Balbi <balbi@kernel.org>
Subject: Re: [PATCH] dt-bindings: usb: exynos-usb: Document clock names for
 DWC3 bindings
Message-ID: <20200219221848.GA6855@bogus>
References: <1581343456-18900-1-git-send-email-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1581343456-18900-1-git-send-email-krzk@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Feb 2020 15:04:16 +0100, Krzysztof Kozlowski wrote:
> The Exynos DWC3 driver expects certain clock names, depending on used
> compatible.  Document this explicitly in the bindings.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  Documentation/devicetree/bindings/usb/exynos-usb.txt | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 

Applied, thanks.

Rob
