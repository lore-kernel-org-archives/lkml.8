Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E13CC18E5C
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 18:36:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0DEB20727
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 18:36:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583865380;
	bh=2x9OjP/cL989J/BJIl8ZTmdrXYn701P4JDMdpwdKyKc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=KOdTsXLZXZN25KgTSwoXT+AIlQHC4RFSII1cSHjP5ALQyRxF3kxVbjqLpSbYldAJ5
	 PWsPXyu5dMo3+NpzLEVgdcnILqk1fyqEqeIWykAFS34MExmuhjCq2UAsyh0l87SgTI
	 zJFkhjjEulRA6VhAGt0fKsgMTme99T4YW/qFJbdQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727232AbgCJSgT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 14:36:19 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:43907 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726391AbgCJSgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 14:36:18 -0400
Received: by mail-ot1-f67.google.com with SMTP id a6so6273685otb.10;
        Tue, 10 Mar 2020 11:36:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RWBhtEAElv+woAI0B9coW/qcWUrLc+hN8tGBRRi9/8s=;
        b=KzL0Cc2cTGGSj3qjzAhUSqEeOnk1ivJqba8748Famn+YIdUawiC4uLcDT8KRVyX+yU
         VIfN/IwTtsE+dI5olqNVHQtGDoHaHYccQzJRAocYrYMaLo7ackvUWyLgo03YQ9lSaXn7
         nHzTV/rgesOuXcdFD+B8SYhC+7agbbalbonCjqK1AMOf4Cg/Svy4mAUueLZka/RtBcGd
         xCtbMhY7r9SBBIU8Ie/1KecLDLpidggoNbCSsFSqe38YbXQ37w1J4yQKsPS2AKIfNxxy
         9cxWRZ0pDd0TGaH0Riw3feG7n9RbFGURqi2/n1yYmkOUfGy6AULzBx/9g6ybgaNDWLLX
         PAhw==
X-Gm-Message-State: ANhLgQ1EfaAk3JlXxz0t9etC6zcpWIp34e9UibQhYUSmBqNpYEHeJsX/
        pMkq57nDmsj1dfWc3Tm0fg==
X-Google-Smtp-Source: ADFU+vu0ICotI3P1yky6B20yPZmLQBQBsrF3y63sWlL0hNI6+A8JD+ItyEEvuVkvK6xbWwo2T/IxBA==
X-Received: by 2002:a9d:6e90:: with SMTP id a16mr5846143otr.72.1583865377661;
        Tue, 10 Mar 2020 11:36:17 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id c12sm4551332oic.27.2020.03.10.11.36.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2020 11:36:16 -0700 (PDT)
Received: (nullmailer pid 22533 invoked by uid 1000);
        Tue, 10 Mar 2020 18:36:16 -0000
Date:   Tue, 10 Mar 2020 13:36:16 -0500
From:   Rob Herring <robh@kernel.org>
To:     Dinh Nguyen <dinguyen@kernel.org>
Cc:     linux-clk@vger.kernel.org, dinguyen@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        sboyd@kernel.org, mturquette@baylibre.com, robh+dt@kernel.org,
        mark.rutland@arm.com
Subject: Re: [PATCHv2 2/3] dt-bindings: documentation: add clock bindings
 information for Agilex
Message-ID: <20200310183616.GA20350@bogus>
References: <20200309171653.27630-1-dinguyen@kernel.org>
 <20200309171653.27630-3-dinguyen@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200309171653.27630-3-dinguyen@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  9 Mar 2020 12:16:52 -0500, Dinh Nguyen wrote:
> Document the Agilex clock bindings, and add the clock header file. The
> clock header is an enumeration of all the different clocks on the Agilex
> platform.
> 
> Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
> ---
> v2: convert original document to YAML
> ---
>  .../bindings/clock/intc,agilex.yaml           | 79 +++++++++++++++++++
>  include/dt-bindings/clock/agilex-clock.h      | 70 ++++++++++++++++
>  2 files changed, 149 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/intc,agilex.yaml
>  create mode 100644 include/dt-bindings/clock/agilex-clock.h
> 

My bot found errors running 'make dt_binding_check' on your patch:

Documentation/devicetree/bindings/clock/intc,agilex.yaml:  while scanning a block scalar
  in "<unicode string>", line 36, column 5
found a tab character where an indentation space is expected
  in "<unicode string>", line 37, column 1
Documentation/devicetree/bindings/Makefile:12: recipe for target 'Documentation/devicetree/bindings/clock/intc,agilex.example.dts' failed
make[1]: *** [Documentation/devicetree/bindings/clock/intc,agilex.example.dts] Error 1
make[1]: *** Waiting for unfinished jobs....
warning: no schema found in file: Documentation/devicetree/bindings/clock/intc,agilex.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/clock/intc,agilex.yaml: ignoring, error parsing file
Makefile:1262: recipe for target 'dt_binding_check' failed
make: *** [dt_binding_check] Error 2

See https://patchwork.ozlabs.org/patch/1251669
Please check and re-submit.
