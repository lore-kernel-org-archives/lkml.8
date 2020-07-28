Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C0D7C433F7
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 05:12:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 377BB22B45
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 05:12:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595913165;
	bh=mMmMOZRqcwbwIAYXJptjnBD0hd+PoJPX2iCLmOcK8eI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=m5YUmEsFsB/icYUADNjxbwJbUcG2JmQpWgnQ9GpfHiapSPOyRk5FIrTVUR2smoEhO
	 s7GTXWc4BBdbO+fdue9gH+GNKDPFfTMgJiNeyJlY5fanF2Vrw3ReEclFdXvuY9HiSY
	 fxSZ5lCBJQSDTcFnMU+0yxtVyxv6lnFEq4dChl0w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726924AbgG1FMo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 01:12:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:34416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726251AbgG1FMn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 01:12:43 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 24B082070A;
        Tue, 28 Jul 2020 05:12:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595913163;
        bh=mMmMOZRqcwbwIAYXJptjnBD0hd+PoJPX2iCLmOcK8eI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=WohhgNcu5yPmT/dSi7ArgVFDeiod6wKcaOO6VOgyuBkdQEvl+qFUFDrZi+0EUMow1
         nA0dTUTC1C7gW3YPIenikWhTvWf3C4A0VMsCFFNsJLVviMuwZAowZUFwYgyX0fcXpv
         GSCUrxOomUhLE6TcjG28gaW00SU8qnogYQ3Mst24=
Date:   Tue, 28 Jul 2020 14:12:38 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>,
        Pia Eichinger <pia.eichinger@st.oth-regensburg.de>,
        Joe Perches <joe@perches.com>, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: adjust kprobes.rst entry to new location
Message-Id: <20200728141238.5fa8056e378fd08b5c1fa3f6@kernel.org>
In-Reply-To: <20200726055843.10783-1-lukas.bulwahn@gmail.com>
References: <20200726055843.10783-1-lukas.bulwahn@gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 26 Jul 2020 07:58:43 +0200
Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:

> Commit 2165b82fde82 ("docs: Move kprobes.rst from staging/ to trace/")
> moved kprobes.rst, but missed to adjust the MAINTAINERS entry.
> 
> Hence, ./scripts/get_maintainer.pl --self-test=patterns complains:
> 
>   warning: no file matches    F:    Documentation/staging/kprobes.rst
> 
> Adjust the entry to the new file location.
> 

Good catch!

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Thanks!

> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
> Naveen, Masami-san, please ack.
> Jonathan, please pick this minor non-urgent patch into docs-next.
> 
> applies cleanly on next-20200724
> 
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 960f7d43f9d7..416fc4555834 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9676,7 +9676,7 @@ M:	Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
>  M:	"David S. Miller" <davem@davemloft.net>
>  M:	Masami Hiramatsu <mhiramat@kernel.org>
>  S:	Maintained
> -F:	Documentation/staging/kprobes.rst
> +F:	Documentation/trace/kprobes.rst
>  F:	include/asm-generic/kprobes.h
>  F:	include/linux/kprobes.h
>  F:	kernel/kprobes.c
> -- 
> 2.17.1
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
