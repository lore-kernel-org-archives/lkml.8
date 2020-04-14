Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 747B3C2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 16:40:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46F5720678
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 16:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586882432;
	bh=jdW8CGXpQRHGN4CXbgUKi3X04IznNELnSn1RxD/psn8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ixnbHD2IePydBDTF+GaMb7XFzZp5f+FsrGnLkTQhYudf44crvb6P/9XuXku6xfzA0
	 LzBmuePBrCK7FQ9z+/3AsTAPXYPwWSZe1ByVhkqWMp8i7siykwPNGByVHKV0FN5n8b
	 ENcG8JBAhreffwXYl+shgRC58EiVJd0LmxXIuyWY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405189AbgDNQka (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 12:40:30 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:47044 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404764AbgDNQkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 12:40:25 -0400
Received: by mail-oi1-f194.google.com with SMTP id q204so10933092oia.13;
        Tue, 14 Apr 2020 09:40:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3x35azgG+lJCU/gZaEiAMxuZVIwGctATbm5bUTVlau4=;
        b=OsoCS8X9Ja254Fhj8jS1lfjNg4PT06oqYuVRREpEUC1LfE6/i746w75DA03/PnvA0J
         TayTwRO6w8B+I4j95/ZLD6iVKJEGQnmBmxjMguCRzC0XZ4W8gMGgFP5Z28KTytyw3gh1
         Xs07Tbtxyt6JqDPxW8ebqLzrVU/+AEkYvGdkNlmc/5bzKrbV3S0Bid+3SK7tQ/YnQz2A
         wl1dabe+Auk6jG8KvuawUrkiME9xZ8LlOSReh7HZhHn4vlHoqPEU4GWcShLZ5HvCO1wv
         txlWHMvAr5Fu0fI2b/0MzlInUoAplJR3uw5yufp05s6zajfvwn7AtgeTCIcIfdCU55+r
         pBLA==
X-Gm-Message-State: AGi0PubTZ9CMvcRl/1c2EUEWvLlKuMvFMUSTjwseo1JyuuUfQjuiBCqr
        lI12pDsj7Ba+7+hz/HDkwQ==
X-Google-Smtp-Source: APiQypL0oSub6bEtdmYrLp1hotMjYYelqHyjSliWQQvH3rQAEdz2dRbHzqQ3NfLOhbbfyOvDATjPug==
X-Received: by 2002:aca:fdd5:: with SMTP id b204mr8487693oii.167.1586882424671;
        Tue, 14 Apr 2020 09:40:24 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id f26sm4225778otp.28.2020.04.14.09.40.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 09:40:24 -0700 (PDT)
Received: (nullmailer pid 6287 invoked by uid 1000);
        Tue, 14 Apr 2020 16:40:23 -0000
Date:   Tue, 14 Apr 2020 11:40:23 -0500
From:   Rob Herring <robh@kernel.org>
To:     Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc:     devicetree@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-kernel@vger.kernel.org,
        Michal Simek <michal.simek@xilinx.com>,
        linux-arm-kernel@lists.infradead.org,
        Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Subject: Re: [PATCH] dt-bindings: timer: cadence_ttc: Migrate
 timer-cadence-ttc documentation to YAML
Message-ID: <20200414164023.GA6221@bogus>
References: <20200401141449.66905-1-iwamatsu@nigauri.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200401141449.66905-1-iwamatsu@nigauri.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  1 Apr 2020 23:14:49 +0900, Nobuhiro Iwamatsu wrote:
> The document was migrated to YAML format and renamed cdns,ttc.yaml.
> And updated the example to the latest format.
> 
> Signed-off-by: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
> ---
>  .../bindings/timer/cadence,ttc-timer.txt      | 21 --------
>  .../devicetree/bindings/timer/cdns,ttc.yaml   | 48 +++++++++++++++++++
>  2 files changed, 48 insertions(+), 21 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/timer/cadence,ttc-timer.txt
>  create mode 100644 Documentation/devicetree/bindings/timer/cdns,ttc.yaml
> 

Applied, thanks.

Rob
