Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FC8DC10DCE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 16:58:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29147208C3
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 16:58:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CVakUe6P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbgCFQ6s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 11:58:48 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:27748 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726237AbgCFQ6r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 11:58:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583513926;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=A55OoPDSCAEQMkVT+BI7hPJYiT6IRiTcYHuIWkW2WoE=;
        b=CVakUe6PzyCQZzKsyTaHnSFILtGI7qkLb7Q+uAC8KwTAcKsAIiRvxXtK4nh/icNWbyOqll
        z3rTSz418dEpkdwx8XnUu9rZR8VwPMTBkJTGa2rCcXS70Z3Vz5Wh2/6CqOWko46IBIYwe7
        fsH9itBmraQS3h3lQy9WUNqDjPLNqTk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-101-r3E-fKK4Or6H92pVcPt3hw-1; Fri, 06 Mar 2020 11:58:44 -0500
X-MC-Unique: r3E-fKK4Or6H92pVcPt3hw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 19172DB60;
        Fri,  6 Mar 2020 16:58:43 +0000 (UTC)
Received: from treble (ovpn-124-190.rdu2.redhat.com [10.10.124.190])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 60DF919C69;
        Fri,  6 Mar 2020 16:58:41 +0000 (UTC)
Date:   Fri, 6 Mar 2020 10:58:39 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Jann Horn <jannh@google.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/entry/64: Fix unwind hint for rewind_stack_do_exit
Message-ID: <20200306165839.wh5qqsmtwbfyirwi@treble>
References: <20200305225443.64426-1-jannh@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200305225443.64426-1-jannh@google.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 05, 2020 at 11:54:43PM +0100, Jann Horn wrote:
> The leaq instruction in rewind_stack_do_exit moves the stack pointer
> directly below the pt_regs at the top of the task stack before calling
> do_exit(). Tell the unwinder to expect pt_regs.
> 
> Signed-off-by: Jann Horn <jannh@google.com>

Thanks Jann.  This fits in nicely with my ORC series so I'll add it.

-- 
Josh

