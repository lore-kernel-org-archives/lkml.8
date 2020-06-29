Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97597C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:24:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B527208B6
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:24:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593465841;
	bh=jRcI34evi/xf/fvu2nH1bmDfvHidBNu9bPSOCbVoq9M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=x8UT6kCDO9aa3zQ3r3+gV23hQwgZPl6aYc9v4rRsqzd8D1RWBbwOU4fJlZci7Q43h
	 vG9nhbH01s/AwCcDDQjerzHlY3IOPZ/7snm7lKRTGBIUPcBrJBHVUCJU4DBtXyu8zP
	 IgCtaRUN4pVw3PClwRcJHXyn1MYl6tnpMe4UBPho=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391011AbgF2VX7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 17:23:59 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:39831 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726524AbgF2VXr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 17:23:47 -0400
Received: by mail-io1-f67.google.com with SMTP id f23so18790477iof.6;
        Mon, 29 Jun 2020 14:23:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bPNJneyouFFATOw4Dr0vJNDA4Ztsxwm7X1dPam5gKXc=;
        b=GXUsOAnYIXWVU3ns2XQG/+nKhWlsNCNf3h0Q6geKniqIvRXiyuUl1AtymaCmMxSnje
         hKeDElxpnlg7hDHOg2e1WrNNVHfsjXs0L263Ui0d7u05CQEoQapnJ3x3yUUhqEfklPOm
         i+YP/l8zT8GbiuBCn35yOKb5utf7NR2fO8pHd7+knfor7lhOpujXytBEELGC7yaP/nX8
         l/JeN1HHqowAdWslqpxrLPd3dqQbj+XZqf5SmfX2aNdhBMLZhoyaG6ETc0wEcaZ3hfP1
         rHerSf+sUhiYFBXABkSe/qlH6cpbQLluQ1Buk4yHHNWEatEXnBc7mnVZTAqXtNDPoQCz
         005A==
X-Gm-Message-State: AOAM533YTAd2yYYVd+eUFGbxvILL61699X52jLSnKJ7KN0i/Kl2GeJTR
        FllCc1dNwQmkvdPrRO7KEQ==
X-Google-Smtp-Source: ABdhPJwN4xgBtOvB/QVmeS0dlgwgcCEX6eRha433UEB2sZAuODMXppw/myhpp3n0pTdObJJHwlROIg==
X-Received: by 2002:a5d:858e:: with SMTP id f14mr14923501ioj.12.1593465826991;
        Mon, 29 Jun 2020 14:23:46 -0700 (PDT)
Received: from xps15 ([64.188.179.255])
        by smtp.gmail.com with ESMTPSA id e3sm504612iot.7.2020.06.29.14.23.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 14:23:46 -0700 (PDT)
Received: (nullmailer pid 2932013 invoked by uid 1000);
        Mon, 29 Jun 2020 21:23:44 -0000
Date:   Mon, 29 Jun 2020 15:23:43 -0600
From:   Rob Herring <robh@kernel.org>
To:     Kangmin Park <l4stpr0gr4m@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Michal Simek <michal.simek@xilinx.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: mailbox: zynqmp_ipi: fix unit address
Message-ID: <20200629212343.GA2930951@bogus>
References: <20200625135158.5861-1-l4stpr0gr4m@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200625135158.5861-1-l4stpr0gr4m@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Jun 2020 22:51:58 +0900, Kangmin Park wrote:
> Fix unit address to match the first address specified in the reg
> property of the node in example.
> 
> Signed-off-by: Kangmin Park <l4stpr0gr4m@gmail.com>
> ---
>  .../devicetree/bindings/mailbox/xlnx,zynqmp-ipi-mailbox.txt     | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Applied, thanks!
