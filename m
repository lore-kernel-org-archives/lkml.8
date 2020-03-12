Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01BA7C10DCE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 23:51:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD1ED20716
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 23:51:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hrDFZCxO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727054AbgCLXvs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 19:51:48 -0400
Received: from mail-pj1-f65.google.com ([209.85.216.65]:51907 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726620AbgCLXvs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 19:51:48 -0400
Received: by mail-pj1-f65.google.com with SMTP id y7so3211793pjn.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Mar 2020 16:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0KxoRh9qG0nLMfrbberK+fO1rqVz30X/phZqryHpwoE=;
        b=hrDFZCxOoZIcuiwEPWccramEAhWr1lMdKuusoyTmE2sVv9Z09z1vKUIBrOVGra0QoW
         Iu+CfN43PYxi12Ebdq88oCKzkUWKHHwbP6LGOUeYqhvDeK58SyOfk0Hd2RUuHTnOpplY
         VrYaCA/WV4QeV4sUlJrKUygPV+W304zKjQSug=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0KxoRh9qG0nLMfrbberK+fO1rqVz30X/phZqryHpwoE=;
        b=froqoNJD2SibyUGzrfwDlwU7Ws+QpTfXMzD3y0uI3ojDcSMbbXgFYber5CMhqwX+we
         Wzkvs705ydqacmyEloqQ0mg+6xtachEHalTnPPCnQ/A6tn1JupLoE/l2y6pDd+nq9p63
         66ThO1GfNK9WHTkzgnTkPpnFXxCXKn24V9OIsdwzHI2A5tZ+2uHKeIjhBvWSbWLnuauo
         Twjqw/Y3ffJGW7Fl26/qeCbsgwjZSvJynEMc0A1QENVoFAVERMqMoB9CfkC6FqkuvJOw
         T0L2g+5VyewDgzdSSIyo+G25CmDNNg52p6HXn/lJr7aRbEvpY98xtOtdZ1PhFa1TrRPo
         Tvzw==
X-Gm-Message-State: ANhLgQ3Td7THnm400xnM0jpzZTAuJcpYBCp8bzs/L4ioyKxFNlB0v/+s
        VtDQ7ovS78HwpK6B19YDfbZDww==
X-Google-Smtp-Source: ADFU+vuYJ4FEHhqKp1ULOQP4BxWE4WCcGej1urOAm1ZQy7sOKoPH70GW5BnhRttob76Zor/FqAJANA==
X-Received: by 2002:a17:90a:345:: with SMTP id 5mr6721841pjf.134.1584057105987;
        Thu, 12 Mar 2020 16:51:45 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id fz3sm10018224pjb.41.2020.03.12.16.51.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2020 16:51:45 -0700 (PDT)
Date:   Thu, 12 Mar 2020 16:51:44 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Todd Kjos <tkjos@android.com>, ard.biesheuvel@linaro.org,
        ardb@kernel.org, john.stultz@linaro.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        naresh.kamboju@linaro.org, shuah@kernel.org,
        Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>, hridya@google.com,
        kernel-team@android.com
Subject: Re: [PATCH 1/3] binderfs: port tests to test harness infrastructure
Message-ID: <202003121651.149266F1@keescook>
References: <20200311105309.1742827-1-christian.brauner@ubuntu.com>
 <20200312131531.3615556-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200312131531.3615556-1-christian.brauner@ubuntu.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 12, 2020 at 02:15:29PM +0100, Christian Brauner wrote:
> Makes for nicer output and prepares for additional tests.
> 
> Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>

Yay harness! :)

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  .../selftests/filesystems/binderfs/Makefile      |  2 ++
>  .../filesystems/binderfs/binderfs_test.c         | 16 ++++++----------
>  2 files changed, 8 insertions(+), 10 deletions(-)
> 
> diff --git a/tools/testing/selftests/filesystems/binderfs/Makefile b/tools/testing/selftests/filesystems/binderfs/Makefile
> index 58cb659b56b4..75315d9ba7a9 100644
> --- a/tools/testing/selftests/filesystems/binderfs/Makefile
> +++ b/tools/testing/selftests/filesystems/binderfs/Makefile
> @@ -3,4 +3,6 @@
>  CFLAGS += -I../../../../../usr/include/
>  TEST_GEN_PROGS := binderfs_test
>  
> +binderfs_test: binderfs_test.c ../../kselftest.h ../../kselftest_harness.h
> +
>  include ../../lib.mk
> diff --git a/tools/testing/selftests/filesystems/binderfs/binderfs_test.c b/tools/testing/selftests/filesystems/binderfs/binderfs_test.c
> index 8c2ed962e1c7..d03ed8eed5eb 100644
> --- a/tools/testing/selftests/filesystems/binderfs/binderfs_test.c
> +++ b/tools/testing/selftests/filesystems/binderfs/binderfs_test.c
> @@ -15,7 +15,9 @@
>  #include <unistd.h>
>  #include <linux/android/binder.h>
>  #include <linux/android/binderfs.h>
> +
>  #include "../../kselftest.h"
> +#include "../../kselftest_harness.h"
>  
>  static ssize_t write_nointr(int fd, const void *buf, size_t count)
>  {
> @@ -252,24 +254,18 @@ static void __do_binderfs_test(void)
>  	ksft_inc_pass_cnt();
>  }
>  
> -static void binderfs_test_privileged()
> +TEST(binderfs_test_privileged)
>  {
>  	if (geteuid() != 0)
> -		ksft_print_msg(
> -			"Tests are not run as root. Skipping privileged tests\n");
> +		ksft_print_msg("Tests are not run as root. Skipping privileged tests\n");
>  	else
>  		__do_binderfs_test();
>  }
>  
> -static void binderfs_test_unprivileged()
> +TEST(binderfs_test_unprivileged)
>  {
>  	change_to_userns();
>  	__do_binderfs_test();
>  }
>  
> -int main(int argc, char *argv[])
> -{
> -	binderfs_test_privileged();
> -	binderfs_test_unprivileged();
> -	ksft_exit_pass();
> -}
> +TEST_HARNESS_MAIN
> 
> base-commit: 2c523b344dfa65a3738e7039832044aa133c75fb
> -- 
> 2.25.1
> 

-- 
Kees Cook
