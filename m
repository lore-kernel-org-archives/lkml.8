Return-Path: <SRS0=bQGS=5U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B76AC2BA15
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 22:54:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF174206E6
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 22:54:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GjML8U5N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726423AbgDDWuk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Apr 2020 18:50:40 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:46720 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726315AbgDDWuj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Apr 2020 18:50:39 -0400
Received: by mail-ot1-f68.google.com with SMTP id 111so11357482oth.13
        for <linux-kernel@vger.kernel.org>; Sat, 04 Apr 2020 15:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QlGS9JyX8iCTAx/m9fGGWb+D9lnYRdPinBIcwJqWSDA=;
        b=GjML8U5NHhOSkWV1EjO/0vNJZ83wZw9JCPx76NZV98f/kwQJ5dO5Uvd7FowKhCrHs9
         mcQpiMfoITIhzLiqyaiVshW7rBVWDtkJqiat4QyHNsIE4Y0DAPW8zU0j6Pzu4Cxp2idw
         pWMZ/WE2HFexDETKOOUb0Bm8ffIOyFOdlSu8MbxDNUTdGyIowLS1FrmmUINMT89MrezD
         U9HuGFJkPbcwVhc+ku9vHYq/ozAUtVwhTKwYL2KqsMlV8VtsZTxgfztGV+WqnTHMOfCP
         xxIlQGgi56zyuoGA6GQNd56lzbOWROzjRlV/uyUqRp29pw2D7cQt169cwOykL51KxuAy
         F41g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QlGS9JyX8iCTAx/m9fGGWb+D9lnYRdPinBIcwJqWSDA=;
        b=YuRfJfd5+69GVJO+x7NEbP+tSJexmJYcg0J5YoKZUJn+tEkTsexffkx5ZshJGjLLuA
         fZwMbxTD1gRKpMuUHjlO64gmW9apXd1TjNrjmNm2wrW8ZOURWfau5D0lXnpItd7NkBWa
         HQCEnWiG8ZWYDVIxgu4HpKfIChWigVt1aNeUqlNVzDFVPDG4sfQk/HAqw3L79fnjIECb
         W2jVR7GpILPYI9oukAw8ahP2cgS4k4KOke/XaeqS/QCWmmHFj/MgJkGJx/jTQazrE8Br
         H2N1xmDBUqSGa7S4a2oGenLyGosMO48Seb6wuOmTx6gWinAXgjPX+SF0ja45eslgnqdJ
         Kfgg==
X-Gm-Message-State: AGi0PuaB0DdTfcu7WyYPEuYEuWwvZmFGD0fOM+BAZFxO/5Pqd0WJjQDJ
        jK/t4SH+xbR2bRBjeQ3D9Ek=
X-Google-Smtp-Source: APiQypJgpdxnXcJlghzVhxh1RcY8j58ay4JCsM2xutl5BB9TsKdwmvUnz3t5Y/2TtrlzN1O14Q14yQ==
X-Received: by 2002:a9d:178a:: with SMTP id j10mr11731075otj.182.1586040638463;
        Sat, 04 Apr 2020 15:50:38 -0700 (PDT)
Received: from ubuntu-m2-xlarge-x86 ([2604:1380:4111:8b00::1])
        by smtp.gmail.com with ESMTPSA id q12sm3262874otn.43.2020.04.04.15.50.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 04 Apr 2020 15:50:37 -0700 (PDT)
Date:   Sat, 4 Apr 2020 15:50:36 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Nick Desaulniers <ndesaulniers@google.com>, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de,
        Peter Zijlstra <peterz@infradead.org>,
        clang-built-linux@googlegroups.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Marco Elver <elver@google.com>,
        Brian Gerst <brgerst@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] x86: signal: move save_altstack_ex out of generic
 headers
Message-ID: <20200404225036.GA12416@ubuntu-m2-xlarge-x86>
References: <20200324220830.110002-1-ndesaulniers@google.com>
 <20200403231611.81444-1-ndesaulniers@google.com>
 <20200404160100.GB26298@redhat.com>
 <20200404170604.GN23230@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200404170604.GN23230@ZenIV.linux.org.uk>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 04, 2020 at 06:06:04PM +0100, Al Viro wrote:
