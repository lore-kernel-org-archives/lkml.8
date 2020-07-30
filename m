Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E304C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 15:34:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCF8E2082E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 15:34:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ClHQa85Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729697AbgG3Pe0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 11:34:26 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:38922 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726581AbgG3Pe0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 11:34:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596123264;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ghDMhL6A2KNLEilKh/KJ4TUbwSrfsjv+yDVIoZhA6qw=;
        b=ClHQa85Z3Mye6g2mUGFADJmxbL1Ix+j1SuMNOG9UXdnlLOnt8nHMbniQo6lJtWDTMMPzTU
        oNR4oGy2MrzT4+21rxRuzn5HgB91ngnumxbLCPhcfdCm8d2ayBfHkD25oNuyOyUrP1oW17
        Swi/8RLC0ErFMnIgBd34MdO5UNgajJk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-467-_DUX7MZhOA-VCkkh1Qrrpg-1; Thu, 30 Jul 2020 11:34:19 -0400
X-MC-Unique: _DUX7MZhOA-VCkkh1Qrrpg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AC8D5100CCC3;
        Thu, 30 Jul 2020 15:34:17 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7795287E00;
        Thu, 30 Jul 2020 15:34:17 +0000 (UTC)
Received: from zmail21.collab.prod.int.phx2.redhat.com (zmail21.collab.prod.int.phx2.redhat.com [10.5.83.24])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id 12BC395A72;
        Thu, 30 Jul 2020 15:34:16 +0000 (UTC)
Date:   Thu, 30 Jul 2020 11:34:16 -0400 (EDT)
From:   Vladis Dronov <vdronov@redhat.com>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Segher Boessenkool <segher@kernel.crashing.org>,
        linuxppc-dev@lists.ozlabs.org,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>
Message-ID: <842212692.9780293.1596123256621.JavaMail.zimbra@redhat.com>
In-Reply-To: <87ft995hv8.fsf@mpe.ellerman.id.au>
References: <20200729133741.62789-1-vdronov@redhat.com> <20200729144949.GF17447@gate.crashing.org> <584129967.9672326.1596051896801.JavaMail.zimbra@redhat.com> <20200729224427.GI17447@gate.crashing.org> <87ft995hv8.fsf@mpe.ellerman.id.au>
Subject: Re: [PATCH] powerpc: fix function annotations to avoid section
 mismatch warnings with gcc-10
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.40.208.60, 10.4.195.18]
Thread-Topic: powerpc: fix function annotations to avoid section mismatch warnings with gcc-10
Thread-Index: rKp81qyk4KEAfYe/qAP0qUT6DQV0IQ==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Michael,

----- Original Message -----
> From: "Michael Ellerman" <mpe@ellerman.id.au>
> Subject: Re: [PATCH] powerpc: fix function annotations to avoid section mismatch warnings with gcc-10
> 
...
> >> > So what changed?  These functions were inlined with older compilers, but
> >> > not anymore?
> >> 
> >> Yes, exactly. Gcc-10 does not inline them anymore. If this is because of
> >> my
> >> build system, this can happen to others also.
> >> 
> >> The same thing was fixed by Linus in e99332e7b4cd ("gcc-10: mark more
> >> functions
> >> __init to avoid section mismatch warnings").
> >
> > It sounds like this is part of "-finline-functions was retuned" on
> > <https://gcc.gnu.org/gcc-10/changes.html>?  So everyone should see it
> > (no matter what config or build system), and it is a good thing too :-)
> 
> I haven't seen it in my GCC 10 builds, so there must be some other
> subtlety. Probably it depends on details of the .config.
> 

I've just had this building the latest upstream for the ppc64le with a derivative
of the RHEL-8 config. This can probably be a compiler/linker setting, like -O2
versus -O3.

> cheers

Best regards,
Vladis Dronov | Red Hat, Inc. | The Core Kernel | Senior Software Engineer

