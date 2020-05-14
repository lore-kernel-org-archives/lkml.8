Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B410C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 19:27:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF06920643
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 19:27:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BxGiiWoW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728210AbgENT1t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 15:27:49 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:57570 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725975AbgENT1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 15:27:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589484467;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=y5h6nPrhEzpYCzdipFANUUrKCuB7CVP+YlT+ibTkEPU=;
        b=BxGiiWoWe55Isd6mrnI+QloqX4KFZv67wN8+pGBiWVheoau7Ls96ivT2Omm9gYgsW2YkoI
        lonMKXWNcxZL7RiIaHYCSonQ/mnYHHB2lRw5sPDfiuxOLJz+qVRqIsyDfQ6r1CMssR0R1N
        oZnT8ik+A4cBTX7JMeL5va6r+9zlXa4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-171--HXsfovRPfaR3hf9MfvoDg-1; Thu, 14 May 2020 15:27:43 -0400
X-MC-Unique: -HXsfovRPfaR3hf9MfvoDg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B8948107ACCD;
        Thu, 14 May 2020 19:27:41 +0000 (UTC)
Received: from treble (ovpn-117-14.rdu2.redhat.com [10.10.117.14])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 15E6C5D9CA;
        Thu, 14 May 2020 19:27:39 +0000 (UTC)
Date:   Thu, 14 May 2020 14:27:38 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Pavel Machek <pavel@denx.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Miroslav Benes <mbenes@suse.cz>,
        Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>, Dave Jones <dsj@fb.com>,
        Jann Horn <jannh@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vince Weaver <vincent.weaver@maine.edu>
Subject: Re: [PATCH 4.19 37/48] x86/entry/64: Fix unwind hints in register
 clearing code
Message-ID: <20200514192738.nolajgjg56of4nat@treble>
References: <20200513094351.100352960@linuxfoundation.org>
 <20200513094401.325580400@linuxfoundation.org>
 <20200513214856.GA27858@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200513214856.GA27858@amd>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 13, 2020 at 11:48:56PM +0200, Pavel Machek wrote:
> On Wed 2020-05-13 11:45:03, Greg Kroah-Hartman wrote:
> > From: Josh Poimboeuf <jpoimboe@redhat.com>
> > 
> > commit 06a9750edcffa808494d56da939085c35904e618 upstream.
> > 
> > The PUSH_AND_CLEAR_REGS macro zeroes each register immediately after
> > pushing it.  If an NMI or exception hits after a register is cleared,
> > but before the UNWIND_HINT_REGS annotation, the ORC unwinder will
> > wrongly think the previous value of the register was zero.  This can
> > confuse the unwinding process and cause it to exit early.
> > 
> > Because ORC is simpler than DWARF, there are a limited number of unwind
> > annotation states, so it's not possible to add an individual unwind hint
> > after each push/clear combination.  Instead, the register clearing
> > instructions need to be consolidated and moved to after the
> > UNWIND_HINT_REGS annotation.
> 
> This actually makes kernel entry/exit slower, due to poor instruction
> scheduling. And that is a bit of hot path... Is it strictly
> neccessary? Not everyone needs ORC scheduler. Should it be somehow
> optional?

I didn't measure a difference beyond the noise level, did you?

-- 
Josh

