Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49CC2C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 08:09:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14B75206F4
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 08:09:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WfQKqFbs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726730AbgEOIJd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 04:09:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726648AbgEOIJc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 04:09:32 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81177C05BD09
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 01:09:32 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id y25so617154pfn.5
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 01:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1vyc3N6Wpm82JIZilzNLGJALVVKWdLUl/sk+JrP3SQY=;
        b=WfQKqFbsR7j0aT0EBVSN2m33HEItYHviYT/e/Oyrp6O+5EmrwjqvbC5f+YgJHhS/Ml
         5HZLGNLbbHysm+MGzdihZhtYNWYX/2aurTMWuP6AqSQFXitKJTySL+XS5PZt21DhvH1K
         AkCIkBjKMNiC6QdGXn+Qi0B43psoWAOmYK2ZU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1vyc3N6Wpm82JIZilzNLGJALVVKWdLUl/sk+JrP3SQY=;
        b=WNYU0jNtjZG3UOyqUixh36eSRljqtjumLjGwfbIpm7Psxiev3pLnNkYjN68ozGt2PD
         sUm6+hRklB9NzT9M0gSKIXy1Jytv7vCPQhMhjhhqVMIEsc6IPGFv1QrdMi893iKULcby
         URoxm/dI2kZMOcMsK8jxxgFPwCKwO7H8smTvkxtoTuj1aJ60oTBUuEnuSk9MYdUoXAvr
         9sztV1vY7uZ8ux3bWLuZp8cmxtnHgNrIeg/VhjODqzxg74U7haDBuYHv8GZljtJu+gwG
         T3ChyNoXgBfVoqYIULv4/I86Et3I+M650Y4F6FD0hwhOQ76bcpzjHob5FcO5ywFiBw5S
         3gEg==
X-Gm-Message-State: AOAM531JpFCcScCurRJNpVIIcQrrUQP3dktH7KHHJ+z+LLNx1J0hb8J2
        lUqw3y1HSLl5gzlh7ukxdoyWjw==
X-Google-Smtp-Source: ABdhPJzj1TkiQ319JdD4TFwt6e2PerHI09OJDhtWGz+jcdRwTxCJRsyCrrUnlx6JTEkb6ZP+l0+hDw==
X-Received: by 2002:a62:ae13:: with SMTP id q19mr2697929pff.310.1589530171972;
        Fri, 15 May 2020 01:09:31 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y14sm1222453pff.205.2020.05.15.01.09.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2020 01:09:30 -0700 (PDT)
Date:   Fri, 15 May 2020 01:09:29 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Xiaoming Ni <nixiaoming@huawei.com>
Cc:     mcgrof@kernel.org, yzaikin@google.com, adobriyan@gmail.com,
        mingo@kernel.org, peterz@infradead.org, akpm@linux-foundation.org,
        yamada.masahiro@socionext.com, bauerman@linux.ibm.com,
        gregkh@linuxfoundation.org, skhan@linuxfoundation.org,
        dvyukov@google.com, svens@stackframe.org, joel@joelfernandes.org,
        tglx@linutronix.de, Jisheng.Zhang@synaptics.com, pmladek@suse.com,
        bigeasy@linutronix.de, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, wangle6@huawei.com
Subject: Re: [PATCH 3/4] watchdog: move watchdog sysctl to watchdog.c
Message-ID: <202005150107.DA3ABE3@keescook>
References: <1589517224-123928-1-git-send-email-nixiaoming@huawei.com>
 <1589517224-123928-4-git-send-email-nixiaoming@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1589517224-123928-4-git-send-email-nixiaoming@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 15, 2020 at 12:33:43PM +0800, Xiaoming Ni wrote:
> +static int sixty = 60;

This should be const. (Which will require a cast during extra2
assignment.)

-- 
Kees Cook
