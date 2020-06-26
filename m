Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0133C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 00:37:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5054207D8
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 00:37:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593131847;
	bh=4Srpq0sjZUqnumgWOmwTaPO+rJbsJtZnC+2BgIUwPRg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Fyg+JZX8H4Ozvsf/tsykBAzLnwL8s5+I0fQokzj3SH9ZFVA59ttpmTKNE5Mbiih9u
	 UmowUydMolE909FyFMkpkTM87As+JZOm9fGj/CWrzG8vp8aoxLUX/ikcw0i+4bPaVZ
	 zoQf0cpkn2gbdjppTjyfiu7SMO4bLPxJ5m4uQbKQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726403AbgFZAh0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 20:37:26 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33845 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725800AbgFZAhZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 20:37:25 -0400
Received: by mail-pf1-f196.google.com with SMTP id u185so1837561pfu.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 17:37:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hy4bKbQAyIT6xPIEHhucZ2hBlDFLteKHmkcc1hLnsOU=;
        b=dsxs28Ohf0nKmHjGSgDdguDfyq8vzWcxfJvkpyXzLpan2AIQNwD2Rl/mCLCmIPWy02
         MhsdjaIHHV4J8dHwQAzX6ou6aM1dn8rngvUuh4xmGauFKYYcghkr0TLMOs7t4MLR5CSO
         MTZujF8BkBVapJC+9WlptBx/FOI+8tGSSu1b+EBFQww/WEIhvE+iac9sZ485hpZNMjAT
         9yHeT3kqeD8UUNdL/3qMieNo5ybkBUjx7HoEB9ULZ5Q8/RdvkH7MGlDITb61SUcKleAA
         NmLTzLuDVld66EazF6vslStgaJQIleHFN1eFBnN8ZasPBhgcib0YLy8vJuQOOTSqANuA
         qeXA==
X-Gm-Message-State: AOAM5314RwOSRUYFZDXI8Ja73/Yg6sbCb52+pKZ8g6t0I24si1FevH1I
        9ZMapBFpGCiMwSeRpi6aivU=
X-Google-Smtp-Source: ABdhPJwbW/Wpb/CEH1pkDAJWNkYhXkyIY0z8C/ygJRWod/Z0Wrh/K+QvD0qZY5nvbqD3UI9BFirzKQ==
X-Received: by 2002:a63:ab02:: with SMTP id p2mr463454pgf.416.1593131844433;
        Thu, 25 Jun 2020 17:37:24 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id n189sm24458611pfn.108.2020.06.25.17.37.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2020 17:37:23 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 363B640430; Fri, 26 Jun 2020 00:37:22 +0000 (UTC)
Date:   Fri, 26 Jun 2020 00:37:22 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] firmware: improve description of firmware_request_nowarn
Message-ID: <20200626003722.GI4332@42.do-not-panic.com>
References: <20200625200221.18219-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200625200221.18219-1-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 25, 2020 at 10:02:21PM +0200, Wolfram Sang wrote:
> The doubled 'however' is confusing. Simplify the comment a little and
> reformat the paragraph.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Acked-by: Luis Chamberlain <mcgrof@kernel.org>

  Luis
