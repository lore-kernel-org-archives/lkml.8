Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF7EEC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 21:06:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BAE682070B
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 21:06:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595883998;
	bh=5+wHYJPlY9xxvgLgFrkKK/xLgayG7gm3nVIlU9PmVcU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=PQMaVl8oWfbYFq5JnWfFHeL6NNtQ8GmB8d3E4tlAHQuauLAYT9w5dtTC8lPF0fAy5
	 Gj5SvK5hk9afwqxWtjfDJ7BcQzHZIbkrTRAUTZvbJeLcE4qmsEtgCELZqNiznnVIhl
	 6IWNulGM/b62NleGoT23awgF/oTCXym7viR3Ynug=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbgG0VGh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 17:06:37 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:34721 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726176AbgG0VGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 17:06:37 -0400
Received: by mail-io1-f67.google.com with SMTP id q75so10358131iod.1;
        Mon, 27 Jul 2020 14:06:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9fqm2imxhfZFwA1JkWuSSvUyCkDcAG780CxONL8snmc=;
        b=hHDDfDFQpWofRCZACB1mhdec6GnFoBkjtECKhk2PuJXACoeN9mbeqdQQmr2PnfzZOE
         0YRdSTXI1fZJOWnAYc7V+hVL1U2F7fNVRssNEFchUf0KPe+ytyPNFFHSBUJ5PVhLXrwJ
         mMbFMTsJuHnLz90rGzG+KJaxb8yIVFrldOvhv1HC6CGCS2cOl16LZ+UYL1+IDHMSZVa8
         T0EP+SiX7SZPRwD2Ro4iqQhs3UJZG8YBWTDHmk+b4tCIdR+zL25qoqGeYxFiGgQwgVRx
         AF5VPRfRmX2dqSbL7UQffncHWOJ6MrvglZrF0rNSj7pGHvLkbqxnGbK4IlbhwjDv6zau
         K0Cw==
X-Gm-Message-State: AOAM532k+JqXLZyLQ7NNP/NainMpZa3rNfOkWol4NIQmvJJo0Gn7mZn3
        dVndrWBI6N9O8rkCPUao+w==
X-Google-Smtp-Source: ABdhPJxEJ1Ub/5oPmpdTsRr2asUDaziPZFNoGYdmDA5VCknP4ggmbQqJIo/xbcUf8Y9tcWQxwDVAmg==
X-Received: by 2002:a02:bb05:: with SMTP id y5mr19178551jan.98.1595883996542;
        Mon, 27 Jul 2020 14:06:36 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id a6sm4640331ioo.44.2020.07.27.14.06.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2020 14:06:36 -0700 (PDT)
Received: (nullmailer pid 872129 invoked by uid 1000);
        Mon, 27 Jul 2020 21:06:35 -0000
Date:   Mon, 27 Jul 2020 15:06:35 -0600
From:   Rob Herring <robh@kernel.org>
To:     Saravana Kannan <saravanak@google.com>
Cc:     kernel-team@android.com, devicetree@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v2 1/2] of: property: Add device link support for
 multiple DT bindings
Message-ID: <20200727210635.GA872092@bogus>
References: <20200724234415.1651639-1-saravanak@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200724234415.1651639-1-saravanak@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Jul 2020 16:44:14 -0700, Saravana Kannan wrote:
> Add support for creating device links out of the following DT bindings:
> - interrupts-extended
> - nvmem-cells
> - phys
> - wakeup-parent
> 
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> ---
> v1->v2: No changes. Just sending again because v2 has changes in Patch 2/2.
> 
>  drivers/of/property.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 

Applied, thanks!
