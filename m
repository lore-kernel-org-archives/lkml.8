Return-Path: <SRS0=iqK9=5A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45E20C10DCE
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 16:21:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19F83206E9
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 16:21:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QGvqkgsh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728917AbgCOQVB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Mar 2020 12:21:01 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:20497 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728628AbgCOQVB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Mar 2020 12:21:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584289260;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QkHM9DY6LYtmZwJS8n3Dg/7aJvZPeK3KqE7yTRbD/n0=;
        b=QGvqkgshue8upL0UShHoX90dPvHaqJ/j/Z8eDbhbeAmI9froaV5gq7aShLAMQC+z056WP9
        iyVYLmYfLhPEmIYlDKZCNjFLk8FQxW92RLkGdntBZ3ZWUBYq83XUzCXYnAp+TPzheIT0Ul
        Y6ePCuAMwpW3VgeZpekn4yDSq7CjrqQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-19-HRED9RIfP32g_g8oJ6jAPQ-1; Sun, 15 Mar 2020 12:20:58 -0400
X-MC-Unique: HRED9RIfP32g_g8oJ6jAPQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 84AD2800D4E;
        Sun, 15 Mar 2020 16:20:57 +0000 (UTC)
Received: from treble (ovpn-120-135.rdu2.redhat.com [10.10.120.135])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id EC97860BFB;
        Sun, 15 Mar 2020 16:20:56 +0000 (UTC)
Date:   Sun, 15 Mar 2020 11:20:55 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [RFC][PATCH 06/16] objtool: Add a statistics mode
Message-ID: <20200315162055.yllohanldpmpe6nk@treble>
References: <20200312134107.700205216@infradead.org>
 <20200312135041.758571858@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200312135041.758571858@infradead.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 12, 2020 at 02:41:13PM +0100, Peter Zijlstra wrote:
> --- a/tools/objtool/check.c
> +++ b/tools/objtool/check.c
> @@ -234,6 +234,7 @@ static int decode_instructions(struct ob
>  	struct symbol *func;
>  	unsigned long offset;
>  	struct instruction *insn;
> +	unsigned long nr_insns = 0;
>  	int ret;
>  
>  	for_each_sec(file, sec) {
> @@ -268,6 +269,7 @@ static int decode_instructions(struct ob
>  				goto err;
>  
>  			hash_add(file->insn_hash, &insn->hash, insn->offset);
> +			nr_insns++;
>  			list_add_tail(&insn->list, &file->insn_list);

It's slightly more readable to do the 'nr_insns++' after the
list_add_tail().

-- 
Josh

