Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8607C43461
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 16:34:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DD0622205
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 16:34:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599842090;
	bh=FuL9n2fs1ljbrrPP9gmbC0akHK29HNE743bOOeGFjU0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=eZorBV4K83BWZo3L9x0nP75ljrsZxulfy9scAldDzask1b+a49Gia6vbt+x2e8dXp
	 QG5pJVzLC7qTxn3mtV336soTDs8ZpkBxcD3Fn3GKnFwj/kJ6aC+OSMoCjIRgwiRVZD
	 XAhP/L5cQ32bWaUq/rzcozFf7lQ7WKvWhxttVi7Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726556AbgIKQer (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 12:34:47 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44601 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726271AbgIKPO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 11:14:56 -0400
Received: by mail-wr1-f65.google.com with SMTP id s12so11821559wrw.11;
        Fri, 11 Sep 2020 08:14:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UIVbwBNKxNo/10lplKWoo394ZufuQog2Ked0Yf0GEU0=;
        b=pi8SdIVAxEH9+5z3pbGZLtoqICGQRgAqCbHXW0i6Y2RydoCALqsvhU+r/mnJsz4XjM
         aaviy7LIDbPe2PuiTnENSbgCYOW9ic7/i6n3dlJNtY0O8fnmgu6Hhe4a9+lzMtXViPiR
         fftSRPPcELoU0ZvMRBE9/oE+85R9YueF1O154MjLpvWkzfCupMClA7PJ8RJSVGOYN2ZV
         4l/bCqJHxLPerVrBMu61AhKI4hUXBVPltRPneyk/q3uQNNjJRpYt4SdUredopwUqxtO2
         PoWmGAdmlfGirtZk3vBbG+9WyQjcsOd9fPz/sAp37wuWsYbHesT34oAkesWZ6kZ8459r
         /xWA==
X-Gm-Message-State: AOAM533T/W7J2zxwvQbcZUqQ1P6Lafrzsw7eSaSgJrKxI9LKwY/ibjBW
        poWO0wwHkVTNQFWTWn1MtEKt/oVxFPpo9g==
X-Google-Smtp-Source: ABdhPJyRFKcUX5ZMW6c5ii/6YaXTE/rQWuO05eOrW+yGWhS9Pw4jNEpnmBx0GwzTcscwqGuyAKKerA==
X-Received: by 2002:a17:906:3e4e:: with SMTP id t14mr2264655eji.269.1599834992753;
        Fri, 11 Sep 2020 07:36:32 -0700 (PDT)
Received: from kozik-lap ([194.230.155.174])
        by smtp.googlemail.com with ESMTPSA id f10sm1814872edk.34.2020.09.11.07.36.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 11 Sep 2020 07:36:31 -0700 (PDT)
Date:   Fri, 11 Sep 2020 16:36:27 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Kukjin Kim <kgene@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Lihua Yao <ylhuajnu@outlook.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>,
        Tomasz Figa <tomasz.figa@gmail.com>
Subject: Re: [PATCH 01/11] ARM: dts: s5pv210: Correct ethernet unit address
 in SMDKV210
Message-ID: <20200911143627.GA659@kozik-lap>
References: <20200907183313.29234-1-krzk@kernel.org>
 <20200907183313.29234-2-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200907183313.29234-2-krzk@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 07, 2020 at 08:33:03PM +0200, Krzysztof Kozlowski wrote:
> The SROM bank 5 is at address 0xa8000000, just like the one put in "reg"
> property of ethernet node.  Fix the unit address of ethernet node.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  arch/arm/boot/dts/s5pv210-smdkv210.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied.

Best regards,
Krzysztof

