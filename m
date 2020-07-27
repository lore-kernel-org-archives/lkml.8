Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2236EC433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 13:36:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD09A20672
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 13:36:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PIq29Lqf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729006AbgG0Ngr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 09:36:47 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:43265 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726298AbgG0Ngr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 09:36:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595857006;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8D67ol3aJBpMshrqkN6iSV7ca0jH4mAuZgj7ZHwQHi4=;
        b=PIq29LqfNaHzcccdszTbHYWEisEdEt0CmVIOomHqXigbJzghqPRH/Ta70JwkJfoW2nGr6j
        W+734zG7C6LW43AlFfxX7bP3CtUEPSc5v78GR3xQa/es721+qjWyAxbBrQC12OGhTn0LrF
        4BCmhPVnkEW3k77l/iEvP91K6/xRbRI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-395-sUa4tk6JNR63pW1PtrxTuw-1; Mon, 27 Jul 2020 09:36:41 -0400
X-MC-Unique: sUa4tk6JNR63pW1PtrxTuw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 53EA91932482;
        Mon, 27 Jul 2020 13:36:40 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-32.rdu2.redhat.com [10.10.112.32])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6E97B5C1B2;
        Mon, 27 Jul 2020 13:36:39 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20200727224626.463ffeaf@canb.auug.org.au>
References: <20200727224626.463ffeaf@canb.auug.org.au>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     dhowells@redhat.com, Andrew Morton <akpm@linux-foundation.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: manual merge of the akpm tree with the fsinfo tree
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2814723.1595856998.1@warthog.procyon.org.uk>
Date:   Mon, 27 Jul 2020 14:36:38 +0100
Message-ID: <2814724.1595856998@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> The notificiations tree has been rebased to remove a new syscall and
> the fsinfo tree rebased on top of that, so the syscall numbers have all
> changed again :-(

Would it make it easier it if I just left a hole for the syscall I dropped for
the moment?

David

