Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4252DC0044D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 19:23:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17A4E20753
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 19:23:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ASoFodBc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732427AbgCPTXO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 15:23:14 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:22151 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732366AbgCPTXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 15:23:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584386592;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vay+P7VHYEUob1GMEwWjqDc6BMYFaq9l6VayXSGNdnw=;
        b=ASoFodBcpv8c7k873w3Z/slQnqOH0GQ/H/LE24iqV82MwPKWRiOzaCwT/jewEv5l6dRoxg
        w7FTdDpV7NUmanO8id5Ummtwiq8UcFzRP1xrGvf9WBtwSNHEcgEcPWnHYDs8EjZ/EBRgBx
        Fh2RLx3/kTEQVTlJUtlmvEG8ZQPb3qQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-112-rxec9ER_NPuyfLLZKExdmA-1; Mon, 16 Mar 2020 15:23:08 -0400
X-MC-Unique: rxec9ER_NPuyfLLZKExdmA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 678AC92784;
        Mon, 16 Mar 2020 19:20:56 +0000 (UTC)
Received: from treble (ovpn-127-104.rdu2.redhat.com [10.10.127.104])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8F9B27E301;
        Mon, 16 Mar 2020 19:20:55 +0000 (UTC)
Date:   Mon, 16 Mar 2020 14:20:53 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [RFC][PATCH 15/16] objtool: Implement noinstr validation
Message-ID: <20200316192053.5oactl56lo6w7vw4@treble>
References: <20200312134107.700205216@infradead.org>
 <20200312135042.288201372@infradead.org>
 <20200315180320.cgy2ealklbjlx4g7@treble>
 <20200316132419.GF12521@hirez.programming.kicks-ass.net>
 <20200316161904.zouwkwup6vwsmxgp@treble>
 <20200316164827.GH12521@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200316164827.GH12521@hirez.programming.kicks-ass.net>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 16, 2020 at 05:48:27PM +0100, Peter Zijlstra wrote:
> On Mon, Mar 16, 2020 at 11:19:04AM -0500, Josh Poimboeuf wrote:
> > On Mon, Mar 16, 2020 at 02:24:19PM +0100, Peter Zijlstra wrote:
> > > > And "read_instr_hints" reads as "read_instruction_hints()".
> > > > 
> > > > Can we come up with a more readable name?  Why not just "notrace"?
> > > > 
> > > > The trace begin/end annotations could be
> > > > 
> > > >   trace_allow_begin()
> > > >   trace_allow_end()
> > > 
> > > notrace already exists and we didn't want to confuse things further.
> > 
> > Um, why would it confuse things to call a section of notrace code
> > ".notrace.text"???
> 
> Because it is strictly stronger than the notrace attribute is. And we
> certainly don't want all that is now marked notrace to end up there.

Ok, I must have misunderstood, I thought it was *all* notrace code going
in there.

I still hope we can come up with a better name.

-- 
Josh

