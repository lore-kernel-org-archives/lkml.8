Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7059FC38A2A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 21:58:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43C2E20870
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 21:58:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cz71TAgu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726797AbgEGV6a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 17:58:30 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52315 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726437AbgEGV6a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 17:58:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588888708;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YIdhd/O6VYCCThTyaA6We9R20n/Ae/tFi2XoFVio1ws=;
        b=cz71TAguzSLFarGW6WObXNFwT+SyzAJhNN4PSTRa/Ifq4te4z+TvXdSLDhL4BNCrsEch4L
        Ee47yNAGCL6+2N5pSON13KIpeJJpFMtKWzJGB9Z0647NlzHu0WM2FwxUTXW8n1s/nRyrFt
        XtA2Eit8XN5xOlwT4j+Bd0mkwLTOj8U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-352-tmgfVTAMOJGL0jzKrrXf8g-1; Thu, 07 May 2020 17:58:23 -0400
X-MC-Unique: tmgfVTAMOJGL0jzKrrXf8g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7B38718B649E;
        Thu,  7 May 2020 21:58:22 +0000 (UTC)
Received: from madcap2.tricolour.ca (unknown [10.3.128.9])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D00B21001B07;
        Thu,  7 May 2020 21:58:15 +0000 (UTC)
Date:   Thu, 7 May 2020 17:58:13 -0400
From:   Richard Guy Briggs <rgb@redhat.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Paul Moore <paul@paul-moore.com>, Eric Paris <eparis@redhat.com>,
        linux-audit@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] audit: Replace zero-length array with flexible-array
Message-ID: <20200507215812.ksvwcykfged7ye2a@madcap2.tricolour.ca>
References: <20200507185041.GA13930@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200507185041.GA13930@embeddedor>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-05-07 13:50, Gustavo A. R. Silva wrote:
> The current codebase makes use of the zero-length array language
> extension to the C90 standard, but the preferred mechanism to declare
> variable-length types such as these ones is a flexible array member[1][2],
> introduced in C99:
> 
> struct foo {
>         int stuff;
>         struct boo array[];
> };
> 
> By making use of the mechanism above, we will get a compiler warning
> in case the flexible array does not occur last in the structure, which
> will help us prevent some kind of undefined behavior bugs from being
> inadvertently introduced[3] to the codebase from now on.
> 
> Also, notice that, dynamic memory allocations won't be affected by
> this change:
> 
> "Flexible array members have incomplete type, and so the sizeof operator
> may not be applied. As a quirk of the original implementation of
> zero-length arrays, sizeof evaluates to zero."[1]
> 
> sizeof(flexible-array-member) triggers a warning because flexible array
> members have incomplete type[1]. There are some instances of code in
> which the sizeof operator is being incorrectly/erroneously applied to
> zero-length arrays and the result is zero. Such instances may be hiding
> some bugs. So, this work (flexible-array member conversions) will also
> help to get completely rid of those sorts of issues.
> 
> This issue was found with the help of Coccinelle.
> 
> [1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
> [2] https://github.com/KSPP/linux/issues/21
> [3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Sounds reasonable to me.  There's another in include/uapi/linux/audit.h
in struct audit_rule_data buf[0].  This alert also helped me fix another
one in a patchset I'm about to post (and will probably cause a merge
conflict but we can figure that out).

Reviewed-by: Richard Guy Briggs <rgb@redhat.com>

> ---
>  include/linux/audit.h |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/audit.h b/include/linux/audit.h
> index f9ceae57ca8d..2b63aee6e9fa 100644
> --- a/include/linux/audit.h
> +++ b/include/linux/audit.h
> @@ -19,7 +19,7 @@
>  struct audit_sig_info {
>  	uid_t		uid;
>  	pid_t		pid;
> -	char		ctx[0];
> +	char		ctx[];
>  };
>  
>  struct audit_buffer;
> 
> 
> --
> Linux-audit mailing list
> Linux-audit@redhat.com
> https://www.redhat.com/mailman/listinfo/linux-audit

- RGB

--
Richard Guy Briggs <rgb@redhat.com>
Sr. S/W Engineer, Kernel Security, Base Operating Systems
Remote, Ottawa, Red Hat Canada
IRC: rgb, SunRaycer
Voice: +1.647.777.2635, Internal: (81) 32635

