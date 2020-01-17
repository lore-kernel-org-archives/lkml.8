Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABE1CC33CB1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 16:44:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71ED521835
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 16:44:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gchxMSxK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728896AbgAQQoO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 11:44:14 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:42843 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726559AbgAQQoO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 11:44:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579279453;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P/p1sRa0n3gIJrBXnOvdAeZPYRGustRcaMbDRiy7ZzQ=;
        b=gchxMSxKMVx1C63D5pHci8V0qZkNmlJjOgjsCojoHWby25MgqRZF/zXxeJTy9i3AYn7zr/
        8AjNB7hlOENEJx+PT9KOLAhl4AcXm0ZpkDP7QairmGgYd1d/bgWEDl6wOk7UNqsV26pUN4
        tITREBSi5UnpIJUw80Abm8JGOn6lfQA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-201-cEXx2zQ0MVO_Zgelvz8tfw-1; Fri, 17 Jan 2020 11:44:11 -0500
X-MC-Unique: cEXx2zQ0MVO_Zgelvz8tfw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B80B28010DD;
        Fri, 17 Jan 2020 16:44:09 +0000 (UTC)
Received: from treble (ovpn-123-54.rdu2.redhat.com [10.10.123.54])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3CD9384D8B;
        Fri, 17 Jan 2020 16:44:09 +0000 (UTC)
Date:   Fri, 17 Jan 2020 10:44:07 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Shile Zhang <shile.zhang@linux.alibaba.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] objtool: use $(SRCARCH) to avoid compile error with
 ARCH=x86_64
Message-ID: <20200117164407.3xkrhx7yrey2ccel@treble>
References: <20191227022931.142690-1-shile.zhang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191227022931.142690-1-shile.zhang@linux.alibaba.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 27, 2019 at 10:29:31AM +0800, Shile Zhang wrote:
> To build objtool with ARCH=3Dx86_64 will failed as:
>=20
>    $make ARCH=3Dx86_64 -C tools/objtool
>    ...
>      CC       arch/x86/decode.o
>    arch/x86/decode.c:10:22: fatal error: asm/insn.h: No such file or di=
rectory
>     #include <asm/insn.h>
>                          ^
>    compilation terminated.
>    mv: cannot stat =E2=80=98arch/x86/.decode.o.tmp=E2=80=99: No such fi=
le or directory
>    make[2]: *** [arch/x86/decode.o] Error 1
>    ...
>=20
> The root cause is the command-line variable 'ARCH' cannot be overridden=
.
> It can be replaced by the one 'SRCARCH' defined in
> 'tools/scripts/Makefile.arch'.
>=20
> Signed-off-by: Shile Zhang <shile.zhang@linux.alibaba.com>

Thanks.  I'll submit it to the -tip tree.

--=20
Josh

