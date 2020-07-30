Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59451C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 14:28:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34A76208A9
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 14:28:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MYOeWiRR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729075AbgG3O2r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 10:28:47 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:59861 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726275AbgG3O2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 10:28:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596119326;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=P3kbMjlHwFYIQuKYA33yRn78H0OnyyltleXaPspOFHo=;
        b=MYOeWiRR80qItNmwQ+DxFC+KrmEhTgUmJDo1mwZTP328tEM7D3NmoCWkShmbxClitS6ORv
        hMmza9tOS8fN+wGb+sHPb2bkP7bWtMRTYJN3S1Jt8iS82G6UWN/IuQ5b5W+ZZXFLOmzCG3
        BXRa88WNQFMdcN1GPN//1jdWs5lIKug=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-370-aCRGPd7qMDyp5JAOuV-85A-1; Thu, 30 Jul 2020 10:28:41 -0400
X-MC-Unique: aCRGPd7qMDyp5JAOuV-85A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0C535100AA22;
        Thu, 30 Jul 2020 14:28:40 +0000 (UTC)
Received: from treble (ovpn-119-23.rdu2.redhat.com [10.10.119.23])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5538A5FC31;
        Thu, 30 Jul 2020 14:28:39 +0000 (UTC)
Date:   Thu, 30 Jul 2020 09:28:37 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Julien Thierry <jthierry@redhat.com>
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org,
        mhelsley@vmware.com, mbenes@suse.cz
Subject: Re: [PATCH v3 4/4] objtool: orc_gen: Move orc_entry out of
 instruction structure
Message-ID: <20200730142837.a425acrg2sdbryy4@treble>
References: <20200730094143.27494-1-jthierry@redhat.com>
 <20200730094143.27494-5-jthierry@redhat.com>
 <20200730100304.GI2655@hirez.programming.kicks-ass.net>
 <e4e239ad-120e-bd8f-4128-6976146c8512@redhat.com>
 <20200730133343.GN2655@hirez.programming.kicks-ass.net>
 <0280367f-3839-acad-799a-ecc2756c1846@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0280367f-3839-acad-799a-ecc2756c1846@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 30, 2020 at 02:45:46PM +0100, Julien Thierry wrote:
> > > But I agree the proposed code is not ideal and on the other we've tried
> > > avoiding #ifdef in the code. Ideally I'd have an empty orc_entry definition
> > > when SUBCMD_ORC is not implemented.
> > > 
> > > Would you have a suggested approach to do that?
> > 
> > How ugly is having that:
> > 
> > struct orc_entry { };
> > 
> > ?
> 
> Not sure I am understanding the suggestion. Without #ifdef this will
> conflict with the definition in <asm/orc_types.h> for x86. Or every arch
> needs to provide their own <asm/orc_types.h> and definition of struct
> orc_entry, even if they don't implement the orc subcommand.
> 
> Which would be preferable? #ifdef? or arch provided definition? (or
> something I have not thought of)

If we wanted to get fancy we could add a 'struct insn_arch_specific
arch' field, and then require every arch to declare it.

But I think just an #ifdef in the 'instruction' struct declaration would
be easiest for now.

-- 
Josh

