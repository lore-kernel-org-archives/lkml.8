Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05480C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 12:33:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFF6820706
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 12:33:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="E6ZKWqWp";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SvhkcAV3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbgHXMdC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 08:33:02 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:42494 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726765AbgHXMcx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 08:32:53 -0400
Date:   Mon, 24 Aug 2020 14:32:47 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598272369;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Qr6lUHBkLuLxAPZNmigB/IH+DYgyFTNeFwwb/3iSrGU=;
        b=E6ZKWqWp00DLUq6qhieA0ftDeXWlXvoGZp+Ms2MXHBT9cykq4O2bVe1ZFTAFq+xhHIxbsE
        4RTPpH8VY8i3Y4neiCBBTEYGypzpAK8ZaZUwkCLV0s01pohlTwnP+vQ5gn1tZamJ7vj7XZ
        kFVmie62X2ToAlH+1Gqgu8S+CVN1vh+G6KuvzzA+PWF70quvEDHYJHfvBTk6i7VusoHRTA
        EGO3YcAgdG2j0mrmdppr9UEUK3GqgRHSFSo8SI0VrKUncAxostzkcwu90gHOChanM4PaT8
        GTZu/XBUDc2UNlOqRKpQJ+P3gbxXV/yUfOT1dfwN6I8EDnorpJ9ZP2uTAHiTwg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598272369;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Qr6lUHBkLuLxAPZNmigB/IH+DYgyFTNeFwwb/3iSrGU=;
        b=SvhkcAV3b9DAe/L8n9ay7Sewgu+Z90tVOc5pxatliy7JT9kFlC2JIzVvEZY4GbOBMnBC9g
        Dnxts6GdoyqYGMAA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Lokesh Gidra <lokeshgidra@google.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Jonathan Corbet <corbet@lwn.net>, Peter Xu <peterx@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Biggers <ebiggers@kernel.com>,
        Daniel Colascione <dancol@dancol.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, kaleshsingh@google.com,
        calin@google.com, surenb@google.com, nnk@google.com,
        jeffv@google.com, kernel-team@android.com,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Shaohua Li <shli@fb.com>, Jerome Glisse <jglisse@redhat.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Nitin Gupta <nigupta@nvidia.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Iurii Zaikin <yzaikin@google.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Daniel Colascione <dancol@google.com>
Subject: Re: [PATCH v2 1/2] Add UFFD_USER_MODE_ONLY
Message-ID: <20200824123247.finquufqpr6i7umb@linutronix.de>
References: <20200822014018.913868-1-lokeshgidra@google.com>
 <20200822014018.913868-2-lokeshgidra@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200822014018.913868-2-lokeshgidra@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-08-21 18:40:17 [-0700], Lokesh Gidra wrote:
> --- a/fs/userfaultfd.c
> +++ b/fs/userfaultfd.c
> @@ -1966,6 +1969,7 @@ static void init_once_userfaultfd_ctx(void *mem)
>  
>  SYSCALL_DEFINE1(userfaultfd, int, flags)
>  {
> +	static const int uffd_flags = UFFD_USER_MODE_ONLY;
>  	struct userfaultfd_ctx *ctx;
>  	int fd;
Why?

Sebastian
