Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC743C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 20:51:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93EC22082F
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 20:51:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iT/B790I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726573AbgGAUvS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 16:51:18 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:57629 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725535AbgGAUvR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 16:51:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593636676;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NbYjpD75KSjMkRrn1WEH75w+FOpZgxrMTEmZVf5CAxw=;
        b=iT/B790I1C+Q2wQ2k9gjmTjUtaXdeFFNYXs3i2sQ8DQH7cg8VkhVfQObSQdrfxwFBby0Af
        J0wizowoDryIk/Uup0PVaGxp0wk1hCKvbrjqLr2xpEd0Zv9xp2WjRXj5Jmu40rvoqHAbHE
        fEwBNwQndjAjQIqqb5s1r6Zpc7GM3oU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-319-pboVzBC7OOSn7T4XBAcKlw-1; Wed, 01 Jul 2020 16:51:12 -0400
X-MC-Unique: pboVzBC7OOSn7T4XBAcKlw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 39BFF1083E80;
        Wed,  1 Jul 2020 20:51:11 +0000 (UTC)
Received: from treble (ovpn-117-134.rdu2.redhat.com [10.10.117.134])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 868255C557;
        Wed,  1 Jul 2020 20:51:10 +0000 (UTC)
Date:   Wed, 1 Jul 2020 15:51:08 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: objtool clac/stac handling change..
Message-ID: <20200701205108.wtgfnijav7lgfiqe@treble>
References: <CAHk-=wizu7DA7EDrsHQLmkTFBvCRxNyPMHaeMDYMF_U75s9RvQ@mail.gmail.com>
 <5F1767D0-416A-4BA4-9DFF-E82D1EA3F5EE@amacapital.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5F1767D0-416A-4BA4-9DFF-E82D1EA3F5EE@amacapital.net>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 01, 2020 at 01:36:22PM -0700, Andy Lutomirski wrote:
> If we do this extable change, we end up with a different mess: some
> exception handlers will clear AC and some won’t.  I’m sure objtool can
> deal with this with some effort, but I’m not convinced it’s worth it.

Yeah.  Peter's more of the expert here, but I think we'd at least need
to annotate the code which expects an implicit CLAC so objtool knows
what to expect.  It's not trivial, but it might be doable.

-- 
Josh

