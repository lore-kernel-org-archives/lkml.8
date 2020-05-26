Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6BF5C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 16:07:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71D26206D5
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 16:07:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UMJzEbVZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728836AbgEZQHN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 12:07:13 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:38869 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727941AbgEZQHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 12:07:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590509232;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ga1+aiKNAdSYKO4V4SMnVKbCjeKbc562al4JWbkomq0=;
        b=UMJzEbVZXAWHPy+UjzIBPz6nq9iyTPqookxOKV6epyKvOO9rLKh0bgbJx/57srFBdin6Jy
        APTNWWiSeLTTi+M8j2fuiaQSEvSWm7KClcX57OLoZJPkjBgv3yhO2Mrc3QdfTuf/6tPdHx
        ldRcs/HzM5/UeQBD7nuUXpgE9twGGOc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-125-TQD69dTlNy2Hwt2v7VI0Tw-1; Tue, 26 May 2020 12:07:10 -0400
X-MC-Unique: TQD69dTlNy2Hwt2v7VI0Tw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 238A918017E8;
        Tue, 26 May 2020 16:07:09 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-138.rdu2.redhat.com [10.10.112.138])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A667D648DB;
        Tue, 26 May 2020 16:07:07 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20200525103310.455f50e0@lwn.net>
References: <20200525103310.455f50e0@lwn.net> <20200516003917.2035545-1-list.lkml.keyrings@me.benboeckel.net> <20200516003917.2035545-2-list.lkml.keyrings@me.benboeckel.net>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     dhowells@redhat.com, Ben Boeckel <me@benboeckel.net>,
        keyrings@vger.kernel.org, Ben Boeckel <mathstuf@gmail.com>,
        jarkko.sakkinen@linux.intel.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] Documentation: security: core.rst: add missing argument
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3191880.1590509226.1@warthog.procyon.org.uk>
Date:   Tue, 26 May 2020 17:07:06 +0100
Message-ID: <3191881.1590509226@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jonathan Corbet <corbet@lwn.net> wrote:

> Applied, thanks.

Ah - I've applied it to my keys-next branch.

David

