Return-Path: <SRS0=iqK9=5A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 309C6C10DCE
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 16:10:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02D74205C9
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 16:10:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DO6GeAGh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728928AbgCOQKg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Mar 2020 12:10:36 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:48244 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728695AbgCOQKg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Mar 2020 12:10:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584288635;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=W4Lm0YoP4KDolNEvyKr/Lt/aezU7JGREH2+Ds0TgmAY=;
        b=DO6GeAGhexHr+zcDyqeIu+M7buBDogGI3Ggo7qqGB6/fP/QQDYs8NiYIe6XHFFEHdF6WXq
        PixoRaeppexXnsVWu1J5FCZSdSMqBvT+if+MYZEwEhqk2CJuEN2UD25pXSu50ZB2GWNScL
        orxD0gxZbmElYaeTYXhOMu9VoCP3Bg4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-232-D271xW-5NYyG8jvhhIqL9g-1; Sun, 15 Mar 2020 12:10:34 -0400
X-MC-Unique: D271xW-5NYyG8jvhhIqL9g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 037BA189D6C0;
        Sun, 15 Mar 2020 16:10:33 +0000 (UTC)
Received: from treble (ovpn-120-135.rdu2.redhat.com [10.10.120.135])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5586310027A7;
        Sun, 15 Mar 2020 16:10:32 +0000 (UTC)
Date:   Sun, 15 Mar 2020 11:10:30 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [RFC][PATCH 05/16] objtool: Optimize find_symbol_by_index()
Message-ID: <20200315161030.5rzgnk7qvaof4zzx@treble>
References: <20200312134107.700205216@infradead.org>
 <20200312135041.699859794@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200312135041.699859794@infradead.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 12, 2020 at 02:41:12PM +0100, Peter Zijlstra wrote:
> @@ -289,7 +286,8 @@ static int read_symbols(struct elf *elf)
>  		}
>  		sym->alias = alias;
>  		list_add(&sym->list, entry);
> -		hash_add(sym->sec->symbol_hash, &sym->hash, sym->idx);
> +
> +		hash_add(elf->symbol_hash, &sym->hash, sym->idx);

Unnecessary added whitespace.

-- 
Josh

