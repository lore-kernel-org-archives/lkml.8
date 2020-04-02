Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1436AC43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 04:47:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3A462063A
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 04:47:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dhL14h93"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727756AbgDBErT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 00:47:19 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:37826 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726136AbgDBErS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 00:47:18 -0400
Received: by mail-lf1-f66.google.com with SMTP id t11so1609627lfe.4
        for <linux-kernel@vger.kernel.org>; Wed, 01 Apr 2020 21:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jR+qIpvmW6w7QrK4EeBLopQUhlKrIw/Ns9wdRSazZHg=;
        b=dhL14h93WaTSS60LNQEAJklTYojZDe/3+TROSGuTio9zoR60uehsWr2N4rY72cS7ID
         p7V1dDyTiUIG/uvQskYbl++LLTRxwNQr7JiiQdsayyMYivkebSEkaSzCp1+ThLQXWlP7
         nF31UQamN1nET3f15oAP1v7rfok+scYPxpTthr96Y3KgwRUq4Uqsk3Yx6suqCBnJeIco
         Ee8U+8V+KAOatHUJnjY3NJpi2un4Bao4skakJ8w0EAb81JrcYzJo+AnN3m79shk5xUHw
         Ir2HNvn+xgx8aOzpAUCPmfvz4SPfYJkrvZWhTQdHYSFwxS+GZ2EwbAugSEgbdtsZyes5
         7PMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jR+qIpvmW6w7QrK4EeBLopQUhlKrIw/Ns9wdRSazZHg=;
        b=DkxmbRgQbaFQhkSwJA+tLL0Qgfkaos0DxR2mLtigwbGbnkznuA/9LRnwva23B3/naZ
         AUF0BcVIbz//z8kv3jx8cGhknmmjlCoY9dusAYRrnfWarYZ1aZ7yIshoBp1KHuw9dkCl
         XWwP6ALGM2L8/LDCAvJONWlDTSVkA6W1YCyz5EiLs0wMS9aHUll42nLqrQfl0BvGhW+w
         8hGaQpxgpH2PsB0kcVEFjFc8SNWdmRevgLR4Yu2cBiOIy7+SJfu/XJYlW0mou7e8GmxT
         VCzvOfnbNM0zz73tctBN7FsC4TL+/wOggdcJPc9N5DkSOdjlRVXQ3YT30eOszl5rIjxb
         C+Fg==
X-Gm-Message-State: AGi0PubhU7pcK7utW82xVZn6Jn19G+MUC1VStSBPUWiN0WmWQf3G9j2o
        kPBliGUn6Y5Xmmv1awxFs17KXpasC81T3TIOXbZpkw==
X-Google-Smtp-Source: APiQypLSjiGAg9joy8hbB/o/hkZaYk+LlpEo3A/FmQpiP4CeIcpPJLZSrJEltGl7ItJHI3b+IcM8UDg80JrfPfsF54s=
X-Received: by 2002:a19:ad43:: with SMTP id s3mr939777lfd.63.1585802835829;
 Wed, 01 Apr 2020 21:47:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200324215049.GA3710@pi3.com.pl> <202003291528.730A329@keescook> <87zhbvlyq7.fsf_-_@x220.int.ebiederm.org>
In-Reply-To: <87zhbvlyq7.fsf_-_@x220.int.ebiederm.org>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 2 Apr 2020 06:46:49 +0200
Message-ID: <CAG48ez1dCPw9Dep-+GWn=SnHv1nVv4Npv1FpFxmomk6tmazB-g@mail.gmail.com>
Subject: Re: [PATCH] signal: Extend exec_id to 64bits
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Adam Zabrocki <pi3@pi3.com.pl>,
        kernel list <linux-kernel@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 1, 2020 at 10:50 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
> Replace the 32bit exec_id with a 64bit exec_id to make it impossible
> to wrap the exec_id counter.  With care an attacker can cause exec_id
> wrap and send arbitrary signals to a newly exec'd parent.  This
> bypasses the signal sending checks if the parent changes their
> credentials during exec.
>
> The severity of this problem can been seen that in my limited testing
> of a 32bit exec_id it can take as little as 19s to exec 65536 times.
> Which means that it can take as little as 14 days to wrap a 32bit
> exec_id.  Adam Zabrocki has succeeded wrapping the self_exe_id in 7
> days.  Even my slower timing is in the uptime of a typical server.

FYI, if you actually optimize this, it's more like 12s to exec 1048576
times according to my test, which means ~14 hours for 2^32 executions
(on a single core). That's on an i7-4790 (a Haswell desktop processor
that was launched about six years ago, in 2014).

Here's my test code:

=============
$ grep 'model name' /proc/cpuinfo | head -n1
model name : Intel(R) Core(TM) i7-4790 CPU @ 3.60GHz
$ cat build.sh
#!/bin/sh
set -e
nasm -felf32 -o fast_execve.o fast_execve.asm
ld -m elf_i386 -o fast_execve fast_execve.o
gcc -o launch launch.c -Wall
gcc -o finish finish.c -Wall
$ cat fast_execve.asm
bits 32

section .text
global _start
_start:
; eax = argv[0]
; expected to be 8 hex digits, with 'a' meaning 0x0 and 'p' meaning 0xf
mov eax, [esp+4]

mov ebx, 0 ; loop counter
hex_digit_loop:
inc byte [eax+ebx]
cmp byte [eax+ebx], 'a'+16
jne next_exec
mov byte [eax+ebx], 'a'
inc ebx
cmp ebx, 5 ;;;;;;;;;;;;;;;;;; this is N, where iteration_count=pow(16,N)
jne hex_digit_loop


; reached pow(256,N) execs, get out

; first make the stack big again
mov eax, 75 ; setrlimit (32-bit ABI)
mov ebx, 3 ; RLIMIT_STACK
mov ecx, stacklim
int 0x80

; execute end helper
mov ebx, 4 ; dirfd = 4
jmp common_exec

next_exec:
mov ebx, 3 ; dirfd = 3

common_exec: ; execveat() with file descriptor passed in as ebx
mov ecx, nullval ; pathname = empty string
lea edx, [esp+4] ; argv
mov esi, 0 ; envp
mov edi, 0x1000 ; flags = AT_EMPTY_PATH
mov eax, 358 ; execveat (32-bit ABI)
int 0x80
int3

nullval:
dd 0
stacklim:
dd 0x02000000
dd 0xffffffff
$ cat launch.c
#define _GNU_SOURCE
#include <fcntl.h>
#include <err.h>
#include <unistd.h>
#include <sys/syscall.h>
#include <sys/resource.h>
int main(void) {
  close(3);
  close(4);
  if (open("fast_execve", O_PATH) != 3)
    err(1, "open fast_execve");
  if (open("finish", O_PATH) != 4)
    err(1, "open finish");
  char *argv[] = { "aaaaaaaa", NULL };

  struct rlimit lim;
  if (getrlimit(RLIMIT_STACK, &lim))
    err(1, "getrlimit");
  lim.rlim_cur = 0x4000;
  if (setrlimit(RLIMIT_STACK, &lim))
    err(1, "setrlimit");

  syscall(__NR_execveat, 3, "", argv, NULL, AT_EMPTY_PATH);
}
$ cat finish.c
#include <stdlib.h>
int main(void) {
  exit(0);
}
$ ./build.sh
$ time ./launch

real 0m12,075s
user 0m0,905s
sys 0m11,026s
$
=============
