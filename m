Return-Path: <SRS0=bQGS=5U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35EF9C4332B
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 17:06:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AC5F206C3
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 17:06:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726248AbgDDRGi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Apr 2020 13:06:38 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:54022 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbgDDRGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Apr 2020 13:06:37 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jKmFA-00AWk5-IK; Sat, 04 Apr 2020 17:06:04 +0000
Date:   Sat, 4 Apr 2020 18:06:04 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>, tglx@linutronix.de,
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
Message-ID: <20200404170604.GN23230@ZenIV.linux.org.uk>
References: <20200324220830.110002-1-ndesaulniers@google.com>
 <20200403231611.81444-1-ndesaulniers@google.com>
 <20200404160100.GB26298@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200404160100.GB26298@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 04, 2020 at 06:01:00PM +0200, Oleg Nesterov wrote:
> On 04/03, Nick Desaulniers wrote:
> >
> > --- a/arch/x86/kernel/signal.c
> > +++ b/arch/x86/kernel/signal.c
> > @@ -416,6 +416,7 @@ static int __setup_rt_frame(int sig, struct ksignal *ksig,
> >  	return 0;
> >  Efault:
> >  	user_access_end();
> > +	reset_altstack();
> >  	return -EFAULT;
> >  }
> >  #else /* !CONFIG_X86_32 */
> > @@ -507,6 +508,7 @@ static int __setup_rt_frame(int sig, struct ksignal *ksig,
> >  
> >  Efault:
> >  	user_access_end();
> > +	reset_altstack();
> >  	return -EFAULT;
> >  }
> 
> I must have missed something, but this looks just wrong.
> 
> reset_altstack() should be called when __setup_rt_frame() (and
> unsafe_save_altstack() in particular) succeeds, not when it fails.
> 
> Nevermind, Al has already suggested to use signal_delivered()...

FWIW, I propose to do is the patch below (against the current mainline);
objections?

Don't do sas_ss_reset() until we are certain that sigframe won't be abandoned

Currently we handle SS_AUTODISARM as soon as we have stored the
altstack settings into sigframe - that's the point when we have
set the things up for eventual sigreturn to restore the old settings.
And if we manage to set the sigframe up (we are not done with that
yet), everything's fine.  However, in case of failure we end up
with sigframe-to-be abandoned and SIGSEGV force-delivered.  And
in that case we end up with inconsistent rules - late failures
have altstack reset, early ones do not.

It's trivial to get consistent behaviour - just handle SS_AUTODISARM
once we have set the sigframe up and are committed to entering
the handler, i.e. in signal_delivered().

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
diff --git a/include/linux/compat.h b/include/linux/compat.h
index 0480ba4db592..f614967374f5 100644
--- a/include/linux/compat.h
+++ b/include/linux/compat.h
@@ -461,8 +461,6 @@ int __compat_save_altstack(compat_stack_t __user *, unsigned long);
 			&__uss->ss_sp, label); \
 	unsafe_put_user(t->sas_ss_flags, &__uss->ss_flags, label); \
 	unsafe_put_user(t->sas_ss_size, &__uss->ss_size, label); \
-	if (t->sas_ss_flags & SS_AUTODISARM) \
-		sas_ss_reset(t); \
 } while (0);
 
 /*
diff --git a/include/linux/signal.h b/include/linux/signal.h
index 05bacd2ab135..28fe9cc134f7 100644
--- a/include/linux/signal.h
+++ b/include/linux/signal.h
@@ -450,8 +450,6 @@ int __save_altstack(stack_t __user *, unsigned long);
 	unsafe_put_user((void __user *)t->sas_ss_sp, &__uss->ss_sp, label); \
 	unsafe_put_user(t->sas_ss_flags, &__uss->ss_flags, label); \
 	unsafe_put_user(t->sas_ss_size, &__uss->ss_size, label); \
-	if (t->sas_ss_flags & SS_AUTODISARM) \
-		sas_ss_reset(t); \
 } while (0);
 
 #ifdef CONFIG_PROC_FS
diff --git a/kernel/signal.c b/kernel/signal.c
index e58a6c619824..4cfe0b9af588 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2769,6 +2769,8 @@ static void signal_delivered(struct ksignal *ksig, int stepping)
 	if (!(ksig->ka.sa.sa_flags & SA_NODEFER))
 		sigaddset(&blocked, ksig->sig);
 	set_current_blocked(&blocked);
+	if (current->sas_ss_flags & SS_AUTODISARM)
+		sas_ss_reset(current);
 	tracehook_signal_handler(stepping);
 }
 
@@ -4070,11 +4072,7 @@ int __save_altstack(stack_t __user *uss, unsigned long sp)
 	int err = __put_user((void __user *)t->sas_ss_sp, &uss->ss_sp) |
 		__put_user(t->sas_ss_flags, &uss->ss_flags) |
 		__put_user(t->sas_ss_size, &uss->ss_size);
-	if (err)
-		return err;
-	if (t->sas_ss_flags & SS_AUTODISARM)
-		sas_ss_reset(t);
-	return 0;
+	return err;
 }
 
 #ifdef CONFIG_COMPAT
@@ -4129,11 +4127,7 @@ int __compat_save_altstack(compat_stack_t __user *uss, unsigned long sp)
 			 &uss->ss_sp) |
 		__put_user(t->sas_ss_flags, &uss->ss_flags) |
 		__put_user(t->sas_ss_size, &uss->ss_size);
-	if (err)
-		return err;
-	if (t->sas_ss_flags & SS_AUTODISARM)
-		sas_ss_reset(t);
-	return 0;
+	return err;
 }
 #endif
 
