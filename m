Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86CB3C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 12:48:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C718206FA
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 12:48:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ah/XXi/B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbgCMMs1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 08:48:27 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:33692 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726216AbgCMMs0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 08:48:26 -0400
Received: by mail-pj1-f67.google.com with SMTP id dw20so1795239pjb.0;
        Fri, 13 Mar 2020 05:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vfLtNZ0VvBNo56dvGGqSEkX8wp84sKqijejN4pOTelU=;
        b=ah/XXi/BK3w0arbvueMFncz4R99pp3f7rtrPBcxJUI8/No6t86N70GsKqhuHhaLRtW
         4mKx/0f98i4FCrt/UVZxNTfMoBE7uLouFwXE1i+l67yIV4gE3q4G/dceAj07Bht9ePuM
         qoBpi3Zmm+KDfdZbxnYZKQr5sOfc/E7tUp5mhGs7Wq/Y3ISAKidHotL7ncr4fibWIydy
         I85UJhQ04RVQwTI/MWCfe8g4FBjig0cEwc4fJ/aiE9zCW6rO2PLfbaNucHGD2eK99wyZ
         Q6iO5e+tfAG2GwlkJ1CPp8Uo2l9LAJdLIHG4i0TMaKKtQloP7GiMqOIvQDsPhaeaGIlJ
         IeFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vfLtNZ0VvBNo56dvGGqSEkX8wp84sKqijejN4pOTelU=;
        b=XfDPTLvtJjDG41ue99WBTRxAhtd7LF6viQxOKAVtMmlLhxxzWDrPK7erQtH/3irV/z
         yti3IQeK8SNyUFQe/bddsPrqBX5+7uiwp5G8QzWqqx5quoD4eOzHNheLZTJv6pylMW8M
         QohVjkPKIwaY7jlm1IoWVVpf52Eo0Cvd4h/Lubn/BUeivuG3QWOZhXXpcVvLF57mMXZX
         SEIMiWsAQm7GSrNpZFk7LQ/ZPAL5pj3W2+wHmqHSaKvjR7vQdgJvf2YKTFzWMt5ApFwv
         Mml4F3yq5g15UCLNj9hyCBysdKMyBxGCoXzzXNHIMowz3brE0KgL9a3MikILSi8Fw7Q0
         ZLDQ==
X-Gm-Message-State: ANhLgQ0jlXopuCJkS0obJYGuT9I3f55wrfLzJ+3T3Zw7LAgIyK+LUrVw
        Foc1vLb5vmPpsdPlQ30URUg=
X-Google-Smtp-Source: ADFU+vslro8nhD0UHm9mdjTw0ua8ebbn96fALM+XAwtOdxgm72mgO30QuS/dGmxXEsoBwZebaSew5A==
X-Received: by 2002:a17:90a:34c6:: with SMTP id m6mr9879368pjf.13.1584103704120;
        Fri, 13 Mar 2020 05:48:24 -0700 (PDT)
Received: from localhost ([106.51.232.35])
        by smtp.gmail.com with ESMTPSA id v123sm33695335pfv.146.2020.03.13.05.48.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 13 Mar 2020 05:48:23 -0700 (PDT)
Date:   Fri, 13 Mar 2020 18:18:21 +0530
From:   afzal mohammed <afzal.mohd.ma@gmail.com>
To:     Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>
Cc:     linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] alpha: Replace setup_irq() by request_irq()
Message-ID: <20200313124821.GD7225@afzalpc>
References: <20200304005209.5636-1-afzal.mohd.ma@gmail.com>
 <20200305130843.17989-1-afzal.mohd.ma@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200305130843.17989-1-afzal.mohd.ma@gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Richard Henderson, Ivan Kokshaysky, Matt Turner, 

On Thu, Mar 05, 2020 at 06:38:41PM +0530, afzal mohammed wrote:
> request_irq() is preferred over setup_irq(). Invocations of setup_irq()
> occur after memory allocators are ready.
> 
> Per tglx[1], setup_irq() existed in olden days when allocators were not
> ready by the time early interrupts were initialized.
> 
> Hence replace setup_irq() by request_irq().
> 
> [1] https://lkml.kernel.org/r/alpine.DEB.2.20.1710191609480.1971@nanos
> 
> Signed-off-by: afzal mohammed <afzal.mohd.ma@gmail.com>

If this patch is okay, please consider acking it so as to take it via
tglx.

Regards
afzal
