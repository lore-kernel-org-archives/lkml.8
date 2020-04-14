Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6678C2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 17:59:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BBEE42054F
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 17:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586887165;
	bh=xaOn/2CWFOj45JQcqfJlIK3rBJp/kxvCd70ZoETImT0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=xzjMfdRWIrdUl+0uo6Fge3Fx50Q8CRau9cRhFE9LQRJgvba0bidYysTK9uAG2B1AQ
	 +Zf0eUzvAlCZ5GQ/lNl41rgBPJOGq2IYXYC5sJLA2qSfdHj53DuoLkP95MQO11WB36
	 Ev+GkHAdrP0Rg5taVM0IjN6NOu9733oXyT8HcpDo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503159AbgDNR7Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 13:59:24 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:37706 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729303AbgDNR7O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 13:59:14 -0400
Received: by mail-oi1-f196.google.com with SMTP id r25so1340731oij.4;
        Tue, 14 Apr 2020 10:59:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MbLt7+mg6Oetm1gbvDN0HE/9QqLc7vIPQSx4pz/IWko=;
        b=dxorrDcMwUzU5gYAGXv9SoiVa8EjmJt7ntOXAyTvSxFQsXS6gEK7jcpuxl/Md0eIUj
         narcCeej6DaoGcyYTaeq3VfE7zQ00s7MRH4p/LQJwDnhOG7B+mssKjRdYwED1zRffH1K
         yy5SvsCQu5XmySV0nha9PJSkSPsPqqFOT0RLXfzgHCItoKIpna7XpyQ4ov7l6olB7ybL
         9Fe5Pci1pSkbGCOfpLXFu5eRezwPwSTU3diIWMiMq6YFsq27hmg0oLAtY1vmR1f0jDWU
         LILCzBd39OVDXg1VF9zyagmg+X63phBKeHJiBWt88ZfsUo2IVygTNSDwRvmopPEScOBq
         duVQ==
X-Gm-Message-State: AGi0PuaQZPnRoG1uhWhxEpmWXg5Kts3QXxIawXJwiw1om+DqIoxqG4Hh
        xznqSWz2R0VdGccuhW1nEQ==
X-Google-Smtp-Source: APiQypJlaXG4zu9PmD/DgToYH3heydOg9ica+o6s8kLB78gY3Gm05N1iYUwxCQz5c3+ZNDu+sl4n8A==
X-Received: by 2002:aca:f491:: with SMTP id s139mr16592669oih.128.1586887153366;
        Tue, 14 Apr 2020 10:59:13 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id k64sm5691828oia.57.2020.04.14.10.59.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 10:59:12 -0700 (PDT)
Received: (nullmailer pid 4704 invoked by uid 1000);
        Tue, 14 Apr 2020 17:59:11 -0000
Date:   Tue, 14 Apr 2020 12:59:11 -0500
From:   Rob Herring <robh@kernel.org>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     heiko@sntech.de, hjc@rock-chips.com, airlied@linux.ie,
        daniel@ffwll.ch, robh+dt@kernel.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: display: convert rockchip rk3066 hdmi
 bindings to yaml
Message-ID: <20200414175911.GA4583@bogus>
References: <20200403133630.7377-1-jbx6244@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200403133630.7377-1-jbx6244@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  3 Apr 2020 15:36:30 +0200, Johan Jonker wrote:
> Current dts files with 'hdmi' nodes for rk3066 are manually verified.
> In order to automate this process rockchip,rk3066-hdmi.txt
> has to be converted to yaml.
> 
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> ---
> Changes v2:
>   Fix irq.h already included in arm-gic.h
> ---
>  .../display/rockchip/rockchip,rk3066-hdmi.txt      |  72 -----------
>  .../display/rockchip/rockchip,rk3066-hdmi.yaml     | 140 +++++++++++++++++++++
>  2 files changed, 140 insertions(+), 72 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/display/rockchip/rockchip,rk3066-hdmi.txt
>  create mode 100644 Documentation/devicetree/bindings/display/rockchip/rockchip,rk3066-hdmi.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
