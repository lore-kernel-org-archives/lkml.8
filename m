Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F190C3F2CD
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 02:03:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0CC524673
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 02:03:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583201017;
	bh=yUrIiqcE7LZmUMwL9trMaDbvbQlrQqZGQmMUS6Upaig=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Ypuz8fdCY+tTZdDWiGKZGgnz8TAtsmhWdxdK6iNG1vSWiTuwJR+uFRJOcdM5GYw7S
	 TB8mTcEYZTFu3mH62pqm8Hff4uhirmp26lXQ21neCq/1MZRQnBmPUl0xEVI7z125Fs
	 ls4fupB94bgI0xKAFtPcDV+mR9gaqyn7jeqPdwKE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727484AbgCCCDh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 21:03:37 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:40631 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726954AbgCCCDg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 21:03:36 -0500
Received: by mail-oi1-f196.google.com with SMTP id j80so1399901oih.7;
        Mon, 02 Mar 2020 18:03:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/UbbCrQ4zJM1G4CgVmEuduvPdDUs8jqlAa46gDYcCCo=;
        b=iFd4GvUkJZH+UaHL3ZUp5a7NdhAH9zZwORGmJKFU97YIovfmPYwIWArQohHgrewlW/
         +ZpLpEJiPIPBmJJ9h6EtYtvxySsE72S35+EDW5+oB7iZ1qdcCds3Va1Xg3mP25WBqo4n
         HG34ntobKFczEkgQYpnn4VjJMMMBmtXkuS62caAyjVi0ylOlOoaxPUzd4iEOeTcOHran
         owQGx5duRlB16ZhHackMEebuDLDInlOOq5n70JSe6fRzgOw4JQpsPLDXe1fNWmedEka2
         Uke94A+14Jf42DXDDAInntJj+u+YQ8UN01jY1LiQ7QIp0Xg9XSPiLh+0mcu3AVoqFw04
         IPOA==
X-Gm-Message-State: ANhLgQ2OanR06ysLfAYoDWNBUrZTZAX8XiI3XyDSCFVOuf+jdbZ3TbnF
        gFuOsO+50BXpOK+/9F191A==
X-Google-Smtp-Source: ADFU+vsTrN9e4+w5gxNDsk4u2uwXJbz5xUm56Q2btlvLSjXZ4AzZ/N9PS1Koa2Y58E6zkQ/klqwpJg==
X-Received: by 2002:a05:6808:902:: with SMTP id w2mr971212oih.170.1583201015568;
        Mon, 02 Mar 2020 18:03:35 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id m2sm7016696oim.13.2020.03.02.18.03.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2020 18:03:35 -0800 (PST)
Received: (nullmailer pid 24397 invoked by uid 1000);
        Tue, 03 Mar 2020 02:03:34 -0000
Date:   Mon, 2 Mar 2020 20:03:34 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jordan Crouse <jcrouse@codeaurora.org>
Cc:     linux-arm-msm@vger.kernel.org, smasetty@codeaurora.org,
        John Stultz <john.stultz@linaro.org>,
        Sean Paul <sean@poorly.run>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Rob Clark <robdclark@gmail.com>,
        David Airlie <airlied@linux.ie>,
        freedreno@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH v4 1/2] dt-bindings: display: msm: Convert GMU bindings
 to YAML
Message-ID: <20200303020334.GA24316@bogus>
References: <1583182067-16530-1-git-send-email-jcrouse@codeaurora.org>
 <1583182067-16530-2-git-send-email-jcrouse@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1583182067-16530-2-git-send-email-jcrouse@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  2 Mar 2020 13:47:46 -0700, Jordan Crouse wrote:
> Convert display/msm/gmu.txt to display/msm/gmu.yaml and remove the old
> text bindings.
> 
> Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
> ---
> 
>  .../devicetree/bindings/display/msm/gmu.txt        | 116 -------------------
>  .../devicetree/bindings/display/msm/gmu.yaml       | 123 +++++++++++++++++++++
>  2 files changed, 123 insertions(+), 116 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/display/msm/gmu.txt
>  create mode 100644 Documentation/devicetree/bindings/display/msm/gmu.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
