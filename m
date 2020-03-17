Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E321C1975A
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 21:05:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E819020738
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 21:05:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sg2AKlnP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726838AbgCQVFL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 17:05:11 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:26017 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726549AbgCQVFL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 17:05:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584479110;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iVSU/hUq+Q3tc0+RYvpp3aUN70WGubCDMx/lLb546d4=;
        b=Sg2AKlnPlkzIwDBUeREAJuC+CDFIkS2pDBEnond62PanrxiE+vB/BBV2Q89G4kFB/eTAo2
        UsJRGre/2jSVDMq3Gyp59NaumiHRdxIoRX594f1dZaOfJR7NoSTN19g9yz1cyDubCWrnps
        Xr/wG44CcKkLteauLvTt1S2PKUZixYM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-311-25fmtZKbOd-CrmzGLmuV3Q-1; Tue, 17 Mar 2020 17:05:09 -0400
X-MC-Unique: 25fmtZKbOd-CrmzGLmuV3Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A137F1137853;
        Tue, 17 Mar 2020 21:05:07 +0000 (UTC)
Received: from treble (unknown [10.10.110.4])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3A30890811;
        Tue, 17 Mar 2020 21:05:06 +0000 (UTC)
Date:   Tue, 17 Mar 2020 16:05:03 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org, x86@kernel.org,
        mhiramat@kernel.org, mbenes@suse.cz, brgerst@gmail.com
Subject: Re: [PATCH v2 00/19] objtool: vmlinux.o and noinstr validation
Message-ID: <20200317210503.a4ic2yd43bbu5ge2@treble>
References: <20200317170234.897520633@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200317170234.897520633@infradead.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 17, 2020 at 06:02:34PM +0100, Peter Zijlstra wrote:
> Hi all,
> 
> Moar patches. This implements the proposed objtool validation for the
> 
>   noinstr -- function attribute
>   instr_{begin,end}() -- annotation
> 
> Who's purpose is to annotate such code that has constraints on instrumentation
> -- such as early exception code. Specifically it makes it very hard to
> accidentally add code to such regions.
> 
> I've left the whole noinstr naming in place, we'll bike-shed on that later.
> 
> This should address all feedback from RFC/v1.

Looks good to me, other than a few minor comments on patch 16.

Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>

-- 
Josh

