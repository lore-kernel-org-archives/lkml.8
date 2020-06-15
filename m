Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A139C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 07:01:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09D5B2067B
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 07:01:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592204481;
	bh=x4Ev22nhPalVqenzG5qzq4QYBmgz0XdOBTrw7lUAUnU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=KFTLq9cIcRUPr1MzcoVgQxKnviIKlswMokd7nzQ4finWxhENrQmJgS1ah/xV8pDHn
	 Z9A/2W5XIRb8J1AzZmGqXqCcgVGzjMUESGLekmjMEX231KQhuCnh3zxn4wfZbj7pdZ
	 jTAhkP+9MKykLKCUDnx4UgjtlyKr1/w3eoI/8A04=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728485AbgFOHBT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 03:01:19 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52903 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728251AbgFOHBR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 03:01:17 -0400
Received: by mail-wm1-f65.google.com with SMTP id r9so13460244wmh.2;
        Mon, 15 Jun 2020 00:01:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=d+1OnnysUnKg4jMyBhqBvZrm+ah/+8kX402EPutOz1A=;
        b=JllVhaL98mJL98nejei7nBR7DbW+qxA6Q+ui/GBWgSshE228pjitxB4n3k9mSWmXgf
         KnsbB9CFsCz6BRiOUs4XDNefQcv+lEJHQxRjNnx8IskY/fCIe7riVVgHn8t+4zwBeHVB
         ZuGFJ6Ye3axN/W46+PwWeSPXxQ1knA2/Ajv97XzU9rPmtTMIXV4bPuQvDnP7ufiOe/iK
         YxH3Dmf3KlBE/Fg/qc8HIQVYukx4XYxpoqNYTJLSD6U5CkEbyvYpd5fbAlhUk2vV4fbn
         yUp4oTKTQFd2LPkPe8L6olyPFWKjHK+tcSLZSrTI9MP8W4aOHkZR931ehgHDWTarvRua
         pd6A==
X-Gm-Message-State: AOAM532f7CoNUCYKDgfDW0VAam5U8NbTBzaUup4G0vRDuuGsCeHvx11I
        Ecg9BtKOktvkFVofJB+ORrg=
X-Google-Smtp-Source: ABdhPJyTeU+ed7tcTTzbrEUnEFBdJrmWBvV3QvLccvfrTwEv7TiwWhG5hsiP8890W2HDdEmMKLZVYA==
X-Received: by 2002:a1c:9acf:: with SMTP id c198mr11474242wme.172.1592204475584;
        Mon, 15 Jun 2020 00:01:15 -0700 (PDT)
Received: from kozik-lap ([194.230.155.184])
        by smtp.googlemail.com with ESMTPSA id v27sm25361523wrv.81.2020.06.15.00.01.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Jun 2020 00:01:14 -0700 (PDT)
Date:   Mon, 15 Jun 2020 09:01:12 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Jonathan Bakker <xc-racer2@live.ca>
Cc:     kgene@kernel.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] ARM: dts: s5pv210: Improvements for Aries boards
Message-ID: <20200615070112.GA23304@kozik-lap>
References: <BN6PR04MB0660787FD651F80CD0C22C2BA39E0@BN6PR04MB0660.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <BN6PR04MB0660787FD651F80CD0C22C2BA39E0@BN6PR04MB0660.namprd04.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 13, 2020 at 11:44:22AM -0700, Jonathan Bakker wrote:
> A couple of new drivers have now been added, so we can add support for
> them in the device tree for Aries.  These are the accelerometer (bma023)
> and the light/proximity sensor (gp2a).
> 
> Additionally, the fuelgauge definition was wrong as there is no interrupt
> support on the galaxys.  The bluetooth definition also had some issues
> with it.
> 
> There is one change to the common s5pv210 dtsi and that is that the gph3
> bank was missing the interrupt-controller property.
> 
> Jonathan Bakker (5):
>   ARM: dts: s5pv210: Add interrupt-controller property to gph3
>   ARM: dts: s5pv210: Correct fuelgauge definition on Aries
>   ARM: dts: s5pv210: Add support for GP2A light sensor on Aries
>   ARM: dts: s5pv210: Add BMA023 accelerometer support to Aries

Thanks, applied entire set.

Best regards,
Krzysztof

