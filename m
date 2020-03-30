Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2D28C2D0F0
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 23:23:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9CF320675
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 23:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585610601;
	bh=xJlfOcMEVmqVc/QfjrW2t0Sr6aekEA+FM0XauqFTWlQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=s1/2lFFWMs8qMbpihhUHurgxcfQk+VKJ8ZV6AflmvVIX/9Z946nfRJnPV+96RuUZY
	 wgCeVFxpfftAgtNyPWI4gNIjvtgs9TLDVWUxQz6ZI9TuNS0LG1Nu1sNZhII3+q4XjY
	 X39QPV+KomP4LGg6LkKWNYWoqnygaRuNPD4usahI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729931AbgC3XXU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 19:23:20 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:38424 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729400AbgC3XXU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 19:23:20 -0400
Received: by mail-il1-f194.google.com with SMTP id n13so10315723ilm.5;
        Mon, 30 Mar 2020 16:23:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ei/2DNWWLO/ewjsFgKybLpdPWmjKaCArsxYWdz6Gmdw=;
        b=Fik8uMvs/g2wW80QXY9N7mY3wSFvueAxMmpUtLvWQK5NfvRQhNZuGBZbu5fZXl9HyC
         /ObMzYVMlca0WHecpw/s63KIg2eNI3n2RVBkMNuqkkhxeHhgH42/rHd2NSlirSyZGkHC
         vzlm6RlCbN5Pk35q3pwfmCVJkKYMWZIlISeGOpQe1tqyzxq/4Ij3UbqLXmJ+IWD64jeC
         lfEgpH8tdrNILhBULMas16pzD4O112PrmYJIDnsGWZ4t9LRRXV+lqP6gtLnd/5+HZkz9
         cGNR/vah4bwr5thh45UZNYdFJVMOd7sTLdGwhuV49zrDfJyb2BgAlps7JASFvvvRpjL0
         E0Xw==
X-Gm-Message-State: ANhLgQ3iAagFRs5Ti5CRUgsGZiscc3cGjhf0CHY+uwNNjwqSySFxxBtz
        FcxLYHGdI5vaBax9tisCGw==
X-Google-Smtp-Source: ADFU+vt6YPW4L+F4/DPUzECJtXAms0HJIkjHPEOx/V9rg1GOkwS/AJdYdgTPIk0+bM3fyuPOyUAUSQ==
X-Received: by 2002:a92:dcc8:: with SMTP id b8mr13358089ilr.244.1585610599472;
        Mon, 30 Mar 2020 16:23:19 -0700 (PDT)
Received: from rob-hp-laptop ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id j23sm4431304ioa.10.2020.03.30.16.23.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2020 16:23:18 -0700 (PDT)
Received: (nullmailer pid 20814 invoked by uid 1000);
        Mon, 30 Mar 2020 23:23:17 -0000
Date:   Mon, 30 Mar 2020 17:23:17 -0600
From:   Rob Herring <robh@kernel.org>
To:     Matheus Castello <matheus@castello.eng.br>
Cc:     afaerber@suse.de, manivannan.sadhasivam@linaro.org,
        mark.rutland@arm.com, robh+dt@kernel.org,
        edgar.righi@lsitec.org.br, igor.lima@lsitec.org.br,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Matheus Castello <matheus@castello.eng.br>
Subject: Re: [PATCH v3 2/3] dt-bindings: arm: actions: Document Caninos
 Loucos Labrador
Message-ID: <20200330232317.GA20759@bogus>
References: <20200229104358.GB19610@mani>
 <20200320035104.26139-1-matheus@castello.eng.br>
 <20200320035104.26139-3-matheus@castello.eng.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200320035104.26139-3-matheus@castello.eng.br>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Mar 2020 00:51:03 -0300, Matheus Castello wrote:
> Update the documentation to add the Caninos Loucos Labrador. Labrador
> project consists of a computer on module based on the Actions Semi S500
> processor and the Labrador base board.
> 
> Signed-off-by: Matheus Castello <matheus@castello.eng.br>
> ---
>  Documentation/devicetree/bindings/arm/actions.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
