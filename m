Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00113C54E8E
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 14:18:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2230206D3
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 14:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589293117;
	bh=uE+0mI4HOJHfvUrEj0x1JKycYetQgyV0lV8D2/7r7mI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=mpakozV603SyRJ+6fVij8kxlAeimNgKe54QRp9L8U+qil9qQsJOQaGP6mJJAiQ1v/
	 l55yCDUougm5s2obyHlNa7wG2al/+Xw1Om2OQIt1R55JhDo1q98UHYhSbB9IJzCt0u
	 UNSdMmWnuA5si6lZpw24Wp+4eZQxubmJimiHXpOY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730193AbgELOSh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 10:18:37 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:41804 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729583AbgELOSg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 10:18:36 -0400
Received: by mail-ot1-f66.google.com with SMTP id 63so3217307oto.8;
        Tue, 12 May 2020 07:18:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zfs2hAY/NiesXQzcF+Dz6T3qLZIhaZ4TvR72I/v5n/4=;
        b=h4I/ZMjOPHZt6LML5siOmRpUkWdNabnSPAaDTdnaPzDH93/vzLEx+q063UvNQLXiz5
         UdZK9l0yKantT3PpIQF9EqrrGtyevLJIC1XONWQVSUsySH0s7fYwLMj6NiV39qBZHBIM
         kz91C/WykGPGz0uKojJMImQul+77jvsMuKDMCZUdf3KKJqe577BqrlusnPownpp2SCV/
         IEqcJYEDAc9RJDNPdA/lBsY/UnK0kk+rpxK4FjSZXLObsTy+STFzSsZMb369KDDDZdPv
         XbUOf1jr0v8iBTzPv1zecj0n4FkHTa1dphbygqTkOnIwBBPIegqxGjDJvliPqGWFWWRr
         BVqw==
X-Gm-Message-State: AGi0PuaJWanz9roT3/TG5SwHBIdz14EMNM7y11U8NdNEtnpswheCR02B
        Mj5qu/6aDqZcsFvrWv2b+CEloBSU9g==
X-Google-Smtp-Source: APiQypK7ywar5BYmiexHrXYIk47tsu1t0a/sBmW76o29L0I4ng8de/0MFHPvPlf+dPXqm0l78vRDRw==
X-Received: by 2002:a9d:51c4:: with SMTP id d4mr15829366oth.249.1589293115368;
        Tue, 12 May 2020 07:18:35 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id d10sm592500ote.10.2020.05.12.07.18.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2020 07:18:34 -0700 (PDT)
Received: (nullmailer pid 9519 invoked by uid 1000);
        Tue, 12 May 2020 14:18:34 -0000
Date:   Tue, 12 May 2020 09:18:34 -0500
From:   Rob Herring <robh@kernel.org>
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc:     linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        ceggers@arri.de, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 0/2] nvmem: skip nodes with compatibles other than
 "nvmem-cell"
Message-ID: <20200512141834.GA3023@bogus>
References: <20200428111829.2215-1-a.fatoum@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200428111829.2215-1-a.fatoum@pengutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 28, 2020 at 01:18:25PM +0200, Ahmad Fatoum wrote:
> The nvmem cell binding applies to all objects which match "^.*@[0-9a-f]+$",
> without taking a compatible into account. This precludes extension of e.g.
> eeprom nodes by any child nodes other than nvmem. Consider following example:
> 
> 	eeprom@0 {
> 		reg = <0 64>;
> 		#address-cells = <1>;
> 		#size-cells = <1>;
> 
> 		partitions {
> 			compatible = "fixed-partitions";
> 			#address-cells = <1>;
> 			#size-cells = <1>;
> 			bits = <64 64 64>; /* to verify it's skipped */
> 
> 			part@0 {
> 				reg = <0x00 16>;
> 			};
> 		};
> 
> 		no-cell@10 {
> 			compatible = "not-nvmem-cell";
> 			reg = <0x10 4>;
> 			bits = <64 64 64>; /* to verify it's skipped */
> 		};
> 
> 		cell-old@14 {
> 			reg = <0x14 0x2>;
> 		};
> 
> 		cell-new@16 {
> 			compatible = "nvmem-cell";
> 			reg = <0x16 4>;
> 		};
> 	};
> 
> Without this series, the NVMEM driver interprets all direct children of eeprom@0
> as NVMEM cells and driver probe fails, because the partitions node lacks a reg
> property, e.g.:
> 
>   nvmem 0-00000: nvmem: invalid reg on /eeprom@0
> 
> Running dtbs_check on the snippet will skip partitions (it doesn't match above
> regex), but will flag no-cell@10 and cell-new@16 as invalid.
> 
> With this series applied, the driver will skip partitions and no-cell@10,
> because they have a compatible but it's not "nvmem-cell".

Because you have to support no compatible (forever), there's no point 
adding this compatible.

> Both cell-old@14 and cell-new@16 will be interpreted as cells.
> 
> Likewise, running dtbs_check on the snippet will skip partitions (compatible
> doesn't match and regex doesn't either) and no-cell@10, but accept the other two.
> 
> This series resolves an existing clash between this nvmem-cell binding and
> the barebox bootloader binding that extends the fixed-partitions MTD
> binding to EEPROMs[1]. It's also a building block for getting nvmem cells and
> partitions in MTD devices to co-exist in the same device tree node[2].

This violates having multiple nodes at the same address because you are 
independently overlaying partitions and nvmem cells on same address 
ranges. It also seems seems pretty fragile if you want to update 
partitions.

I think instead, nvmem cells should be contained within a partition. 
The partition should then have a compatible to indicate it contains 
nvmem cells.

Rob
