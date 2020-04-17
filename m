Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA763C352BE
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 16:16:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4CC82072D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 16:16:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587140219;
	bh=XtsgZHijijuzZe7pbCMmqmPNOdju+fj2LvLO6lzXAzI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=gujjpoLQgSwEEZya6AmZABt9vTeO+/2HydNJVU1NkXDcFKWqFMzB+jsxJQSMppGPy
	 6Cf5aed9jtBoVheAovam7Tjwk7VjHmUj4dRR2hUhd+ss9I8R227VP982X32hb6pZnI
	 vXx0putxSUhAD/T/+1ZumDFZ9IKzEjooaftnDDiQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730035AbgDQQQ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 12:16:59 -0400
Received: from mail-oo1-f53.google.com ([209.85.161.53]:38867 "EHLO
        mail-oo1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729581AbgDQQQ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 12:16:58 -0400
Received: by mail-oo1-f53.google.com with SMTP id i9so571277ool.5;
        Fri, 17 Apr 2020 09:16:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=n18HlrFzEzddDGYInumpnanTTIeL8cwMsOF4IHAX20k=;
        b=ZsBc4Idx2Rn2GiJ2ruLjzQOxjscl9dPRKpIiRuDeYmCM77ZZpJctK1vNJNIUMWfclF
         bIYeBUXzUJC0K5JLG4q+JJCVhik58ZTRnWkMURCfW3O+/Dsvdmm+QGllyoimZv1cm1ng
         kNIBlAaYFEQhh9Axd7SW7Er6J5UsM747Wfidb+GAoi1/IOAvEznr30b7NqFWvO0VOkuL
         YE4D4Ikz471a+jmpP4o5CFoFs+S6Q0e04lDJv9k13wE/YEKykKdL0QvCssmEiwf/C/mb
         3ot4a6dZpsovWShNfphV9rn5LIB+L9glmrL5F4B5nIUBpZlggoGYrB+eRXouHU1nnqVZ
         u2dg==
X-Gm-Message-State: AGi0PuYYxoiPjQKUGJ9Y4tAqKkR32FF/0bYHZJStVjb+9NX++eIWkQGe
        w2GffWe9+duHdfMJr+utcw==
X-Google-Smtp-Source: APiQypJbw3Petn9wdktbWmJ2xla/a7PdjaDZGC8jQledwof5uDQTF8vX3jEaNAjBtZO247IkQqC/rA==
X-Received: by 2002:a4a:5482:: with SMTP id t124mr3083325ooa.92.1587140216553;
        Fri, 17 Apr 2020 09:16:56 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id i23sm8048489otp.74.2020.04.17.09.16.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2020 09:16:55 -0700 (PDT)
Received: (nullmailer pid 32046 invoked by uid 1000);
        Fri, 17 Apr 2020 16:16:53 -0000
Date:   Fri, 17 Apr 2020 11:16:53 -0500
From:   Rob Herring <robh@kernel.org>
To:     Dinh Nguyen <dinguyen@kernel.org>
Cc:     linux-clk@vger.kernel.org, dinguyen@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        sboyd@kernel.org, mturquette@baylibre.com, robh+dt@kernel.org,
        mark.rutland@arm.com
Subject: Re: [PATCHv7 4/5] dt-bindings: documentation: add clock bindings
 information for Agilex
Message-ID: <20200417161653.GA31608@bogus>
References: <20200415164642.29382-1-dinguyen@kernel.org>
 <20200415164642.29382-5-dinguyen@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200415164642.29382-5-dinguyen@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Apr 2020 11:46:41 -0500, Dinh Nguyen wrote:
> Document the Agilex clock bindings, and add the clock header file. The
> clock header is an enumeration of all the different clocks on the Agilex
> platform.
> 
> Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
> ---
> v7: Fix license to be "(GPL-2.0-only OR BSD-2-Clause)"
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

Please add Acked-by/Reviewed-by tags when posting new versions. However,
there's no need to repost patches *only* to add the tags. The upstream
maintainer will do that for acks received on the version they apply.

If a tag was not added on purpose, please state why and what changed.
