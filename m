Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D49B0C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 19:45:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0A8B22B4B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 19:45:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gQjqajQS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbgG2TpD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 15:45:03 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:58469 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726365AbgG2TpC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 15:45:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596051901;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7z1AY2t0xVMFaqXFaJYLyjBDKoQlP/P9rKVEKHnmX5U=;
        b=gQjqajQS9mSbUPHQj3UAi4bR0MarvzBHObtW1bx9Oo6x/IzSNC7uP63Ejeep+D0hDNI1ov
        QQbXsZYpLT+I+m97ATR0zbgJZgkoLU9DGTzoyK6XdBW0hp034BL2mb3UaQ/L/qC6NCvwOe
        YywZEmJQQfNy7/KvZB3/ryKoXFuYzdI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-389-bjWEZW4vPRGZoxxKoe7oBQ-1; Wed, 29 Jul 2020 15:44:58 -0400
X-MC-Unique: bjWEZW4vPRGZoxxKoe7oBQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7EC351005510;
        Wed, 29 Jul 2020 19:44:57 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 538925C6C0;
        Wed, 29 Jul 2020 19:44:57 +0000 (UTC)
Received: from zmail21.collab.prod.int.phx2.redhat.com (zmail21.collab.prod.int.phx2.redhat.com [10.5.83.24])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id 0326E95A71;
        Wed, 29 Jul 2020 19:44:56 +0000 (UTC)
Date:   Wed, 29 Jul 2020 15:44:56 -0400 (EDT)
From:   Vladis Dronov <vdronov@redhat.com>
To:     Segher Boessenkool <segher@kernel.crashing.org>
Cc:     linuxppc-dev@lists.ozlabs.org,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>
Message-ID: <584129967.9672326.1596051896801.JavaMail.zimbra@redhat.com>
In-Reply-To: <20200729144949.GF17447@gate.crashing.org>
References: <20200729133741.62789-1-vdronov@redhat.com> <20200729144949.GF17447@gate.crashing.org>
Subject: Re: [PATCH] powerpc: fix function annotations to avoid section
 mismatch warnings with gcc-10
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.40.208.54, 10.4.195.13]
Thread-Topic: powerpc: fix function annotations to avoid section mismatch warnings with gcc-10
Thread-Index: L6p0OSsHibJ5uHFDmtRNk3Gpgu4Drg==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

----- Original Message -----
> From: "Segher Boessenkool" <segher@kernel.crashing.org>
> To: "Vladis Dronov" <vdronov@redhat.com>
> Cc: linuxppc-dev@lists.ozlabs.org, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, linux-kernel@vger.kernel.org,
> "Paul Mackerras" <paulus@samba.org>
> Sent: Wednesday, July 29, 2020 4:49:49 PM
> Subject: Re: [PATCH] powerpc: fix function annotations to avoid section mismatch warnings with gcc-10
> 
> On Wed, Jul 29, 2020 at 03:37:41PM +0200, Vladis Dronov wrote:
> > Certain warnings are emitted for powerpc code when building with a gcc-10
> > toolset:
> > 
> >     WARNING: modpost: vmlinux.o(.text.unlikely+0x377c): Section mismatch in
> >     reference from the function remove_pmd_table() to the function
> >     .meminit.text:split_kernel_mapping()
> >     The function remove_pmd_table() references
> >     the function __meminit split_kernel_mapping().
> >     This is often because remove_pmd_table lacks a __meminit
> >     annotation or the annotation of split_kernel_mapping is wrong.
> > 
> > Add the appropriate __init and __meminit annotations to make modpost not
> > complain. In all the cases there are just a single callsite from another
> > __init or __meminit function:
> > 
> > __meminit remove_pagetable() -> remove_pud_table() -> remove_pmd_table()
> > __init prom_init() -> setup_secure_guest()
> > __init xive_spapr_init() -> xive_spapr_disabled()
> 
> So what changed?  These functions were inlined with older compilers, but
> not anymore?

Yes, exactly. Gcc-10 does not inline them anymore. If this is because of my
build system, this can happen to others also.

The same thing was fixed by Linus in e99332e7b4cd ("gcc-10: mark more functions
__init to avoid section mismatch warnings").

> 
> Segher

Best regards,
Vladis Dronov | Red Hat, Inc. | The Core Kernel | Senior Software Engineer

