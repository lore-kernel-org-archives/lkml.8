Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E9C6C433E3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 04:58:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E87C722CBB
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 04:58:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JJkuVSIs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726224AbgHGE6k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 00:58:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbgHGE6j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 00:58:39 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48D1EC061575
        for <linux-kernel@vger.kernel.org>; Thu,  6 Aug 2020 21:58:38 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id kr4so318485pjb.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Aug 2020 21:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=g+BLmW/UqB0xmEpWw3DSGRQ3Asgo6mY69ytW4XNGOl8=;
        b=JJkuVSIsmiwwQfwRcrgJuCvHCYvEJ7/rGBkDJQIAaOwxCGT1IAbGMfcmay9NMXLssL
         SadA8EtfqEtmUGXHuMEvDlhCdMyu5uFGohmwg4WXurzLcN+Av7+H68LQWd4m7IJZmh4h
         spzVQu04JCzNBpHoeLeRRyrAzVY5VcGiBtmmFIC+jR4s6fZUdbvsJoyei5gS+rzu2nxU
         j1Hkuerv8X1iDVXOeZXdJzqC5VEMbB2Hp1DhUmxSCArC4gx6o/FtMD1N8isPxFZE7hn8
         EMUSXqoytWltINzKdbUSi364BBQZ5UWjgPjtb1NiuXr+gLDp8+W+a2vWGp9n41joslyw
         faAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=g+BLmW/UqB0xmEpWw3DSGRQ3Asgo6mY69ytW4XNGOl8=;
        b=aGDKTcygZvtZ3VKeqVfPPKNw6JbW8AiUOWVW2HyTPOcGXmzcAEmBNvdlY5xssQWSrQ
         4dy63xiJHFoMojw0P7Jlvw5BI6vebBND673pZv41Lkan0VvPMfdNUUg8ulnEILGbko8E
         /s7QPqRatY/PvAr7+Lm6bJd/pGFt4bDdWZprOWVy/pedexXnzI7GY+6sM47hjXBCTspt
         8fprgoOARJg5KUCiOzC7Xd6+mcl+MV/+IKCuuS3Etvh5t5KalvuSMPalWCqWZQoDFnaV
         h+SAYDPXd/rv7wByZwRpDmWJBJOL2z9ybJ25Iq+Jb2F03rw/QtM+Lu+h3GaliKw2XLDH
         eKmw==
X-Gm-Message-State: AOAM533O/PgMh947pYU4MjdYfh6FXGOCUuI4Il4l2YNvbrbn0XVWNqEC
        YAUT9db0flSwCRjARKVpdQJqKw==
X-Google-Smtp-Source: ABdhPJzojWnJS0bGGiKpZMAET5AfMD2a4xaIp1cXIXcz8JHvWh5QTu28PgvY9R08qZNGngCMPAAuUA==
X-Received: by 2002:a17:90b:1493:: with SMTP id js19mr10177292pjb.223.1596776317879;
        Thu, 06 Aug 2020 21:58:37 -0700 (PDT)
Received: from localhost ([223.190.59.99])
        by smtp.gmail.com with ESMTPSA id z26sm9610356pgc.44.2020.08.06.21.58.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Aug 2020 21:58:37 -0700 (PDT)
Date:   Fri, 7 Aug 2020 10:28:31 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kukjin Kim <kgene@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH v2 37/41] cpufreq: s3c24xx: move low-level clk reg access
 into platform code
Message-ID: <20200807045831.kxmefk4ljssojfgd@vireshk-mac-ubuntu>
References: <20200806181932.2253-1-krzk@kernel.org>
 <20200806182059.2431-37-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200806182059.2431-37-krzk@kernel.org>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06-08-20, 20:20, Krzysztof Kozlowski wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Rather than have the cpufreq drivers touch include the
> common headers to get the constants, add a small indirection.
> This is still not the proper way that would do this through
> the common clk API, but it lets us kill off the header file
> usage.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> [krzk: Rebase and fix -Wold-style-definition]
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
