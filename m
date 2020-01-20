Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D219BC2D0DB
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 17:32:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B43721835
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 17:32:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bl7RvJTM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727071AbgATRcg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 12:32:36 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:58516 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726642AbgATRcg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 12:32:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579541555;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pupWMERdR1wMYcqgiWftw9KbT+PIN4ddg+q+dbnkviw=;
        b=bl7RvJTMLKMcsc6aUZN+7w4IINeNQciSWQrVkiSixjgJkrQj5WA1aS3D1PqSnUXCxky3Zd
        9AZpRGCxWruEClIamDXR7oJOg4nOeAsdwh5Matf9J/b9yQN8w9SYHRWyyovMttLE46eWS0
        S+sjtGuXvCrI3zzs3gZfjcooAbQw5K4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-291-XM1RbWJUNBy5BmfE-J12dA-1; Mon, 20 Jan 2020 12:32:32 -0500
X-MC-Unique: XM1RbWJUNBy5BmfE-J12dA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AD0F3477;
        Mon, 20 Jan 2020 17:32:30 +0000 (UTC)
Received: from treble (ovpn-125-19.rdu2.redhat.com [10.10.125.19])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 050D684DBC;
        Mon, 20 Jan 2020 17:32:29 +0000 (UTC)
Date:   Mon, 20 Jan 2020 11:32:28 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Miroslav Benes <mbenes@suse.cz>
Cc:     akpm@linux-foundation.org, trivial@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arch/Kconfig: Update HAVE_RELIABLE_STACKTRACE description
Message-ID: <20200120173228.5nxa72ri5msywiop@treble>
References: <20200120154042.9934-1-mbenes@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200120154042.9934-1-mbenes@suse.cz>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 20, 2020 at 04:40:42PM +0100, Miroslav Benes wrote:
> save_stack_trace_tsk_reliable() is not the only function providing the
> reliable stack traces anymore. Architecture might define ARCH_STACKWALK
> which provides a newer stack walking interface and has
> arch_stack_walk_reliable() function. Update the description accordingly.
> 
> Signed-off-by: Miroslav Benes <mbenes@suse.cz>

Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>

-- 
Josh

