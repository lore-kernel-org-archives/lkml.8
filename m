Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BD4AC47077
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 23:30:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD8EC206F5
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 23:30:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VXtwTr8e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731640AbgELXaB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 19:30:01 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:25592 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725938AbgELXaB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 19:30:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589326200;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IqdlvKpMoIpWtbvNPmb2zhCeciUUo4G6qYPFhXtCsiU=;
        b=VXtwTr8ewAvyIP8+DHoZz54OZB6Pd8XtaWqpf14VDA1TYf0ixJ8CJZLDmxGnF6oNM2BcOY
        WrqWA727sLvUdhPbVSrGlHU+ge4P72lNVOATKTgJ5V/Dj8ReohtHtIw3s7SVtx8gsrbMxb
        k6YBYp1Kvzo7L4R5Dbhxs/MDlEXHE2Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-468-SvcAXEulM1S1hoMbITGG9A-1; Tue, 12 May 2020 19:29:56 -0400
X-MC-Unique: SvcAXEulM1S1hoMbITGG9A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4483A1841920;
        Tue, 12 May 2020 23:29:55 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-59.rdu2.redhat.com [10.10.112.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 853A15C1B5;
        Tue, 12 May 2020 23:29:53 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <31941725-BEB0-4839-945A-4952C2B5ADC7@lca.pw>
References: <31941725-BEB0-4839-945A-4952C2B5ADC7@lca.pw>
To:     Qian Cai <cai@lca.pw>
Cc:     dhowells@redhat.com, Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: Null-ptr-deref due to "vfs, fsinfo: Add an RCU safe per-ns mount list"
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date:   Wed, 13 May 2020 00:29:52 +0100
Message-ID: <2961585.1589326192@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Qian Cai <cai@lca.pw> wrote:

> Reverted the linux-next commit ee8ad8190cb1 (=E2=80=9Cvfs, fsinfo: Add an=
 RCU safe per-ns mount list=E2=80=9D) fixed the null-ptr-deref.

Okay, I'm dropping this commit for now.

David

