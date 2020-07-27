Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0201BC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 06:46:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C42EB2075D
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 06:46:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FWwfE5u6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726719AbgG0GqH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 02:46:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726116AbgG0GqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 02:46:07 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20CD7C0619D2
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jul 2020 23:46:07 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id il6so2915626pjb.0
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jul 2020 23:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=o1htzMj2bxfnfiU+5t35ArMG7QF9SU1xp/VhRzpBk34=;
        b=FWwfE5u6mzbwbJGxwSUZ8jN7eWMdtg0jcWCp6bBT/vWlwPgo4AtX74RlVqH9r1LF7a
         Ff62HVqy/xFfIy7NmniM+Cq5MIZ3b78bHJOOy2Er/VafwC5e3DtNdZgsMNVz+MsQ8LhY
         +hwjzahctpXtXTN2qeeSdDCeL01gwTppJHDzReZqjuf4QGXdtcxi/DU6H3cfoFJqB8MR
         aH8Uhu2ur1otdW9rmRac6GsMt0eUFc115vhl4PUTpBmyCiEsdjzhC9Ft+vh/RTb7bftM
         Tc/btlEo/fMtYqpDsCRL+fVbB8uT75WsoyKqIljby5aHcKAXi/Bg+XTKFfA+INXOErqA
         A93A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=o1htzMj2bxfnfiU+5t35ArMG7QF9SU1xp/VhRzpBk34=;
        b=epS8Ex4FQPowhk4CSFf+WO9JqM20qYxoj4ahZSlzIKNSJuiirnz5XyYN09JQCQt/aI
         iwuiGXeyPO1VsXkbYSgJCZmsqYfDsXBCOqLfl/9Q6NzZMZujqcfITHqZf1Z8rFXgRuEt
         5e5/NCnAKQNGpG/NpQgeNRuqN8TFDrLY4JdVDRA5JEnyTIM1FvlaIJmtahlvvTG2UTvk
         dEmPZkxMYHnG5G7b2x8RJB/CIh+IsNpMYWjX/n43+fdX/rp86YwMQZmqVux6CG24YGco
         UcMVBSNgU4K8mybDhTsEenSu8PrSi/GQGGOX754uuQoBN4ecHgFDJNUuYqPqXGTq0q+v
         is2w==
X-Gm-Message-State: AOAM5317Do4PBGLzTa/WL7MxJBgdha4Ndm08jKZfVM3phOWikqc2U3Eq
        6J4SLH+8VNg3biRtZwZPwHQ=
X-Google-Smtp-Source: ABdhPJxn49FWtMnYEdpbN+PM8DPUPr+XvhlXSPj1CY1DzEmveoFhii8PHcniBC1sOcI2CkoZm1I7kw==
X-Received: by 2002:a17:902:74c2:: with SMTP id f2mr7250548plt.233.1595832366503;
        Sun, 26 Jul 2020 23:46:06 -0700 (PDT)
Received: from gmail.com ([2601:600:9b7f:872e:a655:30fb:7373:c762])
        by smtp.gmail.com with ESMTPSA id m9sm13208344pjs.18.2020.07.26.23.46.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2020 23:46:05 -0700 (PDT)
Date:   Sun, 26 Jul 2020 23:45:45 -0700
From:   Andrei Vagin <avagin@gmail.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Dmitry Safonov <dima@arista.com>
Subject: Re: [PATCH 1/6] arm64/vdso: use the fault callback to map vvar pages
Message-ID: <20200727064545.GA9619@gmail.com>
References: <20200624083321.144975-1-avagin@gmail.com>
 <20200624083321.144975-2-avagin@gmail.com>
 <159561069973.19270.10637845392621633755.b4-ty@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <159561069973.19270.10637845392621633755.b4-ty@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 24, 2020 at 06:26:23PM +0100, Catalin Marinas wrote:
