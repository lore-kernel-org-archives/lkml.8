Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57C80C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 19:15:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43FB12071E
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 19:15:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598382956;
	bh=/eV/fgHJUQItFUZTZSp83278Y3sIWsfsEMG6RPNtSPg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=v+b+fVBTJzOM/eDXdhFSMm/FsFyD5m0DGUPggRuxO5nqf54tjkhO/wRcTNbeVdzhF
	 OrWVsIFSyL8EOmPdFBRrRI5HRUiyD+WikJ8acLJsiLa32vO0Zg6wHfmzT7OXKJZ2XA
	 vGWgZJuFMXCwgq1+z6f65UxVJ9qO7oR9c8kKa4io=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726779AbgHYTPz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 15:15:55 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:42551 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbgHYTPy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 15:15:54 -0400
Received: by mail-io1-f66.google.com with SMTP id g13so13658159ioo.9;
        Tue, 25 Aug 2020 12:15:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4XX8wc3/JRpkim1j+2JUNKKUtXnfWYfbxiWac/2q+tE=;
        b=Ex3qqW5TBAWr7RuHy3KDKHKdmPPmg6bHlTQEMta7VgVyp/CfHGxzxeZfIHshNjpDBI
         0clii4UuFN0bDOPSfUVWBIJMNkL9Vmzm+Ds4Fs8w8EJ9bZS6lR6uWcbM9eTQTZCyqalE
         p6vPxhxLUaBOfnWt1gJj8G2OvlC6m2JC2R0sFeUGcAS8+W5BmLmQ0w+IGOaBfysV3Xsl
         wIXfcaBhCIqdZMu9k9Ft+qAU3EULt5gwFqXwA3j3cGriNF0840w0RX7kvysS9WFhlmj2
         dJrdwWKlLoHGvyaB+K8eHJEFAxNBcwuXnlSTYO1tde2UXDkaYlQ1qByp+CW32WyJZ0/M
         n0ag==
X-Gm-Message-State: AOAM530ZjshRXJxxXez2TW3R5oa4Vb1XYcEHnJ1lwuyXNxJbrxiLDFSg
        q5+rSxmbqrSaqljhorhXOQ==
X-Google-Smtp-Source: ABdhPJya7bOtWneAGJyNFuSvpzB78bRFjz7WwvHIGRGiD8aNkQdrGL44XodlaT9L8x9Oazvpe5/YLA==
X-Received: by 2002:a02:2b2e:: with SMTP id h46mr11697935jaa.118.1598382952928;
        Tue, 25 Aug 2020 12:15:52 -0700 (PDT)
Received: from xps15 ([64.188.179.249])
        by smtp.gmail.com with ESMTPSA id w13sm9635592ilj.70.2020.08.25.12.15.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2020 12:15:52 -0700 (PDT)
Received: (nullmailer pid 1155009 invoked by uid 1000);
        Tue, 25 Aug 2020 19:15:50 -0000
Date:   Tue, 25 Aug 2020 13:15:50 -0600
From:   Rob Herring <robh@kernel.org>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        sre@kernel.org, r-rivera-matos@ti.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: power: Add the bq25790 dt bindings
Message-ID: <20200825191550.GA1154979@bogus>
References: <20200817151629.11019-1-dmurphy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200817151629.11019-1-dmurphy@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Aug 2020 10:16:28 -0500, Dan Murphy wrote:
> Add the bindings for the bq25790.
> 
> Signed-off-by: Ricardo Rivera-Matos <r-rivera-matos@ti.com>
> Signed-off-by: Dan Murphy <dmurphy@ti.com>
> ---
> 
> v2 - Changed ti,watchdog property, documented the interrupts, fixed exxamples
> for input-current and input-voltage
> 
>  .../bindings/power/supply/bq25790.yaml        | 95 +++++++++++++++++++
>  1 file changed, 95 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/supply/bq25790.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
