Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AD1AC2BA1A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 18:00:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFA3D2063A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 18:00:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SnWMQE+u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726708AbgDGSAx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 14:00:53 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:41732 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726393AbgDGSAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 14:00:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586282451;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gyO6jc1Z3TakWHspl9Y+YDzRHKNQ9lnWi7h2xhn6ToE=;
        b=SnWMQE+upc4NQEL0St996Gzip2x8Rz7n9NfywX/+Opg8ZuDRuCTr9gWr0sH+xFlY54EdCy
        +WrwRRSD9uzhgrCK3VJ8B4o7wbAixPWJfatPFpruY/0bZLew2uTmltnLODeyGsyVqZ4XW9
        LJxKGk5TMjClhHSEgmTXsC0MpsTSkYE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-427-CquBZdi1OrGDRpq1mD43Pw-1; Tue, 07 Apr 2020 14:00:33 -0400
X-MC-Unique: CquBZdi1OrGDRpq1mD43Pw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DEFC18018AC;
        Tue,  7 Apr 2020 18:00:31 +0000 (UTC)
Received: from treble (ovpn-116-24.rdu2.redhat.com [10.10.116.24])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 18AA597AFB;
        Tue,  7 Apr 2020 18:00:29 +0000 (UTC)
Date:   Tue, 7 Apr 2020 13:00:28 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     akpm@linux-foundation.org, broonie@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-next@vger.kernel.org, mhocko@suse.cz,
        mm-commits@vger.kernel.org, sfr@canb.auug.org.au,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: mmotm 2020-04-05-16-45 uploaded (objtool warning)
Message-ID: <20200407180028.rhgllzwr6uqjvkbv@treble>
References: <20200405234639.AU1f3x3Xg%akpm@linux-foundation.org>
 <b9c97c81-2749-7352-c48b-af7d0b1fa9d6@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b9c97c81-2749-7352-c48b-af7d0b1fa9d6@infradead.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 05, 2020 at 10:53:29PM -0700, Randy Dunlap wrote:
> On 4/5/20 4:46 PM, akpm@linux-foundation.org wrote:
> > The mm-of-the-moment snapshot 2020-04-05-16-45 has been uploaded to
> > 
> >    http://www.ozlabs.org/~akpm/mmotm/
> > 
> > mmotm-readme.txt says
> > 
> > README for mm-of-the-moment:
> > 
> > http://www.ozlabs.org/~akpm/mmotm/
> > 
> > This is a snapshot of my -mm patch queue.  Uploaded at random hopefully
> > more than once a week.
> > 
> > You will need quilt to apply these patches to the latest Linus release (5.x
> > or 5.x-rcY).  The series file is in broken-out.tar.gz and is duplicated in
> > http://ozlabs.org/~akpm/mmotm/series
> > 
> > The file broken-out.tar.gz contains two datestamp files: .DATE and
> > .DATE-yyyy-mm-dd-hh-mm-ss.  Both contain the string yyyy-mm-dd-hh-mm-ss,
> > followed by the base kernel version against which this patch series is to
> > be applied.
> > 
> 
> on x86_64:
> 
> arch/x86/entry/vdso/vma.o: warning: objtool: init_vdso_image()+0xe: unreachable instruction
> 
> Full randconfig file is attached.
> 
> .o file is attached.

This one is fixed by the UBSAN_TRAP fix - still waiting for that one to
get merged:

  https://lkml.kernel.org/r/6653ad73c6b59c049211bd7c11ed3809c20ee9f5.1585761021.git.jpoimboe@redhat.com

-- 
Josh

