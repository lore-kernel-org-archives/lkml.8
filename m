Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D8C3C33CB3
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 00:08:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27CCB24673
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 00:08:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579046921;
	bh=wbhPX9Vbp+snlnJ/SyfonoQPcccQXBxTU4uyKfkHh4I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=q3YzrEfzyGesC0e7YWCSnWg9okErfMA3S1A9ls0X80Adf3AAPy0unk6bHcDpZj3YT
	 5uJqWEeWPr6fFvjsuSl97hbMyCyGlpZq9ZkwYFwuyAYZpBOyG06iBmIVnvTEiLEBXf
	 QMfyxcoUDrkTargO2Tm1VnVOJUmJ/qcTGhVSpqfY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728896AbgAOAIk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 19:08:40 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:37890 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728656AbgAOAIj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 19:08:39 -0500
Received: by mail-ot1-f66.google.com with SMTP id z9so12384243oth.5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jan 2020 16:08:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0caRa5XG3dj99WMQy0XFQRo3RUPxiFm3CleZQAkYe78=;
        b=IcbpdA7fht7j1NlslV6zKKdSxqXnLItF2xQGp92KgESCpRErCyiHa82kofV6fHdfUc
         k3wa1Hn78ZORLjp+oz0vsEsoPVqY6edDWz2/n5lY/qPaFgDJbctEi3PHfTUhQ9xA5qjg
         bIRxgzoH0vcf+RTe7ZEtX8TNSxHdBvLZ7Skw1PdlmpZyFqmI/KsbxUk1y7NmEeSedAQL
         bfMpmfXyEckxf/w5s5x7xnQoD/oN+vLgjiKTf8B16p3nhYxl3O15pKJe/+IaVm501GQH
         WP2ej3a3D02lAUbX0ryCAVIhfxV+DWKSodnqzPfp1bjRore15sh/SPJgPK+5erVM47BW
         o3Mw==
X-Gm-Message-State: APjAAAU2BNIkR9Hj0SlqpHGLAX5WYeTfOQzwbKpZUdKqZ3wouLZIUIxI
        yYvmNXBG2Dz63sJOxXghq7O+iRU=
X-Google-Smtp-Source: APXvYqyiQh5RK5HH2Kgk89kiSDZT8GI6ZOMcBt8rWeFsxq7LHU28pmp2iSVKkPdnrEIq/9QrGl+u7w==
X-Received: by 2002:a9d:de9:: with SMTP id 96mr799504ots.222.1579046918871;
        Tue, 14 Jan 2020 16:08:38 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 15sm5111201oin.5.2020.01.14.16.08.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2020 16:08:38 -0800 (PST)
Received: from rob (uid 1000)
        (envelope-from rob@rob-hp-laptop)
        id 2209ae
        by rob-hp-laptop (DragonFly Mail Agent v0.11);
        Tue, 14 Jan 2020 18:08:37 -0600
Date:   Tue, 14 Jan 2020 18:08:37 -0600
From:   Rob Herring <robh@kernel.org>
To:     Andreas Klinger <ak@it-klinger.de>
Cc:     jic23@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        rpi-receiver@htl-steyr.ac.at, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: devantech-srf04.yaml: add pm feature
Message-ID: <20200115000837.GA11941@bogus>
References: <20200109083814.GA5368@arbad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200109083814.GA5368@arbad>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Jan 2020 09:38:16 +0100, Andreas Klinger wrote:
> Add GPIO line and startup time for usage of power management
> 
> Signed-off-by: Andreas Klinger <ak@it-klinger.de>
> ---
>  .../iio/proximity/devantech-srf04.yaml         | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
