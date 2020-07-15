Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E3BCC433E3
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 21:03:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E02112067D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 21:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594847001;
	bh=Vlh6jq3CeiOB+eIOnC5hyz2iGa+kf3f418QAJcxuIGg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=2W7ftpa+uffWUo+qFfdnOCn4s9Za1AtKzYxK2V1H98ctWNADVDzH+0y6Czkxwf3Iq
	 6v9m299YF6W38L3Fl2AFDM3bmeb9xHpSVDP0xsY0M5rzB1H89BDprHoxj4KL2LzEjv
	 TAudairh4/RZeBd0TUEFsU3VDK67+1LtLgrpzp7Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbgGOVDU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 17:03:20 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:33568 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726803AbgGOVDT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 17:03:19 -0400
Received: by mail-il1-f196.google.com with SMTP id a11so3263213ilk.0;
        Wed, 15 Jul 2020 14:03:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GWDZepDoncsEaTMC4EtAIVPS29rg6+akZDaq58u8hqs=;
        b=Vg4IqM0JjAVxKTl92q2Ivw7uzXy7frBWL4IQE628k6as5i0XubgNnpkLl9eunNsiHR
         LeV/KZDrIGrtfgda0uOrRw4SICjDmA6iGKN2/w0Z6FUrVWFxsCoujz8LTZxPD5gVXIzh
         bPST3Jt3hWRJROeAzCSfTrJSDn/KIPsaXORFRBS3Zr8nfErmNRddkSmyi7exigNrsKPe
         piREuaR3ManQ1TKChUWFeDf8r9NftIFyZE4wdYH+koxcHXkH/k3uaPGR7udQDb7zBDm1
         J8uMbK4iRuweGOdWfg7LPhdh2qTRIbB6WG0bDhwP66hOOKadsf+a08AJlb3O0X7+lebD
         FK7w==
X-Gm-Message-State: AOAM531IHXovbKEk1l9dLinDVwY33gRyXQIsuY8ryBJiCPxq4m6yAn++
        HUt/dH/lzGO/+IRGUAOnk/ERffAYN/IA
X-Google-Smtp-Source: ABdhPJwBYLdvUXEXFEUAVM6usSlJJ9M/lybrTM4uUutDaLWTKuqsiNxb1k9dpnNAJ8CbXwx8r57ECw==
X-Received: by 2002:a92:cf51:: with SMTP id c17mr1328712ilr.122.1594846998231;
        Wed, 15 Jul 2020 14:03:18 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id y2sm1721651iox.22.2020.07.15.14.03.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 14:03:17 -0700 (PDT)
Received: (nullmailer pid 811841 invoked by uid 1000);
        Wed, 15 Jul 2020 21:03:16 -0000
Date:   Wed, 15 Jul 2020 15:03:16 -0600
From:   Rob Herring <robh@kernel.org>
To:     Benjamin Gaignard <benjamin.gaignard@st.com>
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        alexandre.torgue@st.com, linux-stm32@st-md-mailman.stormreply.com,
        linux-kernel@vger.kernel.org, mcoquelin.stm32@gmail.com,
        lee.jones@linaro.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/5] dt-bingings: arm: stm32: Add compatibles for syscon
 nodes
Message-ID: <20200715210316.GA811477@bogus>
References: <20200703095520.30264-1-benjamin.gaignard@st.com>
 <20200703095520.30264-2-benjamin.gaignard@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200703095520.30264-2-benjamin.gaignard@st.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 03 Jul 2020 11:55:16 +0200, Benjamin Gaignard wrote:
> Since commit ad440432d1f9 ("dt-bindings: mfd: Ensure 'syscon' has a more specific compatible")
> it is required to provide at least 2 compatibles string for syscon node.
> This patch document the missing compatibles for stm32 SoCs.
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> ---
>  .../devicetree/bindings/arm/stm32/st,stm32-syscon.yaml     | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 

Typo in the subject, otherwise:

Reviewed-by: Rob Herring <robh@kernel.org>
