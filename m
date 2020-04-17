Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 062C3C2D0EF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 14:51:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D50432223C
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 14:51:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jIcIMrDa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728257AbgDQOvt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 10:51:49 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:58928 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727850AbgDQOvt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 10:51:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587135107;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yQIzhOfMzw73993cxueMJNgEnkW4RYZ7tWZBL73PzbE=;
        b=jIcIMrDaY7TQIsZDLaWXOhvnly+z+svou3Li00YOUTsZ8NCu3J++sfXXDE238OgP0AkqDg
        Tb8V3O29CH1IPeCOtdk24XGofvpHIJ/uW0M78BCq9LPiPalX58NJ3IqHG9D7cdM3UXx2jb
        BMMd2DG/L1AkcyiiZ06n598v5XptLvc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-348-Ke1Kwz6rMoeXfhkRC1yUsQ-1; Fri, 17 Apr 2020 10:51:41 -0400
X-MC-Unique: Ke1Kwz6rMoeXfhkRC1yUsQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 152EBDB60;
        Fri, 17 Apr 2020 14:51:40 +0000 (UTC)
Received: from treble (ovpn-116-146.rdu2.redhat.com [10.10.116.146])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BF19618A85;
        Fri, 17 Apr 2020 14:51:38 +0000 (UTC)
Date:   Fri, 17 Apr 2020 09:51:36 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     live-patching@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jessica Yu <jeyu@kernel.org>, x86@kernel.org
Subject: Re: [PATCH v2 7/9] x86/module: Use text_poke() for late relocations
Message-ID: <20200417145136.ls3tafthtql6prhn@treble>
References: <cover.1587131959.git.jpoimboe@redhat.com>
 <572b12b6adcdab29c54cfd41ca8b4672abad628c.1587131959.git.jpoimboe@redhat.com>
 <20200417142944.GF20730@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200417142944.GF20730@hirez.programming.kicks-ass.net>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 17, 2020 at 04:29:44PM +0200, Peter Zijlstra wrote:
> On Fri, Apr 17, 2020 at 09:04:32AM -0500, Josh Poimboeuf wrote:
> > +int apply_relocate_add(Elf64_Shdr *sechdrs,
> > +		   const char *strtab,
> > +		   unsigned int symindex,
> > +		   unsigned int relsec,
> > +		   struct module *me)
> > +{
> > +	int ret;
> > +	bool early = me->state == MODULE_STATE_UNFORMED;
> > +	void *(*write)(void *, const void *, size_t) = memcpy;
> > +
> > +	if (!early) {
> > +		write = text_poke;
> > +		mutex_lock(&text_mutex);
> > +	}
> > +
> > +	ret = __apply_relocate_add(sechdrs, strtab, symindex, relsec, me,
> > +				   write);
> > +
> > +	if (!early) {
> > +		mutex_unlock(&text_mutex);
> > +		text_poke_sync();
> 
> I'm thinking text_poke_sync() wants to be inside text_mutex. Although
> given that nothing should be running that text, it really doesn't
> matter.

Yeah, makes sense.

diff --git a/arch/x86/kernel/module.c b/arch/x86/kernel/module.c
index 2a997afa04c6..23c95a53d20e 100644
--- a/arch/x86/kernel/module.c
+++ b/arch/x86/kernel/module.c
@@ -237,8 +237,8 @@ int apply_relocate_add(Elf64_Shdr *sechdrs,
 				   write);
 
 	if (!early) {
-		mutex_unlock(&text_mutex);
 		text_poke_sync();
+		mutex_unlock(&text_mutex);
 	}
 
 	return ret;

