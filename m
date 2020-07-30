Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9DE9C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 14:42:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 809652082E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 14:42:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UtbTElu+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729681AbgG3OmV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 10:42:21 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:26190 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726873AbgG3OmU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 10:42:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596120139;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Dpt7NYCGMgJLqM5T3Tc/U85T7f72I44GMyjiNHvJGhg=;
        b=UtbTElu+bUCEMtoEnqh8TuS17l+Rc75ZtpYjOO4yg8RLY1gBQCh+gaK/GBWk4rGlHNW6qg
        Cz1gQXGRfT6lxDbx1PZP1CtJLeA39k65e8A0ff+KhAY/nJSpzQD2fdyyaT7Ar+sh/njbf9
        nAYbjTkrdqern8U8egS+W+nDs1xln9w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-303-4CuoGZ18NwaaQEJgytujOQ-1; Thu, 30 Jul 2020 10:42:17 -0400
X-MC-Unique: 4CuoGZ18NwaaQEJgytujOQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 23A04800FEA;
        Thu, 30 Jul 2020 14:42:16 +0000 (UTC)
Received: from treble (ovpn-119-23.rdu2.redhat.com [10.10.119.23])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 239521992D;
        Thu, 30 Jul 2020 14:42:15 +0000 (UTC)
Date:   Thu, 30 Jul 2020 09:42:13 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Julien Thierry <jthierry@redhat.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org, mbenes@suse.cz,
        raphael.gault@arm.com, benh@kernel.crashing.org
Subject: Re: [PATCH v2 5/9] objtool: Make relocation in alternative handling
 arch dependent
Message-ID: <20200730144213.fcitzo4uydshjhxh@treble>
References: <20200730094652.28297-1-jthierry@redhat.com>
 <20200730094652.28297-6-jthierry@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200730094652.28297-6-jthierry@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 30, 2020 at 10:46:48AM +0100, Julien Thierry wrote:
> As pointed out by the comment in handle_group_alt(), support of
> relocation for instructions in an alternative group depends on whether
> arch specific kernel code handles it.
> 
> So, let objtool arch specific code decide whether a relocation for
> the alternative section should be accepted.
> 
> Reviewed-by: Miroslav Benes <mbenes@suse.cz>
> Signed-off-by: Julien Thierry <jthierry@redhat.com>
> ---
>  tools/objtool/arch/x86/arch_special.c | 13 +++++++++++++

The "arch" in "arch_special.c" is redundant, how about special.c?

-- 
Josh

