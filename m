Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1EB5C18E00
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 19:40:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EC22206DB
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 19:40:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I8/0v7pN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbgBSTk6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 14:40:58 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:31779 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726651AbgBSTk4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 14:40:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582141255;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=B2NE/NbXNx0huOaDg+XnsSaVKEiOIkqXx5nv2J9kK4E=;
        b=I8/0v7pNqysRL6BL9CupyLS/pbvSZxwz0S+vv0TREcky8dYrD2mJStvQFZurqWTgHuqzYX
        7tlink4if0S3v6Scv9P1XpAHF+abTOWkCDbXYQQxJm/KqZQCup2NBbIpIncvwETVox7JuA
        W3B9cpmXjfrcSykXxEUUbk7COS2qYn4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-295-Ap-53oU3O-CVBm3QmAVMkA-1; Wed, 19 Feb 2020 14:40:51 -0500
X-MC-Unique: Ap-53oU3O-CVBm3QmAVMkA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 684878017CC;
        Wed, 19 Feb 2020 19:40:49 +0000 (UTC)
Received: from carbon (ovpn-200-26.brq.redhat.com [10.40.200.26])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DC73B5DA76;
        Wed, 19 Feb 2020 19:40:40 +0000 (UTC)
Date:   Wed, 19 Feb 2020 20:40:39 +0100
From:   Jesper Dangaard Brouer <brouer@redhat.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Andrii Nakryiko <andriin@fb.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        BPF-dev-list <bpf@vger.kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Daniel Borkmann <borkmann@iogearbox.net>,
        David Miller <davem@davemloft.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        Toke =?UTF-8?B?SMO4aWxhbmQtSsO4?= =?UTF-8?B?cmdlbnNlbg==?= 
        <toke@redhat.com>, brouer@redhat.com
Subject: Re: Kernel 5.5.4 build fail for BPF-selftests with latest LLVM
Message-ID: <20200219204039.121f10d2@carbon>
In-Reply-To: <20200219181250.GA2852230@kroah.com>
References: <20200219133012.7cb6ac9e@carbon>
        <20200219132856.GA2836367@kroah.com>
        <20200219144254.36c3921b@carbon>
        <20200219181250.GA2852230@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Feb 2020 19:12:50 +0100
Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> On Wed, Feb 19, 2020 at 02:42:54PM +0100, Jesper Dangaard Brouer wrote:
> > On Wed, 19 Feb 2020 14:28:56 +0100
> > Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> >   
> > > On Wed, Feb 19, 2020 at 01:30:12PM +0100, Jesper Dangaard Brouer wrote:  
> > > > Hi Andrii,
> > > > 
> > > > Downloaded tarball for kernel release 5.5.4, and I cannot compile
> > > > tools/testing/selftests/bpf/ with latest LLVM release version 9.    
> > > 
[...]
> > > And has llvm 9 always worked here?  
> > 
> > Yes, llvm-9 used to work for tools/testing/selftests/bpf/.  
> 
> As of when?

Kernel v5.4 works when compiling BPF-selftests with LLVM 9.0.1.

-- 
Best regards,
  Jesper Dangaard Brouer
  MSc.CS, Principal Kernel Engineer at Red Hat
  LinkedIn: http://www.linkedin.com/in/brouer

