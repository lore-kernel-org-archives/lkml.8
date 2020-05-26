Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 406B1C433E2
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 16:09:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DF6120776
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 16:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590509360;
	bh=o7X0LsAaef0eoYFS70zUdJBxKV3nil2kjKPUkH9WY1o=;
	h=Date:From:To:List-Id:Cc:Subject:References:In-Reply-To:List-ID:
	 From;
	b=qqTOE2LygCx3/aNOts27ERqzD+4bJ9PckabFUJlf533Q+w8NnNH5AGU2RkoSSi/9l
	 jgeqtXKcSUHc2M8MtSKN4cKI2k0/4WoxvSLmhxe/9PJxe647KxSDRFtQxLzGZwUBip
	 uSyWWeHGwytpSWT5RC+CoibKIJ08lBYKbDTbQdvE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388547AbgEZQJT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 12:09:19 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:45641 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388373AbgEZQJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 12:09:18 -0400
Received: by mail-il1-f193.google.com with SMTP id 9so2502948ilg.12;
        Tue, 26 May 2020 09:09:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=c24TAX9eZkc7nqjyxn5z29SNHBuSwFKeXoaN8/HMgWM=;
        b=BOKcq9MVzpqsRNqbPPEpOGRiKL2QlTuH0xPCM7yIqK/63A0Gg6NE5fJqnC58CTg2Pq
         nakFyPPNOoFlyfS9OEPTSO5ahPaJc+gtM7xu44+YRLZukyqz22MHB/taSOlF2u7o7r3/
         EmsaJb28exzyWgstLl7AdvCqsS14V2Mx9OzCjJd2aEQ83KDjjbpD3tk0VhVzsm5zTPCx
         8YUJ6PbZmVgBRvfg++3mY7zcaRwsXhP2/3D2iXnEZ14QcKDO+UMj5xeK83fc9mqmGy3u
         2vaJyOFx9dd42TEL1dPM1w4mOv8MwbVdgGw/tHdzQzFi0j5I0TQFxKV9cCWFFHJQpKEM
         bxxA==
X-Gm-Message-State: AOAM530Xul+I/5NE35zMpY2amYIs73HDA/dFwTDzlO3+Vb9rbXMTXMuD
        uX7Gdd+gsD4zH70rk/T3nw==
X-Google-Smtp-Source: ABdhPJxwr3dqawH8+SWnEPm4Q2+Tuopm79dpOC3bN7jhQKABwVvB5cM1bK2uK6nYRp1kjDtiZ6fg5w==
X-Received: by 2002:a92:d6cc:: with SMTP id z12mr1742481ilp.179.1590509357261;
        Tue, 26 May 2020 09:09:17 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id w26sm221173ill.19.2020.05.26.09.09.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2020 09:09:16 -0700 (PDT)
Received: (nullmailer pid 4042318 invoked by uid 1000);
        Tue, 26 May 2020 16:09:15 -0000
Date:   Tue, 26 May 2020 10:09:15 -0600
From:   Rob Herring <robh@kernel.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
List-Id: <soc.lore.kernel.org>
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-mips@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>, soc@kernel.org,
        Paul Burton <paulburton@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 3/6] dt-bindings: memory: Add Baikal-T1 L2-cache
 Control Block binding
Message-ID: <20200526160915.GA4042264@bogus>
References: <20200526125928.17096-1-Sergey.Semin@baikalelectronics.ru>
 <20200526125928.17096-4-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200526125928.17096-4-Sergey.Semin@baikalelectronics.ru>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 May 2020 15:59:25 +0300, Serge Semin wrote:
> There is a single register provided by the SoC system controller,
> which can be used to tune the L2-cache RAM up. It only provides a way
> to change the L2-RAM access latencies. So aside from "be,bt1-l2-ctl"
> compatible string the device node can be optionally equipped with the
> properties of Tag/Data/WS latencies.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> Cc: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
> Cc: Paul Burton <paulburton@kernel.org>
> Cc: Olof Johansson <olof@lixom.net>
> Cc: linux-mips@vger.kernel.org
> Cc: soc@kernel.org
> 
> ---
> 
> Changelog v2:
> - Move driver to the memory subsystem.
> - Use dual GPL/BSD license.
> - Use single lined copyright header.
> - Move "allOf" restrictions to the root level of the properties.
> - Discard syscon compatible string and reg property.
> - The DT node is supposed to be a child of the Baikal-T1 system controller
>   node.
> 
> Changelog v3:
> - Get the reg property back even though the driver is using the parental
>   syscon regmap.
> - The DT schema will live separately from the system controller, but the
>   corresponding sub-node of the later DT schema will $ref this one.
> - Set non-default latencies in the example.
> ---
>  .../memory-controllers/baikal,bt1-l2-ctl.yaml | 63 +++++++++++++++++++
>  1 file changed, 63 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/memory-controllers/baikal,bt1-l2-ctl.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
