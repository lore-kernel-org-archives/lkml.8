Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80368C3815B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 07:13:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58E48206B6
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 07:13:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j+oEqsfF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726262AbgDTHNp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 03:13:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725815AbgDTHNp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 03:13:45 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7941C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 00:13:42 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id h2so9742168wmb.4
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 00:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=YR76M7+QfRjvw5EtwYjnb3So/qNzKUFPYqnKSENL06s=;
        b=j+oEqsfFSEehYdDaMCVRO5/BEh7yOsSRL4WCMgYNU4ByUFUamd/zsXe0tGibrfu0YH
         K5w3ucNoA+y/Yq0Ndpa0YlTi62oODtwd9Jn8ew5HDISSFTANK3RTO6YgT6XCEjQ1ixNi
         lc6VJH/qJiVZk75MbmHTBv/kiswML0390oa7SG3EX6mxjQY7ZO6HL8fXWIyG10fM/xQU
         /E1DZgcGuK8HGwaeusM6FB+el8IttTwDpOApx+r8QzzOZOM1fJ1httF1o8g2JDuacN+o
         W3Spv6i1aAPIMw5lzkJMUJhKvN+svV+qBjWRXsiezEOhy7ySDLL0BRS5OuFgEfn8ChhH
         zSaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=YR76M7+QfRjvw5EtwYjnb3So/qNzKUFPYqnKSENL06s=;
        b=c2bKUO7tJ2zeFPiuioozaKK70AKiWx9FZReKThHa3qs5Ymvq3xM8nL6dY4PGBGXBDF
         dGNk46yG6eXKWY6VWm6DCAsqymTtItfIyATJgi0vuoy0jovgya5TeOi0VY1qSX2h7BHG
         cZYpRi+tB5yv5RNYFU5Lx7Mam7QB4rYBu8ZXdBEfzl59hlkusQfr00vJ0aRag6o59GKj
         X+Eei2nN0/3L0rVaOfVFu1kzmH4i0xGEzH86FON1JahiB0mJwVP22QQAj8K2rqlq/Kd3
         mjbT+rflEtFY8GBierOhoEIgECLK+YV3TZDZNhT8mN7vDBzGRJUCXHVYA/VvOmJTWDpl
         DeRg==
X-Gm-Message-State: AGi0Pua5OF5OPJ2t9eBdSd1VwaJV+jZSQwC/EFPbBu07c+IekO6v6PlX
        PTxDroSaLW5DfcNG6sWn3OqIih6J1wk=
X-Google-Smtp-Source: APiQypKpGsqOSTlQdF58ZanLLw569+NgUTeZDOfWsHb1HlqvPP5ipAf6ybVxjpNRRFSHD1D0SCM2kQ==
X-Received: by 2002:a1c:61c2:: with SMTP id v185mr1356067wmb.92.1587366821384;
        Mon, 20 Apr 2020 00:13:41 -0700 (PDT)
Received: from dell ([95.149.164.107])
        by smtp.gmail.com with ESMTPSA id e15sm41773193wrt.16.2020.04.20.00.13.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 00:13:40 -0700 (PDT)
Date:   Mon, 20 Apr 2020 08:13:39 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     Tang Bin <tangbin@cmss.chinamobile.com>,
        Shengju Zhang <zhangshengju@cmss.chinamobile.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: asic3: Add error checking return in
 asic3_mfd_probe()
Message-ID: <20200420071339.GG3737@dell>
References: <b9626e96-4bdb-e7e1-51e7-a99210de4c32@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b9626e96-4bdb-e7e1-51e7-a99210de4c32@web.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 19 Apr 2020, Markus Elfring wrote:

> > In the function asic3_mfd_probe(), when get resource or irq
> > failed, the value returned just detected and debug error message,
> > but there were no error checking return. So add the right error
> > checking return.
> 
> I suggest to improve the commit message.
> Would you like to adjust the patch subject?
> 
> 
> > And remove the redundant 'ret = 0'.
> 
> I propose to reconsider this interpretation of the source code here.
> How do you think about to move the mentioned statement into an else branch
> at the end?

Could you please fix your mailer.

If you do not, your replies will be lost/discounted!

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
