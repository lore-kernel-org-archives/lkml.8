Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ABB0C83002
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 04:07:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 258BC2073E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 04:07:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CWnLrK8t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726501AbgD3EHH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 00:07:07 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:48336 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725280AbgD3EHG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 00:07:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588219625;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=h7QUeZ/EJElyYuNor3snWfkrLaig19pbSNuuubX2yxM=;
        b=CWnLrK8tlOJNvnDXEi6Iy9mYfBS00tTqyDwOVj4ry3fVrVlPL55R6hq0tS1IyZdgOOQLnb
        nDftawNu62bmyR6FD3QskYJIreCu7Fg1tvAnUcKcSAkwb+2PRuG/9foMOTVNO9aRfo5z2n
        dgVDsATdszjNax+DjCWlpyjmWHKPtgE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-347-yWGoOVZrOmWZAMeAV7qolQ-1; Thu, 30 Apr 2020 00:07:00 -0400
X-MC-Unique: yWGoOVZrOmWZAMeAV7qolQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 582B980B70A;
        Thu, 30 Apr 2020 04:06:58 +0000 (UTC)
Received: from treble (ovpn-113-19.rdu2.redhat.com [10.10.113.19])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 739BF605E1;
        Thu, 30 Apr 2020 04:06:56 +0000 (UTC)
Date:   Wed, 29 Apr 2020 23:06:54 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     changhuaixin <changhuaixin@linux.alibaba.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        bp@alien8.de, hpa@zytor.com, luto@amacapital.net,
        michal.lkml@markovi.net, mingo@redhat.com, tglx@linutronix.de,
        x86@kernel.org, yamada.masahiro@socionext.com
Subject: Re: [PATCH 0/2] Build ORC fast lookup table in scripts/sorttable tool
Message-ID: <20200430040654.mnkcfmj32tr6m3mg@treble>
References: <20200429064626.16389-1-changhuaixin@linux.alibaba.com>
 <20200429084933.GF13592@hirez.programming.kicks-ass.net>
 <1CACF61E-FA7C-4986-AAD2-20A3B2BAC425@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1CACF61E-FA7C-4986-AAD2-20A3B2BAC425@linux.alibaba.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 30, 2020 at 10:32:17AM +0800, changhuaixin wrote:
> 
> 
> > On Apr 29, 2020, at 4:49 PM, Peter Zijlstra <peterz@infradead.org> wrote:
> > 
> > On Wed, Apr 29, 2020 at 02:46:24PM +0800, Huaixin Chang wrote:
> >> Move building of fast lookup table from boot to sorttable tool. This saves us
> >> 6380us boot time on Intel(R) Xeon(R) CPU E5-2682 v4 @ 2.50GHz with cores.
> > 
> > And what does it add to the build time?
> 
> It takes a little more than 7ms to build fast lookup table in
> sorttable on the same CPU. And it is on the critical path.

Thanks, I like it.  It will help make the in-kernel unwinder even
simpler.  And it will enable unwinding from early boot.

Maybe someday we can move all the table sorting code into objtool, once
we have objtool running on vmlinux.o.

I'll try to review the patches soon.

-- 
Josh

