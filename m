Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44B3FC2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 20:22:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18D842073E
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 20:22:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="H4CZRE6V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726838AbgCQUWR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 16:22:17 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:56305 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726814AbgCQUWQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 16:22:16 -0400
Received: by mail-pj1-f66.google.com with SMTP id mj6so239039pjb.5
        for <linux-kernel@vger.kernel.org>; Tue, 17 Mar 2020 13:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZgC1djA04wl+1UG3Cj/HuSgpbFsTOFgzHvgdTKPnNp0=;
        b=H4CZRE6VMBbEB8Hji3lWwaUwDqxZC4Bg0d0oIh9tBOL3zcGJGcAzVKyygFDdErRQqK
         XDcn8dp06tPeWFz0YtmiV/5tsttgeqM4wNdTLQw6UsOAORNBPI6LDhW+QOSB430n8xUE
         QBNl+T73+DJnkrAsh4odZ/nDT9fwkCbgcIHEA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZgC1djA04wl+1UG3Cj/HuSgpbFsTOFgzHvgdTKPnNp0=;
        b=CivBWaznjnZ6XfSK28Dv7AV2OLvcxAmsmdJxHNHZ5gn6xGV0+zXCr8TCDjJHKAJf1+
         KtfwYrnM5DDTNfETPYDd5NdQohpChZaA/rGeRHRMBJnw8Sj2Prh6o/uau0RTIJAq6kJH
         tVfUTQgt9R/eu9APRdeoXTuk5bZ+t8P1La3QhBgRqIKC0J898GlyZTL2TLE5l4OB+F3x
         o6RhJ+KK6IxhscOPmIkG79LkmVDAPJzt3pgYvqdICcUhvn/7aILnvsZzRN2j2KvEGOzc
         MI0ZgDVYMqIZjZ72gKvePn55t50wFp7WSTB+xSruXz+jRmWG/VmWT6TL1Yw1SQ6wiq5E
         cIYw==
X-Gm-Message-State: ANhLgQ3PsDEp/2v8H25yLnKXWhuBtMEI3ZnJ3gOsKLzC3Pv5l8psDKlm
        tCCkJtbP5FmJ16ZHrHd8OAm8FA==
X-Google-Smtp-Source: ADFU+vum1LO9z60NL3vOdRKNvZEfXZRFeaxNqaAhzjZZv6nhKQLnS+tqyBPjXOmirwHuPkOWOfoBdg==
X-Received: by 2002:a17:90a:324b:: with SMTP id k69mr1022491pjb.50.1584476533955;
        Tue, 17 Mar 2020 13:22:13 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id v1sm230341pjy.35.2020.03.17.13.22.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2020 13:22:13 -0700 (PDT)
Date:   Tue, 17 Mar 2020 13:22:12 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     shuah@kernel.org, luto@amacapital.net, wad@chromium.org,
        linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com, Tim.Bird@sony.com
Subject: Re: [PATCH v3 1/6] selftests/seccomp: use correct FIXTURE macro
Message-ID: <202003171322.77AD2BA3B@keescook>
References: <20200316225647.3129354-1-kuba@kernel.org>
 <20200316225647.3129354-2-kuba@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200316225647.3129354-2-kuba@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 16, 2020 at 03:56:41PM -0700, Jakub Kicinski wrote:
> Quoting kdoc:
> 
> FIXTURE_DATA:
>  * This call may be used when the type of the fixture data
>  * is needed.  In general, this should not be needed unless
>  * the *self* is being passed to a helper directly.
> 
> FIXTURE:
>  * Defines the data provided to TEST_F()-defined tests as *self*.  It should be
>  * populated and cleaned up using FIXTURE_SETUP() and FIXTURE_TEARDOWN().
> 
> seccomp should use FIXTURE to declare types.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Acked-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  tools/testing/selftests/seccomp/seccomp_bpf.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
> index ee1b727ede04..7bf82fb07f67 100644
> --- a/tools/testing/selftests/seccomp/seccomp_bpf.c
> +++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
> @@ -909,7 +909,7 @@ TEST(ERRNO_order)
>  	EXPECT_EQ(12, errno);
>  }
>  
> -FIXTURE_DATA(TRAP) {
> +FIXTURE(TRAP) {
>  	struct sock_fprog prog;
>  };
>  
> @@ -1020,7 +1020,7 @@ TEST_F(TRAP, handler)
>  	EXPECT_NE(0, (unsigned long)sigsys->_call_addr);
>  }
>  
> -FIXTURE_DATA(precedence) {
> +FIXTURE(precedence) {
>  	struct sock_fprog allow;
>  	struct sock_fprog log;
>  	struct sock_fprog trace;
> @@ -1509,7 +1509,7 @@ void tracer_poke(struct __test_metadata *_metadata, pid_t tracee, int status,
>  	EXPECT_EQ(0, ret);
>  }
>  
> -FIXTURE_DATA(TRACE_poke) {
> +FIXTURE(TRACE_poke) {
>  	struct sock_fprog prog;
>  	pid_t tracer;
>  	long poked;
> @@ -1817,7 +1817,7 @@ void tracer_ptrace(struct __test_metadata *_metadata, pid_t tracee,
>  		change_syscall(_metadata, tracee, -1, -ESRCH);
>  }
>  
> -FIXTURE_DATA(TRACE_syscall) {
> +FIXTURE(TRACE_syscall) {
>  	struct sock_fprog prog;
>  	pid_t tracer, mytid, mypid, parent;
>  };
> @@ -2321,7 +2321,7 @@ struct tsync_sibling {
>  		}							\
>  	} while (0)
>  
> -FIXTURE_DATA(TSYNC) {
> +FIXTURE(TSYNC) {
>  	struct sock_fprog root_prog, apply_prog;
>  	struct tsync_sibling sibling[TSYNC_SIBLINGS];
>  	sem_t started;
> -- 
> 2.24.1
> 

-- 
Kees Cook
