Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B713EC2D0F4
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 19:29:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 889A7212CC
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 19:29:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585682977;
	bh=J1ivmXD16ZkXdr1AnGPFh2//lpTQ2ieOl2KYSREmx5g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=XlKgHZ571UmlIkQUWD3wK/WuCk62N0M6zAwszOEVVDnzPPSwLXkN57ueS85V6S4d1
	 OBSkQUBeD7XAtIsL8j9unOV4o4h3+DAKyasMq68EZyJ8rtQQFVcM8GVUK1fP0MSt15
	 cckIUXCKpCpK8h8X7UJS//P525/1tZ/oXMscuFuA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731432AbgCaT3g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 15:29:36 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:37584 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729624AbgCaT3f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 15:29:35 -0400
Received: by mail-il1-f194.google.com with SMTP id a6so20627115ilr.4;
        Tue, 31 Mar 2020 12:29:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ObOJq1WzFHtkZgBcoc/TF7vJW09KReKL6cLNV8fdqDM=;
        b=jIHwIeUUZ0njjkh39zuBhHE0/lmzN2bkvb+lvvG0DZ6qzGoe2SoWqt0gOPTX4J4ts/
         i75mxgc2E9MjLWosdV5b/tfJM//S10YdkEYQPHg8kvU5BmdIBPEAKA3E8gmlot0tTpbB
         W+Z7AaSz37j5YOXRhDo1MzFqy0h7jLUWL3fakS7BPmNau9mAeQVateovINICiVYChJid
         RbVK/n7FSuqL+3jD2v2xzwXRYR/5dt0j4iC12zvAXQ2Oz7Ci4GNu3tMoasS8SkeF3fgV
         skTYBm6e8wjUhODKeZucPxH2Zfql4U9pHEUjgfKEx2BFl9Cf8gvPxqqVj6MVsItV6DvE
         5fBQ==
X-Gm-Message-State: ANhLgQ3NhX19crcXPj5aYgoFw3KO1Gz6AdSU74PQsPVDvG2L6lvZr2Mx
        MSpqkaiYEvvh8CfHtKq0YQ==
X-Google-Smtp-Source: ADFU+vveQIAPsuGoqvWA/0abYxzmeN+7ZOGjnLvYH/Pd7ZBX8SjDAS/lpIBwApsgmlv7Har/ZIo7TQ==
X-Received: by 2002:a92:3a0b:: with SMTP id h11mr18574962ila.4.1585682974301;
        Tue, 31 Mar 2020 12:29:34 -0700 (PDT)
Received: from rob-hp-laptop ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id n6sm5174931iod.9.2020.03.31.12.29.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 12:29:33 -0700 (PDT)
Received: (nullmailer pid 26832 invoked by uid 1000);
        Tue, 31 Mar 2020 19:29:32 -0000
Date:   Tue, 31 Mar 2020 13:29:32 -0600
From:   Rob Herring <robh@kernel.org>
To:     Kun Yi <kunyi@google.com>
Cc:     jdelvare@suse.com, linux@roeck-us.net, mark.rutland@arm.com,
        openbmc@lists.ozlabs.org, joel@jms.id.au,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH linux hwmon-next v2 3/3] dt-bindings: (hwmon/sbtsi_tmep)
 Add SB-TSI hwmon driver bindings
Message-ID: <20200331192932.GA22905@bogus>
References: <20200323233354.239365-1-kunyi@google.com>
 <20200323233354.239365-4-kunyi@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200323233354.239365-4-kunyi@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 23, 2020 at 04:33:54PM -0700, Kun Yi wrote:
> Document device tree bindings for AMD SB-TSI emulated temperature
> sensor.
> 
> Signed-off-by: Kun Yi <kunyi@google.com>
> Change-Id: Ife3285afa4cf8d410cb7bee1eb930dc0717084f9
> ---
>  .../devicetree/bindings/hwmon/sbtsi_temp.txt       | 14 ++++++++++++++

Convert to DT schema format and use the compatible string as the 
filename.

>  1 file changed, 14 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/sbtsi_temp.txt
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/sbtsi_temp.txt b/Documentation/devicetree/bindings/hwmon/sbtsi_temp.txt
> new file mode 100644
> index 000000000000..4020f075699e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwmon/sbtsi_temp.txt
> @@ -0,0 +1,14 @@
> +*AMD SoC SB-TSI hwmon driver.

Bindings are for hardware, not drivers.

Please give a better explanation of what this h/w.

> +
> +Required properties:
> +- compatible: manufacturer and chip name, should be
> +	"amd,sbtsi",
> +
> +- reg: I2C bus address of the device
> +
> +Example:
> +
> +sbtsi@4c {
> +	compatible = "amd,sbtsi";
> +	reg = <0x4c>;
> +};
> -- 
> 2.25.1.696.g5e7596f4ac-goog
> 
