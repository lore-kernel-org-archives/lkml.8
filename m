Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21818C83004
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 15:01:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7C9621973
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 15:01:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iAqboQg+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbgD2PBx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 11:01:53 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:27263 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726511AbgD2PBw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 11:01:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588172511;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DH5yl77xdOzHLXKjdPbko73VrWxAprjgWT2z8fHnIdE=;
        b=iAqboQg+sqavb5eEObSn0S2fVEtTNO3ZV4u469m4MVPo5amS/zXe5SbBahb6G5kKwnd0Ny
        CCoXo9dy68Nic2PFwBHQjBZb+GRZB8a6ZcjFYvoIXsZcclPH+eape/PpY6ky99pgKXaqmt
        ODlb+tEIMTKRQO+DVik1nmJx0FNnz3c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-340-DqcEq_ysPZylk-LlQwk3Fg-1; Wed, 29 Apr 2020 11:01:49 -0400
X-MC-Unique: DqcEq_ysPZylk-LlQwk3Fg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C246B80B73B;
        Wed, 29 Apr 2020 15:01:47 +0000 (UTC)
Received: from treble (ovpn-113-19.rdu2.redhat.com [10.10.113.19])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 82A4660BF4;
        Wed, 29 Apr 2020 15:01:46 +0000 (UTC)
Date:   Wed, 29 Apr 2020 10:01:44 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: linux-next: Tree for Apr 29 (objtool warning)
Message-ID: <20200429150144.l6raanbw5askynxp@treble>
References: <20200429183332.69155dfd@canb.auug.org.au>
 <6b54b58f-b6f4-154f-e732-0b433741f1f6@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6b54b58f-b6f4-154f-e732-0b433741f1f6@infradead.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 29, 2020 at 07:50:10AM -0700, Randy Dunlap wrote:
> On 4/29/20 1:33 AM, Stephen Rothwell wrote:
> > Hi all,
> > 
> > Changes since 20200428:
> > 
> 
> on x86_64:
> 
> kernel/trace/trace_branch.o: warning: objtool: ftrace_likely_update()+0x3c4: call to __stack_chk_fail() with UACCESS enabled
> 
> Full randconfig file is attached.

Peter, I think should __stack_chk_fail() be on the safe list?

-- 
Josh

