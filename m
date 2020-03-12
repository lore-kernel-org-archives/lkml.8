Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD01CC10DCE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 17:44:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90ED9206B1
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 17:44:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UXx85Cl6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbgCLRo1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 13:44:27 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:54128 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725268AbgCLRo1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 13:44:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584035066;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tQyo3JSbB/DH2hR9HstC49m+F50qiRJ2W5RaCusW0vA=;
        b=UXx85Cl6W6zBLs/Lrn1f4Qnss9kAcbLrkaCoTnns/pb+bfH8z2ursZiLci6RTt1PgAmRkL
        cVmB6OizRzCRdF3Z98hxiWbNuXYtDi8PQwwQqydJMP27OoMqmuQu9qVDlmZ5nY6PSOA2Xx
        iJUKF17A1yhJCDdkk+vCGeWTFh5RT30=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-484-CX8YOnQQPY2OJu_zssqBPA-1; Thu, 12 Mar 2020 13:44:24 -0400
X-MC-Unique: CX8YOnQQPY2OJu_zssqBPA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2008E13E2;
        Thu, 12 Mar 2020 17:44:23 +0000 (UTC)
Received: from treble (ovpn-122-137.rdu2.redhat.com [10.10.122.137])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6647E90CD0;
        Thu, 12 Mar 2020 17:44:22 +0000 (UTC)
Date:   Thu, 12 Mar 2020 12:44:20 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org, x86@kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [RFC][PATCH 00/16] objtool: vmlinux.o and noinstr validation
Message-ID: <20200312174420.gsc35hklw3p7bnhl@treble>
References: <20200312134107.700205216@infradead.org>
 <20200312162337.GU12561@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200312162337.GU12561@hirez.programming.kicks-ass.net>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 12, 2020 at 05:23:37PM +0100, Peter Zijlstra wrote:
> So one of the problem i've ran into while playing with this and Thomas'
> patches is that it is 'difficult' to deal with indirect function calls.
> 
> objtool basically gives up instantly.
> 
> I know smatch has passes were it looks for function pointer assignments
> and carries that forward into it's callchain generation. Doing something
> like that for objtool is going to be 'fun'...

Yeah, it would have to keep track of register and memory values, even
across function calls.  Which is basically crossing over into emulation
territory.  Which objtool wasn't really built for.

-- 
Josh

