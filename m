Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 469C6C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 21:53:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 168222076C
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 21:53:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598392405;
	bh=sAhkEm6YliRcAYy1mMWm7COysfMC8XW2gvwuTDg62Mk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=LNuXhmWy26VHsJD3KZ/VdWH2rgppk4cxbiUS8rP8xME9aiHXR82BzPHz6TD+zZW2e
	 VnZdvzCwWi16b9zE47NCv3bsXsbdJFXPDwEKEInP0UvXmWRym+QzgE/OULNb14erHc
	 e5OpH/5Fhr5o6sd2/WbKApJHF3i1eoiMp+bLHRWQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726719AbgHYVxV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 17:53:21 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:39945 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726303AbgHYVxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 17:53:20 -0400
Received: by mail-il1-f194.google.com with SMTP id p18so67560ilm.7;
        Tue, 25 Aug 2020 14:53:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7S4jNrtiVeItNvIwFbgTvmiqNgQ9tXiglEZ3XO2eiQM=;
        b=tiR87tQfkcdC4BRLbI+voRAWvI6Qaj4gQzAY17UFuNQOXO2jf5zj+PCWX5n0Gx54rO
         O7Wlo3Epiikl71BfPkLonMiB18jIVeILTdajfMxENSMgtV1lsKHcMKS/nQQT02+wwgcF
         wZ/nHw7qTYJXQGY1EusmjmpUNgl+I5SjfcqgUuNYRkdor4LJLioZXwE238vG+vDYfTsh
         k9JU7DrWi5VyTGHS8huyNxx98f+NXhJqmpUIViR9PKEgjV/yT3wKFQnKF0IliL3gj6kP
         UAHWB0e8s0efdfBFlSG7EZ8Ktrve9fVSn8Py6p/35LBOGAWQ1rmJe6PzsmFhJp7z54BC
         zQDA==
X-Gm-Message-State: AOAM531vMUsec8qPevnTdP9ar/z8fwb/tF/BThy5I8lZTuOiPEV3dCAo
        YlYHt1pJo0kDjhBrMSkTJVckJHpTYM5M
X-Google-Smtp-Source: ABdhPJwd6+sslgtyqmzuBjzuHXAz/dWhzSBO0h7xbItMhxxl6rpQd2N1rXAI/oFBnitw9IqV28R9gA==
X-Received: by 2002:a92:5f06:: with SMTP id t6mr10331000ilb.212.1598392400065;
        Tue, 25 Aug 2020 14:53:20 -0700 (PDT)
Received: from xps15 ([64.188.179.249])
        by smtp.gmail.com with ESMTPSA id p124sm47082iof.19.2020.08.25.14.53.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2020 14:53:19 -0700 (PDT)
Received: (nullmailer pid 1403867 invoked by uid 1000);
        Tue, 25 Aug 2020 21:53:18 -0000
Date:   Tue, 25 Aug 2020 15:53:18 -0600
From:   Rob Herring <robh@kernel.org>
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: display: simple: add Innolux LS075AT011
Message-ID: <20200825215318.GA1403815@bogus>
References: <20200819101206.633253-1-lkundrak@v3.sk>
 <20200819101206.633253-2-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200819101206.633253-2-lkundrak@v3.sk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Aug 2020 12:12:05 +0200, Lubomir Rintel wrote:
> Add the Innolux LS075AT011 7.5" (1200x900) color/reflective LCD panel to
> the panel-simple compatible list. This panel is used in the OLPC laptops.
> 
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> ---
>  .../devicetree/bindings/display/panel/panel-simple.yaml         | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
