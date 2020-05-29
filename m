Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFDCAC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 19:14:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C34D7207F9
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 19:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590779675;
	bh=u2w5DMX9SLKz3u3UEB2CnBtE1clrrOYOtv93QhklISk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=TwWEW25dGL7B7Mq4VE82lRPUD8sv/rIF6M+0c+bOYWCClXyO70Upem3kSGeP/gesh
	 vt4+C/65L10+SFRZbzHltFelftUJmyD+XK43LcYfYIxt9isPHco/D+O7FKWpRgN6vx
	 ceF8oDVs7R2pR5FFF78b6Hl6/Pk2AxvGHQ80aC60=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728016AbgE2TOf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 15:14:35 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:41119 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725865AbgE2TOe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 15:14:34 -0400
Received: by mail-io1-f65.google.com with SMTP id o5so494090iow.8;
        Fri, 29 May 2020 12:14:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=IMboAeBywaKQGMVGQN5Urn1Fr7u4wdf1ZFcW9jks0WY=;
        b=ndxwWQcnLWl3xF3zoGGYusQ3VsFBtQNAxz8ZdqqBSBTWxwEfJv8TJu5dK12SwuICip
         IX5rQNbnIc3HtQG7ahCEvpS7yVcTAylm5IyipfFj4cPGoKmQjdkGLQ5DYa0SFeKvJYKd
         OlTZRW0W33dy0DegIY3UYmcZ35nROWcGRsnIH+EmzdHu+EUaMuoJV26w73lkrtIP2G2B
         hEXotApj3HVd+8aP53Nf/knBF2ADhixxWvS52iyXasdbr8iIjbH+c+/XKjy4Jj5N4Q47
         xD0yLmP2mDbD2pkINYGaZXTsYxzPcgFS3LU8urCFP+fytM052vrKc35APSFKyAlOnRwl
         b2Zg==
X-Gm-Message-State: AOAM532ScVvLkiCAlOj09BClNFNgVQKRLM6BLREfIB3P2XZFa19oyfAA
        VznAR0dC31EozAYwxhv6lA==
X-Google-Smtp-Source: ABdhPJy+ef3k9N4zyOPhHF5avCCR6xmI0bM0RJea8UC82QEtbVGkNrIQ1JvUNYzsLIzDtOpFHLzxzg==
X-Received: by 2002:a6b:6414:: with SMTP id t20mr7908234iog.32.1590779673757;
        Fri, 29 May 2020 12:14:33 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id f1sm5307391ilh.17.2020.05.29.12.14.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2020 12:14:32 -0700 (PDT)
Received: (nullmailer pid 2779230 invoked by uid 1000);
        Fri, 29 May 2020 19:14:31 -0000
Date:   Fri, 29 May 2020 13:14:31 -0600
From:   Rob Herring <robh@kernel.org>
To:     =?utf-8?B?5ZGo55Cw5p2wIChaaG91IFlhbmppZSk=?= 
        <zhouyanjie@wanyeetech.com>
Cc:     mturquette@baylibre.com, robh+dt@kernel.org, sboyd@kernel.org,
        aric.pzqi@ingenic.com, rick.tyliu@ingenic.com,
        yanfei.li@ingenic.com, zhenwenjin@gmail.com,
        sernia.zhou@foxmail.com, paul@crapouillou.net,
        dongsheng.qiu@ingenic.com, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v13 3/7] dt-bindings: clock: Add documentation for X1830
 bindings.
Message-ID: <20200529191431.GA2779176@bogus>
References: <20200528031549.13846-1-zhouyanjie@wanyeetech.com>
 <20200528031549.13846-4-zhouyanjie@wanyeetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200528031549.13846-4-zhouyanjie@wanyeetech.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 May 2020 11:15:45 +0800, 周琰杰 (Zhou Yanjie) wrote:
> Add documentation for the clock bindings of the X1830 Soc from Ingenic.
> 
> Signed-off-by: 周琰杰 (Zhou Yanjie) <zhouyanjie@wanyeetech.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
> 
> Notes:
>     v11:
>     New patch, split from [3/6] in v10.
> 
>     v11->v12:
>     No change.
> 
>     v12->v13:
>     No change.
> 
>  Documentation/devicetree/bindings/clock/ingenic,cgu.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
