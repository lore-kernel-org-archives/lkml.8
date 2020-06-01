Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C6BEC433E1
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 13:15:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41CA22074B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 13:15:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591017301;
	bh=kMjXUVNCNcYikXj8R8lRTRlVJfjbzlaBlZwBz2nduNw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=RPxE25OLD1UECm9njEPEAexHagiT1os3dvjtw01tRAO2ZttgWJYpt2wKJFJjUHJF8
	 Osne03RR1q7fK+S4Oa9ApINQnZUTBDHhrz7pUGpWPloDtkcl8/23gsSLAkTEkt8e+5
	 sERXp37Wenfhp+7XYY+8u7TzFXlRYaRpyXn2rk3A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbgFANPA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 09:15:00 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34543 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726017AbgFANO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 09:14:59 -0400
Received: by mail-pf1-f193.google.com with SMTP id z64so3467135pfb.1;
        Mon, 01 Jun 2020 06:14:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gddyfQ3Neo3DcmxiCVDRf3EtQDq1cuUh0cXICGe8cf4=;
        b=DRtxPfx79yuZ/UoKVQAKA2A3GE6R7B4daQVUA0Oshg5BBHRM3fAyvp2roe6dOAIRh8
         eu4jcoQb+S7/pR2Y/XvNaZnvah/wpCn/Ywvhv8XS779Q519150mzB7chvFYSVwpnA3mx
         NOlXD7/rMwXhglsQhwnPJP3jzXY/N9ho5GfmzPweYKk6QmHOAivWCAAjBaaAWogZ52jb
         LDQFUjLtfsVgo1EIdhfJScrdlaibQBCktr1wyF89C+2goqwPDIH8kU9A/hMgzYdBaX47
         jGkEWTGvZ7oq2ccPkF0ea9kKDC34FKZSCxKdNyfqiH5slCADBjAirnHl2cCchJL9WCA4
         1Gmg==
X-Gm-Message-State: AOAM53006dljZ2GK2F0PSVV3Blewb763dc2CCAKEKEWGXPuKSC2J30Ge
        37esfFGnHjWqAVptuArcHyw=
X-Google-Smtp-Source: ABdhPJyhvFhgDaLemeHJdh4LjmALhxP/lWWjg5b16MtVVLSWXkc4Gw0ALvIpNp0MVDxjYQTNYW5nmA==
X-Received: by 2002:a62:e219:: with SMTP id a25mr20476293pfi.303.1591017297644;
        Mon, 01 Jun 2020 06:14:57 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id 124sm14359923pfb.15.2020.06.01.06.14.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2020 06:14:55 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id A911640251; Mon,  1 Jun 2020 13:14:54 +0000 (UTC)
Date:   Mon, 1 Jun 2020 13:14:54 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Kees Cook <keescook@chromium.org>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>
Subject: Re: [PATCH 2/4] lib: Make test_sysctl initialized as module
Message-ID: <20200601131454.GG11244@42.do-not-panic.com>
References: <159067751438.229397.6746886115540895104.stgit@devnote2>
 <159067753624.229397.13771427935697541820.stgit@devnote2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <159067753624.229397.13771427935697541820.stgit@devnote2>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 28, 2020 at 11:52:16PM +0900, Masami Hiramatsu wrote:
> test_sysctl.c is expected to be used as a module, but since
> it does not use module_init(), it never be registered as
> a module and not appeared under /sys/module/.
> In the result, the selftests/sysctl/sysctl.sh always fails
> to find the test module and is skipped.
> 
> This makes test_sysctl.c initialized as a module by module_init()
> and allow sysctl.sh to find the test module is loaded.
> 
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>

  Luis
