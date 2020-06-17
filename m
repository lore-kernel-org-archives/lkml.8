Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDCBDC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 22:14:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8AC02184D
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 22:14:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592432059;
	bh=/270UX6h2k5gxPi06yMqpjAVFVEu5xKU10OxRUn3RMw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=S/JVnmLHHY0gHjaEVqKsrDpmvlTd0nGBP6+uOVoCzyi469Q47I+R/NIRh1ua6bA3A
	 p0aJYG+CkclFcgxWzbWxsJ+EnO3eZJ0PT+U+SqZ3gaXJZ4jIWYphJAXa0yx6TqrrFy
	 VzQaU2lmcQ8jxsRFBbRWJt5qX+hpAG3rDAYrIcGU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727853AbgFQWOS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 18:14:18 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:46042 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726840AbgFQWOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 18:14:16 -0400
Received: by mail-io1-f68.google.com with SMTP id y5so4738827iob.12;
        Wed, 17 Jun 2020 15:14:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DRXryslTGLkMJqQMxB14CHKUq6hyTDjdoN304utJi9Y=;
        b=A86biCGZ7pKnsRQEEStEZdz59LmUrWX+8fti3y48EXk5NieYJgoOZwPz0+aUeZ3CI5
         KD6NpsHz1v8LyLsGZ1N5YGJAHhiJzbUO6cnnoBHYSNOSQpNVuQCXfkzaQQjBeH5UTImY
         p2rN+lJywhel8QhIpBNXmz0Hc37bJNPFHiLM5j4n8YrmGbir27yusQzTlnj04LLvUoXN
         LJXcPSiYiMqct+CI0ogCwfNs709/T2Ehe7K1L9YldBL2emq9sIot8EJ8RObPlRdR7WL9
         DZNwDlIJVnU27XPghZovC5UVMpEVyGX/bRvTHOHKdC5lIiCl7UI6Mycu9kjhcTeDtmuX
         Nlpg==
X-Gm-Message-State: AOAM532zcyyOqjEJ/MP0hZQ91tKgA8sb3rImTeDNXXpgEAfFScO+XMrR
        2yegpUmVNZb0ha4PqTD65g==
X-Google-Smtp-Source: ABdhPJz7QUutK4RE5S/N61ajEcfcIYnRVvw0B0Br3nuAULonfWSMZqjN0BZ4yZD6EFLd0+qnRQpNQQ==
X-Received: by 2002:a05:6638:35d:: with SMTP id x29mr1434644jap.71.1592432054953;
        Wed, 17 Jun 2020 15:14:14 -0700 (PDT)
Received: from xps15 ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id f1sm494482ilh.17.2020.06.17.15.14.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 15:14:14 -0700 (PDT)
Received: (nullmailer pid 2927550 invoked by uid 1000);
        Wed, 17 Jun 2020 22:14:11 -0000
Date:   Wed, 17 Jun 2020 16:14:11 -0600
From:   Rob Herring <robh@kernel.org>
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     thierry.reding@gmail.com, jonathanh@nvidia.com, frankc@nvidia.com,
        hverkuil@xs4all.nl, sakari.ailus@iki.fi, helen.koike@collabora.com,
        digetx@gmail.com, sboyd@kernel.org, gregkh@linuxfoundation.org,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-i2c@vger.kernel.org
Subject: Re: [RFC PATCH v1 10/18] dt-bindings: tegra: Document VI and CSI
 port nodes
Message-ID: <20200617221411.GB2923473@bogus>
References: <1591768960-31648-1-git-send-email-skomatineni@nvidia.com>
 <1591768960-31648-11-git-send-email-skomatineni@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1591768960-31648-11-git-send-email-skomatineni@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 09, 2020 at 11:02:32PM -0700, Sowjanya Komatineni wrote:
> This patch documents Tegra VI and CSI port and endpoint nodes along
> with the other required properties.
> 
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> ---
>  .../display/tegra/nvidia,tegra20-host1x.txt        | 87 ++++++++++++++++++++++
>  1 file changed, 87 insertions(+)

This is getting converted to schema by Thierry.

Rob
