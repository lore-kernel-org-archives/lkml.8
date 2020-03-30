Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B93CC2D0F1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 23:23:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10A5720675
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 23:23:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585610585;
	bh=PMJ9p/I3SIQe1w/Um5k6QJbVurDqjJaXpOC4nLI70LM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=QryeXJA8riC6raolSdfbmpzT54wqgCYry6MjCVP/CUdQHqAZRX1gp24ZxQVtAgGO+
	 ++jHOJWhbl40OfQWyj53iCNCrqS8lSQsybriuUX8lE927ZaySQ64k8YRTEQjxZviCS
	 r0DBJtGFWe3J0tTmYMz+sd7qjo/g+SRjyz1Saebs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729921AbgC3XXE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 19:23:04 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:37101 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728880AbgC3XXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 19:23:03 -0400
Received: by mail-il1-f195.google.com with SMTP id a6so17644409ilr.4;
        Mon, 30 Mar 2020 16:23:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=/FENrcRt8ESFMiAlQ/CphQpmocrTMguwAEpZGOw8MpM=;
        b=XW9MDmKzKvQuY/75MXAs2jfPmGpM+I8vH7JKwq3NIVTigjPJcW/CUzXwIG19BvZvXD
         PkFMrVuOuRtMuMyEuRGF8BHeG/b2gQ94+2FDtTujkQV6Xrt8XLUxVvG73tP6zGzi2Wpt
         4mZt3h/x83zK7y+Bq/50NTf9Xzj/uDiqLNcYO7nPF6Sqehdj3IK57tGIAB0UMwKVK1P0
         RYwuItJaIx++wa/YaH0224FSWOqvx2eyLOIEhwL/2QwBq/e0p2dh2uz1VUDbtljciw/b
         9LUIKSVtda0MKNXB/YhyEgOQIgT+QfOAJKI0+dqP214ulzBXmagoeHASMkQCq62yXOeS
         9jHg==
X-Gm-Message-State: ANhLgQ2vMAzonLNA5RimCgcgnGgyVWxc2YQkynaClpO/aahBqs6wo8TP
        9M02LtFSrMVuBtcgGzJ7Ng==
X-Google-Smtp-Source: ADFU+vuSwBO+T5QUsS5rZzXFCTkyNgkT6wz2Mwt2WF4anq/h1uoQPkAdLudUXo7MwbXgFB8ZuuykBA==
X-Received: by 2002:a92:b6c8:: with SMTP id m69mr12852345ill.21.1585610582666;
        Mon, 30 Mar 2020 16:23:02 -0700 (PDT)
Received: from rob-hp-laptop ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id j1sm4603610iok.2.2020.03.30.16.23.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2020 16:23:02 -0700 (PDT)
Received: (nullmailer pid 20329 invoked by uid 1000);
        Mon, 30 Mar 2020 23:23:01 -0000
Date:   Mon, 30 Mar 2020 17:23:01 -0600
From:   Rob Herring <robh@kernel.org>
To:     Matheus Castello <matheus@castello.eng.br>
Cc:     afaerber@suse.de, manivannan.sadhasivam@linaro.org,
        mark.rutland@arm.com, robh+dt@kernel.org,
        edgar.righi@lsitec.org.br, igor.lima@lsitec.org.br,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Matheus Castello <matheus@castello.eng.br>
Subject: Re: [PATCH v3 1/3] dt-bindings: Add vendor prefix for Caninos Loucos
Message-ID: <20200330232301.GA20273@bogus>
References: <20200229104358.GB19610@mani>
 <20200320035104.26139-1-matheus@castello.eng.br>
 <20200320035104.26139-2-matheus@castello.eng.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200320035104.26139-2-matheus@castello.eng.br>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Mar 2020 00:51:02 -0300, Matheus Castello wrote:
> The Caninos Loucos Program develops Single Board Computers with an open
> structure. The Program wants to form a community of developers to use
> IoT technologies and disseminate the learning of embedded systems in
> Brazil.
> 
> It is an initiative of the Technological Integrated Systems Laboratory
> (LSI-TEC) with the support of Polytechnic School of the University of
> São Paulo (Poli-USP) and Jon "Maddog" Hall.
> 
> Signed-off-by: Matheus Castello <matheus@castello.eng.br>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
