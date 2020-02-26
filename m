Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BE9AC4BA2C
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 21:57:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C74524653
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 21:57:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582754256;
	bh=3nSSsgJb7wE32/AOOKbfpLf2HqTv8vEAlEPB1uCHz6g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=O7gqh5vzw6uJnAkcmpHGaxbRJqHvfDwIxAD24tkC2ySotl57gbAiv7Q0uVTOK6YXm
	 DUwgg6UFTLDdNr5aA+3sNwbhI6cQJvSYwpF9ju7rdPwNUOSe1CfiKth/mMsnq7XFFL
	 CsRr6/sPcfLzjlhcYVcffvXwqCT6EWjEL3eFFnqU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727763AbgBZV5f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 16:57:35 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:35626 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727584AbgBZV5e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 16:57:34 -0500
Received: by mail-ot1-f66.google.com with SMTP id r16so987403otd.2;
        Wed, 26 Feb 2020 13:57:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VtcV+TLcp6fap4GZT+cz5YJ4UwaOUmy6z1le/e7vBJo=;
        b=lmM/s101FWwYRiFu3E7xJVmr/1IR5XbYnmYpNuZJS56T74eXYvk7LHOcv2Sb64OH/u
         wcGmF0grFM8wUPBIhzBnVWYC9N2VNhi7fdxgFq0qjdhRGapKReA+GPRutQIzj+NgROcI
         BLyGyfER0Dx7UkXB7mzbsuLOcfkAShXx/zGlp5IPj0hzH1e/hm+MV6k2b0z+GuuP6ix1
         xDIyxqLaXOCpUXDjrNrGLQDiHJkJCoh26ta7mFPj8I+JPOT+2m3k/mwvgT82dregaGkA
         avOhME7KczNMcfhY82OkKmG0S84DzwmmfjUunx8iwM2/xJc9oQtYEAFJZvJTaTGbw34p
         slgw==
X-Gm-Message-State: APjAAAUujAmyTzffPWE4GgywnLHZw/RbHnSQe0ql8y9ijj132lIVFC+C
        4jDO8EG0sm0X6muoFS5BEw==
X-Google-Smtp-Source: APXvYqwk/c050OlotHglNYXwW95n1Qe5jSUGzkQ3Gnvc0yR11liQIvvZW7tdL2ZRSj87SItSSbYjfg==
X-Received: by 2002:a9d:7a47:: with SMTP id z7mr737694otm.179.1582754253690;
        Wed, 26 Feb 2020 13:57:33 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 17sm1234725oty.48.2020.02.26.13.57.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2020 13:57:33 -0800 (PST)
Received: (nullmailer pid 1255 invoked by uid 1000);
        Wed, 26 Feb 2020 21:57:32 -0000
Date:   Wed, 26 Feb 2020 15:57:32 -0600
From:   Rob Herring <robh@kernel.org>
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Robert Richter <rric@kernel.org>,
        soc@kernel.org, Jon Loeliger <jdl@jdl.com>,
        Mark Langsdorf <mlangsdo@redhat.com>,
        Eric Auger <eric.auger@redhat.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH 12/13] dt-bindings: arm: Add Calxeda system registers
 json-schema binding
Message-ID: <20200226215732.GA32486@bogus>
References: <20200226180901.89940-1-andre.przywara@arm.com>
 <20200226180901.89940-13-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200226180901.89940-13-andre.przywara@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Feb 2020 18:09:00 +0000, Andre Przywara wrote:
> The Calxeda system registers are a collection of MMIO register
> controlling several more general aspects of the SoC.
> Beside for some power management tasks this node is also somewhat
> abused as the container for the clock nodes.
> 
> Add a binding in DT schema format using json-schema.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  .../bindings/arm/calxeda/hb-sregs.yaml        | 47 +++++++++++++++++++
>  1 file changed, 47 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/calxeda/hb-sregs.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

warning: no schema found in file: Documentation/devicetree/bindings/arm/calxeda/hb-sregs.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/calxeda/hb-sregs.yaml: ignoring, error in schema: properties: clocks
Documentation/devicetree/bindings/display/simple-framebuffer.example.dts:21.16-37.11: Warning (chosen_node_is_root): /example-0/chosen: chosen node must be at root node
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/calxeda/hb-sregs.yaml: properties:clocks: {'type': 'object'} is not valid under any of the given schemas (Possible causes of the failure):
	/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/calxeda/hb-sregs.yaml: properties:clocks: 'maxItems' is a required property

Documentation/devicetree/bindings/Makefile:12: recipe for target 'Documentation/devicetree/bindings/arm/calxeda/hb-sregs.example.dts' failed
make[1]: *** [Documentation/devicetree/bindings/arm/calxeda/hb-sregs.example.dts] Error 1
Makefile:1263: recipe for target 'dt_binding_check' failed
make: *** [dt_binding_check] Error 2

See https://patchwork.ozlabs.org/patch/1245261
Please check and re-submit.
