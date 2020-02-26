Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B3A4C4BA15
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 15:28:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A0742467D
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 15:28:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582730898;
	bh=V++DApnVvdwDrcB3LTIWlQFts2Uje0dnQZFG+S9Qfl4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=VjoBukKi5g+qTNFotHQHdVAg1TPUEz/OVtg10QVyWXRto7CZhsGcLDLL8DwdSbFVP
	 P9tWJzjw1OmfkxNxrD0dN++ipfP33tnIKqiJGcleo9cuZRftnoqrE2n7oTmliJfKKg
	 dDqaGJS6ALeoYLjZpItQJXPCsOfOV4TIMN1stqxQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728132AbgBZP2R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 10:28:17 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:45806 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726148AbgBZP2Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 10:28:16 -0500
Received: by mail-ot1-f68.google.com with SMTP id 59so3250585otp.12;
        Wed, 26 Feb 2020 07:28:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=a9rZZe0L1NxPawlPYOzTIFGXo7NCP4X/kbRAjcuDymA=;
        b=e5QcnTjFhwXf4MCP8R/eVsEOW4NiwsAxik9lFditHhd1ZQ3J/W/NPHmrVb8GyTbUwh
         QsiEKiLgsYIKJ5KwF8ut1s0pkS3pAQ5CtLtB+xS852Eljr3fJm+ctrw8c+TLQVpI/fYp
         1DQyZ/vXrzLnzpMu6XIC57OEGtg1Crj6uOrMosJ1RbRUFtiQC8Zgaz0CleLGs1QJ0Acg
         Edckn+7JRcOXc79S47+5Ex5+EzuLxtQmu2nEl9ktrvD3QC1lSOwBlVufsGN2xoZx2qfq
         RA1gr8qjCqPYhcU7VYwDO1y4BeGOXa4EdC6Zv/DeF+xgef5mE5eW94aqCy55uWVrrGuO
         rurw==
X-Gm-Message-State: APjAAAXBMUgfXXHGrUzAxxrpelLjXnVpodA5ooLvAZHbyVZX2yjzoRMK
        9cIxgDRRj7bIVp9ImzlGxg==
X-Google-Smtp-Source: APXvYqwZ3XlmubdKEg9c/y0IXymM4dIMk5vVK9Zt1kLDjlGgX7KXKA9TIZ8VZho3mGt96KPTVpHDLg==
X-Received: by 2002:a05:6830:1317:: with SMTP id p23mr3519055otq.3.1582730895795;
        Wed, 26 Feb 2020 07:28:15 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id i7sm907560oib.42.2020.02.26.07.28.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2020 07:28:15 -0800 (PST)
Received: (nullmailer pid 3059 invoked by uid 1000);
        Wed, 26 Feb 2020 15:28:14 -0000
Date:   Wed, 26 Feb 2020 09:28:14 -0600
From:   Rob Herring <robh@kernel.org>
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Mark Rutland <mark.rutland@arm.com>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Lubomir Rintel <lkundrak@v3.sk>
Subject: Re: [PATCH 03/10] dt-bindings: clock: Convert marvell,mmp2-clock to
 json-schema
Message-ID: <20200226152814.GA2965@bogus>
References: <20200219073353.184336-1-lkundrak@v3.sk>
 <20200219073353.184336-4-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200219073353.184336-4-lkundrak@v3.sk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Feb 2020 08:33:46 +0100, Lubomir Rintel wrote:
> 
> Convert the fixed-factor-clock binding to DT schema format using
> json-schema.
> 
> While at that, fix a couple of small errors: make the file base name
> match the compatible string, add an example and document the reg-names
> property.
> 
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> ---
>  .../bindings/clock/marvell,mmp2-clock.yaml    | 62 +++++++++++++++++++
>  .../bindings/clock/marvell,mmp2.txt           | 21 -------
>  2 files changed, 62 insertions(+), 21 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/clock/marvell,mmp2-clock.yaml
>  delete mode 100644 Documentation/devicetree/bindings/clock/marvell,mmp2.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
