Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03FA3C352A2
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 17:48:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB99022464
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 17:48:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580924913;
	bh=gh2Zw4CvDEAIWdFs9go8qM08zPjmlCx8YzispcE1yfQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=cZ5qqKKVZcrafh2j1OGy8hrByxAoNH5cYwDuhN/CdUIntU2JXMGFUxaEOb/d+czQZ
	 aTQnzhj7UMzMO/PDtRMU5lKw9fTX8HlnB3ig107z18gkLnsZuZlakO+O5h3wKqIS7o
	 mZlaYtPHr/nv6spKvtT09a9bdlYqyfolzVEdOaj0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727361AbgBERsd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 12:48:33 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36589 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726822AbgBERsc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 12:48:32 -0500
Received: by mail-wr1-f66.google.com with SMTP id z3so3847835wru.3;
        Wed, 05 Feb 2020 09:48:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:content-language
         :user-agent;
        bh=Ux3DGzV35dAceVNHrHJKtHoyHks4VBOBKylo/BD3j8A=;
        b=DkfkhCUQJrmGX5V3JIOOSr6LWxJ1zQ/4xCeP6hEV8W73GivRsJdvgwDmpIhVE2maFl
         AoKnXz6XQaztWKLcuZ5APUZqmWExmm1CNBAImbAedj97ugtamOnmabzKEV9E9GcjVFTq
         9LEVItT0WHX/dkaDnGxGYa3zwOod3zbOruhkW3I5auKjOfuHfbS4kKy/4y48OwgStCFN
         Jwz8QRorMN7f7u6IiRqnHRVHKGqngzy5CAtWnjYWAprb/QIYDYR5fsQ9v+6zqKtvESzV
         vJwiAeY4HJucafCb3AyRCyD7/oTZZZgg5r9jDyQX7IQJxGeYUxGFevZ+HEH6X4Ewd/99
         +QyA==
X-Gm-Message-State: APjAAAWgbNt5A3Z35CoG56eUI/zaHfxnZd7bJzBC39PGWwaPf/k68eq2
        J1boJG/8eoZsaWZ5ytnpvg==
X-Google-Smtp-Source: APXvYqyjCgMXX07vCklzfGwfuVFLf+VA2qWHi/2w8y238KZGaDM7SrZW2WawDJsygiDUkK+5I/A/1g==
X-Received: by 2002:adf:dd51:: with SMTP id u17mr28737729wrm.290.1580924911012;
        Wed, 05 Feb 2020 09:48:31 -0800 (PST)
Received: from rob-hp-laptop ([212.187.182.166])
        by smtp.gmail.com with ESMTPSA id b18sm695624wru.50.2020.02.05.09.48.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2020 09:48:30 -0800 (PST)
Received: (nullmailer pid 28035 invoked by uid 1000);
        Wed, 05 Feb 2020 17:48:29 -0000
Date:   Wed, 5 Feb 2020 17:48:29 +0000
From:   Rob Herring <robh@kernel.org>
To:     Shiping Ji <shiping.linux@gmail.com>
Cc:     Borislav Petkov <bp@alien8.de>, James Morse <james.morse@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-edac <linux-edac@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sasha Levin <sashal@kernel.org>, hangl@microsoft.com,
        ruizhao@microsoft.com, Lei Wang <lewan@microsoft.com>,
        Scott Branden <scott.branden@broadcom.com>,
        Yuqing Shen <yuqing.shen@broadcom.com>
Subject: Re: [PATCH v11 1/2] dt-bindings: edac: dmc-520.yaml
Message-ID: <20200205174829.GA27969@bogus>
References: <5354a9c3-5b5a-486a-9d19-fa9be169faef@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5354a9c3-5b5a-486a-9d19-fa9be169faef@gmail.com>
Content-Language: en-US
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Jan 2020 08:23:08 -0800, Shiping Ji wrote:
> This is the device tree bindings for new EDAC driver dmc520_edac.c.
> 
> From: Lei Wang <leiwang_git@outlook.com>
> 
> Signed-off-by: Lei Wang <leiwang_git@outlook.com>
> Signed-off-by: Shiping Ji <shiping.linux@gmail.com>
> Reviewed-by: James Morse <james.morse@arm.com>
> 
> ---
>      Changes in v11:
>          - Fix issues reported by make dt_binding_check
> 
> ---
>  .../devicetree/bindings/edac/dmc-520.yaml     | 59 +++++++++++++++++++
>  1 file changed, 59 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/edac/dmc-520.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
