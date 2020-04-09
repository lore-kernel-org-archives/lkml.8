Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7B45C2BA2B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 13:53:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8EC620A8B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 13:53:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Db9Da3Eq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727009AbgDINxu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 09:53:50 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:35321 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726582AbgDINxt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 09:53:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586440429;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/e6XWzzBFJ/aLkeNik2nTKsH4FvVzI2sDJBgYcJfbTU=;
        b=Db9Da3EqucqyY4uAayOQWb4HTUYgDbEZ52K8pNWUy9b9nvIMAdS2/T61GWMEgGij/o7Mf8
        n0bJGOtUsCK13dDxJyeo6aWkz3siCdb8TcxbRVCfqIXEZYkRGNSwxBBcIXMGs1XrTwS1JI
        aQ/qtKY7mceREXK2zfNpsqWuAFJpVJQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-194-XPT94KwxOACBhrar-3ukZQ-1; Thu, 09 Apr 2020 09:53:45 -0400
X-MC-Unique: XPT94KwxOACBhrar-3ukZQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D8DA7DB6A;
        Thu,  9 Apr 2020 13:53:44 +0000 (UTC)
Received: from treble (ovpn-118-54.rdu2.redhat.com [10.10.118.54])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0084C60BF3;
        Thu,  9 Apr 2020 13:53:43 +0000 (UTC)
Date:   Thu, 9 Apr 2020 08:53:41 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Julien Thierry <jthierry@redhat.com>
Subject: Re: [PATCH 0/5] objtool fixes
Message-ID: <20200409135341.zczgrpbi3pwayicb@treble>
References: <cover.1585761021.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1585761021.git.jpoimboe@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi x86 maintainers,

Ping?

On Wed, Apr 01, 2020 at 01:23:24PM -0500, Josh Poimboeuf wrote:
> Some objtool fixes related to CONFIG_UBSAN_TRAP, Clang assembler, and
> more...
> 
> Josh Poimboeuf (5):
>   objtool: Fix CONFIG_UBSAN_TRAP unreachable warnings
>   objtool: Support Clang non-section symbols in ORC dump
>   objtool: Support Clang non-section symbols in ORC generation
>   objtool: Fix switch table detection in .text.unlikely
>   objtool: Make BP scratch register warning more robust
> 
>  tools/objtool/check.c    | 26 ++++++++++++++++--------
>  tools/objtool/orc_dump.c | 44 ++++++++++++++++++++++++----------------
>  tools/objtool/orc_gen.c  | 33 +++++++++++++++++++++++-------
>  3 files changed, 71 insertions(+), 32 deletions(-)

-- 
Josh

