Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D16BC3815B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 16:33:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E249206F9
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 16:33:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YMrgm++u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1416141AbgDOQdg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 12:33:36 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:21793 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1416090AbgDOQdd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 12:33:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586968412;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=o3eM1tZfmQMcRnJYXT++oOFvPIFgK+wYaNmGs2fM6+8=;
        b=YMrgm++uKB7tlX44bL380LgGD/wDT+Mt8fmdaOASmIE1WQXOWgHgqp35U2BcLxoLRszjcZ
        nI80PNeFelx/pIMz6ta1pVNQWuoCn37LeUEoEr694Cu2HUFpaq2JeE/nwt8VsbnRQuW7sL
        JeE1Yll9E0YbP75jtrasVFkcDDgEhKY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-456-SnfPGWtkNpWuZX1_2QFTIw-1; Wed, 15 Apr 2020 12:33:29 -0400
X-MC-Unique: SnfPGWtkNpWuZX1_2QFTIw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DF85F107BA97;
        Wed, 15 Apr 2020 16:33:05 +0000 (UTC)
Received: from treble (ovpn-116-146.rdu2.redhat.com [10.10.116.146])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5483CA098C;
        Wed, 15 Apr 2020 16:33:05 +0000 (UTC)
Date:   Wed, 15 Apr 2020 11:33:03 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Jessica Yu <jeyu@kernel.org>
Cc:     live-patching@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 6/7] livepatch: Remove module_disable_ro() usage
Message-ID: <20200415163303.ubdnza6okg4h3e5a@treble>
References: <cover.1586881704.git.jpoimboe@redhat.com>
 <9f0d8229bbe79d8c13c091ed70c41d49caf598f2.1586881704.git.jpoimboe@redhat.com>
 <20200415150216.GA6164@linux-8ccs.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200415150216.GA6164@linux-8ccs.fritz.box>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 15, 2020 at 05:02:16PM +0200, Jessica Yu wrote:
> +++ Josh Poimboeuf [14/04/20 11:28 -0500]:
> > With arch_klp_init_object_loaded() gone, and apply_relocate_add() now
> > using text_poke(), livepatch no longer needs to use module_disable_ro().
> > 
> > The text_mutex usage can also be removed -- its purpose was to protect
> > against module permission change races.
> > 
> > Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
> > ---
> > kernel/livepatch/core.c | 8 --------
> > 1 file changed, 8 deletions(-)
> > 
> > diff --git a/kernel/livepatch/core.c b/kernel/livepatch/core.c
> > index 817676caddee..3a88639b3326 100644
> > --- a/kernel/livepatch/core.c
> > +++ b/kernel/livepatch/core.c
> > @@ -767,10 +767,6 @@ static int klp_init_object_loaded(struct klp_patch *patch,
> > 	struct klp_modinfo *info = patch->mod->klp_info;
> > 
> > 	if (klp_is_module(obj)) {
> > -
> > -		mutex_lock(&text_mutex);
> > -		module_disable_ro(patch->mod);
> > -
> 
> Don't you still need the text_mutex to use text_poke() though?
> (Through klp_write_relocations -> apply_relocate_add -> text_poke)
> At least, I see this assertion there:
> 
> void *text_poke(void *addr, const void *opcode, size_t len)
> {
> 	lockdep_assert_held(&text_mutex);
> 
> 	return __text_poke(addr, opcode, len);
> }

Hm, guess I should have tested with lockdep ;-)

-- 
Josh

