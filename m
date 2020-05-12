Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E721C54E8E
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 02:12:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2988B2071A
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 02:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589249528;
	bh=PVzRHToGk0jwAIcAzV66HkkiRBnnVy9N/wVjUwQVUc4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=gH3NDC48d3tIpCXmdDp2VLH+dvyEtz/mqmDObYiMtW8cnX8MQfBF3l/fe2AtWAqwL
	 4jo7b9joJEpwl/J1CKIOEXMbAOCOmFuLeb0gol7UbO1JmfbRcA2xxK8KFyCiFX+REg
	 eVutfQ0VLJ5W2fDWvYjW/sKAapBU0QuMLqzMrWJg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728605AbgELCMH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 22:12:07 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:33399 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727892AbgELCMH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 22:12:07 -0400
Received: by mail-oi1-f194.google.com with SMTP id o24so16964126oic.0;
        Mon, 11 May 2020 19:12:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=a6FnCmniEb0SZj05Hm52FA7/odoyQ0dRtkEViBqLyQk=;
        b=gFCMk08jK4+HJJmHisoizBRuhbsTZeCEPRBsDlvZUnl8lwLuaYv2APt+Rdfq1cmmsP
         6SKEy/7ASYxoPa3ZKJUv0IKrqMVDMMCIFVkY1SOALbRjL41tzyosDPHO9WYtocgu0iqH
         j9RtLFD5GEdVL7FmS2bVRNQlq2nDFRof5hannXi/SIKjhUaTtFkhINDpPvezZPrLilF0
         shd9UIgUTNgbjC29OAZJNoOHqa9NVOt4e90hn5sQClSGjog1WPD+u0Bx9r92LEAr3SIY
         wi/aCG/VvEl0yzAXyYi/Z0BWePx0Wic3fGLlnp0KQfTpTrKGTluEvIPxSLchkfFhENR/
         lBhg==
X-Gm-Message-State: AGi0PubAkR+oT/fuYFOBvxgEVDk/0BnSODfRw41BEXclNIzXoGxJO3EG
        mBXmW1GuYLMl7tXro0XCOQ==
X-Google-Smtp-Source: APiQypLyUokqa9+HwgdwMV+wpVX5omYrQpTlGxbxo5UJ8ncdqjh4nKtXr+dGUhC/l1K5SQDIn8SHuA==
X-Received: by 2002:a54:4512:: with SMTP id l18mr21349336oil.81.1589249526246;
        Mon, 11 May 2020 19:12:06 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id t6sm3146401otb.27.2020.05.11.19.12.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 19:12:05 -0700 (PDT)
Received: (nullmailer pid 20842 invoked by uid 1000);
        Tue, 12 May 2020 02:12:04 -0000
Date:   Mon, 11 May 2020 21:12:04 -0500
From:   Rob Herring <robh@kernel.org>
To:     Sagar Shrikant Kadam <sagar.kadam@sifive.com>
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        palmer@dabbelt.com, paul.walmsley@sifive.com, atish.patra@wdc.com,
        devicetree@vger.kernel.org
Subject: Re: [RFC PATCH 4/4] dt-bindings: net: phy: extend dt binding for
 VSC8541 ethernet-phy
Message-ID: <20200512021204.GA12999@bogus>
References: <1588072608-7747-1-git-send-email-sagar.kadam@sifive.com>
 <1588072608-7747-5-git-send-email-sagar.kadam@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1588072608-7747-5-git-send-email-sagar.kadam@sifive.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 28, 2020 at 04:16:48AM -0700, Sagar Shrikant Kadam wrote:
> Adding a OUI (Organizationally Unique Identifier) for VSC8541-01
> device to dt node requires a corresponding dt-binding entry as well
> so that checkpatch doesn't complain with a warning:
> 
> DT compatible string "ethernet-phy-id0007.0771" appears un-documented
> 
> Here extend the existing dt binding of VSC8531 device to include
> VSC8541 device example.

Checkpatch.pl is just dumb here and can be ignored. We have the regex 
that documents this compatible. We don't need every VID/PID listed.

> 
> Signed-off-by: Sagar Shrikant Kadam <sagar.kadam@sifive.com>
> ---
>  Documentation/devicetree/bindings/net/mscc-phy-vsc8531.txt | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/mscc-phy-vsc8531.txt b/Documentation/devicetree/bindings/net/mscc-phy-vsc8531.txt
> index 5ff37c6..774448a 100644
> --- a/Documentation/devicetree/bindings/net/mscc-phy-vsc8531.txt
> +++ b/Documentation/devicetree/bindings/net/mscc-phy-vsc8531.txt
> @@ -68,3 +68,6 @@ Example:
>                  vsc8531,led-0-mode	= <LINK_1000_ACTIVITY>;
>                  vsc8531,led-1-mode	= <LINK_100_ACTIVITY>;
>          };
> +        vsc8541_0: ethernet-phy@0 {
> +                compatible = "ethernet-phy-id0007.0771";
> +	};
> -- 
> 2.7.4
> 
