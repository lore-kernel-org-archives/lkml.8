Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46A40C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 21:20:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AA982080C
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 21:20:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H7DG0Sgf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731316AbgCaVUs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 17:20:48 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:47156 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727852AbgCaVUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 17:20:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585689646;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=l1sC/bXso8WfBMNU+dzmS1e2mbgER1BAzZT3b2y34d0=;
        b=H7DG0SgfjCSO3j0Ph6/RPnun5CAwqCIvDVMlxTKyG/DStyn9rRnqS7FJo7xyXWvuzmJTLO
        C+5GCs9H32LyeEW0MtM1sX3LfxrFRTzOItYi0dcwKcUTakIRC+Hl6jQaIEZXKSLiC66eSu
        d7bWbESI8RUD3y870WW2HM8xNNOyo2c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-162-Ib-n9lOpMtC0VpYryZW9KQ-1; Tue, 31 Mar 2020 17:20:45 -0400
X-MC-Unique: Ib-n9lOpMtC0VpYryZW9KQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8171D8017CC;
        Tue, 31 Mar 2020 21:20:43 +0000 (UTC)
Received: from treble (ovpn-118-135.phx2.redhat.com [10.3.118.135])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4E2FB5E009;
        Tue, 31 Mar 2020 21:20:42 +0000 (UTC)
Date:   Tue, 31 Mar 2020 16:20:40 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org, x86@kernel.org,
        mhiramat@kernel.org, mbenes@suse.cz,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC][PATCH] objtool,ftrace: Implement UNWIND_HINT_RET_OFFSET
Message-ID: <20200331212040.7lrzmj7tbbx2jgrj@treble>
References: <20200326154938.GO20713@hirez.programming.kicks-ass.net>
 <20200326195718.GD2452@worktop.programming.kicks-ass.net>
 <20200327010001.i3kebxb4um422ycb@treble>
 <20200330170200.GU20713@hirez.programming.kicks-ass.net>
 <20200330190205.k5ssixd5hpshpjjq@treble>
 <20200330200254.GV20713@hirez.programming.kicks-ass.net>
 <20200331111652.GH20760@hirez.programming.kicks-ass.net>
 <20200331202315.zialorhlxmml6ec7@treble>
 <20200331204047.GF2452@worktop.programming.kicks-ass.net>
 <20200331211755.pb7f3wa6oxzjnswc@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200331211755.pb7f3wa6oxzjnswc@treble>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 31, 2020 at 04:17:58PM -0500, Josh Poimboeuf wrote:
> > I'm not against adding a second/separate hint for this. In fact, I
> > almost considered teaching objtool how to interpret the whole IRET frame
> > so that we can do it without hints. It's just that that's too much code
> > for this one case.
> > 
> > HINT_IRET_SELF ?
> 
> Despite my earlier complaint about stack size knowledge, we could just
> forget the hint and make "iretq in C code" equivalent to "reduce stack
> size by arch_exception_stack_size()" and keep going.  There's
> file->c_file which tells you it's a C file.

Or maybe "iretq in an STT_FUNC" is better since this pattern could
presumably happen in a callable asm function.

-- 
Josh

