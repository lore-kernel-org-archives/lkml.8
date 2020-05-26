Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95243C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 14:01:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65F50208A9
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 14:01:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FjEYAfTh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731834AbgEZOBp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 10:01:45 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:20985 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729443AbgEZOBp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 10:01:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590501704;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hveuu+8b66hoKHpea4C8zYmfpzsl4PpKh2ng2WT4OsY=;
        b=FjEYAfTh0MOeIWcEV3uI83vNMbkiq5M4tWvuzKZuo5CDJRD1fd48mYb72tsY9zrsscJhe4
        jCKWmVB/YEjwHOoa0GZpUFyoH9V/WbGeUmINVaKUBSSuUKFuAdjgraeTb/DDWx3+nB0Ba7
        DRyohC2dWL5x0U9bgU8F/VABxyLXX10=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-388-ahoiBctAPFqCjy_Sue4xcw-1; Tue, 26 May 2020 10:01:37 -0400
X-MC-Unique: ahoiBctAPFqCjy_Sue4xcw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C5430460;
        Tue, 26 May 2020 14:01:16 +0000 (UTC)
Received: from treble (ovpn-112-77.rdu2.redhat.com [10.10.112.77])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8259B10013D2;
        Tue, 26 May 2020 14:01:15 +0000 (UTC)
Date:   Tue, 26 May 2020 09:01:13 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Miroslav Benes <mbenes@suse.cz>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: linux-next: Tree for May 21 (objtool warnings)
Message-ID: <20200526140113.ppjywpx7uir3vrlj@treble>
References: <20200522001209.07c19400@canb.auug.org.au>
 <22332d9b-5e9f-5474-adac-9b3e39861aee@infradead.org>
 <alpine.LSU.2.21.2005251101030.24984@pobox.suse.cz>
 <alpine.LSU.2.21.2005251303430.24984@pobox.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.21.2005251303430.24984@pobox.suse.cz>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 25, 2020 at 01:07:27PM +0200, Miroslav Benes wrote:
> > I'll try to find out which optimization does this, because it is a 
> > slightly different scenario than hiding __noreturn from the callees. 
> > Probably -fno-ipa-pure-const again.
> 
> And it is indeed -fno-ipa-pure-const again.

It still seems odd to me that GCC's dead end detection seems to break
with -fno-ipa-pure-const.  Do you know if these issues can be fixed on
the GCC side?

-- 
Josh

