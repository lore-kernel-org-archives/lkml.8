Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F34FC352A3
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 20:55:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B1A9218AC
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 20:55:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581022514;
	bh=C5elUljcR4J1dZcYIeXO8WfDASuwlosA0Vl8KlP2M48=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=O4LacewAxX8OtBrstaNlefzqPK3b2kCDpJQOdbsTAMErGwhjcyWa85YqXxVTbJu77
	 IB4LjtPvnt4vaW1vZSTcDKetzD47q8S2MiSfDObNV9zOI8IoiAaGqUsNso72BVs7i0
	 brssvc2882dP6poEK2ISPJ4RIb3WkkgzBc4XKa6A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727877AbgBFUzN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 15:55:13 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:37310 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727526AbgBFUzN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 15:55:13 -0500
Received: by mail-pl1-f194.google.com with SMTP id c23so49911plz.4;
        Thu, 06 Feb 2020 12:55:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OuAJn7WSGOIJnnpXDg8F5nxy89HqURtzW0F35vLyP6A=;
        b=FzWp6iBriEPNqRB5Iitby5FzCV3Ku0KzsKMIQ/GEllF+sgTn351+cqyRP0D4gS/xo9
         Wa1R1H8B9E49euVqnHGruK6dyYouy/8LbpYW+PFunZ4q1yfrulno9BR6jWgCJuiigWdi
         pAk0+ImGZ+SfMaGgr0MrweMfgM5TuBYnUIWHDJ80pr2ngh11nFyfnJEjqZwVASjfNYRs
         qd2Co0e0eE+Ec4ynHZm0YVFCYzVItwrU/9wtRaX6m1SZR1m7IB/VgjKLOGgLs/xPmUkq
         2jtgo4+XFIxLcr9S68I56bnnJ9QbIun5z7aF9LyOqdW1GGoK8USCSW5SG3g7geJ3F2YD
         1CKg==
X-Gm-Message-State: APjAAAVHwTYGCb1a6wr5mp0ImSjFqXXJ3hCgZQKKdbLjNrMDT1iCY+qS
        SRr/ovPyCBx1udbte+Fz/A==
X-Google-Smtp-Source: APXvYqwzww5ASCKOY9x4mLqTAZ3M1++KPHZ1rFjTTY7Y/4cZkAbzX+uP/eMMe0O5j9mSg67KwQHQbA==
X-Received: by 2002:a17:902:b210:: with SMTP id t16mr5822035plr.65.1581022512276;
        Thu, 06 Feb 2020 12:55:12 -0800 (PST)
Received: from rob-hp-laptop (63-158-47-182.dia.static.qwest.net. [63.158.47.182])
        by smtp.gmail.com with ESMTPSA id c74sm294768pfb.135.2020.02.06.12.55.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2020 12:55:11 -0800 (PST)
Received: (nullmailer pid 14236 invoked by uid 1000);
        Thu, 06 Feb 2020 20:55:07 -0000
Date:   Thu, 6 Feb 2020 13:55:07 -0700
From:   Rob Herring <robh@kernel.org>
To:     Yuti Amonkar <yamonkar@cadence.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        kishon@ti.com, robh+dt@kernel.org, mark.rutland@arm.com,
        maxime@cerno.tech, jsarha@ti.com, tomi.valkeinen@ti.com,
        praneeth@ti.com, mparab@cadence.com, sjakhade@cadence.com,
        yamonkar@cadence.com
Subject: Re: [PATCH v4 02/13] dt-bindings: phy: Add Cadence MHDP PHY bindings
 in YAML format.
Message-ID: <20200206205507.GA13685@bogus>
References: <1580969461-16981-1-git-send-email-yamonkar@cadence.com>
 <1580969461-16981-3-git-send-email-yamonkar@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1580969461-16981-3-git-send-email-yamonkar@cadence.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Feb 2020 07:10:50 +0100, Yuti Amonkar wrote:
> - Add Cadence MHDP PHY bindings in YAML format.
> - Add Torrent PHY reference clock bindings.
> - Add sub-node bindings for each group of PHY lanes based on PHY type.
>   Each sub-node includes properties such as master lane number, link reset,
>   phy type, number of lanes etc.
> - Add reset support including PHY reset and individual lane reset.
> - Add a new compatible string used for TI SoCs using Torrent PHY.
> This will not affect ABI as the driver has never been functional,
> and therefore do not exist in any active use case.
> 
> Signed-off-by: Yuti Amonkar <yamonkar@cadence.com>
> ---
>  .../bindings/phy/phy-cadence-torrent.yaml     | 143 ++++++++++++++++++
>  1 file changed, 143 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

Documentation/devicetree/bindings/display/simple-framebuffer.example.dts:21.16-37.11: Warning (chosen_node_is_root): /example-0/chosen: chosen node must be at root node
Error: Documentation/devicetree/bindings/phy/phy-cadence-torrent.example.dts:33.42-43 syntax error
FATAL ERROR: Unable to parse input tree
scripts/Makefile.lib:300: recipe for target 'Documentation/devicetree/bindings/phy/phy-cadence-torrent.example.dt.yaml' failed
make[1]: *** [Documentation/devicetree/bindings/phy/phy-cadence-torrent.example.dt.yaml] Error 1
Makefile:1263: recipe for target 'dt_binding_check' failed
make: *** [dt_binding_check] Error 2

See https://patchwork.ozlabs.org/patch/1234141
Please check and re-submit.
