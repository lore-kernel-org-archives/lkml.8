Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E8C3C35280
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 02:52:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1564220731
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 02:52:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="AAy0e1Nk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726742AbgEHCwX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 22:52:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726598AbgEHCwW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 22:52:22 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40C8BC05BD43
        for <linux-kernel@vger.kernel.org>; Thu,  7 May 2020 19:52:22 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id a2so110948ejx.5
        for <linux-kernel@vger.kernel.org>; Thu, 07 May 2020 19:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I+1cQWgxt1/5EB9HjjZokgUdamjeR9vKZIDzakJvGZg=;
        b=AAy0e1Nk3mVl+RuOMUlmFvBi2fP58kdksb+fhyd8Yk6Bo8BHw1pybTBfow3GpZmj60
         ASg9caTfW7yfGiKiiX9abVjtBqL5hwELUNsIFqaFCVcfwO8h3u9TepWr3T1ZGRZbdJOn
         fVJjo/cbsa9XujDL9+F50w3zbLSqDsVpyEMLpAL/o9JdVOfCtNTNjuwnyrPzND5+pgAQ
         oLykSNfH7HCwUBSlFJtXy0UidVAQyurHRsCH+Is44ySOkg5djXe2Wuqaec1n9tS5scfe
         VkbmvGdGeLyHqu70edmdynyF68+X1R+1EDZYnLVm5T350ZUWj0wGGwTf47btot8y5DXX
         Lbzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I+1cQWgxt1/5EB9HjjZokgUdamjeR9vKZIDzakJvGZg=;
        b=rGUt2zi0DYiiUIbhMb7p4hTO0gOJzcNcBh1B0areX7yvyPZpZA/wyGHr5oSSeHXwmB
         Lcxrwk/GwB7ea1UcXaA25cEp8+nuadbzndG4oNr3T3SF8e9msFNF2eWQF2aBrPhz1I+Q
         PVMXyQ540eq9Axms3GgWteMP4Bf9QEAjV4ClT6A4fYs8ctvlEw1OWhnqPq181WRNLMSG
         gnRHNYbvghDjF9PYJdXxBCXO+l+qwV2hmhbmStJgs9pqnMNdlZjO/ifQzZMdLif9NAUu
         jQZbWMyc4C+Om6RSqKE+C9N7vG9P5KeKm8uTaIsZkUGTj+FiICXHQJGD0KsGuYNNyt+U
         bKkg==
X-Gm-Message-State: AGi0PubxrFs1eUFbC5ZEPytsaj5iDrQ5FAZ6mCS46NlDm4YBBNS44Re1
        Doc1tnsx8gYD5hdlJGm4564tWBL+Gt9+I49mU+qa
X-Google-Smtp-Source: APiQypIoy6GdXKb146yh6AuN5kdW/00MOaAx9ReHHhW8zKqMsU1nfHRFkS++ItJFML6mGa+GYeDn3Vz0arJiOWV+kKk=
X-Received: by 2002:a17:906:31da:: with SMTP id f26mr112797ejf.308.1588906340722;
 Thu, 07 May 2020 19:52:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200507185041.GA13930@embeddedor>
In-Reply-To: <20200507185041.GA13930@embeddedor>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 7 May 2020 22:52:09 -0400
Message-ID: <CAHC9VhSm_GWWXuzuwrrcTF3QcKCv1WSZv2=WF4t3DB4P7vshoA@mail.gmail.com>
Subject: Re: [PATCH] audit: Replace zero-length array with flexible-array
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Eric Paris <eparis@redhat.com>, linux-audit@redhat.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 7, 2020 at 2:46 PM Gustavo A. R. Silva
<gustavoars@kernel.org> wrote:
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
> ---
>  include/linux/audit.h |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Merged into audit/next, thanks!

> diff --git a/include/linux/audit.h b/include/linux/audit.h
> index f9ceae57ca8d..2b63aee6e9fa 100644
> --- a/include/linux/audit.h
> +++ b/include/linux/audit.h
> @@ -19,7 +19,7 @@
>  struct audit_sig_info {
>         uid_t           uid;
>         pid_t           pid;
> -       char            ctx[0];
> +       char            ctx[];
>  };
>
>  struct audit_buffer;

-- 
paul moore
www.paul-moore.com
