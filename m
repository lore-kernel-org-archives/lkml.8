Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E0FEC43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 17:54:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 617672074D
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 17:54:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SE1Ru9sC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388998AbgDBRye (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 13:54:34 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:58637 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726617AbgDBRye (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 13:54:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585850072;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+kDm4o06zpMsXiV2HyFO11f1wrVOQthR9R1JHdtLzJw=;
        b=SE1Ru9sC05IVbw+O437nV3s3JACQWu5gof9u5pOrnyKKaspje96xAfezvmKfcQDLJNw5/v
        elkExNG/LxmYl2D0w64BcwJuY8a3m8qUL3InVFgKPUCV68Kqy/q3T9/lMkpQgfUoxiSVNQ
        Xfjp3HEHBmZPBRzjmumKUkTq5sw4fqY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-330--8bAoQ0bNimQioM7Syzkrw-1; Thu, 02 Apr 2020 13:54:31 -0400
X-MC-Unique: -8bAoQ0bNimQioM7Syzkrw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0419F10CE788;
        Thu,  2 Apr 2020 17:54:30 +0000 (UTC)
Received: from treble (ovpn-118-100.rdu2.redhat.com [10.10.118.100])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 47BB8A63CD;
        Thu,  2 Apr 2020 17:54:29 +0000 (UTC)
Date:   Thu, 2 Apr 2020 12:54:26 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Julien Thierry <jthierry@redhat.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        raphael.gault@arm.com
Subject: Re: [PATCH v2 10/10] objtool: Support multiple stack_op per
 instruction
Message-ID: <20200402175426.77houvk46xhcxxmn@treble>
References: <20200327152847.15294-1-jthierry@redhat.com>
 <20200327152847.15294-11-jthierry@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200327152847.15294-11-jthierry@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 27, 2020 at 03:28:47PM +0000, Julien Thierry wrote:
> @@ -127,6 +129,10 @@ int arch_decode_instruction(struct elf *elf, struct section *sec,
>  	if (insn.sib.nbytes)
>  		sib = insn.sib.bytes[0];
>  
> +	op = calloc(1, sizeof(*op));
> +	if (!op)
> +		return -1;
> +

Why not malloc()?

> +static int handle_insn_ops(struct instruction *insn, struct insn_state *state)
> +{
> +	struct stack_op *op;
> +
> +	list_for_each_entry(op, &insn->stack_ops, list) {
> +		int res;
> +
> +		res = update_insn_state(insn, state, op);
> +		if (res)
> +			return res;

This should probably be like:

		if (update_insn_state(insn, state, op))
			return 1;

That way the error codes are converted to non-fatal warnings like before
(which I admit is confusing...)

> @@ -2205,29 +2244,8 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
>  			return 0;
>  
>  		case INSN_STACK:
> -			if (update_insn_state(insn, &state))
> +			if (handle_insn_ops(insn, &state))
>  				return 1;

How about "handle_stack_ops"?

-- 
Josh

