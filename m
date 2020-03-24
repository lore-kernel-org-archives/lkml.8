Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89CD0C10DCE
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 22:09:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E78B2078A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 22:09:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GxQXGqh1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728343AbgCXWJ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 18:09:28 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:38305 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727496AbgCXWJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 18:09:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585087766;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8/DZA43fNaq+Dl/IJEMjJipSmSN3epivzmmuS0/C7B0=;
        b=GxQXGqh15S80Ku+I1aLlH+mYAJVbSJDQXg4g8R163a0dpC1sinCnwt/AcVUhB6JCt2bgH2
        y+RWHkoLQLmb45gBLWG9wA79oaYI2AjzDxNZeacgTPDMyu2diJhYuL7GVkDPGGUYkAyNWI
        v4xIFM80QuwmXc5QFG+DUGk5sqst254=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-234-mZaVibZYPKihq_H91F5m0Q-1; Tue, 24 Mar 2020 18:09:22 -0400
X-MC-Unique: mZaVibZYPKihq_H91F5m0Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8AE32477;
        Tue, 24 Mar 2020 22:09:21 +0000 (UTC)
Received: from treble (unknown [10.10.119.253])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A58CB5C1B2;
        Tue, 24 Mar 2020 22:09:20 +0000 (UTC)
Date:   Tue, 24 Mar 2020 17:09:18 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org, x86@kernel.org,
        mhiramat@kernel.org, mbenes@suse.cz, brgerst@gmail.com
Subject: Re: [PATCH v3 24/26] objtool: Avoid iterating !text section symbols
Message-ID: <20200324220918.iddvi2y4op4sqo4z@treble>
References: <20200324153113.098167666@infradead.org>
 <20200324160925.350445809@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200324160925.350445809@infradead.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 24, 2020 at 04:31:37PM +0100, Peter Zijlstra wrote:
> validate_functions() iterates all sections their symbols; this is
> pointless to do for !text sections as they won't have instructions
> anyway.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>

-- 
Josh

