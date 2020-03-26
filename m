Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8300FC43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 13:56:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 528BF20774
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 13:56:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TjLLHa83"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727769AbgCZN4D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 09:56:03 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:52329 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727729AbgCZN4D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 09:56:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585230961;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jIfxtdzpS5t10KKUyUF+gPYz0Cv5B7oYa30VIS8PJ1g=;
        b=TjLLHa838masgwD7WBNk9VJdrXqdlnLlJNJGoO88lYoQWqGkJ8NaZFxBQeu6fnvWwtq8eV
        XA1r8Mnst15egY5Cj2Z+YxaJ6aOdhkTXo/lppf/VjU7HkLHALUxfG0W9jH7mMNaxs3205U
        dqc+sIYGjtqg8GBOs6xSZeDBqO2zPA4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-78-ppGoIymzNYKwsIc8GmZasw-1; Thu, 26 Mar 2020 09:55:55 -0400
X-MC-Unique: ppGoIymzNYKwsIc8GmZasw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EDAD6801A1B;
        Thu, 26 Mar 2020 13:55:52 +0000 (UTC)
Received: from sandy.ghostprotocols.net (unknown [10.3.128.25])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4B6AB5C241;
        Thu, 26 Mar 2020 13:55:52 +0000 (UTC)
Received: by sandy.ghostprotocols.net (Postfix, from userid 1000)
        id 18300160; Thu, 26 Mar 2020 10:55:48 -0300 (BRT)
Date:   Thu, 26 Mar 2020 10:55:47 -0300
From:   Arnaldo Carvalho de Melo <acme@redhat.com>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mingbo Zhang <whensungoes@gmail.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86: perf: insn: Tweak opcode map for Intel CET
 instructions
Message-ID: <20200326135547.GA20397@redhat.com>
References: <20200303045033.6137-1-whensungoes@gmail.com>
 <20200326103153.de709903f26fee0918414bd2@kernel.org>
 <bac567dd-9810-4919-365e-b3dfb54a6c4b@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bac567dd-9810-4919-365e-b3dfb54a6c4b@intel.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.5.20 (2009-12-10)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Mar 26, 2020 at 07:09:45AM +0200, Adrian Hunter escreveu:
> On 26/03/20 3:31 am, Masami Hiramatsu wrote:
> > Hi,
> > 
> > On Mon,  2 Mar 2020 23:50:30 -0500
> > Mingbo Zhang <whensungoes@gmail.com> wrote:
> > 
> >> Intel CET instructions are not described in the Intel SDM. When trying to
> >> get the instruction length, the following instructions get wrong (missing
> >> ModR/M byte).
> >>
> >> RDSSPD r32
> >> RSDDPQ r64
> >> ENDBR32
> >> ENDBR64
> >> WRSSD r/m32, r32
> >> WRSSQ r/m64, r64
> >>
> >> RDSSPD/Q and ENDBR32/64 use the same opcode (f3 0f 1e) slot, which is
> >> described in SDM as Reserved-NOP with no encoding characters, and got an
> >> empty slot in the opcode map. WRSSD/Q (0f 38 f6) also got an empty slot.
> >>
> > 
> > This looks good to me. BTW, wouldn't we need to add decode test cases to perf?
> > 
> > Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
> > 
> > Thank you,
> > 
> 
> We have correct patches that you ack'ed for CET here:
> 
> 	https://lore.kernel.org/lkml/20200204171425.28073-1-yu-cheng.yu@intel.com/
> 
> But they have not yet been applied.
> 
> Sorry for the confusion.

I'll collect them, thanks for pointing this out.

- Arnaldo

