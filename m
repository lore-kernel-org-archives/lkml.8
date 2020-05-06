Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69354C28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 15:22:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E07D20936
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 15:22:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20150623.gappssmtp.com header.i=@networkplumber-org.20150623.gappssmtp.com header.b="XsLCj3cb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729477AbgEFPVw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 11:21:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729445AbgEFPVt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 11:21:49 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C2D8C061A10
        for <linux-kernel@vger.kernel.org>; Wed,  6 May 2020 08:21:48 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id 7so2575657pjo.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 May 2020 08:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=l3dvl4KUVW6lOYjk9hPMXPvcXmJ6hlVZhKPWrOvasd0=;
        b=XsLCj3cbL0qXcpaGnYJ+pvkth0mpbhYdjiVyqlK1a4thH9KlvZQ6S9vg0C5M5uuMCM
         mASFpDbRVQRlfUdKJYhvC1nXCdOWvgwjWZ0X+QA/IJKG2AFDb9YKiSAF/ft4dR4pwuKC
         DlyUogAWlJAU6XfQVAfQIoC92KD8eYuzCQjM3vMVIuOajaWBVre2GEXpCCUa5MG6IU+0
         Hi3yXyMUjrPsa9S9QybHlcZVDBGptarfLfubZAzlGAmhQutDUJ3g+xLR0lc1KLO+28A2
         kmazSm1h1IKzKZCXYaTck5/J0d9yJ9HENYKVDD1uq1QrakTyxGNd7DqwBKdJcprUJBxq
         2loA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l3dvl4KUVW6lOYjk9hPMXPvcXmJ6hlVZhKPWrOvasd0=;
        b=DyMq8pgkD2AWjK/BMrGmPP0mMDfW8SLAI0vTXqJjzU73mN4KDqjyyM1xdWmtJO4vjp
         kG5Gd0yb7wZnqdfLyFgGhfKqsSv+7aBC5B4DGQCx3yERYHUfGl2VTjRMWr3pe+dTfVov
         qSuBGr9O9+Awcd00bMDnJ7mXED0XlGRNWvJP0R/8cri3BcKas0W9bsJjMEM3rxsUWzkJ
         nPr+CywxCAt6m/VeOLuMf9N2PcLHDnVRtFdV6dZnMzhM1g8I/evWT1kRH0genEgbL31i
         dhEf2IPCcfS/qvOwrvenov0Aaq7oWyhH7rid7jJJuOEqu34rQGUSRisoFWQNdyZi5+5E
         hMow==
X-Gm-Message-State: AGi0PuYX2U6wQJnnpZVmWPV4MCKhMc/c+8uxIx88bcLAEbSt64ZTHQR+
        73kwLy7IpxnZLyEi90LD786qKw==
X-Google-Smtp-Source: APiQypIRqbdsbg6eMigkHYaGO2ldIooYnkYRCiQwznGcabDVCdyPDkuqXpty5XxiCeBTGEXP0X35Yw==
X-Received: by 2002:a17:90b:19d7:: with SMTP id nm23mr8124949pjb.211.1588778508025;
        Wed, 06 May 2020 08:21:48 -0700 (PDT)
Received: from hermes.lan (204-195-22-127.wavecable.com. [204.195.22.127])
        by smtp.gmail.com with ESMTPSA id a17sm2190402pfr.24.2020.05.06.08.21.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2020 08:21:47 -0700 (PDT)
Date:   Wed, 6 May 2020 08:21:39 -0700
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     Po Liu <Po.Liu@nxp.com>
Cc:     dsahern@gmail.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, vinicius.gomes@intel.com,
        davem@davemloft.net, vlad@buslov.dev, claudiu.manoil@nxp.com,
        vladimir.oltean@nxp.com, alexandru.marginean@nxp.com
Subject: Re: [v4,iproute2-next 1/2] iproute2-next:tc:action: add a gate
 control action
Message-ID: <20200506082139.58dff261@hermes.lan>
In-Reply-To: <20200506084020.18106-1-Po.Liu@nxp.com>
References: <20200503063251.10915-2-Po.Liu@nxp.com>
        <20200506084020.18106-1-Po.Liu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  6 May 2020 16:40:19 +0800
Po Liu <Po.Liu@nxp.com> wrote:

> 		} else if (matches(*argv, "base-time") == 0) {
> +			NEXT_ARG();
> +			if (get_u64(&base_time, *argv, 10)) {
> +				invalidarg = "base-time";
> +				goto err_arg;
> +			}
> +		} else if (matches(*argv, "cycle-time") == 0) {
> +			NEXT_ARG();
> +			if (get_u64(&cycle_time, *argv, 10)) {
> +				invalidarg = "cycle-time";
> +				goto err_arg;
> +			}
> +		} else if (matches(*argv, "cycle-time-ext") == 0) {
> +			NEXT_ARG();
> +			if (get_u64(&cycle_time_ext, *argv, 10)) {
> +				invalidarg = "cycle-time-ext";
> +				goto err_arg;
> +			}

Could all these time values use existing TC helper routines?
See get_time().  The way you have it makes sense for hardware
but stands out versus the rest of tc.

It maybe that the kernel UAPI is wrong, and should be using same
time units as rest of tc. Forgot to review that part of the patch.
