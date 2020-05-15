Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD2E7C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 19:53:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B37E320727
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 19:53:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c2iG1OnW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726610AbgEOTxD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 15:53:03 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:58911 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726212AbgEOTxC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 15:53:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589572381;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Z6AtkIfZfwO3h4rCiDNSDBqvPFpFjsjuSQdMEPZGAiU=;
        b=c2iG1OnWVrhd6uLkoDqSedqLWVYBlywHC7B8A2DdQK0/shy0bNPKbaJ1SXLAbl9zaeEePg
        uXUpelaJikiZitUvA+bbBpL4t9e+qJ5m9XcNb1AyftObyVvKMUxTCrvTYqUbgKdDAP4w6U
        kWWJvEO3pzf0lcRjnpN7KRICTY6UrVM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-321-bw0FVL25PkuyET2ad0mJbg-1; Fri, 15 May 2020 15:52:57 -0400
X-MC-Unique: bw0FVL25PkuyET2ad0mJbg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EBEEE100A614;
        Fri, 15 May 2020 19:52:55 +0000 (UTC)
Received: from treble (ovpn-117-151.rdu2.redhat.com [10.10.117.151])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 19A016E9E2;
        Fri, 15 May 2020 19:52:54 +0000 (UTC)
Date:   Fri, 15 May 2020 14:52:53 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Matt Helsley <mhelsley@vmware.com>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Julien Thierry <jthierry@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC][PATCH 1/5] objtool: Exit successfully when requesting help
Message-ID: <20200515195253.c5yzjyigxzhjflsd@treble>
References: <cover.1588888003.git.mhelsley@vmware.com>
 <10618c5e40b34a6af62c183feb5cd474c95e06fa.1588888003.git.mhelsley@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <10618c5e40b34a6af62c183feb5cd474c95e06fa.1588888003.git.mhelsley@vmware.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 11, 2020 at 10:35:09AM -0700, Matt Helsley wrote:
> When the user requests help it's not an error so do not exit with
> a non-zero exit code. This is not especially useful for a user but
> any script that might wish to check that objtool --help is at least
> available can't rely on the exit code to crudely check that, for
> example building an objtool executable succeeds.
> 
> Signed-off-by: Matt Helsley <mhelsley@vmware.com>
> ---
>  tools/objtool/objtool.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/objtool/objtool.c b/tools/objtool/objtool.c
> index 0b3528f05053..593ec85915a9 100644
> --- a/tools/objtool/objtool.c
> +++ b/tools/objtool/objtool.c
> @@ -58,7 +58,10 @@ static void cmd_usage(void)
>  
>  	printf("\n");
>  
> -	exit(129);
> +	if (!help)
> +		exit(129);
> +	else
> +		exit(0);

Looks fine, though the 'else' isn't needed.

-- 
Josh