> On Sat, Apr 04, 2020 at 06:01:00PM +0200, Oleg Nesterov wrote:
> > On 04/03, Nick Desaulniers wrote:
> > >
> > > --- a/arch/x86/kernel/signal.c
> > > +++ b/arch/x86/kernel/signal.c
> > > @@ -416,6 +416,7 @@ static int __setup_rt_frame(int sig, struct ksignal *ksig,
> > >  	return 0;
> > >  Efault:
> > >  	user_access_end();
> > > +	reset_altstack();
> > >  	return -EFAULT;
> > >  }
> > >  #else /* !CONFIG_X86_32 */
> > > @@ -507,6 +508,7 @@ static int __setup_rt_frame(int sig, struct ksignal *ksig,
> > >  
> > >  Efault:
> > >  	user_access_end();
> > > +	reset_altstack();
> > >  	return -EFAULT;
> > >  }
> > 
> > I must have missed something, but this looks just wrong.
> > 
> > reset_altstack() should be called when __setup_rt_frame() (and
> > unsafe_save_altstack() in particular) succeeds, not when it fails.
> > 
> > Nevermind, Al has already suggested to use signal_delivered()...
> 
> FWIW, I propose to do is the patch below (against the current mainline);
> objections?
> 
> Don't do sas_ss_reset() until we are certain that sigframe won't be abandoned
> 
> Currently we handle SS_AUTODISARM as soon as we have stored the
> altstack settings into sigframe - that's the point when we have
> set the things up for eventual sigreturn to restore the old settings.
> And if we manage to set the sigframe up (we are not done with that
> yet), everything's fine.  However, in case of failure we end up
> with sigframe-to-be abandoned and SIGSEGV force-delivered.  And
> in that case we end up with inconsistent rules - late failures
> have altstack reset, early ones do not.
> 
> It's trivial to get consistent behaviour - just handle SS_AUTODISARM
> once we have set the sigframe up and are committed to entering
> the handler, i.e. in signal_delivered().
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
> diff --git a/include/linux/compat.h b/include/linux/compat.h
> index 0480ba4db592..f614967374f5 100644
> --- a/include/linux/compat.h
> +++ b/include/linux/compat.h
> @@ -461,8 +461,6 @@ int __compat_save_altstack(compat_stack_t __user *, unsigned long);
>  			&__uss->ss_sp, label); \
>  	unsafe_put_user(t->sas_ss_flags, &__uss->ss_flags, label); \
>  	unsafe_put_user(t->sas_ss_size, &__uss->ss_size, label); \
> -	if (t->sas_ss_flags & SS_AUTODISARM) \
> -		sas_ss_reset(t); \
>  } while (0);
>  
>  /*
> diff --git a/include/linux/signal.h b/include/linux/signal.h
> index 05bacd2ab135..28fe9cc134f7 100644
> --- a/include/linux/signal.h
> +++ b/include/linux/signal.h
> @@ -450,8 +450,6 @@ int __save_altstack(stack_t __user *, unsigned long);
>  	unsafe_put_user((void __user *)t->sas_ss_sp, &__uss->ss_sp, label); \
>  	unsafe_put_user(t->sas_ss_flags, &__uss->ss_flags, label); \
>  	unsafe_put_user(t->sas_ss_size, &__uss->ss_size, label); \
> -	if (t->sas_ss_flags & SS_AUTODISARM) \
> -		sas_ss_reset(t); \
>  } while (0);
>  
>  #ifdef CONFIG_PROC_FS
> diff --git a/kernel/signal.c b/kernel/signal.c
> index e58a6c619824..4cfe0b9af588 100644
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -2769,6 +2769,8 @@ static void signal_delivered(struct ksignal *ksig, int stepping)
>  	if (!(ksig->ka.sa.sa_flags & SA_NODEFER))
>  		sigaddset(&blocked, ksig->sig);
>  	set_current_blocked(&blocked);
> +	if (current->sas_ss_flags & SS_AUTODISARM)
> +		sas_ss_reset(current);
>  	tracehook_signal_handler(stepping);
>  }
>  
> @@ -4070,11 +4072,7 @@ int __save_altstack(stack_t __user *uss, unsigned long sp)
>  	int err = __put_user((void __user *)t->sas_ss_sp, &uss->ss_sp) |
>  		__put_user(t->sas_ss_flags, &uss->ss_flags) |
>  		__put_user(t->sas_ss_size, &uss->ss_size);
> -	if (err)
> -		return err;
> -	if (t->sas_ss_flags & SS_AUTODISARM)
> -		sas_ss_reset(t);
> -	return 0;
> +	return err;
>  }
>  
>  #ifdef CONFIG_COMPAT
> @@ -4129,11 +4127,7 @@ int __compat_save_altstack(compat_stack_t __user *uss, unsigned long sp)
>  			 &uss->ss_sp) |
>  		__put_user(t->sas_ss_flags, &uss->ss_flags) |
>  		__put_user(t->sas_ss_size, &uss->ss_size);
> -	if (err)
> -		return err;
> -	if (t->sas_ss_flags & SS_AUTODISARM)
> -		sas_ss_reset(t);
> -	return 0;
> +	return err;
>  }
>  #endif
>  
> 

On next-20200404, this makes the three objtool warnings about the call
to memset() with UACCESS disabled disappear and does not add any new
ones.

Tested-by: Nathan Chancellor <natechancellor@gmail.com>
