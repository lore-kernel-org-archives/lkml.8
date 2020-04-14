Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CD44C2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 17:58:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D9E62074D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 17:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586887100;
	bh=l5J9PHRSIFz2AZuTh0+lIGpbdjv6c+ZUP2CwqfwMUE4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=B2nePHH9O/U8/76RkJuKCC6dq33ggdJyYQwTZUBc8WToqHvoQ456DFcfTKP7QzooU
	 51BX/wzwMrhsZq4QGpKaiqOUYxhq8p+SOmZfVoYnUPWcELxgQO3zU5oyqDCXWFEHzY
	 IYDzwxP8Wj5Ax+o23g6H7CHrCQlqpIsFIrFISF8U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503139AbgDNR6N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 13:58:13 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:37937 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729303AbgDNR5v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 13:57:51 -0400
Received: by mail-ot1-f68.google.com with SMTP id k21so563070otl.5;
        Tue, 14 Apr 2020 10:57:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=95VCjMOD5kZUDCbtdtoW55r/KZ/BquQ8J6EOvdKzoX8=;
        b=TW3epxHe1A7V+NAwpfjbhvuQ4RwI/qOiYt8C7AEngbDzy+OUeucFNMOcaHW1tzwaD7
         SmEuMVMJBTeU3blOahpUSgsMse1UpFeoP4dTkNI0egYSu7xKUvX4hLgXcvhiRSv61uC1
         GxYKTAUyeFbe3pzMGtfmyZzJ3Zc4qWwV9P8AbXUyrNUTgrYg8yUb7A5Mw8/KrRZwMTBa
         Su8knejVWaU6nQnKWZ5mYgbqLuLYCI7QFb4leFS9TAsE4SRsLezJxbing/W+U85vmsZX
         FDot6+3ASszykgizaXJh0nc4zkPhzjX8/T0FpeP6LKsuicah5JQ1uDYEYvT/o3jwHYg+
         XGkg==
X-Gm-Message-State: AGi0PuY5u39K8OafC62cPNXULPLb22hLT5uCXG6Fz88+QDY4zAMX5Kv/
        NtEj66kwG9a611PXdDWi8Y/GLi4=
X-Google-Smtp-Source: APiQypKJ4nZqqd6f5jP2/fMwhxkt0Fg4V0MlsSFXXJmYhrshh6EmPivMonFEUEoKGk7x2cMHELuiKg==
X-Received: by 2002:a9d:d0f:: with SMTP id 15mr20284590oti.161.1586887069125;
        Tue, 14 Apr 2020 10:57:49 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id t20sm2431322ott.51.2020.04.14.10.57.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 10:57:48 -0700 (PDT)
Received: (nullmailer pid 30689 invoked by uid 1000);
        Tue, 14 Apr 2020 17:57:47 -0000
Date:   Tue, 14 Apr 2020 12:57:47 -0500
From:   Rob Herring <robh@kernel.org>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     jacob-chen@iotwrt.com, ezequiel@collabora.com, mchehab@kernel.org,
        robh+dt@kernel.org, heiko@sntech.de, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] dt-bindings: media: rockchip-rga: add
 power-domains property
Message-ID: <20200414175747.GA30642@bogus>
References: <20200403130607.6138-1-jbx6244@gmail.com>
 <20200403130607.6138-2-jbx6244@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200403130607.6138-2-jbx6244@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  3 Apr 2020 15:06:07 +0200, Johan Jonker wrote:
> In the old txt situation we add/describe only properties that are used
> by the driver/hardware itself. With yaml it also filters things in a
> node that are used by other drivers like 'power-domains' for rk3399,
> so add it to 'rockchip-rga.yaml'.
> 
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> ---
>  Documentation/devicetree/bindings/media/rockchip-rga.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
