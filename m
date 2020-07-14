Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEE9AC433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 20:51:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB2FE2065D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 20:51:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594759892;
	bh=TBvu4sStwthPTO3PQtBtpAorzMD8ufQBRc8C5jvyq38=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=2YTS6GtclVsxEjbqqMCk26XaGi8xF6/gh6uDVmV6+LlizzepswnZRKF9RRmXILR+e
	 WE+H3qvp7KsFUkLIgL8ds86I5kqPClajUpngMeGfhUcE72H+pI7PEn7kpKT/Xk1zkM
	 aGNoqnD4WhWdst8VfKDLg2nJ+IHTfv3h0rlFMZfM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727950AbgGNUvb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 16:51:31 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:39809 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726442AbgGNUva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 16:51:30 -0400
Received: by mail-il1-f194.google.com with SMTP id k6so18850ili.6;
        Tue, 14 Jul 2020 13:51:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xYP1X5WHYenvLyAi36KqfRnD8go55u9Qh6XLVD5GuJA=;
        b=qnrCZuazz5pZjevvtJfFpdprUYgADOqCYxU1cqPiX5hXJp2+0xflCjtWwKTJO8+K1L
         e1ScH8EgC6jdGln6xBHOAP1MaO1rn0/Uz31/6nQ7XDsW5B1RSqR+T+c4mLYOn2gi3Sj+
         pihU2NIdmcwFpMEqO+1xM2n93W0V2NF9evGA41wylzX5ukKgv95ROR7iD6sJB9qwVxZB
         uAhl7J5XwRElI+VLbiSxCTynEbL09hCMcAcrnfun8b79dKix0dMQNdxsx7oVewMeiqTD
         nvpYN8/j82eUMrour3Ae1Ijf2+2rcq3Kaf+b9/LggqQlRrnEFdSBBmE565bXr7RZcKzL
         YpZw==
X-Gm-Message-State: AOAM5329vP0vSW7gINRT+Pm827X/BMswEYmPSon4Gq8ABCwnzddutDxi
        HpyVSRzHjbr6HZLrKXbhyw==
X-Google-Smtp-Source: ABdhPJzYaEGsMVXimhWQojSMQBi7CsWJsgOaTNvF72hwfOzqRITUBP+rB9yGg+dzr+pElSaD4kGCxw==
X-Received: by 2002:a92:cf51:: with SMTP id c17mr6161881ilr.122.1594759889869;
        Tue, 14 Jul 2020 13:51:29 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id t1sm87993iob.16.2020.07.14.13.51.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 13:51:29 -0700 (PDT)
Received: (nullmailer pid 2897098 invoked by uid 1000);
        Tue, 14 Jul 2020 20:51:28 -0000
Date:   Tue, 14 Jul 2020 14:51:28 -0600
From:   Rob Herring <robh@kernel.org>
To:     Frank Lee <frank@allwinnertech.com>
Cc:     mripard@kernel.org, linux-arm-kernel@lists.infradead.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org, wens@csie.org,
        tiny.windzz@gmail.com, huangshuosheng@allwinnertech.com,
        srinivas.kandagatla@linaro.org, liyong@allwinnertech.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 06/16] dt-bindings: nvmem: SID: add binding for A100's
 SID controller
Message-ID: <20200714205128.GA2897050@bogus>
References: <cover.1594708863.git.frank@allwinnertech.com>
 <6899200489cb4236650ba90646057874b82ed6b7.1594708864.git.frank@allwinnertech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6899200489cb4236650ba90646057874b82ed6b7.1594708864.git.frank@allwinnertech.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Jul 2020 15:08:43 +0800, Frank Lee wrote:
> From: Yangtao Li <frank@allwinnertech.com>
> 
> Add a binding for A100's SID controller.
> 
> Signed-off-by: Yangtao Li <frank@allwinnertech.com>
> ---
>  .../nvmem/allwinner,sun4i-a10-sid.yaml        | 19 +++++++++++--------
>  1 file changed, 11 insertions(+), 8 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
