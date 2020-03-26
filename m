Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84497C43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 12:38:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A4F020409
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 12:38:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cz8v/be9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728239AbgCZMiw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 08:38:52 -0400
Received: from mail-wm1-f73.google.com ([209.85.128.73]:52951 "EHLO
        mail-wm1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727841AbgCZMiv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 08:38:51 -0400
Received: by mail-wm1-f73.google.com with SMTP id w9so2122553wmi.2
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 05:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:cc;
        bh=8yqBrfdJM+UOOeS4se8770yNMpiUTGHQoT5T8DP4qB8=;
        b=cz8v/be9ZLdMPE+hQeq2vnACmD7uqiN8Lq6TKluF0QZdRurVUMGO/Nkjigif91QwY5
         3olUJsW79QJtQwo5MICQlAayampaZfYhnd5DOxSPhJlu6zUUdJM4An/CEtBX5syjwFrG
         bFnI62fgBXnQKzFiADNm0p+P0J0/oahYLaUiZInfTgRUpLv+HtnQmtyNYbeQ+PWoZQQK
         IYDBtpV7vZAFYxyrL9CbgSFM7vWPsht7QzsRMnfxoDLktjlvax679zqjDQ4VWW+T+eBz
         0A3H7eBt/5Jv9KIkWdE4h5ZCPUq39MtsDrxg0UgLD53g4NY0vJV698NDiz7G7dKZr725
         4Qgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:cc;
        bh=8yqBrfdJM+UOOeS4se8770yNMpiUTGHQoT5T8DP4qB8=;
        b=YHbThTposXPbzFR89r09dXciOc6whkFzREhvrb4OMHw3JJcb42xzZv9bjdXof7HclR
         TcL43ObWOpsPl9x6WpPfbl1mogyIq8uWjc+i8TIcvx88ZOY30mcDRptIY6Km82XmcEBG
         wsG6QywO/Bk2U63MJn5bOHcGCywqGvcA6E1tKe4KpxQi3wJttwd8/xomVn8V8vRXvHgX
         IwuTOJc/gyAbMyrsnwf7K9a5IuBjYHOumrUi5U3+Be1ZwqkTctGGkYmG3vbY8B2KEWb+
         cq/wPaavC/RBDFsdmDQ4u5ungPVJ2oXhuEY4M9TSA4kUYym0ru5mE/3y6PNNoi9Vz6nN
         oicQ==
X-Gm-Message-State: ANhLgQ1w0M7Y6oDtYZk4XGXZkvpKchFMM1RAQQzIdKBxoCMKihR9Bcnc
        12GSnCm/fADI5+sB/gve9lbtls6jAdXv
X-Google-Smtp-Source: ADFU+vtfeWdsMSn3bw0z8r9AjHsg1/TKeAFFpdNBrMjpIkIssmcXGEq6QCd9HvQD+cKah5CpMN25OCh4DKvH
X-Received: by 2002:adf:a2d8:: with SMTP id t24mr9044184wra.366.1585226330006;
 Thu, 26 Mar 2020 05:38:50 -0700 (PDT)
Date:   Thu, 26 Mar 2020 13:38:39 +0100
In-Reply-To: <20200323114207.222412-1-courbet@google.com>
Message-Id: <20200326123841.134068-1-courbet@google.com>
Mime-Version: 1.0
References: <20200323114207.222412-1-courbet@google.com>
X-Mailer: git-send-email 2.25.1.696.g5e7596f4ac-goog
Subject: [PATCH]     x86: Alias memset to __builtin_memset.
From:   Clement Courbet <courbet@google.com>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Joe Perches <joe@perches.com>,
        Bernd Petrovitsch <bernd@petrovitsch.priv.at>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Allison Randal <allison@lohutok.net>,
        Clement Courbet <courbet@google.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I discussed with the original authors who added freestanding to our
build. It turns out that it was added globally but this was just to
to workaround powerpc not compiling under clang, but they felt the
fix was appropriate globally.

Now Nick has dug up https://lkml.org/lkml/2019/8/29/1300, which
advises against freestanding. Also, I've did some research and
discovered that the original reason for using freestanding for
powerpc has been fixed here:
https://lore.kernel.org/linuxppc-dev/20191119045712.39633-3-natechancellor@gmail.com/

I'm going to remove -ffreestanding from downstream, so we don't really need
this anymore, sorry for waisting people's time.

I wonder if the freestanding fix from the aforementioned patch is really needed
though. I think that clang is actually right to point out the issue.
I don't see any reason why setjmp()/longjmp() are declared as taking longs
rather than ints. The implementation looks like it only ever propagates the
value (in longjmp) or sets it to 1 (in setjmp), and we only ever call longjmp
with integer parameters. But I'm not a PowerPC expert, so I might
be misreading the code.


So it seems that we could just remove freestanding altogether and rewrite the
code to:

diff --git a/arch/powerpc/include/asm/setjmp.h b/arch/powerpc/include/asm/setjmp.h
index 279d03a1eec6..7941ae68fe21 100644
--- a/arch/powerpc/include/asm/setjmp.h
+++ b/arch/powerpc/include/asm/setjmp.h
@@ -12,7 +12,9 @@

 #define JMP_BUF_LEN    23
-extern long setjmp(long *);
-extern void longjmp(long *, long);
+typedef long * jmp_buf;
+
+extern int setjmp(jmp_buf);
+extern void longjmp(jmp_buf, int);

I'm happy to send a patch for this, and get rid of more -ffreestanding.
Opinions ?
