Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0708DC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 10:51:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9F9B2073A
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 10:51:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fYvE9eT1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729263AbgGUKvO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 06:51:14 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:35048 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726127AbgGUKvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 06:51:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595328672;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CAVqQZqxx/JXjcd5EJmIcsRlf0f1BN05BWvE1MsglC4=;
        b=fYvE9eT1hqRuyYW2D+fRlk2DALIBBLaWiM1zpjPD5tP6LdCwCjmHOoS96Ljac42gxvmDHn
        rmF69VwPbumFwV5F+P9Vekg6IUPrlV/prcI9ewnCjZwtvWGL5OZd9y6xNMAi2YCMynP8yj
        kpkJU7WmCWbGZD0Pms17/Ya0I4sK8Qo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-381-z1j6iwUqO4mSty9xHpIP7w-1; Tue, 21 Jul 2020 06:51:10 -0400
X-MC-Unique: z1j6iwUqO4mSty9xHpIP7w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5738C800466;
        Tue, 21 Jul 2020 10:51:08 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-32.rdu2.redhat.com [10.10.112.32])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 656D061177;
        Tue, 21 Jul 2020 10:51:05 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <202006142054.C00B3E9C9@keescook>
References: <202006142054.C00B3E9C9@keescook> <20200612183450.4189588-1-keescook@chromium.org> <7be4d56b-0406-099b-e505-02e074c5173e@huawei.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     dhowells@redhat.com, Xiaoming Ni <nixiaoming@huawei.com>,
        Peter Zijlstra <peterz@infradead.org>,
        David Windsor <dwindsor@gmail.com>,
        Hans Liljestrand <ishkamiel@gmail.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Paul Moore <paul@paul-moore.com>, edumazet@google.com,
        paulmck@kernel.org, shakeelb@google.com,
        James Morris <jamorris@linux.microsoft.com>,
        alex.huangjianhui@huawei.com, dylix.dailei@huawei.com,
        chenzefeng2@huawei.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] Convert nsproxy, groups, and creds to refcount_t
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <544538.1595328664.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Tue, 21 Jul 2020 11:51:04 +0100
Message-ID: <544539.1595328664@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kees Cook <keescook@chromium.org> wrote:

> > Should mm->mm_users also be replaced by refcount_t?
> =

> I'll say "yes". :)
> https://lore.kernel.org/lkml/1487671124-11188-1-git-send-email-elena.res=
hetova@intel.com/
> =

> > In addition, is it better to change all variables that use
> > atomic_dec_and_test to control the release process to refconut_t?
> =

> For the most part, yes. The following may find a lot of them:
> scripts/coccinelle/api/atomic_as_refcounter.cocci

I've been gradually undoing some of the conversions as there's no equivale=
nt
of atomic_add_return() and atomic_dec_return() that allow me to log the
altered refcount through a tracepoint.

David