> On Wed, 24 Jun 2020 01:33:16 -0700, Andrei Vagin wrote:
> > Currently the vdso has no awareness of time namespaces, which may
> > apply distinct offsets to processes in different namespaces. To handle
> > this within the vdso, we'll need to expose a per-namespace data page.
> > 
> > As a preparatory step, this patch separates the vdso data page from
> > the code pages, and has it faulted in via its own fault callback.
> > Subsquent patches will extend this to support distinct pages per time
> > namespace.
> > 
> > [...]
> 
> Applied to arm64 (for-next/timens), provisionally.
> 
> One potential issue I did not check is the compat vDSO. The arm32 port
> does not support timens currently. IIUC, with these patches and
> COMPAT_VDSO enabled, it will allow timens for compat processes. Normally
> I'd like the arm32 support first before updating compat but I don't
> think there would be any interface incompatibility here.
> 
> However, does this still work for arm32 processes if COMPAT_VDSO is
> disabled in the arm64 kernel?

Yes, it does. I checked that the timens test passes with and without
COMPAT_VDSO:

[avagin@laptop linux]$ git describe HEAD
v5.8-rc3-6-g9614cc576d76

alpine:/tip/tools/testing/selftests/timens# readelf  -h ./timens
ELF Header:
  Magic:   7f 45 4c 46 01 01 01 00 00 00 00 00 00 00 00 00 
  Class:                             ELF32
  Data:                              2's complement, little endian
  Version:                           1 (current)
  OS/ABI:                            UNIX - System V
  ABI Version:                       0
  Type:                              DYN (Shared object file)
  Machine:                           ARM
  Version:                           0x1
  Entry point address:               0x711
  Start of program headers:          52 (bytes into file)
  Start of section headers:          15444 (bytes into file)
  Flags:                             0x5000400, Version5 EABI,
hard-float ABI
  Size of this header:               52 (bytes)
  Size of program headers:           32 (bytes)
  Number of program headers:         7
  Size of section headers:           40 (bytes)
  Number of section headers:         32
  Section header string table index: 31

alpine:/tip/tools/testing/selftests/timens# uname -a
Linux arm64-alpine 5.8.0-rc3+ #100 SMP Sun Jul 26 23:21:07 PDT 2020
aarch64 Linux


[avagin@laptop linux]$ cat  .config | grep VDSO
CONFIG_COMPAT_VDSO=y
CONFIG_THUMB2_COMPAT_VDSO=y
CONFIG_HAVE_GENERIC_VDSO=y
CONFIG_GENERIC_COMPAT_VDSO=y
CONFIG_GENERIC_VDSO_TIME_NS=y


alpine:/tip/tools/testing/selftests/timens# ./timens
1..10
ok 1 Passed for CLOCK_BOOTTIME (syscall)
ok 2 Passed for CLOCK_BOOTTIME (vdso)
not ok 3 # SKIP CLOCK_BOOTTIME_ALARM isn't supported
not ok 4 # SKIP CLOCK_BOOTTIME_ALARM isn't supported
ok 5 Passed for CLOCK_MONOTONIC (syscall)
ok 6 Passed for CLOCK_MONOTONIC (vdso)
ok 7 Passed for CLOCK_MONOTONIC_COARSE (syscall)
ok 8 Passed for CLOCK_MONOTONIC_COARSE (vdso)
ok 9 Passed for CLOCK_MONOTONIC_RAW (syscall)
ok 10 Passed for CLOCK_MONOTONIC_RAW (vdso)
# Pass 8 Fail 0 Xfail 0 Xpass 0 Skip 2 Error 0


[avagin@laptop linux]$ cat  .config | grep VDSO
# CONFIG_COMPAT_VDSO is not set
CONFIG_HAVE_GENERIC_VDSO=y
CONFIG_GENERIC_VDSO_TIME_NS=y

alpine:/tip/tools/testing/selftests/timens# ./timens
1..10
ok 1 Passed for CLOCK_BOOTTIME (syscall)
ok 2 Passed for CLOCK_BOOTTIME (vdso)
not ok 3 # SKIP CLOCK_BOOTTIME_ALARM isn't supported
not ok 4 # SKIP CLOCK_BOOTTIME_ALARM isn't supported
ok 5 Passed for CLOCK_MONOTONIC (syscall)
ok 6 Passed for CLOCK_MONOTONIC (vdso)
ok 7 Passed for CLOCK_MONOTONIC_COARSE (syscall)
ok 8 Passed for CLOCK_MONOTONIC_COARSE (vdso)
ok 9 Passed for CLOCK_MONOTONIC_RAW (syscall)
ok 10 Passed for CLOCK_MONOTONIC_RAW (vdso)
# Pass 8 Fail 0 Xfail 0 Xpass 0 Skip 2 Error 0

Thanks,
Andrei
