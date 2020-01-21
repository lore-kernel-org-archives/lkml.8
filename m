Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CE83C2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 17:33:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1113A206A2
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 17:33:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f4upiMyN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729147AbgAURdP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 12:33:15 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:31467 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728829AbgAURdO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 12:33:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579627993;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=X+1nAC0+SxgPPTs8vkrGO5Iz83uXJrfWdyhSIti9ZQE=;
        b=f4upiMyNr2zvFixS4co9SvZ6N3lVMln7tuYLwzX+9eiHKFbmhyRvGmPtAUXYB8W4q1tdEk
        A4IdCjhHuquGC0cSK6JW0toFH2LkV2AbktEvuFZ5JUKdbq+P7x+8bFP4MzzBl/1PqI5AbI
        U6aCsXrBFNODTw5rOTtHcAtbyzfUuTQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-147-8ATiIqFlPqyuRUumYZ_QDA-1; Tue, 21 Jan 2020 12:33:10 -0500
X-MC-Unique: 8ATiIqFlPqyuRUumYZ_QDA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 83410107ACC4;
        Tue, 21 Jan 2020 17:33:08 +0000 (UTC)
Received: from treble (ovpn-122-154.rdu2.redhat.com [10.10.122.154])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3C49184DB2;
        Tue, 21 Jan 2020 17:33:07 +0000 (UTC)
Date:   Tue, 21 Jan 2020 11:33:05 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Julien Thierry <jthierry@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        peterz@infradead.org, raphael.gault@arm.com,
        catalin.marinas@arm.com, will@kernel.org
Subject: Re: [RFC v5 12/57] objtool: check: Allow jumps from an alternative
 group to itself
Message-ID: <20200121173305.urv77ral76su26cs@treble>
References: <20200109160300.26150-1-jthierry@redhat.com>
 <20200109160300.26150-13-jthierry@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200109160300.26150-13-jthierry@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 09, 2020 at 04:02:15PM +0000, Julien Thierry wrote:
> Alternatives can contain instructions that jump to another instruction
> in the same alternative group. This is actually a common pattern on
> arm64.
> 
> Keep track of instructions jumping within their own alternative group
> and carry on validating such branches.
> 
> Signed-off-by: Julien Thierry <jthierry@redhat.com>
> ---
>  tools/objtool/check.c | 48 ++++++++++++++++++++++++++++++++++---------
>  tools/objtool/check.h |  1 +
>  2 files changed, 39 insertions(+), 10 deletions(-)
> 
> diff --git a/tools/objtool/check.c b/tools/objtool/check.c
> index 8f2ff030936d..c7b3f1e2a628 100644
> --- a/tools/objtool/check.c
> +++ b/tools/objtool/check.c
> @@ -722,6 +722,14 @@ static int handle_group_alt(struct objtool_file *file,
>  	sec_for_each_insn_from(file, insn) {
>  		if (insn->offset >= special_alt->orig_off + special_alt->orig_len)
>  			break;
> +		/* Is insn a jump to an instruction within the alt_group */
> +		if (insn->jump_dest && insn->sec == insn->jump_dest->sec &&
> +		    (insn->type == INSN_JUMP_CONDITIONAL ||
> +		     insn->type == INSN_JUMP_UNCONDITIONAL)) {
> +			dest_off = insn->jump_dest->offset;
> +			insn->intra_group_jump = special_alt->orig_off <= dest_off &&
> +				dest_off < special_alt->orig_off + special_alt->orig_len;
> +		}

This patch adds some complexity, just so we can keep the

  "don't know how to handle branch to middle of alternative instruction group"

warning for the case where code from outside an alternative insn group
is branching to inside the group.  But I've never actually seen that
case in practice, and I get the feeling that warning isn't very useful
or realistic.

How about we just remove the warning?

-- 
Josh

