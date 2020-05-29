Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24B4CC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 20:37:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0979B2075A
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 20:37:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728207AbgE2UhL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 16:37:11 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:56278 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727024AbgE2UhK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 16:37:10 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <seth.forshee@canonical.com>)
        id 1jelka-0004ki-1A
        for linux-kernel@vger.kernel.org; Fri, 29 May 2020 20:37:08 +0000
Received: by mail-io1-f71.google.com with SMTP id c15so472292iom.15
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 13:37:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=H5Cje8enJHccYExZgxsG4qWoyTyd0dqBTrkvQHopa8A=;
        b=PTM5yfas4kIThJfkccaa726KoKrWkehP+/8AR6z98jUO10m2EO8aSshq4LcVTKU8w4
         psCwHIpP+VQBCIznF1NaE1kg4607kRDCjo80nZ169GbiRx6OzJu0IRrIfcjiYxp7m0S5
         FD9Wnzz0WmgTgRPJ2MrhkqSvh/8Hrgz028NU6mW/kd2J8DWg2M3o0mHoBot54iJ4LFq2
         /IU8A2NCOECcuwuiCh122x2ChlYJVETJSKBbVxC38uZ3ZJW2HF9HiTteETq/Eqd1NRsC
         4gHgPHp6X/RWBf3jmkZdkpegBoaOTYD5/dZC1nAaDrW5BBjF39ZIuJNd3EO2JKhp+bsS
         Cyiw==
X-Gm-Message-State: AOAM532N8cV59tE4qpX3tzhby+gxSnBH5JZv1L6NlNiRdF72BptMFX4d
        ueTHWXuckcBQDFiu4EAIeDI5EXYGbqF/1szwjRP7TO4U7NiK0f3RpBRe2JlW0IORKj9gEVYIFiv
        HNf3JBKyEc0ilo62eGh9h2RVc4y0uQfEkIpuZXekI8w==
X-Received: by 2002:a92:8752:: with SMTP id d18mr9552161ilm.224.1590784626928;
        Fri, 29 May 2020 13:37:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJynB9hPXKwUhGIEurQjzDbw+wTXaTe4XHhQxUXV3Za6iqVJm6b+iQ6ywueffW0euC84TrEkiw==
X-Received: by 2002:a92:8752:: with SMTP id d18mr9552132ilm.224.1590784626596;
        Fri, 29 May 2020 13:37:06 -0700 (PDT)
Received: from localhost ([2605:a601:af9b:a120:3a:9575:4d23:d28e])
        by smtp.gmail.com with ESMTPSA id y12sm5655695ilk.16.2020.05.29.13.37.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2020 13:37:05 -0700 (PDT)
Date:   Fri, 29 May 2020 15:37:04 -0500
From:   Seth Forshee <seth.forshee@canonical.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] selftests/ftrace: Use printf instead of echo in
 kprobe syntax error tests
Message-ID: <20200529203704.GA57013@ubuntu-x1>
References: <20200304222009.34663-1-seth.forshee@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200304222009.34663-1-seth.forshee@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 04, 2020 at 04:20:09PM -0600, Seth Forshee wrote:
> Test cases which use echo to write strings containing backslashes
> fail with some shells, as echo's treatment of backslashes in
> strings varies between shell implementations. Use printf instead,
> as it should behave consistently across different shells. This
> requires adjustments to the strings to escape \ and % characters.
> ftrace_errlog_check() must also re-escape these characters after
> processing them to remove ^ characters.
> 
> Signed-off-by: Seth Forshee <seth.forshee@canonical.com>

Ping. Someone just asked me about this patch, and I noticed that it
hasn't been applied or received any feedback.

