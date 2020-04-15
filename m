Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B074EC2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 16:18:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BB56208FE
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 16:18:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586967536;
	bh=L95kJh7HNDA8E7vAGBe8r5mm7PU08bWVJSFatZogGHo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=MPSgXiNopr7J+Ous9vx//aKALdwJ//0PcuySA+CLjdVpnXv/IXjlT9NJXWe8Xhtuc
	 QaCKg6QqwV7UmilM8l4uMbCk4IWTfoomZpGvTInIqwjwOreZLLlfGWdztz0D5U0sG/
	 9dZbiXj1NNUS3SGiOWmFchKV6LA7BGtbg5mBEe3s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1415548AbgDOQSy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 12:18:54 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:37656 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436549AbgDOQSn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 12:18:43 -0400
Received: by mail-oi1-f196.google.com with SMTP id r25so4082592oij.4;
        Wed, 15 Apr 2020 09:18:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=y6mEF3x+XYhXpSM89WxwJmLStGtmC7gvxiAfRjFJhog=;
        b=FY5zmqzD/JrdhypqYtm+g0IwFLW5r2c3TxbKKb+DSVNr6L45ZDeMw6tbnCoaInv4R4
         zV0PQ/k/0IdlIYqS6gQEtHN62kpLjWiOk2zpM2/wfP3sjaI4jS/9gzDAKHCD2qHybn83
         pHghFKMpun1/TkfI3bRVIc2mi3hqh4Zd14LbL7k3NXxOAu1anCJBEGyAqZzU/7F0Kf0/
         q1pBu7WGjnofilt71g9xSJCN5hTzUV99934NzVEjbZ0JSaH/pOVsZulNncm9BWuK+Lnw
         m6ZfN8KIDUst7FIyUjfvuwT4WXtPoYNEdA5u2GmT2jWq9qDDs5u2QiEs4kFRHpnfqe/q
         El4Q==
X-Gm-Message-State: AGi0PuZ0XmgdtLOtwa93OXCGJWsvc/x7QAuhcTo7l6Hyd/ULD16gimzr
        nbQubTJnXwUcpRzPJec1UgTPbihIdA==
X-Google-Smtp-Source: APiQypIBe/N4FYeGBZid7490V9jbXplYDI3CpXW1MwryQ9Vj0f3c8l1tvBVcbq/Vuo/BErnQtibVSg==
X-Received: by 2002:aca:e08a:: with SMTP id x132mr19364361oig.93.1586967522289;
        Wed, 15 Apr 2020 09:18:42 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 85sm1487345oie.17.2020.04.15.09.18.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2020 09:18:41 -0700 (PDT)
Received: (nullmailer pid 25712 invoked by uid 1000);
        Wed, 15 Apr 2020 16:18:40 -0000
Date:   Wed, 15 Apr 2020 11:18:40 -0500
From:   Rob Herring <robh@kernel.org>
To:     Pawel Dembicki <paweldembicki@gmail.com>
Cc:     Pawel Dembicki <paweldembicki@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 1/2] dt-bindings: vendor-prefixes: Add Check Point
Message-ID: <20200415161759.GA24696@bogus>
References: <20200409070448.3209-1-paweldembicki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200409070448.3209-1-paweldembicki@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  9 Apr 2020 09:04:43 +0200, Pawel Dembicki wrote:
> Check Point Software Technologies Ltd. is a company based in Israel and
> USA. They manufacture network devices and provide software
> products for IT security.
> 
> Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
> ---
> Changes in v2:
> - corrected line order
> 
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Applied, thanks.

Rob
