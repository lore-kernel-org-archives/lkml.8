Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77A4DC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 16:51:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F94D206F6
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 16:51:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SWI87RLR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727600AbgCXQvl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 12:51:41 -0400
Received: from merlin.infradead.org ([205.233.59.134]:42084 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbgCXQvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 12:51:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=N4GZ7+M1eRD8an5K8OELlYenKfDSxyisShOnVR18rRU=; b=SWI87RLREq1G8eS1Z3UkgbOL0p
        bNHNo+3m3jDy6NqaD6lgk6E9M55IYXv9cfhQ4U/m3TXNeU0F2KlTX53PnObUuMNeVlJ1gkH2u2N6R
        D5gvmeidJjwsqgsFdXisT18Q7t5TQ6VhFQ+3m90HRTger2cxdygkelqCgubtTt9c2XQU43UDatsqN
        hT8WBbB2aFRGRhmAq8BnWOkIGcld4281RMuTyMKV6/G+s23GqR12lnGg03FVfw+8bRTXRnLGqVMJw
        75U0QGdWL580574YY2M7/tE8Nr4hP6vt2L8s/nVucP+OSxxOC3HSp8eXiqjwLmRlNWv8r6tfkBn+f
        oXqZY5kw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jGmm3-0007dt-99; Tue, 24 Mar 2020 16:51:31 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3FDB6306118;
        Tue, 24 Mar 2020 17:51:28 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2057920200A0F; Tue, 24 Mar 2020 17:51:28 +0100 (CET)
Date:   Tue, 24 Mar 2020 17:51:28 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Maddie Stone <maddiestone@google.com>,
        Marco Elver <elver@google.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, kernel-team@android.com,
        kernel-hardening@lists.openwall.com,
        Oleg Nesterov <oleg@redhat.com>
Subject: Re: [RFC PATCH 03/21] list: Annotate lockless list primitives with
 data_race()
Message-ID: <20200324165128.GS20696@hirez.programming.kicks-ass.net>
References: <20200324153643.15527-1-will@kernel.org>
 <20200324153643.15527-4-will@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200324153643.15527-4-will@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 24, 2020 at 03:36:25PM +0000, Will Deacon wrote:
> diff --git a/include/linux/list.h b/include/linux/list.h
> index 4fed5a0f9b77..4d9f5f9ed1a8 100644
> --- a/include/linux/list.h
> +++ b/include/linux/list.h
> @@ -279,7 +279,7 @@ static inline int list_is_last(const struct list_head *list,
>   */
>  static inline int list_empty(const struct list_head *head)
>  {
> -	return READ_ONCE(head->next) == head;
> +	return data_race(READ_ONCE(head->next) == head);
>  }

list_empty() isn't lockless safe, that's what we have
list_empty_careful() for.
