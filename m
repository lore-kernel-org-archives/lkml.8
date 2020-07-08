Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21E3AC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 06:44:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3BAA206E2
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 06:44:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594190678;
	bh=gz6h123/qa2afouMert0W4ce4nX9OLW1NVvv/g6qz9A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=BbzUulCsPe2Mz5nVaOL31sTGUeVVqJlUYGGJTM8frNDMqn4oot/bWHc0tUD2RP0Ku
	 6/gIj36XUBRgqTbwJua/96dLol9uLtujdlPycQBRSCe1sc1nBmABakbYAczMpLKGHz
	 cY4O6vdP5crZeBmYfRhtwPkOQKkamJCdsxRbZxOg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729786AbgGHGoh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 02:44:37 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:35693 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726174AbgGHGog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 02:44:36 -0400
Received: by mail-pj1-f67.google.com with SMTP id f16so763686pjt.0;
        Tue, 07 Jul 2020 23:44:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xugiqIhWgDyPUIRQocIBP2J7Hrt09NF5Sv5m+G5LnOk=;
        b=cD5B2mJuc+CNz6aUXmJeYz5HG0Qh7TbrvoHQMDKNiB5UxyHKuiw0xdKmLUbps96G2N
         duFg4Z4KlJ4l3lhitgbAd328WYjR7OnmAhLnvWSqwMDMAnvQv4dt2hlIhduo5xyvc10Q
         NFhwwEn0W53wyxBE6hPIfGeaxm8dY+tzwZbjiXodaUeIEcwWhhTN+kTJmlTOpVNq8J5s
         tB1gcdogxTdW3v2Q0PhPY1D9VlRILLOB0kJqk0MjozyfWrIHPgALz5jAXweXrnB58APY
         Mve8M66PW/Ky+454zA8oKwlVuY7rbUP9lWcZzGVYkJLFj3/USnCcVunO5/CzYXuswl/N
         KHkw==
X-Gm-Message-State: AOAM532Fvb4OB+KlV+V+V3DBnGCg35gZJ6KANk0YT2NG+MUSKeHXu3ik
        vyFDbBFJdRi65RXi6aYsh6w=
X-Google-Smtp-Source: ABdhPJwyhCGrZ1fEfmUBZILkNsv3VUQI7+NNzFiLMr2Fo6CDQGxckRs9AxmZZEbjbbKVbEinrPwqkA==
X-Received: by 2002:a17:90a:3fc7:: with SMTP id u7mr8155757pjm.231.1594190675605;
        Tue, 07 Jul 2020 23:44:35 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id r2sm15455857pfh.106.2020.07.07.23.44.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 23:44:34 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id EC8C8400DB; Wed,  8 Jul 2020 06:44:33 +0000 (UTC)
Date:   Wed, 8 Jul 2020 06:44:33 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Shuah Khan <shuah@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Dominik Czarnota <dominik.czarnota@trailofbits.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests: kmod: Add module address visibility test
Message-ID: <20200708064433.GD4332@42.do-not-panic.com>
References: <202007031141.6AC2173@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202007031141.6AC2173@keescook>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 03, 2020 at 11:43:28AM -0700, Kees Cook wrote:
> Make sure we don't regress the CAP_SYSLOG behavior of the module address
> visibility via /proc/modules nor /sys/module/*/sections/*.
> 
> Cc: Luis Chamberlain <mcgrof@kernel.org>
> Cc: Shuah Khan <shuah@kernel.org>
> Cc: linux-kselftest@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>

  Luis
