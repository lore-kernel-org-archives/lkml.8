Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DC54C433E6
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 19:40:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D9F220684
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 19:40:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LMMD8+XS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728793AbgGQTka (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 15:40:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728183AbgGQTk3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 15:40:29 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA7ADC0619D2;
        Fri, 17 Jul 2020 12:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=YNM2ClGKSk+I/zk32YLeSoT1zPmRZd/0t0dgn2nd+w0=; b=LMMD8+XSPsz9H9sVQtBgDNe7+1
        m9OrNg/Y8EfAZf8V38a333bPUU1pgJDw95Gg4Sei+L4jsrpu9gs96tSiSsov9C6hqpqBMw4LRFJE+
        vXvWzgJu9+avgjo206O1gS0iq5/e9CsQ49s5g0E0BiYTMdMju/ByFewLGTzp1fwjt/gRqHei8SMyR
        jjuEYPmU4ljh/nbTg9zGbF8EXu75dzzpJVVU4G4kUPX4dIEEIZP0bLudvIKyd0uowrzK8X26dUpQe
        J3h7UGnGK8gEdtkTph1N5tdqhzHPuPkg0xZ6p1/hlScNhZmnOTQzs0AQ/mXS1k9TFpcu4yoNUTOjy
        KSMVOM5Q==;
Received: from [2601:1c0:6280:3f0::19c2]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jwWDb-0002hN-KL; Fri, 17 Jul 2020 19:40:27 +0000
Subject: Re: [PATCH 09/25] Documentation: rcu/tree.c: rcu_nmi_enter: fix
 sphinx warning
To:     "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>, corbet@lwn.net,
        mchehab@kernel.org
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200717185624.2009393-1-dwlsalmeida@gmail.com>
 <20200717185624.2009393-9-dwlsalmeida@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <6afb0bcd-92b3-a16c-a911-41e90d5d626e@infradead.org>
Date:   Fri, 17 Jul 2020 12:40:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200717185624.2009393-9-dwlsalmeida@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/17/20 11:56 AM, Daniel W. S. Almeida wrote:
> From: "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>
> 
> Fix the following warning:
> 
> warning: Excess function parameter 'irq' description in 'rcu_nmi_enter'
> 
> Signed-off-by: Daniel W. S. Almeida <dwlsalmeida@gmail.com>

At least 2 people have already fixed this one...

> ---
>  kernel/rcu/tree.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index c716eadc7617f..4540659640fe9 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -944,7 +944,6 @@ void __rcu_irq_enter_check_tick(void)
>  
>  /**
>   * rcu_nmi_enter - inform RCU of entry to NMI context
> - * @irq: Is this call from rcu_irq_enter?
>   *
>   * If the CPU was idle from RCU's viewpoint, update rdp->dynticks and
>   * rdp->dynticks_nmi_nesting to let the RCU grace-period handling know
> 


-- 
~Randy

