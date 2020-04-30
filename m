Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C2A7C83001
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 04:10:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 161C42073E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 04:10:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="an4TSvut"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726554AbgD3EKq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 00:10:46 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:34695 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726481AbgD3EKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 00:10:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588219844;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=o6NaKXa+l9qdhNmwuaFitGXRL4T48gITkqZV3NlW2qY=;
        b=an4TSvutNrjoDzylU7AQxSeYcOnUy58QSsxIcwusmR/wD/JxRKPiBMVstH6SEIqs96TT8d
        dFNmcOZMqHPCRKRyT0M4vikfdWItg+1J53gtOlNFAv0J5qqX0rNSM1gdoqHap0/w9Tso/g
        gRQ27g3E4WsfmmPLGjYcKc57Levn5eU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-304-pWu7VxWUNR-RB7JNUh0LIQ-1; Thu, 30 Apr 2020 00:10:38 -0400
X-MC-Unique: pWu7VxWUNR-RB7JNUh0LIQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1827B8014D5;
        Thu, 30 Apr 2020 04:10:37 +0000 (UTC)
Received: from treble (ovpn-113-19.rdu2.redhat.com [10.10.113.19])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A79F610023A6;
        Thu, 30 Apr 2020 04:10:35 +0000 (UTC)
Date:   Wed, 29 Apr 2020 23:10:33 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     changhuaixin <changhuaixin@linux.alibaba.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        bp@alien8.de, hpa@zytor.com, luto@amacapital.net,
        michal.lkml@markovi.net, mingo@redhat.com, tglx@linutronix.de,
        x86@kernel.org, yamada.masahiro@socionext.com
Subject: Re: [PATCH 0/2] Build ORC fast lookup table in scripts/sorttable tool
Message-ID: <20200430041033.x7hggzh2lsbtc3u7@treble>
References: <20200429064626.16389-1-changhuaixin@linux.alibaba.com>
 <20200429084933.GF13592@hirez.programming.kicks-ass.net>
 <1CACF61E-FA7C-4986-AAD2-20A3B2BAC425@linux.alibaba.com>
 <20200430040654.mnkcfmj32tr6m3mg@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200430040654.mnkcfmj32tr6m3mg@treble>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 29, 2020 at 11:06:58PM -0500, Josh Poimboeuf wrote:
> On Thu, Apr 30, 2020 at 10:32:17AM +0800, changhuaixin wrote:
> > 
> > 
> > > On Apr 29, 2020, at 4:49 PM, Peter Zijlstra <peterz@infradead.org> wrote:
> > > 
> > > On Wed, Apr 29, 2020 at 02:46:24PM +0800, Huaixin Chang wrote:
> > >> Move building of fast lookup table from boot to sorttable tool. This saves us
> > >> 6380us boot time on Intel(R) Xeon(R) CPU E5-2682 v4 @ 2.50GHz with cores.
> > > 
> > > And what does it add to the build time?
> > 
> > It takes a little more than 7ms to build fast lookup table in
> > sorttable on the same CPU. And it is on the critical path.
> 
> Thanks, I like it.  It will help make the in-kernel unwinder even
> simpler.  And it will enable unwinding from early boot.
> 
> Maybe someday we can move all the table sorting code into objtool, once
> we have objtool running on vmlinux.o.
> 
> I'll try to review the patches soon.

BTW, another cool feature would be for sorttable to run on modules
during the module linking phase.

-- 
Josh

