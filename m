Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E1D4C55182
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 22:59:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26C2A206DD
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 22:59:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726973AbgDTW7v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 18:59:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726055AbgDTW7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 18:59:50 -0400
X-Greylist: delayed 6009 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 20 Apr 2020 15:59:50 PDT
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAA15C061A0E;
        Mon, 20 Apr 2020 15:59:50 -0700 (PDT)
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 30928823;
        Mon, 20 Apr 2020 22:59:50 +0000 (UTC)
Date:   Mon, 20 Apr 2020 16:59:49 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Stephen Kitt <steve@sk2.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>, linux-doc@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] docs: sysctl/kernel: document BPF entries
Message-ID: <20200420165949.14dc0752@lwn.net>
In-Reply-To: <20200315122648.20558-1-steve@sk2.org>
References: <20200315122648.20558-1-steve@sk2.org>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 15 Mar 2020 13:26:48 +0100
Stephen Kitt <steve@sk2.org> wrote:

> Based on the implementation in kernel/bpf/syscall.c,
> kernel/bpf/trampoline.c, include/linux/filter.h, and the documentation
> in bpftool-prog.rst.
> 
> Signed-off-by: Stephen Kitt <steve@sk2.org>
> ---
> 
> Notes:
>     This patch is intended for docs-next, but I'd appreciate reviews from
>     BPF developers.

Haven't seen a whole lot of those...it's been a month, so I'll ahead and
apply this; it can be fixed up later if need be.

Thanks,

jon
