Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E762C2BA19
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 14:21:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 013C72075E
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 14:21:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="UA4vS/uv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730590AbgDMOVF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 10:21:05 -0400
Received: from mail.skyhub.de ([5.9.137.197]:37910 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730562AbgDMOU7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 10:20:59 -0400
Received: from zn.tnic (p200300EC2F06C900CDC4EA77E1BD02DC.dip0.t-ipconnect.de [IPv6:2003:ec:2f06:c900:cdc4:ea77:e1bd:2dc])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2BCCC1EC05D6;
        Mon, 13 Apr 2020 16:20:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1586787657;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EvqjNnYQ7o0idjKHDUx8jEi5/BB6c/YUkQH5OCgKrQg=;
        b=UA4vS/uvqDIJ6vpmf30WbVO8rgXk8eXQu4ujQ2VCo1rCrpDDYBVSLLoi3ez1bRyVdLPfL7
        u57Ej8KqhFZa3VC0EB2VAXawNjozEJL1QQ6eNfjRk9inXTO6vd+45v71N3nX0AtFybp5lR
        6WHStVd7PcMDbDV0AfyR/x6sMOIehpk=
Date:   Mon, 13 Apr 2020 16:20:51 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     =?utf-8?Q?Fr=C3=A9d=C3=A9ric_Pierret_=28fepitre=29?= 
        <frederic.pierret@qubes-os.org>
Cc:     boris.ostrovsky@oracle.com, jgross@suse.com,
        sstabellini@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        x86@kernel.org, hpa@zytor.com, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] xen x86: fix early boot crash with gcc-10
Message-ID: <20200413142051.GC3772@zn.tnic>
References: <20200413123535.10884-1-frederic.pierret@qubes-os.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200413123535.10884-1-frederic.pierret@qubes-os.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 13, 2020 at 02:35:35PM +0200, Frédéric Pierret (fepitre) wrote:
> The change fixes boot failure on VM where kernel (at least v5.4 and v5.6)
> is built with gcc-10 and STACKPROTECTOR_STRONG enabled:
> 
> ```
> Kernel panic - not syncing: stack-protector: Kernel stack is corrupted in: cpu_bringup_and_idle+0x93/0xa0
> CPU: 1 PID: 0 Comm: swapper/1 Not tainted 5.4.31-1.qubes.x86_64 #1
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.12.0-1 04/01/2014
> Call Trace:
>   dump_stack+0x64/0x88
>    panic+0x10b/0x2ed
>    ? cpu_bringup_and_idle+0x93/0xa0
>    __stack_chk_fail+0x15/0x20
>    cpu_bringup_and_idle+0x93/0xa
> ```
> The change makes successfully booting the VM. The VM is hosted by
> KVM hypervisor and is running Xen into.
> 
> Based on work done by Sergei Trofimovich: https://lkml.org/lkml/2020/3/26/1133

I was waiting for the merge window to finish to queue his patch. That is
done now, you can rebase yours ontop.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
