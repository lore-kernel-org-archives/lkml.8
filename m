Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48D4DC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 12:17:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C134207D8
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 12:17:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593173828;
	bh=Rh+lkgwOeWK1YT93VgAtukf8tYP52VV8ykNXCv84pHg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=EhoETDG360vHhDcwBHQOMQJDB9GiRhFsUlmw5nrp85wMhcesC0pk58icm6GZ3c0ld
	 mys5GGBx+2KLga+srWehYW7N2f8tdpk6zwsl9TBMOQoKDhxKUlcBNc2DfYCTebyjv7
	 3lONJUl+9nYY2fdxAcf/PFVKER3hVFdUqxIEDmI4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728257AbgFZMRG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 08:17:06 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46007 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727977AbgFZMRE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 08:17:04 -0400
Received: by mail-pf1-f193.google.com with SMTP id a127so4555835pfa.12;
        Fri, 26 Jun 2020 05:17:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DsE2wAMRmQbvTNE8N6VxmuoaI9A47onJe1cGAUDjN50=;
        b=HhhowDwsKIIIB4cM298MMBZ03ELMfv5rYV6GfanmTor+HVEuB3ikE605OF39RUQacL
         4hyBcC6UF3rPZHQBzzLkOOwKoGCGhwFsyEU0fme476xqWF7kUogPCt/7yotHfkslHyIu
         ySOkkstmJnM06zzfcav0k1gMX/7LqanBB+ft6gRB1i8bb6/mju8qb/rXK24OJZ9l+YBf
         qC47iIy42IZbp3O7cgCknAW3VqYlA+WI86O37+9m+WslI8lphryG3OWjqKD/34nImx/B
         2nNJlE6xC3D5TpmNmj9GVFqrJYBkegHv4y/HEACJ99DyVRxP67bcnk8ZG9+680N83Mng
         s1fA==
X-Gm-Message-State: AOAM530aVTluKHeYcRVHS32nvt+U9VblsnIS4V4mniO53M5XtTJPLk2q
        gyy2ndYH3DzjDcqYqPhAsKo=
X-Google-Smtp-Source: ABdhPJwKPCfOPErb9QfKR/PTVjk9VWTUGqdxZW5FaJYMAQDflzqzSbvwxBnY0csptyJYBMj1ntPOtg==
X-Received: by 2002:a63:7313:: with SMTP id o19mr2540204pgc.307.1593173824266;
        Fri, 26 Jun 2020 05:17:04 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id 204sm1332367pfc.18.2020.06.26.05.17.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2020 05:17:02 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 0897040B24; Fri, 26 Jun 2020 12:17:02 +0000 (UTC)
Date:   Fri, 26 Jun 2020 12:17:01 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 6/9] sysctl: Call sysctl_head_finish on error
Message-ID: <20200626121701.GM4332@42.do-not-panic.com>
References: <20200626075836.1998185-1-hch@lst.de>
 <20200626075836.1998185-7-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200626075836.1998185-7-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 26, 2020 at 09:58:33AM +0200, Christoph Hellwig wrote:
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> 
> This error path returned directly instead of calling sysctl_head_finish().

And if the commit log can say why this was bad. Found through code
inspection from what I recall right?

  Luis
