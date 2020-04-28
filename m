Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4956DC83008
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 17:45:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20947208FE
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 17:45:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588095959;
	bh=O+eyJ7MHYV5iFBMUTfbdrKFEjVEzKxXbn1GEW9GkDlM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Wm5Z08quc8oQnJ/Fb5IG7ElvHNnU0PNlURgisLlGx60laIoGYBQKv4EVS2K7ObbSc
	 509JbRgvQbutSJhH7E5Q8yamQe5G/OJ1Itv2VoV3o781iL+oKwoRFmURGxrl84EtXF
	 sD+0B0ij+9ai2LCilSbvjPAFhfwqnADS/xhkSyMA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728506AbgD1Rp6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 13:45:58 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:42658 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727074AbgD1Rp6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 13:45:58 -0400
Received: by mail-ot1-f65.google.com with SMTP id m18so34085363otq.9;
        Tue, 28 Apr 2020 10:45:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kfq7SkTW3lVA5fc+b2olv/pWU0aYgh/EgSkA9CMlu98=;
        b=de5laq5Ub2dJ0JSuvzBJyM8He8TFC/KPfARIocyd6D5FrNdMrlI9S3HMcMPOgRGHEJ
         uTJOAt1GY0sgE7TJA/g99Mel9ESlFtDXz6KydUH7dh0Y8AFOlz3mdVsCRcA66GAAO1Wc
         kWjQ2UgUIh7+fVZl64IVaVhvhpdlAU+nWTxZrK+WiuMIbgoDbv3SI34+hSArKXbbTOnY
         DFPzk9IsOxHcCARwMh0DB4zQElhebAlhQrYCnml8LNVOZTDyOxIPudU3Bgv7ZFtkgwKz
         2jFeAX50Sz+ZgMI8TJR0VTi+MbKUHf/M+ZOHbg3vIv0z+GBnakJSLWWwVvYU+rn34+gc
         hTKg==
X-Gm-Message-State: AGi0PuY7vft7eFFln1P6lFXE4TFtLw2/GOWLsJ76ShWNbua9wyFyec3w
        xeXWNX4vjNZ/FSPx7MeFow==
X-Google-Smtp-Source: APiQypJtrp7LL/+MpiiXqU9Hvl+h8GlykGXOiX9VgWlJ70h8yw1o7mJaxioxd7LVbC35iP9gyxGoGA==
X-Received: by 2002:aca:ba88:: with SMTP id k130mr3699905oif.24.1588095957484;
        Tue, 28 Apr 2020 10:45:57 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id k12sm4935752oik.30.2020.04.28.10.45.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2020 10:45:55 -0700 (PDT)
Received: (nullmailer pid 3807 invoked by uid 1000);
        Tue, 28 Apr 2020 17:45:54 -0000
Date:   Tue, 28 Apr 2020 12:45:54 -0500
From:   Rob Herring <robh@kernel.org>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     saravanak@google.com, linux-kernel@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devicetree@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Subject: Re: [PATCH v3 1/2] of: property: Fix create device links for all
 child-supplier dependencies
Message-ID: <20200428174554.GA3739@bogus>
References: <20200420120101.31405-1-nsaenzjulienne@suse.de>
 <20200420120101.31405-2-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200420120101.31405-2-nsaenzjulienne@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Apr 2020 14:01:01 +0200, Nicolas Saenz Julienne wrote:
> Upon adding a new device from a DT node, we scan its properties and its
> children's properties in order to create a consumer/supplier
> relationship between the device and the property provider.
> 
> That said, it's possible for some of the node's children to be disabled,
> which will create links that'll never be fulfilled.
> 
> To get around this, use the for_each_available_child_of_node() function
> instead of for_each_available_node() when iterating over the node's
> children.
> 
> Fixes: d4387cd11741 ("of: property: Create device links for all child-supplier depencencies")
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> Reviewed-by: Saravana Kannan <saravanak@google.com>
> 
> ---
> 
> Changes since v1:
>  - Slightly reword description
> 
>  drivers/of/property.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Applied, thanks.

Rob
