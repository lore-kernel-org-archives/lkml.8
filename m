Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59427C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 21:31:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 23D9920768
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 21:31:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595539869;
	bh=XL7Rk8zWsunyyCExPIRLeILwzx5O8u5OJMOV/lEfXYM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=jWVL0rgZ6ypTieKN2sohHzB/R7PC/7XJf9VQI4w9Cbk4pw6x4teWtMsV2SE0xLTzG
	 zWjj2lfxIYELtb3nq1T7xrExTWirhGdfkeJfd9ANGCjEsy2+XYQP8GqN7tihJjjCb4
	 LqXVKiePdpLBkPu+wbBYRdlPZPnL2rFl+rH3u8ig=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727887AbgGWVbI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 17:31:08 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:37988 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726368AbgGWVbH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 17:31:07 -0400
Received: by mail-io1-f65.google.com with SMTP id l1so7795371ioh.5;
        Thu, 23 Jul 2020 14:31:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vjE3NqOQPDxrOySB8VOWL3YX/nVenA3VGTS7dfzrOE0=;
        b=AA7irF34lMVbZEdipXr4hANQFQv+RGs+KcLH1dA/+EsmJ+tHnHY6yotmoTiN55BleH
         3vtb/sL9qsZnQ276HmklLducCCpzDCJncIw87LwMIy5fWKCI2TOoAyzGD0wxBQbkyXvy
         txghqZBs/OVhZ5to8Yv7x6ONhPI3MH+Q8qNeio0dRddrT8n836Ck1N6ZFad7rBGEQkfz
         tafd7nHAhbOZ/p3MFqKNS+kvnTvK0ezG7mSVKggj39054nFNCulhJ5R18Ky4ufwk7etc
         umUwkk1/KhVW5W+AFiIPF5S5++9Dai0DpU5l6VnxS6graANlK56kVHrQ9ZLkRvfV/4IO
         18Zw==
X-Gm-Message-State: AOAM532XW3nxsAe2Jwz1Jymo9lJvN2kA8nB4/TbX0dgf9SsDvwd8dEis
        jQxC2WZjVvzZFVXvj/3dRA==
X-Google-Smtp-Source: ABdhPJwVgnA/hJhV9LiGGQc1ZkHWGKUdeMAdCJZFPk2qNXp9oIvRFjNVEtg1Or3jAlQMNEPN7Am+2Q==
X-Received: by 2002:a05:6602:2f88:: with SMTP id u8mr7023269iow.120.1595539866319;
        Thu, 23 Jul 2020 14:31:06 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id y1sm1710227ilh.53.2020.07.23.14.31.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2020 14:31:05 -0700 (PDT)
Received: (nullmailer pid 893661 invoked by uid 1000);
        Thu, 23 Jul 2020 21:31:04 -0000
Date:   Thu, 23 Jul 2020 15:31:04 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     linux-rockchip@lists.infradead.org,
        Suniel Mahesh <sunil@amarulasolutions.com>,
        linux-amarula <linux-amarula@amarulasolutions.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 5/7] dt-bindings: arm: rockchip: Add Engicam PX30.Core
 C.TOUCH 2.0 10.1" OF
Message-ID: <20200723213104.GA893605@bogus>
References: <20200723123951.149497-1-jagan@amarulasolutions.com>
 <20200723123951.149497-6-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200723123951.149497-6-jagan@amarulasolutions.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Jul 2020 18:09:49 +0530, Jagan Teki wrote:
> PX30.Core is an EDIMM SOM based on Rockchip PX30 from Engicam.
> 
> C.TOUCH 2.0 10.1" Open Frame is a Carrier board with Capacitive
> touch 10.1" open frame from Engicam.
> 
> PX30.Core needs to mount on top of this Carrier board for creating
> complete PX30.Core C.TOUCH 2.0 10.1" Open Frame.
> 
> Add bindings for it.
> 
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
>  Documentation/devicetree/bindings/arm/rockchip.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
