Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9708C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 14:09:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5DCC20829
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 14:09:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eb0/UZn3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727036AbgEROJ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 10:09:28 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:53798 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726945AbgEROJ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 10:09:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589810967;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vQQaQ/avTvuFtQHQK1QliBct9lrv4FiG5moHpisL6LI=;
        b=eb0/UZn3kkcAycuKACcBngNdvM8ZkLUL8RMlcCoAKXIobcYiEEz3yUJ2MLZ36RCinxC+DI
        wYRAFoypFtk3XQ/IOeFfdnzRFbSqkMc+b1wskWGqudWnETQLAUkh61SER79SYIW7rE4vlX
        lh6vgwL+D9fcDR+nUOgBOO8vi6Q3C88=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-246-gfvETf5vNiG1UPgFGIFTpA-1; Mon, 18 May 2020 10:09:25 -0400
X-MC-Unique: gfvETf5vNiG1UPgFGIFTpA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4F526460;
        Mon, 18 May 2020 14:09:24 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-95.rdu2.redhat.com [10.10.112.95])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BE7015C1B2;
        Mon, 18 May 2020 14:09:22 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20200516003917.2035545-2-list.lkml.keyrings@me.benboeckel.net>
References: <20200516003917.2035545-2-list.lkml.keyrings@me.benboeckel.net> <20200516003917.2035545-1-list.lkml.keyrings@me.benboeckel.net>
To:     Ben Boeckel <me@benboeckel.net>
Cc:     dhowells@redhat.com, keyrings@vger.kernel.org,
        Ben Boeckel <mathstuf@gmail.com>,
        jarkko.sakkinen@linux.intel.com, corbet@lwn.net,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] Documentation: security: core.rst: add missing argument
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <870600.1589810961.1@warthog.procyon.org.uk>
Date:   Mon, 18 May 2020 15:09:21 +0100
Message-ID: <870601.1589810961@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ben Boeckel <me@benboeckel.net> wrote:

>  	long keyctl(KEYCTL_PKEY_QUERY,
>  		    key_serial_t key_id, unsigned long reserved,
> +		    const char* params,
>  		    struct keyctl_pkey_query *info);

"const char *params".  I fixed that and applied it.

David

