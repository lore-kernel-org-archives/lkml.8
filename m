Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4971DC3F68F
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 16:08:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EBB721835
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 16:08:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579709309;
	bh=Wt/QXdeR9dhB+sV9Tei7vifvbp6xJGRZkZesXjdoQw0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=uLbk3RwjLAqX4Hx9x+Y7hBLEtFKx/voEXvSxBAKbsiLFbJwlsFQQUq5/qpSA3azee
	 4iHmb5lDV9hvjcJvQ1f6gbiuVM1a3/W31+HwVhRQ7IHpbDeGYmzJyvQYaYifdSFqqp
	 Ggbpjief/D77xgaJ3eOZ665D+DLSIkj83NySs694=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725884AbgAVQI2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 11:08:28 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:38815 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728916AbgAVQIZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 11:08:25 -0500
Received: by mail-ot1-f68.google.com with SMTP id z9so6748916oth.5;
        Wed, 22 Jan 2020 08:08:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fJ6RphyD8sSyPTqyOLqAI/Xz7E4nNP+XR5CyPMuI564=;
        b=BP0JmMHeWNbH2s3xrZkfG/MUGgwt4T/GJq0kR96G9AkFbzotPU/JwjMKhN/g2KPU+5
         YhVkuhS2gMYjo5RJ1tiaYUuNyICRfrfjn+BnljYJMJTgwZuH0P9vSSuxmssW8M21k5EU
         qwey/57t80DqixS2qcSgDv7jLAwgCgH/5rbEhtegL427b0XZw3JblaNtyOHXOhKrsjsb
         PlvwpqoYQ3o0kplqdCPeVM8AU4hSOLBdW1adBCY9Qd2LDXjKuoZcT7FUFH7vTv/RDn/c
         T7Gl1GqUa7rcM5aHhDFN4HvIJnOKOSbCIK4db4Z8GI4M1uK9PnxtaRqSCluiZJKQ7UKF
         MGcA==
X-Gm-Message-State: APjAAAUWd7kGZ8DwwqhIWM2JpSvB+WRtBI4tkeNCJlZ2yreEjBbDImWn
        ZNc19xnji8u3RUB4yP/lRg==
X-Google-Smtp-Source: APXvYqxLEOxbsL08vDuEoLiLKQY5f0wqCbNPih8yNmPTCMWHpkhVewkTCUhbZi3T/uga/TLzgU10Zg==
X-Received: by 2002:a05:6830:10c6:: with SMTP id z6mr8270289oto.203.1579709304565;
        Wed, 22 Jan 2020 08:08:24 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id y13sm14708687otk.40.2020.01.22.08.08.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2020 08:08:23 -0800 (PST)
Received: (nullmailer pid 15086 invoked by uid 1000);
        Wed, 22 Jan 2020 16:08:22 -0000
Date:   Wed, 22 Jan 2020 10:08:22 -0600
From:   Rob Herring <robh@kernel.org>
To:     Emmanuel Vadot <manu@freebsd.org>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, heiko@sntech.de,
        dianders@chromium.org, andy.yan@rock-chips.com,
        robin.murphy@arm.com, mka@chromium.org, jagan@amarulasolutions.com,
        nick@khadas.com, kever.yang@rock-chips.com, m.reichl@fivetechno.de,
        aballier@gentoo.org, pbrobinson@gmail.com, vicencb@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Emmanuel Vadot <manu@freebsd.org>
Subject: Re: [PATCH 1/2] dt-bindings: Add doc for Pine64 Pinebook Pro
Message-ID: <20200122160822.GA15049@bogus>
References: <20200116225617.6318-1-manu@freebsd.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200116225617.6318-1-manu@freebsd.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Jan 2020 23:56:16 +0100, Emmanuel Vadot wrote:
> Add a compatible for Pine64 Pinebook Pro
> 
> Signed-off-by: Emmanuel Vadot <manu@freebsd.org>
> ---
>  Documentation/devicetree/bindings/arm/rockchip.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
