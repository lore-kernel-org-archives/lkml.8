Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F075FC3F2D1
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 21:49:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D364C20717
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 21:49:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388441AbgCDVto (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 16:49:44 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:44648 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388312AbgCDVtn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 16:49:43 -0500
Received: from mail-yw1-f70.google.com ([209.85.161.70])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <seth.forshee@canonical.com>)
        id 1j9btd-0000WF-4v
        for linux-kernel@vger.kernel.org; Wed, 04 Mar 2020 21:49:41 +0000
Received: by mail-yw1-f70.google.com with SMTP id w185so4666445ywa.22
        for <linux-kernel@vger.kernel.org>; Wed, 04 Mar 2020 13:49:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=D15ynwrrHMGu8Lvf29PfzDkO2Xnj0Kx0WtMUcRAoGUk=;
        b=qoWQGSSu/tFHv8n1zwRep6M0w8gOzEnTnGgWSITy8RY1i92WhHypPPLqIeE5ehpgJm
         ikKLO32hhoo6dG7MBS8eg7o9eOVWx8rk5ttTptc4+5aD8XLFlpsx2O4uQkAlde9OsQST
         FRaLmBW+RErO1VW4i28DXK7mUfXgiXOi86AC6v8erm3nnHWjlKEAoIS0ykauHbX1HSRt
         im6CC1qJoCCyNS5C89hs+2TVkLGJDZAm532KbO+PnK6TFRmv0j2DLqm11FztAUJYnON/
         oWps5hVQFRi6dywVEsjioL+/U1isGBvPNhiX2CTbE3aQKGSm8Uh5ha+5yaT8uurDyVcB
         U5WA==
X-Gm-Message-State: ANhLgQ3JMUgiSAyBYZ65sExLKB2N9h13OzhtDnqMLDpZiM+TQBVYUyTT
        VBM4x6nzqth12atvf6CYt6VmGLojAgW2ESsBAlxjK1sWKObQnhzvOD+i2g38Y59VDgU6qkOoNIg
        oGAdjKzX8vZ/+0/szJK8dGSyJJbKfvZ8l1Vg3eTHOGg==
X-Received: by 2002:a81:1c0a:: with SMTP id c10mr3094621ywc.142.1583358580153;
        Wed, 04 Mar 2020 13:49:40 -0800 (PST)
X-Google-Smtp-Source: ADFU+vvZJaZ2FtmAIkALFVCfi34cHUNwTZA1Ei8eY+3Av/7AbgzCPgrLFiRi2PMqNWVrh806Nnr7ZA==
X-Received: by 2002:a81:1c0a:: with SMTP id c10mr3094602ywc.142.1583358579744;
        Wed, 04 Mar 2020 13:49:39 -0800 (PST)
Received: from localhost ([2605:a601:af9b:a120:d987:fd11:6482:bff3])
        by smtp.gmail.com with ESMTPSA id d2sm5077945ywe.36.2020.03.04.13.49.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 13:49:38 -0800 (PST)
Date:   Wed, 4 Mar 2020 15:49:37 -0600
From:   Seth Forshee <seth.forshee@canonical.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/ftrace: Use printf instead of echo in kprobe
 syntax error tests
Message-ID: <20200304214937.GA2347@ubuntu-x1>
References: <20200304161435.23019-1-seth.forshee@canonical.com>
 <20200304155004.7dd033a3@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200304155004.7dd033a3@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 04, 2020 at 03:50:04PM -0500, Steven Rostedt wrote:
> On Wed,  4 Mar 2020 10:14:35 -0600
> Seth Forshee <seth.forshee@canonical.com> wrote:
> 
> > --- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc
> > +++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc
> > @@ -37,7 +37,7 @@ fi
> >  
> >  check_error 'p vfs_read ^$none_var'	# BAD_VAR
> >  
> > -check_error 'p vfs_read ^%none_reg'	# BAD_REG_NAME
> > +check_error 'p vfs_read ^%%none_reg'	# BAD_REG_NAME
> >  check_error 'p vfs_read ^@12345678abcde'	# BAD_MEM_ADDR
> >  check_error 'p vfs_read ^@+10'		# FILE_ON_KPROBE
> >  
> > @@ -80,7 +80,7 @@ check_error 'p vfs_read arg1=^'			# NO_ARG_BODY
> >  # instruction boundary check is valid on x86 (at this moment)
> >  case $(uname -m) in
> >    x86_64|i[3456]86)
> > -    echo 'p vfs_read' > kprobe_events
> > +    printf 'p vfs_read' > kprobe_events
> >      if grep -q FTRACE ../kprobes/list ; then
> >  	check_error 'p ^vfs_read+3'		# BAD_INSN_BNDRY (only if function-tracer is enabled)
> >      fi
> > @@ -89,13 +89,13 @@ esac
> >  
> >  # multiprobe errors
> >  if grep -q "Create/append/" README && grep -q "imm-value" README; then
> > -echo 'p:kprobes/testevent _do_fork' > kprobe_events
> > +printf 'p:kprobes/testevent _do_fork' > kprobe_events
> >  check_error '^r:kprobes/testevent do_exit'	# DIFF_PROBE_TYPE
> > -echo 'p:kprobes/testevent _do_fork abcd=\1' > kprobe_events
> > -check_error 'p:kprobes/testevent _do_fork ^bcd=\1'	# DIFF_ARG_TYPE
> > -check_error 'p:kprobes/testevent _do_fork ^abcd=\1:u8'	# DIFF_ARG_TYPE
> > -check_error 'p:kprobes/testevent _do_fork ^abcd=\"foo"'	# DIFF_ARG_TYPE
> > -check_error '^p:kprobes/testevent _do_fork abcd=\1'	# SAME_PROBE
> > +printf 'p:kprobes/testevent _do_fork abcd=\\1' > kprobe_events
> > +check_error 'p:kprobes/testevent _do_fork ^bcd=\\1'	# DIFF_ARG_TYPE
> > +check_error 'p:kprobes/testevent _do_fork ^abcd=\\1:u8'	# DIFF_ARG_TYPE
> > +check_error 'p:kprobes/testevent _do_fork ^abcd=\\"foo"'# DIFF_ARG_TYPE
> > +check_error '^p:kprobes/testevent _do_fork abcd=\\1'	# SAME_PROBE
> >  fi
> >  
> >  exit 0
> 
> 
> This change causes my tests to fail:
> 
> ++ echo 'Test command: p vfs_read arg1="abcd'
> Test command: p vfs_read arg1="abcd
> ++ echo
> ++ grep 'trace_kprobe: error:' -A 3 error_log
> [61913.240093] trace_kprobe: error: Invalid fetch argument
>   Command: p vfs_read arg1="abcd
>                            ^
> +++ tail -n 1 error_log
> +++ wc -c
> ++ N=29
> +++ expr 13 + 21
> ++ test 34 -eq 29

Ah, I did miss a couple of backslashes that need to be escaped there.
The test passes for me without it though, so mabye printf behavior is
less consistent than I thought.

I'll send a v2, hopefully it will work better for you.

Seth
