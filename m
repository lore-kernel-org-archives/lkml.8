Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C70E7C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 20:41:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FA292075D
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 20:41:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iYGtfwM1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726883AbgG2Uls (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 16:41:48 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:44908 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726476AbgG2Ulr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 16:41:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596055306;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tz3AJclcgpUUd5Ie5LOD0OGxJo0zoLyE3foe8l24nRs=;
        b=iYGtfwM1QPF1Eb5HNsD0EOkj2xutyTFT+KM5wYrftob6UEvn+xznLuuVZrDTPpblgAPb1y
        l0ys5aavG8HhqnUDIFF1l7pM40Y8nVYJdRofYrppBX27/GBJLHLSP/cfAuqk77cuufJdNH
        3hsWggVZiv13VhPzWNCKw01HhrL52k0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-237-RahEJVJbP9CvmEsIJZ3KEQ-1; Wed, 29 Jul 2020 16:41:44 -0400
X-MC-Unique: RahEJVJbP9CvmEsIJZ3KEQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B21101083E85;
        Wed, 29 Jul 2020 20:41:41 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-32.rdu2.redhat.com [10.10.112.32])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3DFD08A18A;
        Wed, 29 Jul 2020 20:41:38 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20200729111120.GA2638@hirez.programming.kicks-ass.net>
References: <20200729111120.GA2638@hirez.programming.kicks-ass.net> <20200721195132.GJ10769@hirez.programming.kicks-ass.net> <202006142054.C00B3E9C9@keescook> <20200612183450.4189588-1-keescook@chromium.org> <7be4d56b-0406-099b-e505-02e074c5173e@huawei.com> <544539.1595328664@warthog.procyon.org.uk> <202007211144.A68C31D@keescook> <3211866.1595933798@warthog.procyon.org.uk>
To:     peterz@infradead.org
Cc:     dhowells@redhat.com, Kees Cook <keescook@chromium.org>,
        Xiaoming Ni <nixiaoming@huawei.com>,
        David Windsor <dwindsor@gmail.com>,
        Hans Liljestrand <ishkamiel@gmail.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Paul Moore <paul@paul-moore.com>, edumazet@google.com,
        paulmck@kernel.org, shakeelb@google.com,
        James Morris <jamorris@linux.microsoft.com>,
        alex.huangjianhui@huawei.com, dylix.dailei@huawei.com,
        chenzefeng2@huawei.com, linux-kernel@vger.kernel.org,
        Will Deacon <will@kernel.org>
Subject: Re: [RFC][PATCH] locking/refcount: Provide __refcount API to obtain the old value
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4041519.1596055297.1@warthog.procyon.org.uk>
Date:   Wed, 29 Jul 2020 21:41:37 +0100
Message-ID: <4041520.1596055297@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

peterz@infradead.org wrote:

> I'm not entirely sure what you mean with interpret, provided you don't
> trigger a refcount fail, the number will be just what you expect and
> would get from refcount_read(). If you do trigger a fail, you'll get a
> negative value.

That's fine.  I seem to remember talk about the possibility that the number
wouldn't necessarily bottom out at zero - for instance if it was arranged such
that the overflow flag was set on an overflow or underflow so that it could be
trapped on (using INTO or TRAPV, for example).

David

