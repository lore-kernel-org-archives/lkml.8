Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66F94C43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 12:32:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37E8620714
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 12:32:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732361AbgDAMcS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 08:32:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:45154 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732166AbgDAMcS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 08:32:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id C129CAD4B;
        Wed,  1 Apr 2020 12:32:16 +0000 (UTC)
Date:   Wed, 1 Apr 2020 14:32:16 +0200 (CEST)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Julien Thierry <jthierry@redhat.com>
cc:     linux-kernel@vger.kernel.org, jpoimboe@redhat.com,
        peterz@infradead.org, raphael.gault@arm.com
Subject: Re: [PATCH v2 01/10] objtool: Move header sync-check ealier in
 build
In-Reply-To: <20200327152847.15294-2-jthierry@redhat.com>
Message-ID: <alpine.LSU.2.21.2004011430120.15809@pobox.suse.cz>
References: <20200327152847.15294-1-jthierry@redhat.com> <20200327152847.15294-2-jthierry@redhat.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Mar 2020, Julien Thierry wrote:

> Currently, the check of tools files against kernel equivalent is only
> done after every object file has been built. 

> This means one might fix
> build issues against outdated headers without seeing a warning about
> this.

Could you explain the above in more detail, please?

Otherwise it looks good.

Miroslav

> Check headers before any object is built. Also, make it part of a
> FORCE'd recipe so every attempt to build objtool will report the
> outdated headers (if any).
> 
> Signed-off-by: Julien Thierry <jthierry@redhat.com>
> ---
>  tools/objtool/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/objtool/Makefile b/tools/objtool/Makefile
> index ee08aeff30a1..519af6ec4eee 100644
> --- a/tools/objtool/Makefile
> +++ b/tools/objtool/Makefile
> @@ -43,10 +43,10 @@ export srctree OUTPUT CFLAGS SRCARCH AWK
>  include $(srctree)/tools/build/Makefile.include
>  
>  $(OBJTOOL_IN): fixdep FORCE
> +	@$(CONFIG_SHELL) ./sync-check.sh
>  	@$(MAKE) $(build)=objtool
>  
>  $(OBJTOOL): $(LIBSUBCMD) $(OBJTOOL_IN)
> -	@$(CONFIG_SHELL) ./sync-check.sh
>  	$(QUIET_LINK)$(CC) $(OBJTOOL_IN) $(LDFLAGS) -o $@
>  
>  
> -- 
> 2.21.1
> 

