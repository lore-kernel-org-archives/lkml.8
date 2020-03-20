Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34B11C4332B
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 15:28:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 157AE2072D
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 15:28:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727319AbgCTP2b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 11:28:31 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:36270 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727049AbgCTP2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 11:28:31 -0400
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jFJZQ-0006lF-2N; Fri, 20 Mar 2020 16:28:24 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 8D8FC100375; Fri, 20 Mar 2020 16:28:23 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>
Subject: Re: [PATCH 04/17] kernel: futex.c: get rid of a docs build warning
In-Reply-To: <aab1052263e340a3eada5522f32be318890314a1.1584456635.git.mchehab+huawei@kernel.org>
References: <cover.1584456635.git.mchehab+huawei@kernel.org> <aab1052263e340a3eada5522f32be318890314a1.1584456635.git.mchehab+huawei@kernel.org>
Date:   Fri, 20 Mar 2020 16:28:23 +0100
Message-ID: <87h7yj59m0.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:

The subject prefix for this is: 'futex:'

> Adjust whitespaces and blank lines in order to get rid of this:
>
> 	./kernel/futex.c:491: WARNING: Definition list ends without a blank line; unexpected unindent.
>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  kernel/futex.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/futex.c b/kernel/futex.c
> index 67f004133061..dda6ddbc2e7d 100644
> --- a/kernel/futex.c
> +++ b/kernel/futex.c
> @@ -486,7 +486,8 @@ static u64 get_inode_sequence_number(struct inode *inode)
>   * The key words are stored in @key on success.
>   *
>   * For shared mappings (when @fshared), the key is:
> - *   ( inode->i_sequence, page->index, offset_within_page )
> + * ( inode->i_sequence, page->index, offset_within_page )

Sigh. Is there no better way to make this look sane both in the file and
in the docs?

Thanks,

        tglx


