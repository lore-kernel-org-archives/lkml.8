Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6250C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 15:46:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7456D2074F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 15:46:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="wcr7+XLL";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="1+gJ5HvL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389654AbgF3PqA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 11:46:00 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54984 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389432AbgF3Pp7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 11:45:59 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 63F087A818;
        Tue, 30 Jun 2020 11:45:57 -0400 (EDT)
        (envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:in-reply-to:message-id:references:mime-version
        :content-type; s=sasl; bh=qtNUAx9ee2dr/6KMkTsUA/oi30Q=; b=wcr7+X
        LLtKEZszPzxEwePuzobuOh1tLdpz5VYsVI5qY2i0ovxoJ0nwLJxHq+pnmqGSnJjj
        MLLCde6KCENi9NqPhYXPTKWxesjyAnJhlUApmx9aoRWw4GyH+lK1S70og0askc0r
        9Mm5CauM0c1+13f0EBu08YpE0E5NVszJRyEXc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5A0D97A817;
        Tue, 30 Jun 2020 11:45:57 -0400 (EDT)
        (envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=fluxnic.net;
 h=date:from:to:cc:subject:in-reply-to:message-id:references:mime-version:content-type; s=2016-12.pbsmtp; bh=A0aF3p7sqCBXQ5afZPVyfIXLWjyDeU13XjzH1QUb90s=; b=1+gJ5HvLtA+38vIw09LDadOwkgZpTpiYsAG/BQ4gb8ZzhLvXsVXw4iZT+oObw91aKG4OZIM4aBxpRHLotoWyV4isvbdSz3We1FJaEX29q1dfEkD/LOCVpPz1UOjnG7QUKC+lLyxVaHSvKzR/3LQ61gSilfZWZEf36djCfAj210A=
Received: from yoda.home (unknown [24.203.50.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id ACB097A815;
        Tue, 30 Jun 2020 11:45:56 -0400 (EDT)
        (envelope-from nico@fluxnic.net)
Received: from xanadu.home (xanadu.home [192.168.2.2])
        by yoda.home (Postfix) with ESMTPSA id B47712DA0A5D;
        Tue, 30 Jun 2020 11:45:55 -0400 (EDT)
Date:   Tue, 30 Jun 2020 11:45:55 -0400 (EDT)
From:   Nicolas Pitre <nico@fluxnic.net>
To:     Al Viro <viro@zeniv.linux.org.uk>
cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        David Howells <dhowells@redhat.com>
Subject: Re: [RFC][PATCHES] converting FDPIC coredumps to regsets
In-Reply-To: <20200630043641.GD2786714@ZenIV.linux.org.uk>
Message-ID: <nycvar.YSQ.7.77.849.2006301141110.1785@knanqh.ubzr>
References: <20200630043641.GD2786714@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Pobox-Relay-ID: C9B187D6-BAE8-11EA-BD60-C28CBED8090B-78420484!pb-smtp1.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Jun 2020, Al Viro wrote:

> 	The obvious solution is to introduce struct elf_prstatus_fdpic
> and use that in binfmt_elf_fdpic.c, taking these fields out of the
> normal struct elf_prstatus.  Unfortunately, the damn thing is defined in
> include/uapi/linux/elfcore.h, so nominally it's a part of userland ABI.
> However, not a single userland program actually includes linux/elfcore.h.
> The reason is that the definition in there uses elf_gregset_t as a member,
> and _that_ is not defined anywhere in the exported headers.  It is defined
> in (libc) sys/procfs.h, but the same file defines struct elf_prstatus
> as well.  So if you try to include linux/elfcore.h without having already
> pulled sys/procfs.h, it'll break on incomplete type of a member.  And if
> you have pulled sys/procfs.h, it'll break on redefining a structure.
> IOW, it's not usable and it never had been; as the matter of fact,
> that's the reason sys/procfs.h had been introduced back in 1996.

Huh! That's convenient alright.

Acked-by: Nicolas Pitre <nico@fluxnic.net>


Nicolas
