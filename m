Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C020AC43461
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 18:22:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B7F820578
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 18:22:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VtELwxuP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726407AbgIDSWi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 14:22:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:53613 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726047AbgIDSWi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 14:22:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599243757;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rsib+tmV5EtJHf3qVbLEvuMYy7KgO7QA3QRt3DTHtZU=;
        b=VtELwxuP4FUMKMsurmTErGH19FHNZJqdm1HqL0KVYS9TKKoQBE+4z5felL0ochJSPjgRvS
        COByn1L2Ghv6IYzlEKI2kf3sGL/guf4lQgTbwQcuThLW3o6WagoUt8eHj749nljn3UrHuH
        6GCZ/YR343eBRmWbDCAuYNwlNFSBhWk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-316-rxSz6AWrOU6Dsphy59XPIg-1; Fri, 04 Sep 2020 14:22:34 -0400
X-MC-Unique: rxSz6AWrOU6Dsphy59XPIg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B43A4100670D;
        Fri,  4 Sep 2020 18:22:32 +0000 (UTC)
Received: from treble (ovpn-117-138.rdu2.redhat.com [10.10.117.138])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D3A317E419;
        Fri,  4 Sep 2020 18:22:31 +0000 (UTC)
Date:   Fri, 4 Sep 2020 13:22:29 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Julien Thierry <jthierry@redhat.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org, mbenes@suse.cz,
        raphael.gault@arm.com, benh@kernel.crashing.org
Subject: Re: [PATCH v3 02/10] objtool: Make sync-check consider the target
 architecture
Message-ID: <20200904182229.nw5ootdhd2gjdgbd@treble>
References: <20200904153028.32676-1-jthierry@redhat.com>
 <20200904153028.32676-3-jthierry@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200904153028.32676-3-jthierry@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 04, 2020 at 04:30:20PM +0100, Julien Thierry wrote:
> Do not take into account outdated headers unrelated to the build of the
> current architecture.
> 
> Reviewed-by: Miroslav Benes <mbenes@suse.cz>
> Signed-off-by: Julien Thierry <jthierry@redhat.com>
> ---
>  tools/objtool/Makefile      | 2 +-
>  tools/objtool/sync-check.sh | 4 ++++
>  2 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/objtool/Makefile b/tools/objtool/Makefile
> index 33d1e3ca8efd..20df5541ca43 100644
> --- a/tools/objtool/Makefile
> +++ b/tools/objtool/Makefile
> @@ -64,7 +64,7 @@ export srctree OUTPUT CFLAGS SRCARCH AWK
>  include $(srctree)/tools/build/Makefile.include
>  
>  $(OBJTOOL_IN): fixdep FORCE
> -	@$(CONFIG_SHELL) ./sync-check.sh
> +	@$(CONFIG_SHELL) ./sync-check.sh $(SRCARCH)
>  	@$(MAKE) $(build)=objtool

SRCARCH is already exported by the Makefile, so should sync-check.sh
just check $SRCARCH directly (and error out if it doesn't exist)?

-- 
Josh

