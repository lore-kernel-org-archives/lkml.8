Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A764C3F2D7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 16:57:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1840720674
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 16:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583341029;
	bh=C2CddSrtRznh8XRpIeRL3aTU+1Zm12E9YjYWxBIDQ50=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=W9JXW4DStOPgyRVl2YrUM7+gQeJDH3iEaO0oh4JCldpUWzcsQokTeVwWxAvIsYcDy
	 IjQPnRoIPMEmQUivjQ+7fZYsszUv8vvUxLOS3ru96qPtJLTUpdS13ntI2sMvEz3IcJ
	 vXGHOCgnrk0nsEhJRQ7xMHKHiKuvOBCwPvdklBH4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729554AbgCDQ5I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 11:57:08 -0500
Received: from mail-oi1-f175.google.com ([209.85.167.175]:37879 "EHLO
        mail-oi1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725765AbgCDQ5H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 11:57:07 -0500
Received: by mail-oi1-f175.google.com with SMTP id q65so2788529oif.4;
        Wed, 04 Mar 2020 08:57:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=v56tNbaf27S3vsJCZpK0lDpbd6dC6biMMvnBq59fAOw=;
        b=oRuNtB6ll/BixhQQZMrUdbHr5O0Nynm9xq2ILXcpalUNkA4mDcUcD3rlS9JB/GCkMc
         LDrMTQjBC3Om00/8FuLi5FS4nL3hdFpFFXz0kcTM084RWNc2oJD19Hi0oVPws7r7wH6Z
         ONTz6i6FylKkLu/mZ1eBnFHH6m7mWVQ6Rdf7SZj2AOVLBXxGZ2sgxTE9M02B/avbl9GD
         cPCJijd/wSUA/M/eT/wqMAt7PpOm0uLpclAxXzHALLE2sK9Jq2XAQ0XAo4favW04nugF
         J9qU6hiqfl/vVyFZrdex52szeA16KOKK3ga9L14FW+puWLPewh1fq0NRlkB2axg1jIjy
         8CUQ==
X-Gm-Message-State: ANhLgQ05Xi82kARnctGUXR9eFwX/68lVH/M5pqb7Ahnd8eBSn8KK2c1p
        2wLHG34rCoQCxVLbRpsnMg==
X-Google-Smtp-Source: ADFU+vuq6LTSjctHGWYdpBagVO2mWD6V/pN+nXSJfZEGYnGz547pSblqr5DAPWLVCdCXURaCM/KV6w==
X-Received: by 2002:a05:6808:298:: with SMTP id z24mr2285480oic.101.1583341026709;
        Wed, 04 Mar 2020 08:57:06 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id i185sm5371438oib.51.2020.03.04.08.57.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 08:57:05 -0800 (PST)
Received: (nullmailer pid 19811 invoked by uid 1000);
        Wed, 04 Mar 2020 16:57:04 -0000
Date:   Wed, 4 Mar 2020 10:57:04 -0600
From:   Rob Herring <robh@kernel.org>
To:     Sam Shih <sam.shih@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Sam Shih <sam.shih@mediatek.com>
Subject: Re: [v3,1/2] dt-bindings: pwm: Update bindings for MT7629 SoC
Message-ID: <20200304165704.GA19695@bogus>
References: <1583319973-20694-1-git-send-email-sam.shih@mediatek.com>
 <1583319973-20694-2-git-send-email-sam.shih@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1583319973-20694-2-git-send-email-sam.shih@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Mar 2020 19:06:12 +0800, Sam Shih wrote:
> This updates bindings for MT7629 pwm controller.
> 
> Signed-off-by: Sam Shih <sam.shih@mediatek.com>
> ---
>  Documentation/devicetree/bindings/pwm/pwm-mediatek.txt | 5 +++++
>  1 file changed, 5 insertions(+)
> 

Applied, thanks.

Rob
