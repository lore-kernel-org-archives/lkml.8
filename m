Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83CC0C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 09:32:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58CB120724
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 09:32:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728413AbgGFJcJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 05:32:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:37820 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727973AbgGFJcJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 05:32:09 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 4A475AE0E;
        Mon,  6 Jul 2020 09:32:08 +0000 (UTC)
Received: by lion.mk-sys.cz (Postfix, from userid 1000)
        id BA757602E3; Mon,  6 Jul 2020 11:32:07 +0200 (CEST)
Date:   Mon, 6 Jul 2020 11:32:07 +0200
From:   Michal Kubecek <mkubecek@suse.cz>
To:     =?utf-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Cc:     Andy Lutomirski <luto@kernel.org>, x86@kernel.org,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH entry v2 3/6] x86/entry/xen: Route #DB correctly on Xen PV
Message-ID: <20200706093207.hogaifg6e4fjfgqh@lion.mk-sys.cz>
References: <cover.1593795633.git.luto@kernel.org>
 <4163e733cce0b41658e252c6c6b3464f33fdff17.1593795633.git.luto@kernel.org>
 <20200706084155.ndltt24ipognh67e@lion.mk-sys.cz>
 <9432d30a-e1eb-2b5e-beff-e24768c09aad@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9432d30a-e1eb-2b5e-beff-e24768c09aad@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 06, 2020 at 10:57:07AM +0200, Jürgen Groß wrote:
> On 06.07.20 10:41, Michal Kubecek wrote:
> > this patch - now in mainline as commit 13cbc0cd4a30 ("x86/entry/32: Fix
> > #MC and #DB wiring on x86_32") - seems to break i586 builds with
> > CONFIG_XEN_PV=y as xenpv_exc_nmi and xenpv_exc_debug are only defined
> > with CONFIG_X86_64:
> > 
> > [ 1279s] ld: arch/x86/entry/entry_32.o: in function `asm_xenpv_exc_nmi':
> > [ 1279s] /home/abuild/rpmbuild/BUILD/kernel-pae-5.8.rc4/linux-5.8-rc4/linux-obj/../arch/x86/include/asm/idtentry.h:557: undefined reference to `xenpv_exc_nmi'
> > [ 1279s] ld: arch/x86/entry/entry_32.o: in function `asm_xenpv_exc_debug':
> > [ 1279s] /home/abuild/rpmbuild/BUILD/kernel-pae-5.8.rc4/linux-5.8-rc4/linux-obj/../arch/x86/include/asm/idtentry.h:567: undefined reference to `xenpv_exc_debug'
> 
> Fix is already queued in tip/tip.git x86/urgent

Thank you,
Michal
