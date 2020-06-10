Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23D02C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 23:40:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0E072078D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 23:39:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U6yIy4WB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726917AbgFJXj6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 19:39:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726374AbgFJXj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 19:39:57 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E2A9C03E96B
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 16:39:57 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id er17so1883861qvb.8
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 16:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8JfMKp4EsHexc1E//gaOq+e5Ss9lLtPVkZqEJdXcboc=;
        b=U6yIy4WBkffclpOeo54p+W92B8hpPVF1RbiS6AGdFmI5SHgYemTqKBoFmgjbZPoceS
         3JB3vSGhSLNSRtiGKA6QOsL/JnoR1rp+dt/zHgHCi+Ia5IRTZ/LUBWYUiRBMd4r+Ms4z
         IhFYoICVFiEzH3vFKSOm4xg1aw0vYYUG7nuog9pAnZnTxjJXRn3YeQ3UNbTv8jek54hK
         LfcNjHG6K1RXeVjDH7S4HAEN0OIUxh9w4EYvqpmisjL5EpM81SMhNCXMgYGNhrPYJ8fo
         bnhj5viIzGuXKhVHB/eEVKZlZ3zI+U/3O0mUwEpS468ZaO9sm8XMgs1X/zSYc0pnmIjo
         lycA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=8JfMKp4EsHexc1E//gaOq+e5Ss9lLtPVkZqEJdXcboc=;
        b=Qwfk7boWHvvGLSPk0N/lV890vRc9m0yfux3Q0qkAUU2GTKqiUwSQMwrFspEwIwKSdQ
         ++jaYEYamq//0gIqAggYLdWD6QAB6n4JUP0aSjZ40FOP2MEG8wUzNk8Fc6YnV6o8uIGL
         +l2vL89oo7frxCg/FX0Mo3UwAbQ8fiawXPfnSFiqrSR5FVKRHNQNhFEW/5x+aprSlLM8
         ZyIidmiXcftmVw6GNF8my2TZSxvFjud9W0eqDICpbY7WDjOtE7wO8d6s0c89txkktJ2w
         VZ6i3tooCVPkdY6EiORfMuXwUh5X+DSYaJ6UyLC3Q1aHk4acCUNpZgSYGzwS3MW7ZXAs
         shYg==
X-Gm-Message-State: AOAM532HVRMyE6nQQAhS/cseixM6FbKsEPq2/rMEitSXij+QVPNA6Fq/
        Kn+IO88j3ZJAq9i1Py6YbC8=
X-Google-Smtp-Source: ABdhPJyV6dTWpNHQPL4tjFDWpHxAyWy6gEoWcoQImXe5L/ZB2q9jKZr9zSGlcwEnvnn7H9Msvh/IKQ==
X-Received: by 2002:ad4:4d09:: with SMTP id l9mr5702939qvl.8.1591832396672;
        Wed, 10 Jun 2020 16:39:56 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id 80sm911651qkl.116.2020.06.10.16.39.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2020 16:39:56 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Wed, 10 Jun 2020 19:39:54 -0400
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Fangrui Song <maskray@google.com>,
        Rong Chen <rong.a.chen@intel.com>,
        kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Makefile: Improve compressed debug info support detection
Message-ID: <20200610233954.GB2941409@rani.riverdale.lan>
References: <20200610063715.v2qrqvwtegdxdwzl@google.com>
 <20200610191106.2662548-1-nivedita@alum.mit.edu>
 <CAKwvOdnF9xhrs+FP4QXo6uXxgHMfHO8NvPYs1=KDE2ZyhCw2QQ@mail.gmail.com>
 <20200610233046.GA2941409@rani.riverdale.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200610233046.GA2941409@rani.riverdale.lan>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 10, 2020 at 07:30:46PM -0400, Arvind Sankar wrote:
> On Wed, Jun 10, 2020 at 02:27:55PM -0700, Nick Desaulniers wrote:
> 
> No, as-option does invoke the assembler. The problem here is that with
> -Wa, the option is only seen by the assembler, not the gcc driver. So it
> will succeed because the assembler supports it, but it will not test
> whether the gcc driver also supports it.
> 

I think in theory another way to fix it is to just use -Wa even for
CFLAGS, assuming the compiler itself doesn't have to do anything with
the option and it's purely an assembler thing. Then you'd just do the as
and ld tests.
