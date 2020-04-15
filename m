Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04C83C38A29
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 14:42:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D92522076D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 14:42:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586961744;
	bh=PAG9Vhu/wdR1VqyO6fTJvVRJwUmrUv2Vfe0zePWlCMM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=yxr+VtEmxjrIHc16YtQI71JIHaPb2KV9C/pjC8YbH9aoiFZTnZD2Tfoww4Ska4y6W
	 IShJ77e2up8GCSF9r1npo9Qq7rFIxlWvwMNVTwIZ7Rx8s59OpBXhcvGeL7/7toSPRZ
	 tSDMYdEM5F44XYFHuSOZnJjy7oRlSS7DsMJkUD0A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2634548AbgDOOmW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 10:42:22 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:38109 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2636734AbgDOOkT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 10:40:19 -0400
Received: by mail-oi1-f193.google.com with SMTP id x21so7423663oic.5;
        Wed, 15 Apr 2020 07:40:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JuvzyUQda56xAYCtJ1sYbNZE0RbPskAoqaEeQtvOFTc=;
        b=Lm1SGHp1ePyVnSm8uGOUhjUuQugLoiqDF3i3pc3v/io2tYwopAXfLGrUZpAlY+KPkR
         uJSRRnxUet1jAUqMYd2vfUbYArisZNOKSznGMKJ3txzgbGXzZqUToUw6ba282wIivcuv
         HwIJ9U2jw1MhSQeIBmqqNfoWdKRx7XWdkLRf6ah0T8QkZp2I7UkkzzvwK/BU2u9vBse/
         IStit7d8gG5MUcXE8HZyvaa0TAqKkzeogmxEsN3x0yFWuP14Qo1MVL/yhZgTjdYG343X
         fNJy/BerqUGIj3lb352rX7ynWqzoVCIgzFC17Y7egIBx59inYMcHfF/2TbpiB5YN5e5u
         QNLw==
X-Gm-Message-State: AGi0PubXUwENK1l3z3uniWGVQS2YRsCjPDgFPUNnK/u7iR9+we2e5I1m
        AyW2SCeWcYW34WXs9UmsZA==
X-Google-Smtp-Source: APiQypKQDJ7OUo2PH72nmsevzWtRJ1xyeW5rr9pORlJ4+DM6LMTt1YQKtYojzR45dQWjeWOKMSmnqA==
X-Received: by 2002:aca:ecce:: with SMTP id k197mr15969614oih.127.1586961617711;
        Wed, 15 Apr 2020 07:40:17 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id y131sm6420487oie.39.2020.04.15.07.40.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2020 07:40:17 -0700 (PDT)
Received: (nullmailer pid 11685 invoked by uid 1000);
        Wed, 15 Apr 2020 14:40:16 -0000
Date:   Wed, 15 Apr 2020 09:40:16 -0500
From:   Rob Herring <robh@kernel.org>
To:     Dinh Nguyen <dinguyen@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, sboyd@kernel.org,
        mturquette@baylibre.com, mark.rutland@arm.com
Subject: Re: [PATCHv6 4/5] dt-bindings: documentation: add clock bindings
 information for Agilex
Message-ID: <20200415144016.GA26244@bogus>
References: <20200406160418.27476-1-dinguyen@kernel.org>
 <20200406160418.27476-5-dinguyen@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200406160418.27476-5-dinguyen@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 06, 2020 at 11:04:17AM -0500, Dinh Nguyen wrote:
> Document the Agilex clock bindings, and add the clock header file. The
> clock header is an enumeration of all the different clocks on the Agilex
> platform.
> 
> Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
> ---
> v6: fix build error by adding descriptions for clocks and reg in
>     properties
> v5: update license to GPL-2.0-only
>     Add additionalProperties
>     Add clock input for clkmgr
> v4: really fix build error(comment formatting was wrong)
> v3: address comments from Stephen Boyd
>     fix build error(tab removed in line 37)
>     renamed to intel,agilex.yaml
> v2: convert original document to YAML
> ---
>  .../bindings/clock/intel,agilex.yaml          | 46 ++++++++++++
>  include/dt-bindings/clock/agilex-clock.h      | 70 +++++++++++++++++++
>  2 files changed, 116 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/intel,agilex.yaml
>  create mode 100644 include/dt-bindings/clock/agilex-clock.h
> 
> diff --git a/Documentation/devicetree/bindings/clock/intel,agilex.yaml b/Documentation/devicetree/bindings/clock/intel,agilex.yaml
> new file mode 100644
> index 000000000000..83bca2661ec3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/intel,agilex.yaml
> @@ -0,0 +1,46 @@
> +# SPDX-License-Identifier: GPL-2.0-only

Dual license new bindings:

(GPL-2.0-only OR BSD-2-Clause)

With that:

Reviewed-by: Rob Herring <robh@kernel.org>
