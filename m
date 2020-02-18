Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7573EC34049
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 21:05:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AF662070B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 21:05:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582059947;
	bh=pXRGp6Z5lMsZ/0lr66clxg0dlS14Nc8pwOBlEOaxAT0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=TL4WHAb2EZ6lW0oUrleVn9rXAUdJGyXQRLi8lb5Ey9PJ6Kny513+oprKwkPvceTMT
	 OuzNdaX6Rg50Gq7WNjC/zmQGVA87jpzEF4Qvof0WIkKOVbZRjrVGe/15wUaGByXvNS
	 aMdZNXMx9oU88Z8aJFQYCOaPt0jyfpQQSDnVuaZs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbgBRVFq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 16:05:46 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:39750 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726482AbgBRVFp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 16:05:45 -0500
Received: by mail-ot1-f66.google.com with SMTP id 77so20950785oty.6;
        Tue, 18 Feb 2020 13:05:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=2NFp6Xk53EoDTqiO1l+FnY4ve5J6YqrYXVw+6lM+mI8=;
        b=s5kQnPUn+fzfSwuWKU6M/zm/PBLgj/RC1C7epH9ZRMuOyDqVDqjfI1JZHmaWJ929re
         jaRHS3YGvkRY+aAYWefObd0El3kOej/kk0jazcgEsIByiv3KRTJGW9D35jRai1N7i+59
         W9bU5Gsa2Cf5TdbyL9KrcaO1wb3JKB5mcqSA8h7p23j/yc4sq+sj2ElTu/POKd61Lssj
         qCJB5nYQ6BjUwL4a0+GzL7kIpdHglF4/Vp+DfzGwzA9JelKhHR3xawVWu/ZgPfHB7aro
         AkPToDY57Xf6byG19/Li1dSy03jBxD+waRtx/Clr9wqf6vR9pR+6ukDm7l+3egBS68w2
         A+xQ==
X-Gm-Message-State: APjAAAUwxIksyhxezx4rz6lUiL/b/iEE+eOkW4fgxdL+XW7hti43+Kps
        t4e1FATGhlMiRczt8sMLwAp/5+U=
X-Google-Smtp-Source: APXvYqxcwtPcb9dczEQuX/YRkNOyWP8oJdu6arcnSX/Hbr2ChjUqdwgZkFrS0kF7gjxMTNBUk++bxQ==
X-Received: by 2002:a9d:6ad6:: with SMTP id m22mr18026683otq.7.1582059943981;
        Tue, 18 Feb 2020 13:05:43 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id w6sm1728684otp.69.2020.02.18.13.05.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2020 13:05:43 -0800 (PST)
Received: (nullmailer pid 3545 invoked by uid 1000);
        Tue, 18 Feb 2020 21:05:42 -0000
Date:   Tue, 18 Feb 2020 15:05:42 -0600
From:   Rob Herring <robh@kernel.org>
To:     =?utf-8?B?5ZGo55Cw5p2wIChaaG91IFlhbmppZSk=?= 
        <zhouyanjie@wanyeetech.com>
Cc:     linux-mips@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        paul@crapouillou.net, mturquette@baylibre.com, sboyd@kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com
Subject: Re: [PATCH v5 5/6] dt-bindings: clock: Add and reorder ABI for X1000.
Message-ID: <20200218210542.GA3483@bogus>
References: <1581701262-110556-1-git-send-email-zhouyanjie@wanyeetech.com>
 <1581701262-110556-7-git-send-email-zhouyanjie@wanyeetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1581701262-110556-7-git-send-email-zhouyanjie@wanyeetech.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 15 Feb 2020 01:27:41 +0800, =?UTF-8?q?=E5=91=A8=E7=90=B0=E6=9D=B0=20=28Zhou=20Yanjie=29?=          wrote:
> The SSI clock of X1000 not like JZ4770 and JZ4780, they are not
> directly derived from the output of SSIPLL, but from the clock
> obtained by dividing the frequency by 2. "X1000_CLK_SSIPLL_DIV2"
> is added for this purpose, it must between "X1000_CLK_SSIPLL"
> and "X1000_CLK_SSIMUX", otherwise an error will occurs when
> initializing the clock. These ABIs are only used for X1000, and
> I'm sure that no other devicetree out there is using these ABIs,
> so we should be able to reorder them.
> 
> Signed-off-by: 周琰杰 (Zhou Yanjie) <zhouyanjie@wanyeetech.com>
> ---
> 
> Notes:
>     v5:
>     New patch.
> 
>  include/dt-bindings/clock/x1000-cgu.h | 58 ++++++++++++++++++-----------------
>  1 file changed, 30 insertions(+), 28 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
