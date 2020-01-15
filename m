Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11F2EC33CB2
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 16:05:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3DA5222C3
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 16:05:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579104320;
	bh=k4+2rcZsa73U1u6VMCpgUDA0iChm3TyHbBQes4nZI2U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=PGNwn6xbTHAcAbuYrs7qbTLMCSnbpbp4W55nHLZ3z5jsUXhpPRyObbKzZgxxKrjxx
	 /vT52XdEnkhSwknVk+iVmTSOLmkjpSbY7+auXTlVjOxIa8D1ieSUFjospDIXP4xaVn
	 xK2m48pxt1jeHdBahftutx3+Ttuwfm6ZcT2fDeP8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729012AbgAOQFU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 11:05:20 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:41803 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726418AbgAOQFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 11:05:19 -0500
Received: by mail-ot1-f65.google.com with SMTP id r27so16517051otc.8
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jan 2020 08:05:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AIn1O5GCmKw7dugKJey6e6TvKV2y4GDiW1xXQSe2Ay0=;
        b=Te5XpvsfO2ljwUnC2oCCp4XXtIKVMTvbAxsORqlsqctS0gPbZigJ6c0igZgk1E1AYC
         2jOkSx4NWlFMtVGONeJvk8BOOjhEDU7yw624uwFtAbxcdmM+3GnprVZFsIUKs7jKWTjP
         Mbj1G/vXSTj1knDPawzliMyT88ZBYeJNWLa7SOYRT3t/uutujziqg7HhwGDQFMN6DdT2
         cFDBDeC37RT0M7Ov8HriLfUvY9uzSrRnadrUW2s90oqgNT6zT8b4AVRuyqdJRtKzmt+w
         /qInN+MFSgG493rt1/kfPW5THZDVNzGwf5XmjvW2jAemQsGh1aO3d1NG7/++5zum3M/f
         UC9w==
X-Gm-Message-State: APjAAAXAKJwUUlZTl/Lv82Q/2BR3GeHt9WlpxXGkudpO7e6Et3y8CjiU
        1hMpKCO47KfWTdNn4271EptOdwo=
X-Google-Smtp-Source: APXvYqyOt8skbyB+gNu3UOOoDroEbGaxnC2aAg/wCfLgz7KhyH5FT5uZ8vChvOM59TcXgwVERR8dSA==
X-Received: by 2002:a9d:7593:: with SMTP id s19mr3084692otk.219.1579104318025;
        Wed, 15 Jan 2020 08:05:18 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id x26sm835225oto.7.2020.01.15.08.05.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 08:05:17 -0800 (PST)
Received: from rob (uid 1000)
        (envelope-from rob@rob-hp-laptop)
        id 22040c
        by rob-hp-laptop (DragonFly Mail Agent v0.11);
        Wed, 15 Jan 2020 10:05:16 -0600
Date:   Wed, 15 Jan 2020 10:05:16 -0600
From:   Rob Herring <robh@kernel.org>
To:     JC Kuo <jckuo@nvidia.com>
Cc:     gregkh@linuxfoundation.org, thierry.reding@gmail.com,
        robh@kernel.org, jonathanh@nvidia.com, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-usb@vger.kernel.org, felipe.balbi@linux.intel.com,
        JC Kuo <jckuo@nvidia.com>
Subject: Re: [PATCH v1] dt-binding: usb: add "super-speed-plus"
Message-ID: <20200115160516.GA18911@bogus>
References: <20200113060046.14448-1-jckuo@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200113060046.14448-1-jckuo@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Jan 2020 14:00:46 +0800, JC Kuo wrote:
> This commit adds "super-speed-plus" to valid argument list of
> "maximum-speed" property.
> 
> Signed-off-by: JC Kuo <jckuo@nvidia.com>
> ---
>  Documentation/devicetree/bindings/usb/generic.txt | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 

Applied, thanks.

Rob
