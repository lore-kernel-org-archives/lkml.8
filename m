Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62D37C4CECC
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 21:34:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F1442070B
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 21:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588023274;
	bh=bzYkS1jEmYKLLaiahQ523rQRdG7e1GXlcRoT4pqgHJM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=g9BYSnVoia+e8wIHmuGu5d5P5BqFyUpkDJFjJ6ED4oqpRKxb7bAZqkILiAa/7YQ4F
	 ORKDfGWKOtSMzpzOzNUe8FDdZTPeJtOClSsIdK2eOSPOPP2OP7OK0e+2az1BGDG75X
	 9xc/M9l4i4AZS8PgaDT8s/24E03X01P8GDgOKebw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726335AbgD0Ved (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 17:34:33 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:36939 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726030AbgD0VeV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 17:34:21 -0400
Received: by mail-ot1-f66.google.com with SMTP id z17so29047836oto.4;
        Mon, 27 Apr 2020 14:34:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XRUQCI377Xbc6JD+2krofLmVxxHirS9bA0gL+Jn1x9k=;
        b=e6XL/Csvti1mhQrcIXXYXbRQzyYSb+N3qnF7HOLjKPuspwCrDrHb2u+3J+DccpJFfG
         BE9NEaKFrLPTXchMqWBxmfQN3vaIRNbPLK/tJJ9rX8H8Mb+VC0ur669Q9Gfrg3xwctzw
         tqTlcXZSbYCtKvQHLLp5a9IvzecGsx9nXUjks0ARNrhm0IfBzpZRCnt6hDKsxP8qWoNT
         xoN0NjiK5jsSw20kLt05+a8KTBWV2P4zkin2udQEW4S1wAC6vHdSAgUSFSNDt8cGvEx2
         ILPPb/iJvE7WXz4K50WIzpw3/Y+xZ0qTA++YpqdbpDeUgRobKuR6FIHSVP78tVJ9u000
         tApQ==
X-Gm-Message-State: AGi0Puat9JCMnMkTVELun3ah+QkXSFfFZOCyVImuyz4lHMNOUGhfDSZ8
        mZcebnHQKw9Bc5lkrf7ndg==
X-Google-Smtp-Source: APiQypJ9mE/BH2D4+sKYproJwZ1HaMb0oGk33+e3IQvAocBe9hWzM892y3UWLh7SWCcD4cf4iNNOaA==
X-Received: by 2002:a9d:51cc:: with SMTP id d12mr18633279oth.70.1588023260003;
        Mon, 27 Apr 2020 14:34:20 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id i196sm587727oib.8.2020.04.27.14.34.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2020 14:34:19 -0700 (PDT)
Received: (nullmailer pid 2856 invoked by uid 1000);
        Mon, 27 Apr 2020 21:34:18 -0000
Date:   Mon, 27 Apr 2020 16:34:18 -0500
From:   Rob Herring <robh@kernel.org>
To:     Angelo Ribeiro <Angelo.Ribeiro@synopsys.com>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Angelo Ribeiro <Angelo.Ribeiro@synopsys.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sam Ravnborg <sam@ravnborg.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>
Subject: Re: [PATCH v3 1/4] dt-bindings: display: Add IPK DSI subsystem
 bindings
Message-ID: <20200427213418.GA2156@bogus>
References: <cover.1587992776.git.angelo.ribeiro@synopsys.com>
 <04a657ce78633d82565d3a7ce34a8ab52310ff63.1587992776.git.angelo.ribeiro@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <04a657ce78633d82565d3a7ce34a8ab52310ff63.1587992776.git.angelo.ribeiro@synopsys.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Apr 2020 16:00:33 +0200, Angelo Ribeiro wrote:
> Add dt-bindings for Synopsys DesignWare MIPI DSI Host and VPG (Video
> Pattern Generator) support in the IPK display subsystem.
> 
> The Synopsys DesignWare IPK display video pipeline is composed by a DSI
> controller (snps,dw-ipk-dsi) and a VPG (snps,dw-ipk-vpg) as DPI
> stimulus. Typically is used the Raspberry Pi
> (raspberrypi,7inch-touchscreen-panel) as DSI panel that requires a
> I2C controller (snps,designware-i2c).
> 
> Reported-by: Rob Herring <robh+dt@kernel.org>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Sam Ravnborg <sam@ravnborg.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> Cc: Joao Pinto <jpinto@synopsys.com>
> Signed-off-by: Angelo Ribeiro <angelo.ribeiro@synopsys.com>
> ---
> Changes since v3:
>   - Fixed dt-binding breaking on `make dt_binding_check`.
> 
> Changes since v2:
>   - Fixed dt-bindings issues, see
>     https://patchwork.ozlabs.org/patch/1260819/.
> ---
>  .../bindings/display/snps,dw-ipk-dsi.yaml          | 159 +++++++++++++++++++++
>  .../bindings/display/snps,dw-ipk-vpg.yaml          |  73 ++++++++++
>  2 files changed, 232 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/snps,dw-ipk-dsi.yaml
>  create mode 100644 Documentation/devicetree/bindings/display/snps,dw-ipk-vpg.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/snps,dw-ipk-dsi.example.dt.yaml: dw-ipk-dsi@2000: compatible: ['snps,dw-ipk-dsi'] is too short

See https://patchwork.ozlabs.org/patch/1277673

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure dt-schema is up to date:

pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade

Please check and re-submit.
