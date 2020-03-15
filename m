Return-Path: <SRS0=iqK9=5A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A712C10DCE
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 16:09:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39F5A20578
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 16:09:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VEVmLLl3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728871AbgCOQJ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Mar 2020 12:09:29 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:60523 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728310AbgCOQJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Mar 2020 12:09:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584288568;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZvfpCDi2rKJmJAvsmnRekrSK8tNLi3wzOk8K48DUov4=;
        b=VEVmLLl3o/o99yAGae+Z7oe62Xi877YCemcSKy/At06p9ldXzq/mC+hrDjZ6s3sJO7AWCz
        /w/G68cl9HmEhC6z5ifyTPWQvNbqQN2ZFuIvmy/hgDXZvF2nsF5R801Q092z4WC8tZq+3U
        tJTPtQGqShfwo9Q2zo2xn4FmuV7u1sU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-122-2V2UxltzP0Kalk5PHP7k8Q-1; Sun, 15 Mar 2020 12:09:24 -0400
X-MC-Unique: 2V2UxltzP0Kalk5PHP7k8Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 91B06189D6C0;
        Sun, 15 Mar 2020 16:09:23 +0000 (UTC)
Received: from treble (ovpn-120-135.rdu2.redhat.com [10.10.120.135])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A05E59CA3;
        Sun, 15 Mar 2020 16:09:22 +0000 (UTC)
Date:   Sun, 15 Mar 2020 11:09:19 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [RFC][PATCH 05/16] objtool: Optimize find_symbol_by_index()
Message-ID: <20200315160919.zd7phtq7ejyq4kva@treble>
References: <20200312134107.700205216@infradead.org>
 <20200312135041.699859794@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200312135041.699859794@infradead.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 12, 2020 at 02:41:12PM +0100, Peter Zijlstra wrote:
> The symbol index is object wide, not per section, so it makes no sense
> to have the symbol_hash be part of the section object. By moving it to
> the elf object we avoid the linear sections iteration.

I remember there was a specific reason for this oddity, but it eludes me
now.

This does make sense, assuming it doesn't break anything.

-- 
Josh

