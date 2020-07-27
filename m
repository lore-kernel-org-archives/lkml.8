Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 135E7C433E5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 13:36:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D920920672
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 13:36:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c3iTE5Ez"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729003AbgG0NgH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 09:36:07 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:39673 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726298AbgG0NgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 09:36:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595856966;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qUgEH1K320HFXVyeiPJVVXjlGNJKxoO09QtGKl4Q8tg=;
        b=c3iTE5Ezqeg4hbDLIUANqYqGidCAAxBt2dO2qSlSFlewdVO8zlE2Wt/ML95zvV2iWUPk22
        5/5FQqnVnGBER+BpDDFxT0e0mcCvFOjbfqzP7XF4vhmuof3OXQsZ4ix0wMYUSIIA0Ln6Be
        LmyKuyj9mmrsJcEOU9zF//uXBL2CgTg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-48-5g5K5XbrPlGQU-D9eMtoZQ-1; Mon, 27 Jul 2020 09:36:01 -0400
X-MC-Unique: 5g5K5XbrPlGQU-D9eMtoZQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A03721932489;
        Mon, 27 Jul 2020 13:36:00 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-32.rdu2.redhat.com [10.10.112.32])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C7CB219D82;
        Mon, 27 Jul 2020 13:35:59 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20200727224343.5f86c3c8@canb.auug.org.au>
References: <20200727224343.5f86c3c8@canb.auug.org.au>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     dhowells@redhat.com,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: problem in the fsinfo tree
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2814644.1595856959.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Mon, 27 Jul 2020 14:35:59 +0100
Message-ID: <2814645.1595856959@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> In rebasing commit
> =

>   348b039216fb ("fsinfo: Add fsinfo() syscall to query filesystem inform=
ation")
> =

> you forgot to update
> =

> arch/arm64/include/asm/unistd.h
> include/uapi/asm-generic/unistd.h =


Sorry about that, but it's a pain to do this manually.

David

