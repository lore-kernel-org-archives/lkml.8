Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CED01C2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 21:45:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6162206A2
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 21:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586900735;
	bh=EYM9DzGXhALV2lxpMVZWWxznJSNpIBJFFRKkKAwCSwM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=SRMUp+fRkfN229S8lCBCmkaVpKZNDYYRXAa6txYkrs3M6OdenWQ0mbNOJL9P6PVy7
	 N5ObDE7XwNKprorpsvvpOPEg6UvS7+F0XP6skLEWkVxOkS/RBqI6my83/F8MQRKUxm
	 DgSlzPhRO4CtNNZTppG9n6l6AMHzklEDzHe4540Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2634118AbgDNVpc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 17:45:32 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:37088 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2634022AbgDNVog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 17:44:36 -0400
Received: by mail-ot1-f68.google.com with SMTP id z17so1331712oto.4;
        Tue, 14 Apr 2020 14:44:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1rbtN7N+ptVDeQQdbAIqZEIk2V0QAROfk/PV0WHMjRE=;
        b=ZosH/jfgJtUIf0XyZFDTyR2BJmAA3Ga6u2mvbdK0rzmgBr+ZEBmyNdMiEx3l3waieY
         QPfEtQyJZzPIefcUZ+iKleSZqfM8lu1jnO6/pmSvrmeTYDDkbw+LeC8v6lBsMhmvl0+r
         J07TIrZCOvXwpaGpAPjjyiU0mmpt1zMxPwAkXzCihx7bA2HQu/QTBeM3dFbdaqQta0tH
         7KeaxCun9U5VO+FvGZ5v8eVDFn2oDzPIwrsyFsUyJ+rOPhngM0qDjQsqgcy8GCr5DmDg
         no33Frb7fsHTyMSJF6mtr+cy8ew4y9C9rKbOu2BpvHwxIbXjMcfKrnUtRfRZTophb0pH
         qWGg==
X-Gm-Message-State: AGi0PuaYDwhCz2TjlxkpdOBR/rkmegSK2Kf5x1qZgr91JoRYYAHq1/z+
        N+7GlfXQq8PYPumh0nWQbg==
X-Google-Smtp-Source: APiQypL96hB6UYPUf5qDgTbGQ//SKC8rB0d/g8MUB8WJ16O3Kia4xlS7p8LgovR0p7mxbY0QwQJLCw==
X-Received: by 2002:a9d:3988:: with SMTP id y8mr10467743otb.352.1586900675157;
        Tue, 14 Apr 2020 14:44:35 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id r67sm5788491oie.19.2020.04.14.14.44.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 14:44:34 -0700 (PDT)
Received: (nullmailer pid 10522 invoked by uid 1000);
        Tue, 14 Apr 2020 21:44:33 -0000
Date:   Tue, 14 Apr 2020 16:44:33 -0500
From:   Rob Herring <robh@kernel.org>
To:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Cc:     dri-devel@lists.freedesktop.org,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>, devicetree@vger.kernel.org,
        Sam Ravnborg <sam@ravnborg.org>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Subject: Re: [PATCH v2 2/2] dt-bindings: Document the Synopsys ARC HDMI TX
 bindings
Message-ID: <20200414214433.GA10013@bogus>
References: <20200414144402.27643-1-Eugeniy.Paltsev@synopsys.com>
 <20200414144402.27643-3-Eugeniy.Paltsev@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200414144402.27643-3-Eugeniy.Paltsev@synopsys.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Apr 2020 17:44:02 +0300, Eugeniy Paltsev wrote:
> This patch adds documentation of device tree bindings for the Synopsys
> HDMI 2.0 TX encoder driver for ARC SoCs.
> 
> Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
> ---
>  .../display/bridge/snps,arc-dw-hdmi.yaml      | 131 ++++++++++++++++++
>  1 file changed, 131 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/bridge/snps,arc-dw-hdmi.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/bridge/snps,arc-dw-hdmi.example.dt.yaml: example-0: 'hdmi@0x10000' does not match any of the regexes: '.*-names$', '.*-supply$', '^#.*-cells$', '^#[a-zA-Z0-9,+\\-._]{0,63}$', '^[a-zA-Z][a-zA-Z0-9,+\\-._]{0,63}$', '^[a-zA-Z][a-zA-Z0-9,+\\-._]{0,63}@[0-9a-fA-F]+(,[0-9a-fA-F]+)*$', '^__.*__$', 'pinctrl-[0-9]+'
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/bridge/snps,arc-dw-hdmi.example.dt.yaml: hdmi@0x10000: 'interrupts' does not match any of the regexes: 'pinctrl-[0-9]+'

See https://patchwork.ozlabs.org/patch/1270389

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure dt-schema is up to date:

pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade

Please check and re-submit.
