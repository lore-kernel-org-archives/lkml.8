Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F01CCC54FCB
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 13:29:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C072720663
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 13:29:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="Gt7agO8G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727115AbgD0N3K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 09:29:10 -0400
Received: from forwardcorp1j.mail.yandex.net ([5.45.199.163]:48874 "EHLO
        forwardcorp1j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726769AbgD0N3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 09:29:10 -0400
Received: from mxbackcorp1j.mail.yandex.net (mxbackcorp1j.mail.yandex.net [IPv6:2a02:6b8:0:1619::162])
        by forwardcorp1j.mail.yandex.net (Yandex) with ESMTP id 12F502E09A3;
        Mon, 27 Apr 2020 16:29:05 +0300 (MSK)
Received: from vla1-81430ab5870b.qloud-c.yandex.net (vla1-81430ab5870b.qloud-c.yandex.net [2a02:6b8:c0d:35a1:0:640:8143:ab5])
        by mxbackcorp1j.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id K3H49cSzVI-T3nGq4Ee;
        Mon, 27 Apr 2020 16:29:05 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1587994145; bh=+le2GIAhEIPI8xAIUs+VYbFLSXRRCHe5U0FQ2+oQmVc=;
        h=In-Reply-To:Message-ID:From:Date:References:To:Subject:Cc;
        b=Gt7agO8GSR83RY2ebFES+sFW0fv1czwqHlihg+F8LIA5J2yXRrBJkD4ssr6xJUc5h
         LgGIr5lratnhNYBwTSIubala5q0c0ry8AJVXefMBC6tmw6vIJHa7puF4xUyoZevOKM
         ib+VJHUY4mTk9QX5eepww/6D1d7gx/js9CvIn1nQ=
Authentication-Results: mxbackcorp1j.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-vpn.dhcp.yndx.net (dynamic-vpn.dhcp.yndx.net [2a02:6b8:b080:7208::1:1])
        by vla1-81430ab5870b.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id xq1YpEXLXr-T3XS2fxu;
        Mon, 27 Apr 2020 16:29:03 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
Subject: Re: [PATCH] lib/test_lockup.c: make test_inode static
To:     Jason Yan <yanaijie@huawei.com>, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org
Cc:     Hulk Robot <hulkci@huawei.com>
References: <20200417074021.46411-1-yanaijie@huawei.com>
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Message-ID: <4b210d34-5dae-63c7-4fde-3332b99b0159@yandex-team.ru>
Date:   Mon, 27 Apr 2020 16:29:03 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200417074021.46411-1-yanaijie@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/04/2020 10.40, Jason Yan wrote:
> Fix the following sparse warning:
> 
> lib/test_lockup.c:145:14: warning: symbol 'test_inode' was not declared.
> Should it be static?

Yep, but that's not so important.

> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Jason Yan <yanaijie@huawei.com>
> ---
>   lib/test_lockup.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/test_lockup.c b/lib/test_lockup.c
> index ea09ca335b21..419fbaceba73 100644
> --- a/lib/test_lockup.c
> +++ b/lib/test_lockup.c
> @@ -142,7 +142,7 @@ module_param(reallocate_pages, bool, 0400);
>   MODULE_PARM_DESC(reallocate_pages, "free and allocate pages between iterations");
>   
>   struct file *test_file;

Why you're fixing only this warning? =)
test_file above should generate the same.

> -struct inode *test_inode;
> +static struct inode *test_inode;
>   static char test_file_path[256];
>   module_param_string(file_path, test_file_path, sizeof(test_file_path), 0400);
>   MODULE_PARM_DESC(file_path, "file path to test");
> 
