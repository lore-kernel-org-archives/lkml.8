Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF8EEC433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 16:54:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C58A1206C0
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 16:54:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hZT2Hmdt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732448AbgIAQyu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 12:54:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:37783 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729956AbgIAPYV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 11:24:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598973859;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VNdzPUDseq3USZ8d0ARHPx4qAsVpMOQfpHPauNqTGkg=;
        b=hZT2HmdtQlwwLTfupB3ojMMyFE0yhBKirPKBly4BmhsXZbOzxuWfX6p4AX97/69kyJRYFj
        CpS/x5PqDO/treuXLaainsNHt1lYkcfoFgdtqnR/tkMa/JB+XsvHtB9GyDvs0a1Dpx4tMy
        PtuAT/lGN1bXWaqQoMqrS0voKjyAhIM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-170-IjWHW1V8PDqr_6_fply3sw-1; Tue, 01 Sep 2020 11:24:14 -0400
X-MC-Unique: IjWHW1V8PDqr_6_fply3sw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A0E5B1007467;
        Tue,  1 Sep 2020 15:24:12 +0000 (UTC)
Received: from treble (ovpn-113-168.rdu2.redhat.com [10.10.113.168])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id F0F5161177;
        Tue,  1 Sep 2020 15:24:07 +0000 (UTC)
Date:   Tue, 1 Sep 2020 10:24:06 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     David Laight <David.Laight@aculab.com>
Cc:     "'x86@kernel.org'" <x86@kernel.org>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        'Linus Torvalds' <torvalds@linux-foundation.org>,
        'Al Viro' <viro@zeniv.linux.org.uk>,
        'Will Deacon' <will@kernel.org>,
        'Dan Williams' <dan.j.williams@intel.com>,
        'Andrea Arcangeli' <aarcange@redhat.com>,
        'Waiman Long' <longman@redhat.com>,
        'Peter Zijlstra' <peterz@infradead.org>,
        'Thomas Gleixner' <tglx@linutronix.de>,
        'Andrew Cooper' <andrew.cooper3@citrix.com>,
        'Andy Lutomirski' <luto@kernel.org>,
        'Christoph Hellwig' <hch@lst.de>
Subject: Re: [PATCH] x86/uaccess: Use pointer masking to limit uaccess
 speculation
Message-ID: <20200901152406.gghubhgnlmoodisi@treble>
References: <f12e7d3cecf41b2c29734ea45a393be21d4a8058.1597848273.git.jpoimboe@redhat.com>
 <20200828192911.ezqspexfb2gtvrr7@treble>
 <f54657f1b5e74ec99cef62228db50dee@AcuMS.aculab.com>
 <56488b800d044a7e81efd8b40198a527@AcuMS.aculab.com>
 <20200831173112.fjfnnup5cfc5t226@treble>
 <93873def6ede46f89fa33b3fc78876f6@AcuMS.aculab.com>
 <20200901142651.eir5nx4gpy63shlm@treble>
 <0e91076ecda04055859b3ec32f8493ba@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0e91076ecda04055859b3ec32f8493ba@AcuMS.aculab.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 01, 2020 at 03:00:44PM +0000, David Laight wrote:
> e user-space accesses.
> > 
> > Well, yes, but that's a much bigger job which can be done later.
> 
> Isn't this all rather difficult to exploit though?
> (Unlike the original Spectre which trivially let kernel
> memory be read.)
> Don't you need to manage to 'preset' the branch predictor and BTB
> to the right state and then manage some kind of timing attack
> on L1 cache?

In-place training of the branch predictor, and L1 timing attacks are
both trivial.

The harder part is finding another gadget to build on the speculative
load.  But there have been no shortage of new and creative ways to do
that over the last three years.

Also, since Spectre v1 affects many architectures, and may never get
fixed in HW, it's wise to harden these classes of attacks, especially if
we can do so easily.

Yes, it's not as efficient as it could be, but at least I think it's
better than the existing LFENCE.  And it will get more efficient after
Christoph's set_fs() removal, and then even more so when we move the
masking to inside access_ok().

-- 
Josh

