Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A2E4C2BA19
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 08:27:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60C8320672
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 08:27:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vZnUnwZQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbgDFI1Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 04:27:24 -0400
Received: from mail-wr1-f43.google.com ([209.85.221.43]:32796 "EHLO
        mail-wr1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726514AbgDFI1Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 04:27:24 -0400
Received: by mail-wr1-f43.google.com with SMTP id a25so16359054wrd.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 01:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=55a3ErFUzwi21OsaY2azC2jkNniTZaL9xFoaJMyXUts=;
        b=vZnUnwZQ1qXHKPZWX9+n3t/3eu+4bLYPi6ploQCBGr2mO6XDyM+5moogDuVDP5C2E0
         0fWMGbfcau+ZSAOFIMEtSHXueEnHV++vJN+YCDqRJyiF2EuYCIWyOpzLYn1U4aFLSuzM
         rOR75n4gmmGORVuj3EQgVQFfBJmtjls9BN4lixj3Pf7rzDSoQzhLh3MCdS+lQct3KzGX
         4dCXSxEt0ATG1uiz1vQcMavWBrh9LtDK8/VPJefOXf1COF7IuGnhHz1hy/OQ5tfbvreU
         yQdz6C1+IeKUnmNLrxF3RwVQKZPsVW+3foLqVTM4EMnDrlzlNcOMbFlT0EFxMuhk/M/K
         GHJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=55a3ErFUzwi21OsaY2azC2jkNniTZaL9xFoaJMyXUts=;
        b=C1gKj4XQKDr+xQaYFA16ePBii+0d5YAU9aP6qU2oOtRSVTtpDdYVnMZP7DnylwM5cZ
         yzGKl8XvYg4hGPx9rCDZO78XfDhUsM1gLTJotZCGc+mB8fWEq7o9zW27iJgS0aX1Ojfe
         tRkHa0xm9HxXtsy4G3k9Aceu9LLhcxlE4b3fNHrV6U6d7I28OD4J2dzbXJUH8sUfdr8E
         sutnVf6gsCxKxVwZW/0How05LzSY7XI9zkfOMBtozkNlW5hgBgfe6BA9SPvX01klOTmS
         cu+o/v7uCYR1EjkPzD4zKvN6uvHubyEM4hVsecGCPlL0eB+iAib9fudiZExauGXcuUcS
         2t2g==
X-Gm-Message-State: AGi0Pua0SqtFC0K97lVFWleIuGCZ6+eFz+liyycDiKFWE7tsqwongl9a
        fN0ETlfHhxSFxWMsuWofzFYNHaMP
X-Google-Smtp-Source: APiQypJLN67xNTSrQ/sLaRRm40PviBXbgVl5KjikszA4PoZlueozEyPgWcG4LCvJHjec39ZOyIFK2Q==
X-Received: by 2002:a05:6000:1205:: with SMTP id e5mr24179604wrx.73.1586161642322;
        Mon, 06 Apr 2020 01:27:22 -0700 (PDT)
Received: from Red ([2a01:cb1d:3d5:a100:2e56:dcff:fed2:c6d6])
        by smtp.googlemail.com with ESMTPSA id f3sm24957862wmj.24.2020.04.06.01.27.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 01:27:21 -0700 (PDT)
Date:   Mon, 6 Apr 2020 10:27:20 +0200
From:   Corentin Labbe <clabbe.montjoie@gmail.com>
To:     ebiederm@xmission.com, kexec@lists.infradead.org
Cc:     mripard@kernel.org, wens@csie.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Trying to kexec on Allwinner A80
Message-ID: <20200406082720.GA31279@Red>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

I am trying to add the last missing Allwinner Soc in kernelci: the A80.
But this SoC does not have any way to be used in kernelci, no USB nor network in uboot.
So I have tried to fake uboot since the kernel has network support and run the new kernel via kexec.

But kexec 2.0.18 fail to work:
kexec --force /tmp/kernel --initrd /tmp/ramdisk --dtb /tmp/dtb --command-line='console=ttyS0,115200n8 root=/dev/ram0 earlycon=uart,mmio32,0x7000000 ip=dhcp'
syscall kexec_file_load not available.
Try gzip decompression.
kernel: 0xb6535008 kernel_size: 0x853200
MEMORY RANGES
0000000020000000-000000009fffffff (0)
zImage header: 0x016f2818 0x00000000 0x00853200
zImage size 0x853200, file size 0x853200
zImage requires 0x00864200 bytes
  offset 0x0000bae4 tag 0x5a534c4b size 8
Decompressed kernel sizes:
 text+data 0x0158b3a0 bss 0x000632f0 total 0x015ee690
Resulting kernel space: 0x01def5a0
Kernel: address=0x20008000 size=0x01def5a0
Initrd: address=0x21df8000 size=0x0090b6fa
DT    : address=0x22704000 size=0x00005c09
kexec_load: entry = 0x20008000 flags = 0x280000
nr_segments = 3
segment[0].buf   = 0xb6535008
segment[0].bufsz = 0x853204
segment[0].mem   = 0x20008000
segment[0].memsz = 0x854000
segment[1].buf   = 0xb5c29008
segment[1].bufsz = 0x90b6fa
segment[1].mem   = 0x21df8000
segment[1].memsz = 0x90c000
segment[2].buf   = 0x4db50
segment[2].bufsz = 0x5c09
segm[   71.039126] kexec_core: Starting new kernel
ent[2].mem   = 0[   71.044712] Disabling non-boot CPUs ...
x22704000
segment[2].memsz = 0x6000
[   71.489070] Bye!


I have tried also kexec-2.0.20
Try gzip decompression.
zImage header: 0x00000000 0x000019b4 0x00001000
zImage requires 0x008641c0 bytes
Could not find a free area of memory of 0x86c1c0 bytes...
Cannot load /tmp/kernel

What can I do for made it working ? I probably need to give it some memory address, but I am a bit loss.

Thanks
Regards
