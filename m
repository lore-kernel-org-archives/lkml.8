Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99A37C33CAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 19:59:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 648D2217F4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 19:59:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579636768;
	bh=E7/VCyBFhCbz5FGCj9d8OMTv1zgCqlkuq6Vg9ZHEQpA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ybOwpOj5xWf6oxhUyU0uio5jpviNUZSYESXCtVSWt+ARVXonhKM7SKAQqDKtY/P1b
	 H0hw5KW7+JHHq0UO3WAUuy5cbPiNAW6PyWcstoFiWt5d6t/o77b2QDh+rbsnxhNdNC
	 eNAvMnc4RLu8asxtPLbBY/eRTnVWHkLzG7Qw9Izg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728767AbgAUT71 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 14:59:27 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:33866 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727350AbgAUT71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 14:59:27 -0500
Received: by mail-ed1-f67.google.com with SMTP id l8so4336189edw.1;
        Tue, 21 Jan 2020 11:59:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yLP2mrDM4GzvFszqzHvSuZS42R+DLtGroTOxaZ4xrnA=;
        b=OtccDkpbgxKsPNIJesVARemnG9HHHmKD5ubxyasWPhVWSIe1uDoPSm0HecUO0CQV2H
         esVxcd0FRtR36D49JASKAkvZx+dS4TcELkFLzg/ni4Djj9GTP8EEvjtbdY2VbTDiY40D
         cACHzcYPBLBH/flI1puzmOi0g2sPFaRn59Q8Az0/2+Uz5k8rdYuiR3IwajGns271IrZx
         P3Wdxs2IRPxfW1iogBR/+NExxYyeBMiCypGorLCfOmAXgfV1yiXx2g1rUBdG1/UZNZ46
         I4hxdjmu2LqIaql65ym7zviUb+Dhvah19nyrSDEJWqugh+tWV8ykWajswgr3WXG/jR2L
         VbGA==
X-Gm-Message-State: APjAAAX/dWRyL2EXjmk4b0Gf24UC6WvGMU1fkxY8NU+f//1ESUML+qK3
        jof7pw02PH2nU69DYh/3Hdg=
X-Google-Smtp-Source: APXvYqx8qpPI7rbjj7PMeTabytp7AQsKM7Q19VB32tG5zAWX+KB8OyA/6QmSuzDcmfSZD5PHOZ0eMA==
X-Received: by 2002:a17:906:cccf:: with SMTP id ot15mr6127734ejb.7.1579636765312;
        Tue, 21 Jan 2020 11:59:25 -0800 (PST)
Received: from kozik-lap ([194.230.155.229])
        by smtp.googlemail.com with ESMTPSA id ay8sm1258847ejb.6.2020.01.21.11.59.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 21 Jan 2020 11:59:24 -0800 (PST)
Date:   Tue, 21 Jan 2020 20:59:22 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Arnd Bergmann <arnd@arndb.de>, Kevin Hilman <khilman@kernel.org>,
        Olof Johansson <olof@lixom.net>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kukjin Kim <kgene@kernel.org>,
        linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH 19/20] ARM: s3c64xx: Drop unneeded select of TIMER_OF
Message-ID: <20200121195922.GB24380@kozik-lap>
References: <20200121103413.1337-1-geert+renesas@glider.be>
 <20200121103722.1781-1-geert+renesas@glider.be>
 <20200121103722.1781-19-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200121103722.1781-19-geert+renesas@glider.be>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 21, 2020 at 11:37:21AM +0100, Geert Uytterhoeven wrote:
> Support for Samsung S3C64XX systems depends on ARCH_MULTI_V6, and thus
> on ARCH_MULTIPLATFORM.
> As the latter selects TIMER_OF, there is no need for MACH_S3C64XX_DT to
> select TIMER_OF.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Kukjin Kim <kgene@kernel.org>
> Cc: Krzysztof Kozlowski <krzk@kernel.org>

Thanks, applied.

Best regards,
Krzysztof

