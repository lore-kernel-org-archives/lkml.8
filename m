Return-Path: <SRS0=iqK9=5A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F3FEC10DCE
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 16:18:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E222F20637
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 16:18:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MYIP8PmA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728890AbgCOQSi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Mar 2020 12:18:38 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:42535 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728628AbgCOQSi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Mar 2020 12:18:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584289117;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5YpxgrgZOFhG1ZE1mY604BOqcsKDnPAATI2kwFlaiNA=;
        b=MYIP8PmABsu/JkP9kE4F/V/vw9FjYkKuD8PDe3xWe115iWU53IqxnNYbFUyvHR6FwnPZfj
        XKrw8GkskWZI20lobnDJAUg5S7a35E7MJmB8v+Aj4iGsN+AD5wb6SBDQGsaAvelDjS19a6
        fDPG0LPxEiVHpGttXWOFHM+e/aVgeFg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-446-1yBuZoANNFmak75wwj7oIA-1; Sun, 15 Mar 2020 12:18:35 -0400
X-MC-Unique: 1yBuZoANNFmak75wwj7oIA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9C692800D4E;
        Sun, 15 Mar 2020 16:18:34 +0000 (UTC)
Received: from treble (ovpn-120-135.rdu2.redhat.com [10.10.120.135])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A6B565DA76;
        Sun, 15 Mar 2020 16:18:33 +0000 (UTC)
Date:   Sun, 15 Mar 2020 11:18:31 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [RFC][PATCH 05/16] objtool: Optimize find_symbol_by_index()
Message-ID: <20200315161831.perix63awlsfj2bl@treble>
References: <20200312134107.700205216@infradead.org>
 <20200312135041.699859794@infradead.org>
 <20200315160919.zd7phtq7ejyq4kva@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200315160919.zd7phtq7ejyq4kva@treble>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 15, 2020 at 11:09:19AM -0500, Josh Poimboeuf wrote:
> On Thu, Mar 12, 2020 at 02:41:12PM +0100, Peter Zijlstra wrote:
> > The symbol index is object wide, not per section, so it makes no sense
> > to have the symbol_hash be part of the section object. By moving it to
> > the elf object we avoid the linear sections iteration.
> 
> I remember there was a specific reason for this oddity, but it eludes me
> now.
> 
> This does make sense, assuming it doesn't break anything.

On second thought I guess it was the symbol_list which had this
intentional per-section structure (for a still unremembered reason).

Then the symbol_hash came later, and it just parroted the symbol_list
structure.  So yeah, this change should be fine.

-- 
Josh

