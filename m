Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90E84C2D0F0
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 23:06:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 648BB207FF
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 23:06:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585609613;
	bh=AELQrW7y3T3q6mg9ZOSrYRC8agnayQ+CyIkqhTLPOuM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=12LwL0uZALjpaygAPMbNwqoKVwDu31kRsWeBXOl/ZTY8YX2zOtZ41EjU6c1SpjO7Z
	 YJ+33eZ3sTP+GmV+/lzWG/nyd85QEjZCK6wQ3vJl07X888y8vyzBFJs6Qtcj+s54KF
	 4UykgYybBXxNQgCiOPt2v0HyBhI1Pa8o/SVaUEkU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729862AbgC3XGw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 19:06:52 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:36000 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728987AbgC3XGw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 19:06:52 -0400
Received: by mail-io1-f68.google.com with SMTP id n10so5658051iom.3;
        Mon, 30 Mar 2020 16:06:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2R3HeLQuIVaRCkh6X9o27tq3rLDIUQvSz/ALYknVRuQ=;
        b=ZqnPHyDWKMvPuny61ARi723y1mevUwHsDOfUDDWCUYTsRJxEeopk29eDupbAYak+TO
         VDBP33W8yK6OTNRWj558ja+OoeMuWNWdhdJe4bGYqbn6/oGH6h/LQ33FV90NlMCEKXh5
         bLv0LHagTwBPWO0KH9Yb06D4V0Da1MgVi4Grwh02KP1d9oA3PHSRte6mAkGTOcsU8mwz
         GmBy2AA+1nKnM/rnM16pWjj8lC6Uz0F+vEXB8Xl6s0qw5KIPngiOG7sJnmMDJhn8HEfP
         gZS1Lu9w5QhgZUQiBqCHD1pYJo974y1TsB3TvI6jrIKM4MQgMIOe0/1UL1tEQ1DVgSvx
         Kyng==
X-Gm-Message-State: ANhLgQ18JoKd958qNvgrKSdmlDAjvuluRtC6p9jf0CEtQLyt+xEwEeXg
        uC8HuyrSzTfmQTvWF+ujKQ==
X-Google-Smtp-Source: ADFU+vuK6gZ0DHpy9mtPPqneXZSnMRxos+jfYY3/2CKIx6COKayBSG14rG/bH2o8Ip/2xpj5hXIgbw==
X-Received: by 2002:a02:2384:: with SMTP id u126mr13486357jau.64.1585609609630;
        Mon, 30 Mar 2020 16:06:49 -0700 (PDT)
Received: from rob-hp-laptop ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id m4sm5313115ill.78.2020.03.30.16.06.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2020 16:06:48 -0700 (PDT)
Received: (nullmailer pid 29320 invoked by uid 1000);
        Mon, 30 Mar 2020 23:06:47 -0000
Date:   Mon, 30 Mar 2020 17:06:47 -0600
From:   Rob Herring <robh@kernel.org>
To:     Nagarjuna Kristam <nkristam@nvidia.com>
Cc:     kishon@ti.com, robh+dt@kernel.org, thierry.reding@gmail.com,
        jonathanh@nvidia.com, balbi@kernel.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-usb@vger.kernel.org,
        jckuo@nvidia.com, Nagarjuna Kristam <nkristam@nvidia.com>
Subject: Re: [PATCH V1 1/8] dt-bindings: phy: tegra-xusb: Add charger-detect
 property
Message-ID: <20200330230647.GA29166@bogus>
References: <1584527467-8058-1-git-send-email-nkristam@nvidia.com>
 <1584527467-8058-2-git-send-email-nkristam@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1584527467-8058-2-git-send-email-nkristam@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Mar 2020 16:01:00 +0530, Nagarjuna Kristam wrote:
> Add nvidia,charger-detect boolean property for Tegra210 and Tegra186
> platforms. This property is used to inform driver to perform charger
> detection on corresponding USB 2 port.
> 
> Signed-off-by: Nagarjuna Kristam <nkristam@nvidia.com>
> ---
>  Documentation/devicetree/bindings/phy/nvidia,tegra124-xusb-padctl.txt | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
