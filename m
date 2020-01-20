Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88F04C33CB7
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 08:43:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 602362087E
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 08:43:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="musV59sR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbgATInl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 03:43:41 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40220 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbgATInl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 03:43:41 -0500
Received: by mail-wr1-f65.google.com with SMTP id c14so28533972wrn.7
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jan 2020 00:43:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=gifHuIbCmX+R9NDRnITZu82J8BFsOQKVLbmsTjc0e3M=;
        b=musV59sR94nIPfcgLIQtZwLs7/Yv/sT8+U7PToHVQCNBIcL9rnHYPKzK/o72OFGbox
         jC5rDARSf8dVbjGdy1UbybpHRvHUWMVEnAJWJfY/VzyoM70ysvSBCWqNMlraAkrJ8eGO
         UFcbGHGVg2C7GbWXAWgdzcBbK80kqSgtqMC9mfwfNsUffbNzqADCqCqSn9oHEnxXyk2n
         PxwYRMqYfoafCx/frJnKYxhPj/KO5Gwc3r4Jg9XBiSpOfSupaGCRbAYKNcSs1kmUiGUD
         yuAit4UfcbMIbIdFYnIZfY59dbcgkaoQKR1W+VD8uNGNVebbWne7xwRuhiywuw78zJNQ
         S+mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=gifHuIbCmX+R9NDRnITZu82J8BFsOQKVLbmsTjc0e3M=;
        b=G5TloesDjqi8SEVlQbxNwocdPLNPqnb6Nr67kqZfih1y98fTDCyaRWqGq3BMXVMBgB
         7DnncFKT8Qtf0+kf9SxI1+DMzU6WlKK5aZzCbR8KkzrXSuRKQCmkNWB7SzTf69YVPuxg
         lLO8SdAeNEuNfIkILwjB8MNJE1CQd/TadA6yZrzNhpb9gS7boEv+40aQbLXzC0eTMrWO
         Kra7t5u6zptXfspCbmKAX2yRq6pGaARoG6lAy9h8cwPdpUmz3CfRfQ4e8peoB5wswfBI
         +FnyfO6j3rhONrxsqsy4eNrmOIR/0rcm/p8gI9zsnpT7IErlFeV26Ix/cS0mw2VJSHjT
         GbGw==
X-Gm-Message-State: APjAAAU9WK+VPQoa1d05Mq2UU8bLp68Qo7Y/gXLwN072Rlr0HCgzNgao
        sNfYR81XAFZOfffTLroOBJR9yA==
X-Google-Smtp-Source: APXvYqy+rWDfjjYcUJ9qyGjk1MjXcoc+KJXJZXfExAHNyyprH+X8jUuldYdSqr6JOsriaYepWzKiNA==
X-Received: by 2002:adf:df03:: with SMTP id y3mr17198094wrl.260.1579509819402;
        Mon, 20 Jan 2020 00:43:39 -0800 (PST)
Received: from dell ([2.27.35.227])
        by smtp.gmail.com with ESMTPSA id n16sm47472001wro.88.2020.01.20.00.43.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2020 00:43:38 -0800 (PST)
Date:   Mon, 20 Jan 2020 08:43:55 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Wen Su <Wen.Su@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Mark Brown <broonie@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        devicetree@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, wsd_upstream@mediatek.com
Subject: Re: [RESEND 1/4] dt-bindings: regulator: Add document for MT6359
 regulator
Message-ID: <20200120084355.GW15507@dell>
References: <1579506450-21830-1-git-send-email-Wen.Su@mediatek.com>
 <1579506450-21830-2-git-send-email-Wen.Su@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1579506450-21830-2-git-send-email-Wen.Su@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Jan 2020, Wen Su wrote:

> From: Wen Su <wen.su@mediatek.com>
> 
> add dt-binding document for MediaTek MT6359 PMIC
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Wen Su <wen.su@mediatek.com>

These are in the wrong order.  Tags should describe history, thus
should be in chronological order.  For instance, the ordering you used
describes Rob reviewing the patch *before* you sent it, which is not
possible.

> ---
>  .../bindings/regulator/mt6359-regulator.txt        | 59 ++++++++++++++++++++++
>  1 file changed, 59 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/regulator/mt6359-regulator.txt

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