> ---
> Changes in v2:
>  - Escape backslashes for a couple of additional tests
> 
>  .../testing/selftests/ftrace/test.d/functions |  6 +++---
>  .../test.d/kprobe/kprobe_syntax_errors.tc     | 20 +++++++++----------
>  2 files changed, 13 insertions(+), 13 deletions(-)
> 
> diff --git a/tools/testing/selftests/ftrace/test.d/functions b/tools/testing/selftests/ftrace/test.d/functions
> index 5d4550591ff9..b38c6eb029e8 100644
> --- a/tools/testing/selftests/ftrace/test.d/functions
> +++ b/tools/testing/selftests/ftrace/test.d/functions
> @@ -114,11 +114,11 @@ yield() {
>  }
>  
>  ftrace_errlog_check() { # err-prefix command-with-error-pos-by-^ command-file
> -    pos=$(echo -n "${2%^*}" | wc -c) # error position
> -    command=$(echo "$2" | tr -d ^)
> +    pos=$(printf "${2%^*}" | wc -c) # error position
> +    command=$(printf "$2" | sed -e 's/\^//g' -e 's/%/%%/g' -e 's/\\/\\\\/g')
>      echo "Test command: $command"
>      echo > error_log
> -    (! echo "$command" >> "$3" ) 2> /dev/null
> +    (! printf "$command" >> "$3" ) 2> /dev/null
>      grep "$1: error:" -A 3 error_log
>      N=$(tail -n 1 error_log | wc -c)
>      # "  Command: " and "^\n" => 13
> diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc
> index ef1e9bafb098..039c03d230b9 100644
> --- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc
> +++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc
> @@ -37,14 +37,14 @@ fi
>  
>  check_error 'p vfs_read ^$none_var'	# BAD_VAR
>  
> -check_error 'p vfs_read ^%none_reg'	# BAD_REG_NAME
> +check_error 'p vfs_read ^%%none_reg'	# BAD_REG_NAME
>  check_error 'p vfs_read ^@12345678abcde'	# BAD_MEM_ADDR
>  check_error 'p vfs_read ^@+10'		# FILE_ON_KPROBE
>  
>  grep -q "imm-value" README && \
> -check_error 'p vfs_read arg1=\^x'	# BAD_IMM
> +check_error 'p vfs_read arg1=\\^x'	# BAD_IMM
>  grep -q "imm-string" README && \
> -check_error 'p vfs_read arg1=\"abcd^'	# IMMSTR_NO_CLOSE
> +check_error 'p vfs_read arg1=\\"abcd^'	# IMMSTR_NO_CLOSE
>  
>  check_error 'p vfs_read ^+0@0)'		# DEREF_NEED_BRACE
>  check_error 'p vfs_read ^+0ab1(@0)'	# BAD_DEREF_OFFS
> @@ -80,7 +80,7 @@ check_error 'p vfs_read arg1=^'			# NO_ARG_BODY
>  # instruction boundary check is valid on x86 (at this moment)
>  case $(uname -m) in
>    x86_64|i[3456]86)
> -    echo 'p vfs_read' > kprobe_events
> +    printf 'p vfs_read' > kprobe_events
>      if grep -q FTRACE ../kprobes/list ; then
>  	check_error 'p ^vfs_read+3'		# BAD_INSN_BNDRY (only if function-tracer is enabled)
>      fi
> @@ -89,13 +89,13 @@ esac
>  
>  # multiprobe errors
>  if grep -q "Create/append/" README && grep -q "imm-value" README; then
> -echo 'p:kprobes/testevent _do_fork' > kprobe_events
> +printf 'p:kprobes/testevent _do_fork' > kprobe_events
>  check_error '^r:kprobes/testevent do_exit'	# DIFF_PROBE_TYPE
> -echo 'p:kprobes/testevent _do_fork abcd=\1' > kprobe_events
> -check_error 'p:kprobes/testevent _do_fork ^bcd=\1'	# DIFF_ARG_TYPE
> -check_error 'p:kprobes/testevent _do_fork ^abcd=\1:u8'	# DIFF_ARG_TYPE
> -check_error 'p:kprobes/testevent _do_fork ^abcd=\"foo"'	# DIFF_ARG_TYPE
> -check_error '^p:kprobes/testevent _do_fork abcd=\1'	# SAME_PROBE
> +printf 'p:kprobes/testevent _do_fork abcd=\\1' > kprobe_events
> +check_error 'p:kprobes/testevent _do_fork ^bcd=\\1'	# DIFF_ARG_TYPE
> +check_error 'p:kprobes/testevent _do_fork ^abcd=\\1:u8'	# DIFF_ARG_TYPE
> +check_error 'p:kprobes/testevent _do_fork ^abcd=\\"foo"'# DIFF_ARG_TYPE
> +check_error '^p:kprobes/testevent _do_fork abcd=\\1'	# SAME_PROBE
>  fi
>  
>  exit 0
> -- 
> 2.25.0
> 
