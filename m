Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 243E3C35E0C
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 16:58:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F13F22084E
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 16:58:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582649915;
	bh=DGo/7vXc7wiatpJv6gQ6xPlMlzMCjWZPMr1UU6NC1rc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=rg5/AKghJG5N0CURqnEelva44ZtVNd0eBCH/CpNeOjDKAlCRao8mQbxruX1lAd+Lb
	 +hZKrZhhq2AZI5w+iR1YjYqin87V1p+rC+DBWP78K3THH4lPJE8F33V1vrCZ6KdH8L
	 0sKnWe2Pz4eQ5INnYuSkwnQvXJiK5kwpPOGl7834=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731270AbgBYQ6d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 11:58:33 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:42157 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730622AbgBYQ6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 11:58:33 -0500
Received: by mail-ot1-f67.google.com with SMTP id 66so148417otd.9;
        Tue, 25 Feb 2020 08:58:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wNzxWSQ1tQslOmHo/lUe5bvBdq4oBwobAy2UbzGvBWo=;
        b=fABuUEXfhkAeFro2eMHrF4T9C2jBjm36Q0i3TEWTjGbPmd9jt6bkCBNZZJxXfBn5b+
         lGeELu7bzOtSlgjG0J7ikP1UdTxy6NblT+fYAVyuPn89qpXfn0eqOWG3/ghHyKB7dJJp
         DBawZ1wDOS7cHcLOB4TwvAjaRXuysX6dgJeBM53Ht2IOtXT0/iD6O/Zucz8j0ZgRGO7F
         GtOQDrKlE34/P27mn0ItNarKqztx4oj4lgZvs7K/D5LxskWAz4P8E3iyfTBsZGnh0otS
         vFK6jDL/n03jhY6krqoj/j+09SB/LAvDkV/pQpvNZfSrtYA682KAwk1g/YBLy/+ITuO2
         k0pA==
X-Gm-Message-State: APjAAAVjFPLXh3jGAWbRf3OsOFXECH5YrGF9zIea9Ao41F2vpLlWr5mK
        OEJATuh5yD139lMX3QfGRg==
X-Google-Smtp-Source: APXvYqxYc8aMsqeCPYcQYMwiEVntpOoLKEjMX6GCUzuQ/cxMfJsdrK/gcja4ar7em6rX1+95uNQbCw==
X-Received: by 2002:a05:6830:138b:: with SMTP id d11mr42919856otq.38.1582649912141;
        Tue, 25 Feb 2020 08:58:32 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id c7sm5938254otn.81.2020.02.25.08.58.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2020 08:58:31 -0800 (PST)
Received: (nullmailer pid 17603 invoked by uid 1000);
        Tue, 25 Feb 2020 16:58:30 -0000
Date:   Tue, 25 Feb 2020 10:58:30 -0600
From:   Rob Herring <robh@kernel.org>
To:     Dhananjay Kangude <dkangude@cadence.com>
Cc:     linux-edac@vger.kernel.org, bp@alien8.de, mchehab@kernel.org,
        tony.luck@intel.com, james.morse@arm.com,
        linux-kernel@vger.kernel.org, mparab@cadence.com,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        Dhananjay Kangude <dkangude@cadence.com>
Subject: Re: [PATCH 2/2] dt-bindings: edac: Add cadence ddr mc support
Message-ID: <20200225165830.GA16864@bogus>
References: <20200225093856.7328-1-dkangude@cadence.com>
 <20200225093856.7328-3-dkangude@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200225093856.7328-3-dkangude@cadence.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Feb 2020 10:38:56 +0100, Dhananjay Kangude wrote:
> Add documentation for cadence ddr memory controller EDAC DTS bindings
> 
> Signed-off-by: Dhananjay Kangude <dkangude@cadence.com>
> ---
>  .../devicetree/bindings/edac/cdns,ddr-edac.yaml    |   56 ++++++++++++++++++++
>  1 files changed, 56 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/edac/cdns,ddr-edac.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

Documentation/devicetree/bindings/display/simple-framebuffer.example.dts:21.16-37.11: Warning (chosen_node_is_root): /example-0/chosen: chosen node must be at root node
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/edac/cdns,ddr-edac.example.dt.yaml: edac@fd100000: 'ranges' does not match any of the regexes: 'pinctrl-[0-9]+'

See https://patchwork.ozlabs.org/patch/1243950
Please check and re-submit.
