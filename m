Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD875C3815B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 17:48:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8019520857
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 17:48:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GXRI4PIn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbgDTRsF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 13:48:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726492AbgDTRsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 13:48:05 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E1A5C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 10:48:03 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id w11so5415300pga.12
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 10:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Q4Luph9bjUR+Gp2ezvaV6wES2xaIHfMicGZ5Eha18+I=;
        b=GXRI4PInUTtUMm78jGtgjATrvbZr7mvC9uO2/IV0glFIM8jmisWzRO4HTbPySF4d1O
         GWuqHjfb00loi9NzH+INM6AwCX4OoEKBLTWC1dkE/SDIg59HDNN5LW7ATSr0dtA8WD5w
         h8pHdanm2ZyCwCuUjoGXH/ynQspj7qlcqCYQ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Q4Luph9bjUR+Gp2ezvaV6wES2xaIHfMicGZ5Eha18+I=;
        b=D2GovAPEpxC4enIE+WynItAeLGePy9ydgeqXJgzF2X88rnFPL6608+fAl2eJWg+Kp+
         7yk9IclqN5ampOFMYYlJiH1lk5EScAYZJo33QZ/1rQ+Mn6yffw/A+Nwt8Ztg0gjijrrC
         /8vK3GstoYX0rgh/i/GXgPxBpANPyO5fJvUnfJGcxRqWy+YnGySjd7UIr+AtoK1Z2qw/
         324Au+MssL3XCL6PicNqhVJf1BXxvsQEXpg3HvU9sNuAxoonC/Lz/ftzInhXOhRhxg/u
         b4I9GZD6KEZ+34ICsckC2b78NTBElNMsyfbUiIt82cuohXPj7swKi5fuHYbEt8hYr+ZS
         6VjQ==
X-Gm-Message-State: AGi0PuaEvfgHO2isX8OV/mwNwgB4pWlFx0lQ08qmhJdddEmqzKceiIcn
        kttZpcwZZim+mBb5Vw88ZeWCrg==
X-Google-Smtp-Source: APiQypIlqdHwV4TpkFSW47Z++mEoKRMoGEEDfMbXdZ0NOOBU9Wa+n6xGftMqzJcnXbkOXMMNsNnKIA==
X-Received: by 2002:a62:864b:: with SMTP id x72mr6072442pfd.305.1587404883243;
        Mon, 20 Apr 2020 10:48:03 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id w186sm109237pff.83.2020.04.20.10.48.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 10:48:02 -0700 (PDT)
Date:   Mon, 20 Apr 2020 10:48:01 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Kristen Carlson Accardi <kristen@linux.intel.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        arjan@linux.intel.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com,
        rick.p.edgecomb@intel.com
Subject: Re: [PATCH 0/9] Function Granular Kernel Address Space Layout
 Randomization
Message-ID: <202004201046.600183D@keescook>
References: <20200415210452.27436-1-kristen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200415210452.27436-1-kristen@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 15, 2020 at 02:04:42PM -0700, Kristen Carlson Accardi wrote:
> Kristen Carlson Accardi (8):
>   objtool: do not assume order of parent/child functions
>   x86: tools/relocs: Support >64K section headers

Can these two patches land separately (i.e. "now")? CFI will need the
relocs fix too, so better to have this landed upstream for both
features. I see Josh's Ack in the first...

-- 
Kees Cook
