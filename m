Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBFA3C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 18:54:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B810720829
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 18:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589914471;
	bh=fIEq6DFhsxTVEiHlbY6EVVVRHvnCNzJKEOeusLmGMxQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=BQIWTec3kgwhJL9wWIpt7Q983vqZRC1naQx1h+PFPNq5URvVCEwzzVRMgRM+1sV8d
	 oAbWMVMIC3LabMklff251XiXtnf0q9UvsKENeP2w4cX+SkKKYwyc+WVKVtRmYyMJHP
	 tg83KoNZPgQAMUhR5QgWCZWmQDn1Ll24p801OsqQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbgESSyb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 14:54:31 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:46627 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726474AbgESSyb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 14:54:31 -0400
Received: by mail-io1-f65.google.com with SMTP id j8so267270iog.13;
        Tue, 19 May 2020 11:54:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6yvH5f7eUCT+zbMbOyCn4vCw24ZmYs3FmNu5W792pm0=;
        b=qokbVY5ZiZgqiLVY3ZxvT0ij99Y6mdDqNHYEek7OzvrO0xDNDB6pZrWEPN66WJ8i+b
         8VWa5zvts4c+sk1OhHN3RyAy+8yhsfTDkCKD9GdZzaDe6Weh8Aiop7GTSNEoqNif22Vz
         W235Am0hORONUnSbz4cSU32KZ0JK5ePE/wryooaFQ3YTnRrFi/+XVpDDa+IteG3QDOSB
         4rMobPW4/XUbA7lnSDB4FdUc+b81eWkZnlqOI+PQZccGZCKTLsJs1dlUOacMfCXHoCHl
         WKYVcIFJyp7zrniAnHMMB9zkGYPjlzAzJtzVutBox9cfKwsqr1phe3WnKtfOdUoL2sOK
         paTw==
X-Gm-Message-State: AOAM533FG0KFHApzL8eD33by+zj9/EeXezmOR734nCG/NHn4qw+/fS4E
        kf0gyEdN3/HxA51gkDHQRQ==
X-Google-Smtp-Source: ABdhPJwPDjdIGewcxeFramxh57H6SU+K6yPvEAifYkQTl4FsSaib4a/QCfxo70sUCE+/ZCEgwvDkkw==
X-Received: by 2002:a6b:6a13:: with SMTP id x19mr303517iog.175.1589914468730;
        Tue, 19 May 2020 11:54:28 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id 7sm176362ion.52.2020.05.19.11.54.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2020 11:54:28 -0700 (PDT)
Received: (nullmailer pid 468859 invoked by uid 1000);
        Tue, 19 May 2020 18:54:27 -0000
Date:   Tue, 19 May 2020 12:54:27 -0600
From:   Rob Herring <robh@kernel.org>
To:     Grygorii Strashko <grygorii.strashko@ti.com>
Cc:     Santosh Shilimkar <ssantosh@kernel.org>,
        Nishanth Menon <nm@ti.com>, Dave Gerlach <d-gerlach@ti.com>,
        linux-arm-kernel@lists.infradead.org, Sekhar Nori <nsekhar@ti.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCH v4 1/2] dt-bindings: soc: ti: add binding for k3
 platforms chipid module
Message-ID: <20200519185427.GA468784@bogus>
References: <20200512123449.16517-1-grygorii.strashko@ti.com>
 <20200512123449.16517-2-grygorii.strashko@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200512123449.16517-2-grygorii.strashko@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 May 2020 15:34:48 +0300, Grygorii Strashko wrote:
> Add DT binding for Texas Instruments K3 Multicore SoC platforms chipid
> module which is represented by CTRLMMR_xxx_JTAGID register and contains
> information about SoC id and revision.
> 
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
> Reviewed-by: Lokesh Vutla <lokeshvutla@ti.com>
> Reviewed-by: Tero Kristo <t-kristo@ti.com>
> ---
>  .../bindings/soc/ti/k3-socinfo.yaml           | 40 +++++++++++++++++++
>  1 file changed, 40 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/ti/k3-socinfo.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
