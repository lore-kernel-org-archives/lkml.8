Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B083C433E7
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 15:25:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC392206A5
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 15:25:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599060352;
	bh=M1Vv/KM1OFVTFwE3RJE4fDataCfWpgCvPRcdvr78zSE=;
	h=Date:From:To:Subject:References:In-Reply-To:List-ID:From;
	b=Hu3arp17+MiYXJFvr5SpCJyVgEQVZGbHfgaUkcpaE23z7YZstPbhKCYZy0N9L3bwb
	 mUGdkFJwvfoM5I3pYC175mEgPXG8z5/MEMmjqhUlQDrhRVIxYtqEoRSvfo+Cccf1O1
	 Mqud6JhmVhqLL4t+ABqgjsm4W23Utca2sqfHj1FM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728172AbgIBPZU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 11:25:20 -0400
Received: from mail-ej1-f67.google.com ([209.85.218.67]:33022 "EHLO
        mail-ej1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727963AbgIBPWv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 11:22:51 -0400
Received: by mail-ej1-f67.google.com with SMTP id j11so1530131ejk.0;
        Wed, 02 Sep 2020 08:22:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sFHrQub+jTEKH5D1eU35+5gm+w2UlYWNNVwMw3mItZk=;
        b=r15hSUvrilTOq2F1Yu2f+YytVguJpWhjgHU3CS15axbYsgIHQm3ZDNVqWO9PDV0D8e
         83TH22gfhhP+Kmd8UY9ibYvj/HPEfpADiPiy2rLW04kAa6wI2NmRl0o12Wauu1RZgoST
         BNjikQXnAKGwBJoIsmka+F3GoKw4EYX88t4Hbej9t3lqqA/PhAwFJ3RZpetnD/EbGusX
         VrCXiJILBD3ZihQeJL8E6NISRTKK6Wy9fw5R0sD/rxSBTyqGEjMaRmU+uNu2ed+9s4VS
         76PSqrRtg/n7ASWhqQ/EOei9L2TxUPTKICKj7oMaynEuPy0GgPZd6eUyilUJV847tGc3
         Q0Fg==
X-Gm-Message-State: AOAM530g1nrVlPZz/rQdgAEuuRcTZhjvicdjOc/H26YuXN8uBdKYeoia
        INZ0Jws/S2M85gozeOyOwZ8=
X-Google-Smtp-Source: ABdhPJx988jNbSiGWtKhTNatNe3+5wNYljOf8q4qU2m3EM4LHKPlNuShz9gHWeXEp3FZLOdxA3HYhg==
X-Received: by 2002:a17:906:3957:: with SMTP id g23mr600042eje.24.1599060169950;
        Wed, 02 Sep 2020 08:22:49 -0700 (PDT)
Received: from kozik-lap ([194.230.155.106])
        by smtp.googlemail.com with ESMTPSA id x21sm4530841ejy.97.2020.09.02.08.22.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 02 Sep 2020 08:22:49 -0700 (PDT)
Date:   Wed, 2 Sep 2020 17:22:47 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Markus Mayer <mmayer@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: Re: [PATCH 1/2] memory: brcmstb_dpfe: Simplify with dev_err_probe()
Message-ID: <20200902152247.GA19659@kozik-lap>
References: <20200828153747.22358-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200828153747.22358-1-krzk@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 28, 2020 at 05:37:46PM +0200, Krzysztof Kozlowski wrote:
> Common pattern of handling deferred probe can be simplified with
> dev_err_probe().  Less code and the error value gets printed.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  drivers/memory/brcmstb_dpfe.c | 7 ++-----

Applied.

Best regards,
Krzysztof

