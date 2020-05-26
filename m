Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 026F4C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 14:00:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF94C20B80
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 14:00:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NUYWWu+f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731792AbgEZOAh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 10:00:37 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:23666 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728558AbgEZOAh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 10:00:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590501636;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=86WQURgCqAHa0WXNLzZX28I5KUeKUOWQEKAQ4Gpwaf0=;
        b=NUYWWu+fDO93/EZYSH8HVplpoD0SlCYkH/vAqA7m5bYDAJs+h7SaNkowpkU559ZRj32OD5
        u2jNY44XCBxcrePIuBQdz7XlCRmamchd3XamDE5PbkcAUPnXpHClOL3x4wEwp+hB+Q/6Lo
        CQ2EunuSYqZH4J+ZeVcBAz6jJAUJo1E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-160-OvaMsk5FP-u0DBdNEz45pQ-1; Tue, 26 May 2020 10:00:32 -0400
X-MC-Unique: OvaMsk5FP-u0DBdNEz45pQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B8357100CD14;
        Tue, 26 May 2020 14:00:30 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.193.170])
        by smtp.corp.redhat.com (Postfix) with SMTP id 3210460E1C;
        Tue, 26 May 2020 14:00:29 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Tue, 26 May 2020 16:00:30 +0200 (CEST)
Date:   Tue, 26 May 2020 16:00:28 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Greentime Hu <greentime.hu@sifive.com>
Cc:     guoren@linux.alibaba.com, vincent.chen@sifive.com,
        paul.walmsley@sifive.com, palmerdabbelt@google.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v4 01/13] ptrace: Use regset_size() for dynamic
 regset size.
Message-ID: <20200526140027.GC24212@redhat.com>
References: <cover.1590474856.git.greentime.hu@sifive.com>
 <3700190a602a6d30fcbf76e1eea667e29a65c4c9.1590474856.git.greentime.hu@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3700190a602a6d30fcbf76e1eea667e29a65c4c9.1590474856.git.greentime.hu@sifive.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/26, Greentime Hu wrote:
>
> @@ -882,13 +882,18 @@ static int ptrace_regset(struct task_struct *task, int req, unsigned int type,
>  	const struct user_regset_view *view = task_user_regset_view(task);
>  	const struct user_regset *regset = find_regset(view, type);
>  	int regset_no;
> +	unsigned int size;
>
> -	if (!regset || (kiov->iov_len % regset->size) != 0)
> +	if (!regset)
>  		return -EINVAL;
>
>  	regset_no = regset - view->regsets;
> -	kiov->iov_len = min(kiov->iov_len,
> -			    (__kernel_size_t) (regset->n * regset->size));
> +	size = regset_size(task, regset);
> +
> +	if ((kiov->iov_len % size) != 0)
> +		return -EINVAL;

Hmm. this doesn't look right.

Before this patch we check "iov_len % regset->size", this is not the same
as "iov_len % regset_size()".

IOW, currently you can read/write, say, only the 1st register, you patch
breaks this?

Oleg.

