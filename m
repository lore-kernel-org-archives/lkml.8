Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ECCDC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 14:45:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02A7D20873
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 14:45:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389192AbgE0Opr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 10:45:47 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:55694 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387942AbgE0Opq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 10:45:46 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jdxJQ-0000II-2h; Wed, 27 May 2020 08:45:44 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jdxJP-0001YS-1X; Wed, 27 May 2020 08:45:43 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Kaitao Cheng <pilgrimtao@gmail.com>
Cc:     adobriyan@gmail.com, christian@brauner.io,
        akpm@linux-foundation.org, gladkov.alexey@gmail.com, guro@fb.com,
        walken@google.com, avagin@gmail.com, khlebnikov@yandex-team.ru,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20200527141155.47554-1-pilgrimtao@gmail.com>
Date:   Wed, 27 May 2020 09:41:53 -0500
In-Reply-To: <20200527141155.47554-1-pilgrimtao@gmail.com> (Kaitao Cheng's
        message of "Wed, 27 May 2020 22:11:55 +0800")
Message-ID: <87k10x5tji.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jdxJP-0001YS-1X;;;mid=<87k10x5tji.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19ZJUROciTO0oQgmo8Eq5PTszzMpNU4F40=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH] proc/base: Skip assignment to len when there is no error on d_path in do_proc_readlink.
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kaitao Cheng <pilgrimtao@gmail.com> writes:

> we don't need {len = PTR_ERR(pathname)} when IS_ERR(pathname) is false,
> it's better to move it into if(IS_ERR(pathname)){}.

Please look at the generated code.

I believe you will find that your change will generate worse assembly.

Eric


> Signed-off-by: Kaitao Cheng <pilgrimtao@gmail.com>
> ---
>  fs/proc/base.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/fs/proc/base.c b/fs/proc/base.c
> index d86c0afc8a85..9509e0d42610 100644
> --- a/fs/proc/base.c
> +++ b/fs/proc/base.c
> @@ -1753,9 +1753,10 @@ static int do_proc_readlink(struct path *path, char __user *buffer, int buflen)
>  		return -ENOMEM;
>  
>  	pathname = d_path(path, tmp, PAGE_SIZE);
> -	len = PTR_ERR(pathname);
> -	if (IS_ERR(pathname))
> +	if (IS_ERR(pathname)) {
> +		len = PTR_ERR(pathname);
>  		goto out;
> +	}
>  	len = tmp + PAGE_SIZE - 1 - pathname;
>  
>  	if (len > buflen)
