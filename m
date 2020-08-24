Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D55F6C433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 23:21:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 902A720656
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 23:21:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598311273;
	bh=/5N86twYxI4EOqGjvFSLOCPWrz5bWFFe3dXOW1QKBBg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=uvEeejZQLsM+m3M4+EGAibUm/l3ImFIUEgkG262ZZ8wui2wJZ3uZ/7++dHWHnDXtX
	 BwxYD8iSJF0Ah4h8NeIJ5E4yVRPoz+KGNareeCPICgBFFdAUAEW2Ff/8Bn3HJDh98T
	 P8orxFrewaaIDL/um3yQusVSkHW3C21PHcYgAFvM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728219AbgHXXVM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 19:21:12 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:34318 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbgHXXVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 19:21:11 -0400
Received: by mail-il1-f196.google.com with SMTP id t4so8858384iln.1;
        Mon, 24 Aug 2020 16:21:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dHT21K2ThCYKCWY29jE8gV7M7hztSi8jrOrYJdoMcr0=;
        b=rtNgqi0PWAYDY8+XfLOTCTxyJgLrHgU+uMJtEXvUKMZL9qMVNHvKaHSt+w0J1r+46N
         7r4LInvO1gYo79LQjS5kOdfHnDKakU6RjD8bAV5lnPA8xSrJkqJeL4jt8utPAc78MqN9
         oyixe3T+UigdY1eRHSwUmSe3/eTppclWa2aeRHadxWFOVB9iSLDZ6mPY4tYE96SKa1SZ
         nNg6FTi+UrXJ1T7D12OOjTvwDrI0Q+Ss8/cYIxhSclxRHg1Raf37oqC0LeirLAiasINY
         OIs48ogv7WDUxk4GPiggpgQEih3hGFmWsTQHonBpEHpVN7G+fuwq6/2x4qh4J/lRD5Ar
         yQbQ==
X-Gm-Message-State: AOAM530lkhn1EqD3PZrueOlJwPUpM7yZOAW+PHVAtW9ixewJBW+A5nko
        9QuBhaLCtOY4asaZ351EsA==
X-Google-Smtp-Source: ABdhPJwiumbOUZIb5eWkoPu21UOZDeJrET/huZ74qaDExYc53dFYCFj1qMLSr538p/WawFhjmM5vhg==
X-Received: by 2002:a05:6e02:134e:: with SMTP id k14mr6989994ilr.271.1598311270740;
        Mon, 24 Aug 2020 16:21:10 -0700 (PDT)
Received: from xps15 ([64.188.179.249])
        by smtp.gmail.com with ESMTPSA id a11sm7966826ilh.74.2020.08.24.16.21.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2020 16:21:10 -0700 (PDT)
Received: (nullmailer pid 3525044 invoked by uid 1000);
        Mon, 24 Aug 2020 23:21:07 -0000
Date:   Mon, 24 Aug 2020 17:21:07 -0600
From:   Rob Herring <robh@kernel.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Rajeev Huralikoppi <rajeev.huralikoppi@silvaco.com>,
        Nicolas Pitre <nico@fluxnic.net>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-i3c@lists.infradead.org,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Conor Culhane <conor.culhane@silvaco.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/4] dt-bindings: Add vendor prefix for Silvaco
Message-ID: <20200824232107.GA3525014@bogus>
References: <20200812141312.3331-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200812141312.3331-1-miquel.raynal@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Aug 2020 16:13:09 +0200, Miquel Raynal wrote:
> Silvaco, Inc. is an EDA provider of software tools used for process
> and device development and for analog/mixed-signal, power IC and
> memory design [1].
> 
> [1] https://www.silvaco.com/company/profile/profile.html
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
> 
> Changes in v2:
> * Change the prefix 'svc,' -> 'silvaco,'.
> 
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
