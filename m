Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E62C9C4BA14
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 15:37:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B06F6206E6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 15:37:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582731459;
	bh=+qylfP2svw3GzUbhdzwhFg/ECBTAJnouwsutnI92lf0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=n+Kepprm2+n1cxJbC34KcDTiHbKEaedt0etlnBRgxRdsAMyBl7C+IXZXd7IUFEe44
	 8b7RhQoMhUMKitm4dTxWt+L82YjNRgc3KA61OIE8GnzinG9W0eExhdJb57AbmasoyO
	 fXnGpawnPBN/NiB3cU3ova/VXpxieJiUzbGeSkBU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728335AbgBZPhi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 10:37:38 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:45827 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728014AbgBZPhi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 10:37:38 -0500
Received: by mail-ot1-f68.google.com with SMTP id 59so3282550otp.12;
        Wed, 26 Feb 2020 07:37:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6FzyO6AECYlm7QMzzyrk9pWi96fxzU1V5qZ0EPieTIk=;
        b=NOjztxD6+tbu0i7MJz9NepMaYts6hrnhEl2klJYPTiCa+rdo33kKIu3N7ZD9lNfrB1
         qWbaxGKZD04fa8rdr6x/aXPPurtDZ68P1M4hJcTU+FDLb20pTvsn8eYq7vSu9jk6xtee
         RRqAP/xy+QsMtIzrzQEl8tiEGBxLLdYtL7SO83VsScpFVW43dZTzNDII+zajh81Okow5
         VQ5chuangHVyXWuatYQZV5tnK9o078brASxGTKcaRR/pzX0gJlO7/wsaWddmDWHiotKo
         R+pgufLD84dukBW6hhwc4wVzWsYb+qiCBgS7G4KBOD3acbDbgg8eEUqhKG8uUWLa3zv3
         SpIw==
X-Gm-Message-State: APjAAAVQjgKo0/2KfzTnKFZy6bRlWKikclYiAMz35tTY3+cRE9PHPLp8
        2dIsqvuPB6fOQ9RJgZwLwg==
X-Google-Smtp-Source: APXvYqyLgpMB7D/d5PMJHvcv2asfZGnuMiD3nzHW0Qu43FA9IBj88j6MyezXGcYeLRBnE0xJV0LiHg==
X-Received: by 2002:a05:6830:10d7:: with SMTP id z23mr3555808oto.114.1582731456203;
        Wed, 26 Feb 2020 07:37:36 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id q9sm878846otl.53.2020.02.26.07.37.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2020 07:37:35 -0800 (PST)
Received: (nullmailer pid 17418 invoked by uid 1000);
        Wed, 26 Feb 2020 15:37:34 -0000
Date:   Wed, 26 Feb 2020 09:37:34 -0600
From:   Rob Herring <robh@kernel.org>
To:     Ansuel Smith <ansuelsmth@gmail.com>
Cc:     Ansuel Smith <ansuelsmth@gmail.com>,
        Adrian Panella <ianchi74@outlook.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] regulator: add smb208 support
Message-ID: <20200226153734.GA17365@bogus>
References: <20200219163711.479-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200219163711.479-1-ansuelsmth@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Feb 2020 17:37:11 +0100, Ansuel Smith wrote:
> Smb208 regulators are used on some ipq806x soc.
> Add support for it to make it avaiable on some routers
> that use it.
> 
> Signed-off-by: Adrian Panella <ianchi74@outlook.com>
> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> ---
>  Documentation/devicetree/bindings/mfd/qcom-rpm.txt | 4 ++++
>  drivers/regulator/qcom_rpm-regulator.c             | 9 +++++++++
>  2 files changed, 13 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
