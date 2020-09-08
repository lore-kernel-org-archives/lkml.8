Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F557C43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 09:03:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF2712166E
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 09:03:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599555822;
	bh=nWbNo9627PGYZ+fb1NBn9HWm+Sx+3zGpB38MekgqEjA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=s94U6RwfSrlhD8xroyGePUnDwzaWEys8gPfzYcspODNv9MxfMfJGU/FdtBI+orTOH
	 iLKhRwmRv1iytsjiMdL4MjzYjtW6KhvuCO8DN2FSMpaf+EUWwwhoh0fpJAw1kHS796
	 /DRqKWaDY9qRABIgSIJm1PUwAelrDJ0x1+uKSBw4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728632AbgIHJDl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 05:03:41 -0400
Received: from mail-ej1-f68.google.com ([209.85.218.68]:38492 "EHLO
        mail-ej1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728137AbgIHJDj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 05:03:39 -0400
Received: by mail-ej1-f68.google.com with SMTP id i22so21396949eja.5
        for <linux-kernel@vger.kernel.org>; Tue, 08 Sep 2020 02:03:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7vax94Uq5CcS5h993vsrSwAxRr1VYqzINtzJjKdQag4=;
        b=XgVaBHN78V3GZnJpKV86E59JVArxphmwH+fSpA62/4+55TJlMY1DUzQHVK/iz4bV74
         ak5+1UojCHbmsf2ImG9nkWpEROCs/ilCIp0sBIybZBn31cvpdJS2E2m5hYyki5rn2bjs
         GRy5G3kwoHSL4eiChkssxCUSNJuCPojpZ/ks8E7JTqeE1RXlPJ2VpnMb666rq5Ox33+L
         vDc7F9c1vIy+fk+r5QDFOWeibI+k2R+d2X38A/PRUrouj8cAeJdc0MVg1dCptOoQ7kQZ
         Raoe5ik6VfTzVHL2F4qH/TfBFO6OTgiqsTmqaPJoqFzMlcGfMjMO116zHBO8Ia93B9mS
         /CRg==
X-Gm-Message-State: AOAM533CVj/SUnz3wncnGJOI7Cax212zOlhBA5lbj0APH/xlDP7BW6MT
        DyTl3cx8D+Q3aTyXcPDnE1o=
X-Google-Smtp-Source: ABdhPJzsqclzU54ANuoweimcT9uq8KN4Mk0EtvkSr/h/LQM2oEbjXkD+CzIH3You7kmBPHCePs/yIA==
X-Received: by 2002:a17:906:15cc:: with SMTP id l12mr25872760ejd.7.1599555818125;
        Tue, 08 Sep 2020 02:03:38 -0700 (PDT)
Received: from pi3 ([194.230.155.174])
        by smtp.googlemail.com with ESMTPSA id p11sm292860edu.93.2020.09.08.02.03.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 02:03:37 -0700 (PDT)
Date:   Tue, 8 Sep 2020 11:03:35 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Xu Yilun <yilun.xu@intel.com>
Cc:     mdf@kernel.org, linux-kernel@vger.kernel.org, trix@redhat.com,
        matthew.gerlach@linux.intel.com, russell.h.weight@intel.com,
        lgoncalv@redhat.com, hao.wu@intel.com
Subject: Re: [PATCH] add the FPGA Device Feature List (DFL) EMIF support
Message-ID: <20200908090335.GA24693@pi3>
References: <1599553645-26928-1-git-send-email-yilun.xu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1599553645-26928-1-git-send-email-yilun.xu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 08, 2020 at 04:27:24PM +0800, Xu Yilun wrote:
> This patch depend on the patchsets: "Modularization of DFL private
> feature drivers" & "add dfl bus support to MODULE_DEVICE_TABLE()"

The need for bus I understand but why it depends on the "Modularization
of DFL private feature drivers"?

Anyway I will need a stable tag with mentioned dependencies or this will
wait for the next cycle.

Best regards,
Krzysztof


> 
> https://lore.kernel.org/linux-fpga/1599488581-16386-1-git-send-email-yilun.xu@intel.com/
> 
> The driver supports the EMIF controller on Intel Programmable
> Acceleration Card (PAC). The controller manages the on-board memory of
> the PCIe card.
> 
> Xu Yilun (1):
>   memory: dfl-emif: add the DFL EMIF private feature driver
> 
>  .../ABI/testing/sysfs-bus-dfl-devices-emif         |  25 +++
>  drivers/memory/Kconfig                             |   9 +
>  drivers/memory/Makefile                            |   2 +
>  drivers/memory/dfl-emif.c                          | 211 +++++++++++++++++++++
>  4 files changed, 247 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-dfl-devices-emif
>  create mode 100644 drivers/memory/dfl-emif.c
> 
> -- 
> 2.7.4
> 
