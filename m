Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9440C2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 16:47:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9074120678
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 16:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586882873;
	bh=Z3HL3YklrDsYIwg1FC7aIP/KadUNBA+ByR+bmRcSUF8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=suxB2DLrzQpXPCVUvEFejkUjKKZ2KvJV87f1qUIFD9PfBsEIMCQInHmPjN08EQgiY
	 AQ29qs+0yez5hy6Ag49hIJnXk7CmAbslsRN7thKg6I6yrUyP8IKOGLSettEyhRuLjV
	 SH+aK76341nGcIPLPo0CrPvToxisASoSLthvwuno=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440245AbgDNQrw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 12:47:52 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:39275 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439829AbgDNQrs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 12:47:48 -0400
Received: by mail-oi1-f193.google.com with SMTP id 8so746409oiy.6;
        Tue, 14 Apr 2020 09:47:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1DShrROwnF7X9d9SMVhrVA7oJhrTiR4bUnQCj8Zvi9c=;
        b=iq+rhnrlo87C7+lHdr/82VR2Rq9JUihbxP+2iJrMtx3WXdGN2bIG9aJoEM0s+G+djk
         Ny56g8XYhCnZ6pj0H3g5eAOZoR0AeoUR0krxsOouYPngaWOkfeOE3UbRwh7jdaSilZqW
         4o4NS9O8HszKYmsEOG7By0fwsn16uyK2KlJ6Rq7+b+z0FdX8vMiqF2VApvVW1OkCZS0I
         EpX93ldgkM8cxwpGaTwlRDmI8rb42wz1KH/jlNp3yLC3P9w2aW15ymqUry8Lb22gi71B
         YRk096kHO5/NmeLy2kf2xy2CD2dyL1IxPvQ1FO9zkY/9u5d4OMOtg3IM/65tW8qjEX7N
         flxw==
X-Gm-Message-State: AGi0PuaIOQqwI1TfeNdVgXGbAXLGcr3Gj8rt0Mju9r0EatDxv0FP2fat
        ZKQnk7/rgiY5jPCseI4QLQ==
X-Google-Smtp-Source: APiQypKgVqsv4MG/Gxkug3PTAe9uHf8XSPYniQqitRAH/xDET7WGXdw9YTKAqzT4dZ5MNbItqugOQw==
X-Received: by 2002:aca:ddc4:: with SMTP id u187mr16297069oig.129.1586882867577;
        Tue, 14 Apr 2020 09:47:47 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id d3sm5660560oth.81.2020.04.14.09.47.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 09:47:46 -0700 (PDT)
Received: (nullmailer pid 16669 invoked by uid 1000);
        Tue, 14 Apr 2020 16:47:46 -0000
Date:   Tue, 14 Apr 2020 11:47:46 -0500
From:   Rob Herring <robh@kernel.org>
To:     Saravana Kannan <saravanak@google.com>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Saravana Kannan <saravanak@google.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>, kernel-team@android.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] of: property: Add device link support for extcon
Message-ID: <20200414164746.GA16614@bogus>
References: <20200401225203.163155-1-saravanak@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200401225203.163155-1-saravanak@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  1 Apr 2020 15:52:03 -0700, Saravana Kannan wrote:
> Add support for creating device links out of more DT properties.
> 
> Cc: MyungJoo Ham <myungjoo.ham@samsung.com>
> Cc: Chanwoo Choi <cw00.choi@samsung.com>
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> ---
>  drivers/of/property.c | 2 ++
>  1 file changed, 2 insertions(+)
> 

Applied, thanks.

Rob
