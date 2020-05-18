Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E07DBC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 22:28:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6C1E207ED
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 22:28:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i9AN3Ttb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728335AbgERW2C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 18:28:02 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:54203 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728223AbgERW2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 18:28:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589840881;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RxqrGhaxYTaOFAMxAjNWB6KLd24PknAk9v9zZTCSj84=;
        b=i9AN3Ttbm1MtjeKipTGXqKYxebbcRpxVPPv+f/xfH984NsD4kBuiomqiFKOLYfwi8LvmGF
        iqaZajUeh7bstIE9sbpACtH3QeROA2RlBCs9IfRCBpmDnuhASAI517GK3dmAHf9udZgEbe
        GLB6YlBoVDdj+Z5rLW8LwDceUFkxLQQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-503-G51VBqGuOn282OSXz8VsPA-1; Mon, 18 May 2020 18:27:59 -0400
X-MC-Unique: G51VBqGuOn282OSXz8VsPA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E9A0180B700;
        Mon, 18 May 2020 22:27:57 +0000 (UTC)
Received: from treble (ovpn-113-47.rdu2.redhat.com [10.10.113.47])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DCB9D3A1;
        Mon, 18 May 2020 22:27:56 +0000 (UTC)
Date:   Mon, 18 May 2020 17:27:54 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Matt Helsley <mhelsley@vmware.com>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Julien Thierry <jthierry@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC][PATCH 4/5] objtool: Enable compilation of objtool for all
 architectures
Message-ID: <20200518222754.cp7vh2qp76khfy4r@treble>
References: <cover.1588888003.git.mhelsley@vmware.com>
 <9f709ea2ae66cc03b3ff3329baa8f670ccd0e368.1588888003.git.mhelsley@vmware.com>
 <20200515205610.fmdimt7wbafypuqc@treble>
 <20200518195045.GQ9040@rlwimi.vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200518195045.GQ9040@rlwimi.vmware.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 18, 2020 at 12:50:45PM -0700, Matt Helsley wrote:
> > Why were these moved to arch.h?  They're not necessarily arch-specific,
> > but rather "check"-specific, so I think they still belong in check.h, if
> > possible.
> 
> Ah, found it. They are arch specific due to struct orc_entry, which is
> presently not defined for any archs besides x86.
> 
> Prior to the patch (-> means "includes"):
> 	check.h -> asm/orc_types.h (defines struct orc_entry)
> 	orc_gen.c -> check,h
> 
> After patch:
> 	check.c -> asm/orc_types.h
> 	orc_gen.c -> asm/orc_types.h
> 	orc_gen.c -> check.h
> 	orc_gen.c -> arch.h
> 	{ now weak.c } -> check.h
> 
> So this prevents the headers, which help us keep the weak definitions
> consistent with the strong definitions, from breaking compiles on archs
> that lack struct orc_entry.
> 
> I'm not sure what the best way to remove this dependency is without
> a nasty void * for the orc entry, or some #ifdef games related to
> checking for cpp defines from asm/orc_types.h. This approach neatly
> avoids conditional preprocessor games and type casting though I do
> agree it's surprising.
> 
> Do you have any advice here?

Would it work if we just move the check() and orc_dump() prototypes to
objtool.h?  Then weak.c can just include objtool.h.  And check.h and
orc.h would only need to be included for arches which implement them.

-- 
Josh

