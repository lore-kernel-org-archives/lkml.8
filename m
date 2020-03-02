Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77AE7C3F2CD
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 23:48:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E4272465E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 23:48:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583192916;
	bh=2w/FOfArXTn6xiW8kV9yHiG6X72xH20daDeVM0P+IJI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=qfRTljeZpLMEDm7scJpt/CvM0iGAx/Pq/znTrcA35zPX59Ay4NMSDJ72gVZKa+ksp
	 /HsccIAabSQYWSgMBvFtV8DDV0S5EyBmdBHsRdf7gf0A4cB65GFnk6PoPCHCWpWGer
	 a/wRKug3tXHUKKVctWYXNx+mZZ0P+GKMKu2p8xJI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbgCBXse (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 18:48:34 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:34433 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726890AbgCBXse (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 18:48:34 -0500
Received: by mail-oi1-f196.google.com with SMTP id g6so1165259oiy.1;
        Mon, 02 Mar 2020 15:48:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IRKRL6bsVR25jdnkySlY9nrjsKRKvfWFUdg3jJgqhvM=;
        b=QPn+2GMJ6bOETNGW0/sMtcGo3pIR5cynmiAxBgy8Z0Grk9dw7n7SBjmI5NahM/aIOZ
         o+DFsEjQpI5119V+4zKzKkF0Uimay7K24iNRhzZPnwB2AYvX4qkfo9/LbJ/x5cn/aymK
         0tN+o7LuzzC7bhokwK+yCynaLxVfQi2V5o4UqjOLKCVWsxAJ/zEwsoJHinbb8rRIFJsO
         0bF/AuffpiJGr9OPJA069Kut7EQRXyTd1+YFBBY0amiMtkXVLkqF1pfQUbiuD4YwnRcv
         vJevgkrqKcwRcFW0+7x+q6DnM09hrrSLkSBTSpkAYjgQmqmreUdPjMxIcX11BO4upHfC
         canA==
X-Gm-Message-State: ANhLgQ2Kvvy0hRbYGEo+EavWAZneapgKdr/xa9SRbFn8EspsbYW/zElv
        u/o1aXmr5yDdLwipyPGS3Q==
X-Google-Smtp-Source: ADFU+vt2I73Ny42c4sY9uLWCMSp6hK6ClCvDil8321kkwWDH86USwR7muQDsWqWnRb7qcFSntFukew==
X-Received: by 2002:aca:1011:: with SMTP id 17mr678618oiq.72.1583192913409;
        Mon, 02 Mar 2020 15:48:33 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id z19sm4129288otp.81.2020.03.02.15.48.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2020 15:48:32 -0800 (PST)
Received: (nullmailer pid 31830 invoked by uid 1000);
        Mon, 02 Mar 2020 23:48:32 -0000
Date:   Mon, 2 Mar 2020 17:48:32 -0600
From:   Rob Herring <robh@kernel.org>
To:     Christian Hewitt <christianshewitt@gmail.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Christian Hewitt <christianshewitt@gmail.com>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        =?iso-8859-1?Q?Jer=F4me?= Brunet <jbrunet@baylibre.com>
Subject: Re: [PATCH v6 1/3] dt-bindings: add vendor prefix for SmartLabs LLC
Message-ID: <20200302234831.GA31775@bogus>
References: <1583036241-88937-1-git-send-email-christianshewitt@gmail.com>
 <1583036241-88937-2-git-send-email-christianshewitt@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1583036241-88937-2-git-send-email-christianshewitt@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun,  1 Mar 2020 08:17:19 +0400, Christian Hewitt wrote:
> SmartLabs LLC are a professional integrator of Interactive TV solutions
> and IPTV/VOD devices [1].
> 
> [1] https://www.smartlabs.tv/en/about/
> 
> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
