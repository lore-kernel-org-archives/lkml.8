Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BD2DC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 10:26:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37FE32080C
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 10:26:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="aVcWrsEr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732367AbgFSK0N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 06:26:13 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:53477 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732249AbgFSKZq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 06:25:46 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 49pFLp73VDz9sSJ;
        Fri, 19 Jun 2020 20:25:38 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1592562339;
        bh=v3lZ1zhxm30dbuwgJcVNBDOXwalAnBkaTaUQ7+IoMNs=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=aVcWrsEruaaErbDP8NVcrNS+EK8+wxDbELGLevLdX9mcDCpb2pHRbgdeARe5/0EAL
         HesWHI6KgwsqORqKaT58fELkECtqgo2D4W9poc7mZN1pDn08e6v1zwhsW8Q0bQ4BIQ
         6GRgbhI4Wh5rwGGp8dFKkH1goaM4iZMptx53G0/eTk9OLEZJ4Kj1ZdvcCQ7vNDxmnm
         KcVGCIcLF/uOJg6YXgAM+fVIWQ9RuTLN8p/6GvgtoRZX1B2nfBLgz/NZ9MeMofKBaU
         x6S5cFKqCuS38FqqKoevBr+TYTdwgNwV5GXeBTi6ct72b3/mDTums4QVH+QXSuzlva
         Rjvb3HigWEwpA==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     linuxppc-dev@ozlabs.org
Cc:     arnd@arndb.de, linux-arch@ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] powerpc/syscalls: Split SPU-ness out of ABI
In-Reply-To: <20200616135617.2937252-2-mpe@ellerman.id.au>
References: <20200616135617.2937252-1-mpe@ellerman.id.au> <20200616135617.2937252-2-mpe@ellerman.id.au>
Date:   Fri, 19 Jun 2020 20:26:05 +1000
Message-ID: <87h7v7cpxe.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Ellerman <mpe@ellerman.id.au> writes:
> Using the ABI field to encode whether a syscall is usable by SPU
> programs or not is a bit of kludge.
>
> The ABI of the syscall doesn't change depending on the SPU-ness, but
> in order to make the syscall generation work we have to pretend that
> it does.
>
> It also means we have more duplicated syscall lines than we need to,
> and the SPU logic is not well contained, instead all of the syscall
> generation targets need to know if they are spu or nospu.
>
> So instead add a separate file which contains the information on which
> syscalls are available for SPU programs. It's just a list of syscall
> numbers with a single "spu" field. If the field has the value "spu"
> then the syscall is available to SPU programs, any other value or no
> entry entirely means the syscall is not available to SPU programs.
>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> ---
>  arch/powerpc/kernel/syscalls/Makefile      |  16 +-
>  arch/powerpc/kernel/syscalls/spu.tbl       | 430 +++++++++++++++++++++
>  arch/powerpc/kernel/syscalls/syscall.tbl   | 195 ++++------
>  arch/powerpc/kernel/syscalls/syscalltbl.sh |  10 +-
>  4 files changed, 523 insertions(+), 128 deletions(-)
>  create mode 100644 arch/powerpc/kernel/syscalls/spu.tbl

For the archives, the changes to the syscall table & the generation of
the spu.tbl can be more-or-less generated with the script below
(ignoring whitespace & comments).

cheers


#!/bin/bash

git checkout v5.8-rc1

table=arch/powerpc/kernel/syscalls/syscall.tbl

for number in {0..439}
do
    line=$(grep -E "^$number\s+(common|spu)" $table)
    if [[ -n "$line" ]]; then
	read number abi name syscall compat <<< "$line"
	if [[ "$syscall" != "sys_ni_syscall" ]]; then
	    if [[ "$name" == "utimesat" ]]; then # fix typo
		name="futimesat"
	    fi
	    echo -e "$number\t$name\tspu"
	    continue
	fi
    fi

    line=$(grep -m 1 -E "^$number\s+" $table)
    read number abi name syscall compat <<< "$line"
    if [[ -n "$name" ]]; then
	echo -e "$number\t$name\t-"
    fi
done > spu-generated.tbl

cat $table | while read line
do
    read number abi name syscall compat <<< "$line"

    if [[ "$number" == "#" ]]; then
	echo $line
	continue
    fi

    case "$abi" in
	"nospu")	;&
	"common")	;&
	"32")		;&
	"64") echo "$line" | sed -e "s/nospu/common/" ;;
    esac
done > syscall-generated.tbl

git cat-file -p 35e32a6cb5f6:$table | diff -w -u - syscall-generated.tbl
git cat-file -p 35e32a6cb5f6:arch/powerpc/kernel/syscalls/spu.tbl | diff -w -u - spu-generated.tbl

