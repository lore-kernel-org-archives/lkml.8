Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5378C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 16:59:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E24E2063A
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 16:59:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QsHoyLpx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391114AbgDCQ7X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 12:59:23 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:42127 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728121AbgDCQ7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 12:59:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585933162;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0cjGQs7ZJFpDDMnRgUApJKcyQromsXU5+AxTIgkAGnM=;
        b=QsHoyLpxkgh/amDoMB0D8hhrlaaw2eVrAs1t9Sz6sGu3usVh83r3PS6bcNwfDwF6XMVxJh
        Pwh5nGy89fU+nCpoau0kEaudurtwIPgv5aUdm18fBZL2OF7CD1WeEsHlMEtW7r7BZFpHBG
        q9XwzthKTU5/gWQCpfOD95kIyhmlCV4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-467-ZmqnCpb_M4aoc7eYn4ga7A-1; Fri, 03 Apr 2020 12:59:20 -0400
X-MC-Unique: ZmqnCpb_M4aoc7eYn4ga7A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C3C5F800D5C;
        Fri,  3 Apr 2020 16:59:18 +0000 (UTC)
Received: from treble (ovpn-118-100.rdu2.redhat.com [10.10.118.100])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B63547E32F;
        Fri,  3 Apr 2020 16:59:16 +0000 (UTC)
Date:   Fri, 3 Apr 2020 11:59:13 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     jeyu@kernel.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, keescook@chromium.org,
        Miroslav Benes <mbenes@suse.cz>
Subject: Re: [PATCH] module: Harden STRICT_MODULE_RWX
Message-ID: <20200403165913.cxjxrwp7j5kssfxk@treble>
References: <20200403163716.GV20730@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200403163716.GV20730@hirez.programming.kicks-ass.net>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 03, 2020 at 06:37:16PM +0200, Peter Zijlstra wrote:
> 
> We're very close to enforcing W^X memory

Oh, and I haven't forgotten ;-)  Will bump it up the TODO list and
finish it soon.

-- 
Josh

