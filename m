Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2842BC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 15:41:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFC25207C3
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 15:41:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jMCRLXqC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730875AbgFIPll (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 11:41:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728533AbgFIPlk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 11:41:40 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56CE4C05BD1E;
        Tue,  9 Jun 2020 08:41:39 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id x14so21846847wrp.2;
        Tue, 09 Jun 2020 08:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=r7h76P0dKyHEx8WPlkV2onlEY1gE+C6vJU2/8YGmV8c=;
        b=jMCRLXqCC5n46nxhZSTRYiUOjijr53ShFSQrank/4QderFdAP2/dM57IcLxL6h0o+6
         I6X6rAyGBx6ckaB8AvgDUru1yLbdP+Mj2S4xowMXTOSUotZqLlL/zudC10Kjkt7LkM9+
         /FRI4CQBdyMz6K4Q4s1fPpmtujCprnM6Y9AN3ka1gSb65W4PnWxyuamcS3EsucC4TFfV
         B4LeYERziSVb0Y+fYu8WVZNQAO69o7gyXTCkeCAMHFVgtTjLzW846y/6gU1CWNrEeJNw
         JRpY2kiGzOczChzcQZC4yKiOtNmeOBOaGW5S9ZNN4DROd1AstiIBPl9ItGl/TtYKJKjV
         v7Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=r7h76P0dKyHEx8WPlkV2onlEY1gE+C6vJU2/8YGmV8c=;
        b=WYKXnxwkSUBhd/0jJwlpuTeqX+Be95I6mhiYNCTcOzaJml7As6uXkJvvpEIaPGo5c/
         eJjDtyQ5oMd7pn+tyPWznH3a82LBB/nrDn+Qv2xITOqE7fVLbPslxHEtlLqpPMw7hgwf
         r8sauhjfxOCcU+tazmk8QX+Vpg1sV7CUUTyfz/mc504baKR+XtJFR5tWLB0gVUyyYcbK
         vyz3XnFIUQ2j+p9fi4JzeZJ9nAWYwLSDFFNBegkRU3nwSHDcDG2izs9Qj1arfG9xa5m2
         m1F9kpTMn7VeBWwtgLI6/CdKM/b0qFwgZ0DpqqXir0C7d2cm8wgyIqM2OiS+DTx74EHe
         AkJQ==
X-Gm-Message-State: AOAM530+CIK5RC6aXQNPqHuxxGB2Oi+TkeuuckTTSXD3I8VbOm8iwoB4
        LCIsCQ/3CFuMMs9MwKD+oBemfroI
X-Google-Smtp-Source: ABdhPJzX0xm8+EZE/x/FTYVRtjfyRU8LCykbMUd4i6f9dEB4R5VZqml1CFxFR03A9O3apmbS2wygpA==
X-Received: by 2002:adf:a491:: with SMTP id g17mr5486612wrb.132.1591717297973;
        Tue, 09 Jun 2020 08:41:37 -0700 (PDT)
Received: from Red ([2a01:cb1d:3d5:a100:2e56:dcff:fed2:c6d6])
        by smtp.googlemail.com with ESMTPSA id v19sm3249259wml.26.2020.06.09.08.41.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2020 08:41:37 -0700 (PDT)
Date:   Tue, 9 Jun 2020 17:41:35 +0200
From:   Corentin Labbe <clabbe.montjoie@gmail.com>
To:     davem@davemloft.net, sparclinux@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: Re: Fail to build tftpboot.img
Message-ID: <20200609154135.GB30571@Red>
References: <20200605110535.GA9025@Red>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200605110535.GA9025@Red>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 05, 2020 at 01:05:35PM +0200, Corentin Labbe wrote:
> Hello
> 
> For reinstalling an old SPARC machine , I need a netboot image.
> I tried to create it via make tftpboot.img but got:
> BUILD: sparc to /home/compile/crossbuild/next/sparc/sparc64/defconfig
> make[1]: Entering directory '/usr/src/crossbuild/next/sparc/sparc64/defconfig'
>   GEN     Makefile
> scripts/kconfig/conf  --syncconfig Kconfig
>   GEN     Makefile
>   CALL    /linux-next/scripts/atomic/check-atomics.sh
>   CALL    /linux-next/scripts/checksyscalls.sh
> <stdin>:1511:2: warning: #warning syscall clone3 not implemented [-Wcpp]
>   CHK     include/generated/compile.h
>   GZIP    kernel/config_data.gz
>   CC      kernel/configs.o
>   AR      kernel/built-in.a
>   GEN     .version
>   CHK     include/generated/compile.h
>   UPD     include/generated/compile.h
>   CC      init/version.o
>   AR      init/built-in.a
>   LD      vmlinux.o
>   MODPOST vmlinux.symvers
> WARNING: modpost: EXPORT symbol "_mcount" [vmlinux] version generation failed, symbol will not be versioned.
>   MODINFO modules.builtin.modinfo
>   GEN     modules.builtin
>   LD      .tmp_vmlinux.kallsyms1
>   KSYM    .tmp_vmlinux.kallsyms1.o
>   LD      .tmp_vmlinux.kallsyms2
>   KSYM    .tmp_vmlinux.kallsyms2.o
>   LD      vmlinux
>   SYSMAP  System.map
>   MODPOST Module.symvers
>   STRIP   arch/sparc/boot/image
>   kernel: arch/sparc/boot/image is ready
>   ELFTOAOUT arch/sparc/boot/tftpboot.img
> PT 0 Entry: Loadable to 0x400000[0x5288d0] from 0x0[0x4ca694] align 0x100000
> PT 1 Entry: Note
> PT 2 Entry: unknown
>   PIGGY   arch/sparc/boot/tftpboot.img
> lseek: Invalid argument
> make[2]: *** [/linux-next/arch/sparc/boot/Makefile:72: arch/sparc/boot/tftpboot.img] Error 1
> make[2]: *** Deleting file 'arch/sparc/boot/tftpboot.img'
> make[1]: *** [arch/sparc/Makefile:76: tftpboot.img] Error 2
> make[1]: Leaving directory '/usr/src/crossbuild/next/sparc/sparc64/defconfig'
> make: *** [Makefile:185: __sub-make] Error 2
> 
> I got this result on both linux-next and 5.6.15
> 
> I have straced the process:
> 22495 openat(AT_FDCWD, "arch/sparc/boot/tftpboot.img", O_RDWR) = 3              
> 22495 read(3, "\1\3\1\7\0\0\0\0\0Lf\224\0\0\0\0\0\0\0\0\0\0\0\0\0\5\342<\0\0\0\0"..., 512) = 512
> 22495 lseek(3, 0, SEEK_SET)             = 0                                     
> 22495 read(3, "\1\3\1\7\0\0\0\0\0Lf\224\0\0\0\0\0\0\0\0\0\0\0\0\0\5\342<\0\0\0\0"..., 1024) = 1024
> 22495 lseek(3, -480, SEEK_SET)          = -1 EINVAL (Argument invalide)         
> 22495 dup(2)                            = 4                                     
> 22495 fcntl(4, F_GETFL)                 = 0x402 (flags O_RDWR|O_APPEND)         
> 22495 fstat(4, {st_mode=S_IFCHR|0620, st_rdev=makedev(0x88, 0x1a), ...}) = 0    
> 22495 write(4, "lseek: Invalid argument\n", 24) = 24                            
> 22495 close(4)                          = 0                                     
> 
> Regards

The problem was a too old elftoaout binary.
I will send a patch for printing a better error message.

Regards
