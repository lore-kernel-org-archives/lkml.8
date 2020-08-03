Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6803C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 12:18:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B116D204EC
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 12:18:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WP1SJLyo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726807AbgHCMSh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 08:18:37 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:60180 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726130AbgHCMSb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 08:18:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596457110;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yp+6IvmfkJLq0vw/bDQrRkwBOeDsZaKu4i7gyZaPeYY=;
        b=WP1SJLyo5bQ7jdilOv0tFebfiw6YpIh2AflTmeglpOGMGYcLLMPrhQQUNk94md+F03G/MY
        JwLVCvJTKPv/P8/B72Y/pj31kh8Qv73leJM+kOLo6J5dfz7HXGVxvLnnIUIiZLPABVzL2J
        jRziivnjMuu9qE7ii58GrV7Nhp0KtEo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-441-mgdDRM8vOwiYSE6W0iD38A-1; Mon, 03 Aug 2020 08:18:23 -0400
X-MC-Unique: mgdDRM8vOwiYSE6W0iD38A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AA293805721;
        Mon,  3 Aug 2020 12:18:22 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9D5195D9F7;
        Mon,  3 Aug 2020 12:18:22 +0000 (UTC)
Received: from zmail17.collab.prod.int.phx2.redhat.com (zmail17.collab.prod.int.phx2.redhat.com [10.5.83.19])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id 8E7F21809547;
        Mon,  3 Aug 2020 12:18:22 +0000 (UTC)
Date:   Mon, 3 Aug 2020 08:18:22 -0400 (EDT)
From:   Jan Stancek <jstancek@redhat.com>
To:     broonie@kernel.org, skhan@linuxfoundation.org
Cc:     ltp@lists.linux.it, linux-kernel@vger.kernel.org
Message-ID: <1881588710.5797015.1596457102422.JavaMail.zimbra@redhat.com>
In-Reply-To: <9927ed18c642db002e43afe5e36fb9c18c4f9495.1594811090.git.jstancek@redhat.com>
References: <9927ed18c642db002e43afe5e36fb9c18c4f9495.1594811090.git.jstancek@redhat.com>
Subject: Re: [PATCH] selftests: vdso: hash entry size on alpha,s390x is 8
 bytes
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.40.208.12, 10.4.195.12]
Thread-Topic: selftests: vdso: hash entry size on alpha,s390x is 8 bytes
Thread-Index: mzWLwxoVgxh0LzlPvmyKz4MhjG4FnQ==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


----- Original Message -----
> parse_vdso.c is crashing on 5.8-rc5 s390x, because it wrongly reads
> nbucket as 0:
>   Program received signal SIGFPE, Arithmetic exception.
>   0x0000000001000f3e in vdso_sym (version=0x1001280 "LINUX_2.6",
>   name=0x100128a "__vdso_getcpu") at parse_vdso.c:207
>   207             ELF(Word) chain = vdso_info.bucket[elf_hash(name) %
>   vdso_info.nbucket];
>   (gdb) p vdso_info.nbucket
>   $1 = 0
> 
> Per readelf source:
>   https://sourceware.org/git/?p=binutils-gdb.git;a=blob;f=binutils/readelf.c;h=2406304fe35a832ac53aa7b1a367f3f7afed4264;hb=HEAD#l10027
> and objdump output hash entries are double size on 64bit s390 and alpha:
>   0000000000000120 <.hash>:
>    120:   00 00 00 00             .long   0x00000000
>    124:   00 00 00 03             .long   0x00000003
>    128:   00 00 00 00             .long   0x00000000
>    12c:   00 00 00 07             .long   0x00000007
>    130:   00 00 00 00             .long   0x00000000
>    134:   00 00 00 01             .long   0x00000001
>    138:   00 00 00 00             .long   0x00000000
>    13c:   00 00 00 05             .long   0x00000005
>    140:   00 00 00 00             .long   0x00000000
>    144:   00 00 00 06             .long   0x00000006
> 	  ...
>    16c:   00 00 00 02             .long   0x00000002
>    170:   00 00 00 00             .long   0x00000000
>    174:   00 00 00 03             .long   0x00000003
>    178:   00 00 00 00             .long   0x00000000
>    17c:   00 00 00 04             .long   0x00000004
> 
> Do similar check in parse_vdso.c and treat hash entries as double word.

Ping, any thoughts about the issue or patch?

