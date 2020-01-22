Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2480C33CB6
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 16:13:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76D66206A2
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 16:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579709599;
	bh=xexVkCwRPjr6rK/de4qaY6T3FRmqn+WVdOxMj0bVMpo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ZzBYdOMci2204xNUklq4PoS887HZ/ofzDqOE4VsS5z+2BEqu37OdlOeAr3TjPCTKI
	 JO0fIRe8yGS3WAvmKZxnLpMi8gGSgfUa0XxCZBoDxOQ6QN04qeTfvhKaYbIQfKqF65
	 EfazciKM3ptVw37ULcbOGcWW+QnXJbJiFSa4G4XA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726054AbgAVQNS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 11:13:18 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:37052 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725827AbgAVQNS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 11:13:18 -0500
Received: by mail-ot1-f68.google.com with SMTP id k14so6754809otn.4;
        Wed, 22 Jan 2020 08:13:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GOOLLN3pWqF44g0LrBYSSN02QHJR2vx0pTwlOGVzsYA=;
        b=uY2Q9BizotywcwmcYCQEuyq93aV+jRZAyw13R+1gKHb2I0/oU7kg/AJCPhs+of2L4/
         NH8nhuM0q+Tpof8ysqaDm02a2K3mcbujeVKcHtu8YHzIqiB+WQ/Kel1+3SyOIYgsS034
         ZHG6opnGW/f4qN+uVYVaWhZv1LeaY4niKmmk4kXdVJHc2Qc6nqluUzYeeZa/C3Hos7XE
         YK/ib1npApVBBnIdnm4l7p8HGMq34t8aOdMxfkPsNp3/we0FkX/pEgQKt8lmsPssxT7p
         xwa1wjx3GxQtvFAF54McxVond5tAeLm0T64DgihXLPC8R2J3Z9+1DTCh6Kc5N0g0Dz7h
         jO0g==
X-Gm-Message-State: APjAAAUAK4nTTa8ehPALFsYkFhNLqhgtzhLCqkmcDQ7ZobYkIT6zk4gm
        EhbAJOV1Fm4l8WW2gADECw==
X-Google-Smtp-Source: APXvYqwmYzoKLn86Ynkcc7J9y/0tsMyrxzTXAULNTlvpYI9DbPKZBh7QKOk1PALsTI0JgjdMXfP/ig==
X-Received: by 2002:a9d:754a:: with SMTP id b10mr8107214otl.273.1579709597319;
        Wed, 22 Jan 2020 08:13:17 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id z17sm13145536oib.3.2020.01.22.08.13.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2020 08:13:16 -0800 (PST)
Received: (nullmailer pid 23907 invoked by uid 1000);
        Wed, 22 Jan 2020 16:13:15 -0000
Date:   Wed, 22 Jan 2020 10:13:15 -0600
From:   Rob Herring <robh@kernel.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>, mka@chromium.org,
        Andy Gross <agross@kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>, swboyd@chromium.org,
        Douglas Anderson <dianders@chromium.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH v3] dt-bindings: timer: Use non-empty ranges in example
Message-ID: <20200122161315.GA23684@bogus>
References: <20200117155303.v3.1.I7dbd712cfe0bdf7b53d9ef9791072b7e9c6d3c33@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200117155303.v3.1.I7dbd712cfe0bdf7b53d9ef9791072b7e9c6d3c33@changeid>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Jan 2020 15:53:26 -0800, Douglas Anderson wrote:
> On many arm64 qcom device trees, running `make dtbs_check` yells:
> 
>   timer@17c20000: #size-cells:0:0: 1 was expected
> 
> It appears that someone was trying to assert the fact that sub-nodes
> describing frames would never have a size that's more than 32-bits
> big.  That does indeed appear to be true for all cases I could find.
> 
> Currently many arm64 qcom device tree files have a #address-cells and
> about in commit bede7d2dc8f3 ("arm64: dts: qcom: sdm845: Increase
> address and size cells for soc").  That means the only way we can
> shrink them down is to use a non-empty ranges.
> 
> Since forever it has said in "writing-bindings.txt" to "DO use
> non-empty 'ranges' to limit the size of child buses/devices".  I guess
> we should start listening to it.
> 
> I believe (but am not certain) that this also means that we should use
> "ranges" to simplify the "reg" of our sub devices by specifying an
> offset.  Let's update the example in the bindings to make this
> obvious.
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> See:
>   https://lore.kernel.org/r/20191212113540.7.Ia9bd3fca24ad34a5faaf1c3e58095c74b38abca1@changeid
> 
> ...for the patch that sparked this change.
> 
> Changes in v3:
> - Fixed my typo frame@f0003000 => frame@2000
> 
> Changes in v2:
> - Fixed my typo 0xf0000000 => 0xf0001000
> 
>  .../bindings/timer/arm,arch_timer_mmio.yaml          | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 

Applied, thanks.

Rob
