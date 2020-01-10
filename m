Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDD9FC33CA4
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 16:43:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA823206ED
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 16:43:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="i0Rg9Bza"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728691AbgAJQnq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 11:43:46 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:35699 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728500AbgAJQnp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 11:43:45 -0500
Received: by mail-lj1-f196.google.com with SMTP id j1so2803992lja.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jan 2020 08:43:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Pm99SCRD39aSykpKsV1b1rzH8qf7T3QdtwsXWUzu9qA=;
        b=i0Rg9BzaBV3bDRQs3ovsLP+l27vpUbCj22RX0910z8vB0xuiFx/94EkOFLvDHjufQ7
         QQW7qp/zctnvaB2qjIAQTXQXkUVaUVUWPqNfS7T3YkQN2/xJuML+u1sQ+85Y+/9US9ny
         40lzs94o/mE5F4fllS4FljUl5Ua2n7Wzgc12ivkdvwfyomWG834sjSVkjius5c1z7m3s
         ldv26Ht7f+22hz52NuHl+ZIjTXAj71R/s6lgwSY81+3WpAQo1n91hKu38uKLg9JK5gjx
         5TjkOQRfKp48xQdoIjnFwhJUIMSXx5lUAJKn4gqVqUMaGTOW74uLdRLKhZqHjqkygqVD
         0N8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Pm99SCRD39aSykpKsV1b1rzH8qf7T3QdtwsXWUzu9qA=;
        b=rYLwTpG+WCLQ9AD6vafPkWAZdmklzUKoqWwbDCZ6Betr4MSiVPZ43i85C93zJ5dNWr
         TXNff7BFzfhA3kp7a1meNIkDrkVHm9WYPAFEnSwYnauRT7NA79vu3irakEQ+LUDUQIJV
         TKJsTMstp6V3r1gvewsxgEGETbmg8Ls+K4VdPjO6kfeA4Vh1IyiATFgOhjvx/Ym49Q71
         V24avptFxFW5Qc2TyYF4e7mcvh48Hlp64PeUCJSJwGcvCtZtw0yKkFjtxTdSHuvaaCwG
         VPw/8zcxiGZt3Eq8Yk9w+zhpShjx06WzG30Oa6o++owB/21pyOy+Yo8XRa/C/rEFfN5l
         kvLA==
X-Gm-Message-State: APjAAAWSzHinYzDyxk7ZMQN6W1LnlqY4BxK+MsBt3IWsZonx0dwBpjb1
        VtOfQXewaGDrS44Cgo9XBKPAWLJDhJ/t/6H6KftG
X-Google-Smtp-Source: APXvYqznUMLFzKxhGAmzacN05wI7Fy5rsGZYs8e8aqAK8iFiXqtRyfPq/XxxvKIG6c8YXW4vgavZEeYQsc4UXa5He9g=
X-Received: by 2002:a2e:5357:: with SMTP id t23mr3289578ljd.227.1578674623470;
 Fri, 10 Jan 2020 08:43:43 -0800 (PST)
MIME-Version: 1.0
References: <20200110095856.76612-1-yehs2007@zoho.com>
In-Reply-To: <20200110095856.76612-1-yehs2007@zoho.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 10 Jan 2020 11:43:32 -0500
Message-ID: <CAHC9VhTrg_7XNQSXsHLDtHwr+u1mK9uX49tUC5uH0N06Y1W1dQ@mail.gmail.com>
Subject: Re: [PATCH] selinux: remove redundant msg_msg_alloc_security
To:     Huaisheng Ye <yehs2007@zoho.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>,
        James Morris <jmorris@namei.org>,
        Serge Hallyn <serge@hallyn.com>, tyu1@lenovo.com,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org, Huaisheng Ye <yehs1@lenovo.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 10, 2020 at 4:59 AM Huaisheng Ye <yehs2007@zoho.com> wrote:
> From: Huaisheng Ye <yehs1@lenovo.com>
>
> selinux_msg_msg_alloc_security only calls msg_msg_alloc_security but
> do nothing else. And also msg_msg_alloc_security is just used by the
> former.
>
> Remove the redundant function to simplify the code.
>
> Signed-off-by: Huaisheng Ye <yehs1@lenovo.com>
> ---
>  security/selinux/hooks.c | 17 ++++++-----------
>  1 file changed, 6 insertions(+), 11 deletions(-)

Merged into selinux/next, thanks!

-- 
paul moore
www.paul-moore.com
