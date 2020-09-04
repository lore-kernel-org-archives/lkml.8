Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11FEDC43461
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 18:55:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3711206A5
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 18:55:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PHiRDDSP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbgIDSzf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 14:55:35 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:44124 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726047AbgIDSzd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 14:55:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599245731;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oFPHcehcUmB19GUL5LiwgzkyVfpLa6gz216yp/zHq+4=;
        b=PHiRDDSPY1/XIUs0LlCGyxEYAI+7xvL/0MIP5yjKMQYffm0rLQYcOlrTr0m8pa1JUz8/8H
        nb3N7NTrydqaqUI/NdIHZ0pkfx+sgrkfUanevqTOoXu4UjMtVfd4iXISktRgS3EzQ4KDi3
        4gMv0a8yc+3jopW7ySCEvFVisgYgEM0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-558-ZpJmevbXNOGJeEKRTCVFMg-1; Fri, 04 Sep 2020 14:55:29 -0400
X-MC-Unique: ZpJmevbXNOGJeEKRTCVFMg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0819918A2240;
        Fri,  4 Sep 2020 18:55:28 +0000 (UTC)
Received: from treble (ovpn-117-138.rdu2.redhat.com [10.10.117.138])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4E90F5C5DE;
        Fri,  4 Sep 2020 18:55:27 +0000 (UTC)
Date:   Fri, 4 Sep 2020 13:55:25 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Julien Thierry <jthierry@redhat.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org, mbenes@suse.cz,
        raphael.gault@arm.com, benh@kernel.crashing.org
Subject: Re: [PATCH v3 00/10] Make check implementation arch agnostic
Message-ID: <20200904185525.zkx46hsbobghr2wb@treble>
References: <20200904153028.32676-1-jthierry@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200904153028.32676-1-jthierry@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 04, 2020 at 04:30:18PM +0100, Julien Thierry wrote:
> Hi,
> 
> The current implementation of the check subcommand has various x86 bits
> here and there. In order to prepare objtool to provide check for other
> architectures, add some abstraction over the x86 specific bits, relying
> on objtool arch specific code to provide some necessary operations.
> 
> This is part of the effort to implement check for arm64, initiated [1]
> by Raphael. The series is based on top of the separation of check & orc
> subcommands series[2].
> 
> I've push both series base on top of tip/objtool/core at [3].
> 
> - The first two patches make it simpler for new arches to provide their
> list of kernel headers, without worrying about modifications in the x86
> headers.
> - Patch 3 Moves arch specific macros to more suitable location
> - Patches 4 and 5 add abstraction to handle alternatives
> - Patch 6 adds abstraction to handle jump table
> - Patches 7-10 makes unwind hint definitions shared across architectures
> 
> Changes since v2 [4]:
> - Rebased on v5.9-rc1
> - Under tools/objtool/arch/x86/, rename arch_special.c to special.c
> - Rename include/linux/frame.h to inclide/linux/objtool.h
> - Share unwind hint types across architectures

Thanks.  These look good.  We're still trying to get our merge process
worked out, and tip/objtool/core is now pretty old, but these apply well
enough.

If there are no more comments I can fix up the few minor comments I had
and then try to get them merged after your other set (once Peter and I
figure out how to do that :-)

-- 
Josh

