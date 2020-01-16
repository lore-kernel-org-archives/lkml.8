Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 616CAC33CB6
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 19:29:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C0FD206D9
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 19:29:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579202972;
	bh=EF2kPRKsef7/I30MN62Wfrk4m74NOmj7QJ5OG9PQLdw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=gyO427reIQI06zTt4xFKXowXasKwS/kh86wLevW7AoxhzJl9JKG+aKiWvX7Axc/vx
	 5hSMvg0TieOSqg7hsPNHCBHbpHjanDevi4el3DHhRqcOmP3KkpJ02Nuq3tedYSDgCZ
	 8ehO2cYN+5qyWf1TGcUaJt4/d9SmTudvwdhm56Zk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730314AbgAPT3b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 14:29:31 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:44289 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729044AbgAPT3a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 14:29:30 -0500
Received: by mail-oi1-f193.google.com with SMTP id d62so19870152oia.11;
        Thu, 16 Jan 2020 11:29:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=D0JIWPnsYgxjHJnE5BfoF3NZoxlKFK4Y77Nq/8y7ezs=;
        b=lKD7rHVeXKpEarqLRd6sTLbJHu9LYw502QdJf6JXQyMXzVyejdEML/rLc1yUXEgWSK
         WCA+Cso6kGlAaE7WpyT+drw4baOzjXmb+NavLCDwql5TJo0eu4txi7f+zUlK4ph0p52d
         lc3SE2cKhlpEngACf2IVzjBexLL+IHmWUwKFEZku1AFmhi55wurSVVI2wjB9IUxhGDw2
         NixdM1zdLJ4W4rFPQb4+o1IjMlWTXx5IjEellID2BMSTcMGt/wps9NXU0yFt0NV1bsSs
         JLVeYmvHmKrzo7o3ECEWY3RwwtGQQqBMV8rYJzsydbl7znozh7cQ6xPaMAbgQ2dRYRZ+
         pr2A==
X-Gm-Message-State: APjAAAUAFCqzfnC8N9JJ0zdUCW+KlljsQ5pNyzXCVzE03SliNfrGbo+l
        qnB2ZOZm4XuCn1EbWD1NFw==
X-Google-Smtp-Source: APXvYqxKidt2yeQs5IGuNWSmZp6MzfrFSsaJkFcNm4vVcSUsA9SWbac9tU0UOLuDMJZgPTkC0llSjg==
X-Received: by 2002:aca:b187:: with SMTP id a129mr495210oif.175.1579202969846;
        Thu, 16 Jan 2020 11:29:29 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id m3sm8028076otf.13.2020.01.16.11.29.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2020 11:29:29 -0800 (PST)
Received: (nullmailer pid 2025 invoked by uid 1000);
        Thu, 16 Jan 2020 19:29:28 -0000
Date:   Thu, 16 Jan 2020 13:29:28 -0600
From:   Rob Herring <robh@kernel.org>
To:     Joakim Zhang <qiangqing.zhang@nxp.com>
Cc:     maz@kernel.org, jason@lakedaemon.net, tglx@linutronix.de,
        robh+dt@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        fugang.duan@nxp.com, Joakim Zhang <qiangqing.zhang@nxp.com>
Subject: Re: [PATCH V5 1/2] dt-bindings/irq: add binding for NXP INTMUX
 interrupt multiplexer
Message-ID: <20200116192928.GA1014@bogus>
References: <1579064664-16452-1-git-send-email-qiangqing.zhang@nxp.com>
 <1579064664-16452-2-git-send-email-qiangqing.zhang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1579064664-16452-2-git-send-email-qiangqing.zhang@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Jan 2020 13:04:23 +0800, Joakim Zhang wrote:
> This patch adds the DT bindings for the NXP INTMUX interrupt multiplexer
> for i.MX8 family SoCs.
> 
> Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
> ---
>  .../interrupt-controller/fsl,intmux.yaml      | 67 +++++++++++++++++++
>  1 file changed, 67 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/fsl,intmux.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

Documentation/devicetree/bindings/display/simple-framebuffer.example.dts:21.16-37.11: Warning (chosen_node_is_root): /example-0/chosen: chosen node must be at root node
Error: Documentation/devicetree/bindings/interrupt-controller/fsl,intmux.example.dts:20.27-28 syntax error
FATAL ERROR: Unable to parse input tree
scripts/Makefile.lib:300: recipe for target 'Documentation/devicetree/bindings/interrupt-controller/fsl,intmux.example.dt.yaml' failed
make[1]: *** [Documentation/devicetree/bindings/interrupt-controller/fsl,intmux.example.dt.yaml] Error 1
Makefile:1263: recipe for target 'dt_binding_check' failed
make: *** [dt_binding_check] Error 2

See https://patchwork.ozlabs.org/patch/1223172
Please check and re-submit.
