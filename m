Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09ABEC5ACC4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 23:07:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF4C8208C4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 23:07:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AE2QNE8g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727910AbgBSXHL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 18:07:11 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36420 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726736AbgBSXHL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 18:07:11 -0500
Received: by mail-pf1-f194.google.com with SMTP id 185so862780pfv.3;
        Wed, 19 Feb 2020 15:07:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BpAK0N0csT9XJl1pJ8eW/GvQx6cCF5TpsDFna9mb00s=;
        b=AE2QNE8gxUpo3bHMVqtQcs4L+N9lWXeKtm5LmCJfkZzhkaIJlBQX0VH9bAq5AX/+YL
         uYyFfYpZyPnaEuPxasi0sLoX9y+Nk9HVveKC3ZAJLV1yf+vHGxNrM+hKTYVKhqykL+EL
         esguw1AWNPgvn7lLlyOGv13FL5ro9C2lzFCnnNzSUrh0BPcE64oWzQ7AFNx64KmhXWRc
         siQXrdttOcZQQAEHXZATjP+Q28lY1Q51T7ftVEOFbqtX1s/fzwhEA6FTYhPNye0VhG5f
         tuHGkwYVpLxd0sOzkb2mHikW4DOveReM1x4jh5Cv1MhfpuCe0JMqXozpHEDT6y6jqTPz
         JTmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=BpAK0N0csT9XJl1pJ8eW/GvQx6cCF5TpsDFna9mb00s=;
        b=AZHu7C33ePHScoPd3+4LByXMxhGx1tsWMEwcLOfkoTYNA9k6Ct+GlFNMrTlaBxmV1T
         XWSsDLuvu4O+MXgVZRhehNo9eBmhXLCnv+m7GKsb7ZrM0+39zM5PZ2JvvPLbzsjpme2s
         gnLJy/1miyoJBS4hgBlR3XLfo4Q+c07ePevduFbLgdQnJ7mayK1bB1MJnS/elbuIwJLV
         V4Se/t0s8IBz5sH2KENByKwCONTPnhBmIsUBlvm+c6zudNJeBoq5btUMKkceiK/JCKRG
         qDW3DCEoIwytmuhHKUUuNFpWx5q8mVhnDTu7sklwSQjtjDcHYP54h8odT8TmTpDFbOT4
         l4KA==
X-Gm-Message-State: APjAAAWaJN1f3sQ7BA9o4eVTuunp3bb2zhL+6ajS3FTPeUNab1NMD9rO
        Hm8qcEKFWYlYH8IbbxX29/Y=
X-Google-Smtp-Source: APXvYqxh49FcHc52H+qlIHU5UzyGCYcl5LoUbt/n4aWi17VB6tPfgwNwJbgl8bMrgy2O2n9hb78O3A==
X-Received: by 2002:a65:621a:: with SMTP id d26mr29302350pgv.151.1582153630520;
        Wed, 19 Feb 2020 15:07:10 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id j125sm665635pfg.160.2020.02.19.15.07.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Feb 2020 15:07:09 -0800 (PST)
Date:   Wed, 19 Feb 2020 15:07:09 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Henry Shen <henry.shen@alliedtelesis.co.nz>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        guillaume.ligneul@gmail.com, jdelvare@suse.com, trivial@kernel.org,
        venture@google.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: Add TI LM73 as a trivial device
Message-ID: <20200219230709.GA9245@roeck-us.net>
References: <20200212030615.28537-1-henry.shen@alliedtelesis.co.nz>
 <20200212030615.28537-2-henry.shen@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200212030615.28537-2-henry.shen@alliedtelesis.co.nz>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 12, 2020 at 04:06:14PM +1300, Henry Shen wrote:
> The Texas Instruments LM73 is a digital temperature sensor with 2-wire
> interface. Add LM73 as a trivial device.
> 
> Signed-off-by: Henry Shen <henry.shen@alliedtelesis.co.nz>
> Acked-by: Rob Herring <robh@kernel.org>

Applied to hwmon-next.

Thanks,
Guenter
> ---
> Changes in v2:
> - add missing sign-off
> 
>  Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
> index 978de7d37c66..20e6bae68fec 100644
> --- a/Documentation/devicetree/bindings/trivial-devices.yaml
> +++ b/Documentation/devicetree/bindings/trivial-devices.yaml
> @@ -350,6 +350,8 @@ properties:
>            - ti,ads7830
>              # Temperature Monitoring and Fan Control
>            - ti,amc6821
> +            # Temperature sensor with 2-wire interface
> +          - ti,lm73
>              # Temperature sensor with integrated fan control
>            - ti,lm96000
>              # I2C Touch-Screen Controller
