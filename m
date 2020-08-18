Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AB59C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 08:19:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 437A32076E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 08:19:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WIkTqJgu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbgHRIT0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 04:19:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49689 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726357AbgHRITZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 04:19:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597738764;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=u5BW4sttAkWqGg8PlkiSb/wzvzki2Fh+MHof6eikw/c=;
        b=WIkTqJgu8Xiv+wJtPCFrOvgtlQHfKkzgIiSpM/WUnbw27OcW4wrrqQufLU94GlF6Zd4HG4
        X57AabYMAdBR+BihNxxtvlBf+sxdoP22nW9WUIxq5Yq8PVZVHyy19Q4H2LMwLK4I5WgGxR
        m5Y0KQ3YA4SQdkgJ+MFu+0NlKR3oXhQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-377-9aejwH2JN_etFEeUIAm9LA-1; Tue, 18 Aug 2020 04:19:22 -0400
X-MC-Unique: 9aejwH2JN_etFEeUIAm9LA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D65E281F012;
        Tue, 18 Aug 2020 08:19:20 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-127.rdu2.redhat.com [10.10.120.127])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A810C7A1E6;
        Tue, 18 Aug 2020 08:19:19 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20200817090523.68692855@canb.auug.org.au>
References: <20200817090523.68692855@canb.auug.org.au> <20200805163246.4df09c31@canb.auug.org.au>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     dhowells@redhat.com, Masahiro Yamada <masahiroy@kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: manual merge of the fsinfo tree with the kbuid tree
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2193239.1597738758.1@warthog.procyon.org.uk>
Date:   Tue, 18 Aug 2020 09:19:18 +0100
Message-ID: <2193240.1597738758@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> This is now a conflict between the fsinfo tree and Linus' tree.

Please drop the fsinfo branch for now, thanks.

David

