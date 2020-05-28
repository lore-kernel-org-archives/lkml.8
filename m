Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9420CC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 12:36:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FF7520707
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 12:36:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aisp8qRE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389815AbgE1Mgx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 08:36:53 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:43488 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2389734AbgE1Mgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 08:36:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590669408;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GRwkxAXKadNb8L6vblVDH1YHL3lLq/VSX5Jl4TgNeUQ=;
        b=aisp8qREGtJsTbhPQlr2s8xSZwp7hGPo1T28LgtDPb5QIxQIwcQYEhGT491TzHBOzU8x35
        7GyoCgLjPa/s4OYmJIr9YVFm/gGS092UoYxLMP9CMMbp4VusWw3PvfHZqFpzVKkPtFunbI
        YQ5kzlTrzrE0soVaAApCl+ZX5hO0hKI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-485-EyyxwPu9Nla98fHg1KPQ8w-1; Thu, 28 May 2020 08:36:45 -0400
X-MC-Unique: EyyxwPu9Nla98fHg1KPQ8w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 81F52108597B;
        Thu, 28 May 2020 12:36:43 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.192.7])
        by smtp.corp.redhat.com (Postfix) with SMTP id A969F1001268;
        Thu, 28 May 2020 12:36:41 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Thu, 28 May 2020 14:36:43 +0200 (CEST)
Date:   Thu, 28 May 2020 14:36:40 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Greentime Hu <greentime.hu@sifive.com>
Cc:     guoren@linux.alibaba.com, vincent.chen@sifive.com,
        paul.walmsley@sifive.com, palmerdabbelt@google.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v5 01/13] ptrace: Use regset_size() for dynamic regset
Message-ID: <20200528123639.GA19813@redhat.com>
References: <cover.1590646208.git.greentime.hu@sifive.com>
 <e490cf0a1b57b7cb34a5ea1252e7a71109d6ffee.1590646208.git.greentime.hu@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e490cf0a1b57b7cb34a5ea1252e7a71109d6ffee.1590646208.git.greentime.hu@sifive.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/28, Greentime Hu wrote:
>
> --- a/kernel/ptrace.c
> +++ b/kernel/ptrace.c
> @@ -888,7 +888,7 @@ static int ptrace_regset(struct task_struct *task, int req, unsigned int type,
>  
>  	regset_no = regset - view->regsets;
>  	kiov->iov_len = min(kiov->iov_len,
> -			    (__kernel_size_t) (regset->n * regset->size));
> +			    (__kernel_size_t) regset_size(task, regset));

Acked-by: Oleg Nesterov <oleg@redhat.com>

