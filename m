Return-Path: <SRS0=PEot=6K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1A1FC54FCB
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 22:24:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87D072070A
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 22:24:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cyO2ULob"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbgDZWYt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Apr 2020 18:24:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbgDZWYt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Apr 2020 18:24:49 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19C81C061A0F
        for <linux-kernel@vger.kernel.org>; Sun, 26 Apr 2020 15:24:49 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id j26so23058147ots.0
        for <linux-kernel@vger.kernel.org>; Sun, 26 Apr 2020 15:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OBLAv3ala95rLSVXUcIkojndaShuLPu2zPwvFjdEly8=;
        b=cyO2ULobk7znDxC6KxHmNYBOG8F34LOm5QsZQN4riz0cSshLBBxKuzZ8QcmZ5PFors
         PZCraducRpH4ipa9oRdPoj3+4WMVnWIv2Mqwr45riIyJcQijn/Vz5wwBAiE6rCUgVXeK
         8SxsWWOVquMy40TRsWRjM7YrECZYobI/7+7GE0QK5hVpDjBWMaDvBaH8zoXWEYIwC9QQ
         /MXNdWpRiTiVBcBB4LgFlwTy4244jbqnKMH+wruxuOkvRGL/9CG80RC6Gl1W1e8q56AQ
         /+MWUTu6UsG12uqEKz/Vp3F3MTBjUBt4xVKNHsmRoM34khsOWh89IGdVu767Sv++PB/q
         y7UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OBLAv3ala95rLSVXUcIkojndaShuLPu2zPwvFjdEly8=;
        b=lbDyVLgn20iaZZAc+UgXueEzxZRTcGeUboQZJ7n5t9BN8OUBtos8DmrseX4PGO9i5U
         dlR/jHm0hzc6BUpSsobYvwpmB+5QEXPxOEg0OCvzxUo3+vJ2z91JgPFqHJ6CtIzzvae4
         xNSkCpT/RJTf0SARtNS77I3ioN8JeNYN2Z9LRR82OGST1sX8gsCndubJmAW2fPGctAQP
         wOPIQkaKxaCbFXuCsTpBKd0GImY6gsGPWfY30DdWcTNsAUb4S07DpDLwZLWVbhdXthgg
         9V75boEECEVX8zoqJpNPCBqTG5p1iF5kDeozaES9CU3Pgtf9S9iz0wHR+VuuZo+52pHi
         Uc7w==
X-Gm-Message-State: AGi0PuZSXJSjze5ECabojLHGmkSrR95rXnotBYHqBmai0k5N9ok2JbGt
        TmtjiSl5D/KMknPKP+an1qA=
X-Google-Smtp-Source: APiQypK0w4cqdzOM1cLQvyiHhJBMZlmEVBW9AS4qqoKOjtdRySFx9GQ6g/nVLyX3ojl/dRuIf3YKeA==
X-Received: by 2002:aca:31ce:: with SMTP id x197mr14434706oix.157.1587939886194;
        Sun, 26 Apr 2020 15:24:46 -0700 (PDT)
Received: from ubuntu-s3-xlarge-x86 ([2604:1380:4111:8b00::1])
        by smtp.gmail.com with ESMTPSA id h12sm2273441oou.43.2020.04.26.15.24.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 26 Apr 2020 15:24:45 -0700 (PDT)
Date:   Sun, 26 Apr 2020 15:24:44 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     jani.nikula@linux.intel.com, airlied@linux.ie, daniel@ffwll.ch,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: Re: [PATCH] drm/i915: re-disable -Wframe-address
Message-ID: <20200426222444.GA24867@ubuntu-s3-xlarge-x86>
References: <20200426214215.139435-1-ndesaulniers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200426214215.139435-1-ndesaulniers@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 26, 2020 at 02:42:15PM -0700, 'Nick Desaulniers' via Clang Built Linux wrote:
> The top level Makefile disables this warning. When building an
> i386_defconfig with Clang, this warning is triggered a whole bunch via
> includes of headers from perf.
> 
> Link: https://github.com/ClangBuiltLinux/continuous-integration/pull/182
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>

This is not technically a clang specific warning but I assume it is only
visible with clang so this location is probably fine.

Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
