Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E58DC2BA2B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 14:03:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53EE020730
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 14:03:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586441017;
	bh=uYIN7akAqSeGyqntCckj3OTgbjTllf/P2We/ZaEodqk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=nF+LD5lCGVvCYwjkNBQUwVO2ozj1mRCHKfSPhbLO3wGGtDqnsGDN/j29Xfd6SoWrS
	 tNRj+/daEEa0bz7xtKprkRWJaKc7OhyBtjrLx9hFkNe/xQ/Qr0Yx6crPctFb7vSqdb
	 WyZSqS5t0x/9LaPBUAHUAkMwTXtxNeHXS2i7V+sI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727183AbgDIODf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 10:03:35 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52357 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726552AbgDIODf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 10:03:35 -0400
Received: by mail-wm1-f68.google.com with SMTP id t203so4010421wmt.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Apr 2020 07:03:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NJFNUW9rve5VxEqt6lfAQ74tVBw3+PkCOoIp3q3UvBI=;
        b=h7/OiIfBYAel2h8O85EOS+qngMQxftWL219ziplccjlQjIk4SoabOHEL5PBrhWHOQ+
         DkmQAacsxflqdQbvD4CZ8fXbEZ/7kaj9CSDmNTpFtC0oPpw31iZD+JwjGr8fWGJVaZeo
         bim2IPDdPY+4UDy5tMTZecg771HvLQK424Jz+T4dRTPxNBMr8ftp9hzKbygUnvcHZLj5
         EnDtZPriv/cZmb1jpyiQqltVAViiomRvS6yJTv9Ohiq2PgQQyMXJ3e/P3QQdGk4GZocp
         z04J4SqKrQjZK8vqCAipZWP+RCECwcRoI1wyzsOVyeKA7qhsUdFnb7q4euAw+NTpeD22
         AC1A==
X-Gm-Message-State: AGi0PubdgFjXssGEI5ebnStuN+kdb/cl37cW4qWSFTJLUr1R0lX6bdiM
        cQFEjZIrryYt39IBPWvskNk=
X-Google-Smtp-Source: APiQypKHULiMtmrREI84NH9lgGjpDS+5uIqgdzmt7dcqbQwgyTWHKuxOZngGIH41v5Fh75KjmVDFdQ==
X-Received: by 2002:a1c:51:: with SMTP id 78mr19336wma.157.1586441013851;
        Thu, 09 Apr 2020 07:03:33 -0700 (PDT)
Received: from localhost (ip-37-188-180-223.eurotel.cz. [37.188.180.223])
        by smtp.gmail.com with ESMTPSA id t67sm3892102wmt.48.2020.04.09.07.03.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2020 07:03:33 -0700 (PDT)
Date:   Thu, 9 Apr 2020 16:03:31 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     kernel test robot <oliver.sang@intel.com>
Cc:     Alexander Potapenko <glider@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Christoph Lameter <cl@linux.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Sandeep Patil <sspatil@android.com>,
        Laura Abbott <labbott@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Jann Horn <jannh@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Marco Elver <elver@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        OTC LSE PnP <otc.lse.pnp@intel.com>
Subject: Re: [mm]  6471384af2:
 phoronix-test-suite.darktable.Masskrug.CPU-only.seconds 10.2% regression
Message-ID: <20200409140331.GK18386@dhcp22.suse.cz>
References: <20200409135029.GA2072@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200409135029.GA2072@xsang-OptiPlex-9020>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 09-04-20 21:50:29, kernel test robot wrote:
> Greeting,
> 
> FYI, we noticed a 10.2% regression of phoronix-test-suite.darktable.Masskrug.CPU-only.seconds due to commit:
> 
> 
> commit: 6471384af2a6530696fc0203bafe4de41a23c9ef ("mm: security: introduce init_on_alloc=1 and init_on_free=1 boot options")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
[...]
> CONFIG_INIT_ON_ALLOC_DEFAULT_ON=y
> CONFIG_INIT_ON_FREE_DEFAULT_ON=y

So the feature is enabled by default and therefore this is no
regression. The feature is expected to have an overhead. It is nice to
see that quantified. These numbers roughly match those presented when
the feature was enabled.
-- 
Michal Hocko
SUSE Labs
