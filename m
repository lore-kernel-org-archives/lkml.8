Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB48EC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 14:56:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8799F20679
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 14:56:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b="Eqdpy+33"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729598AbgFPO4J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 10:56:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729167AbgFPOz4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 10:55:56 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39CEAC0613ED
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 07:55:56 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id b5so9609742pfp.9
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 07:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WNF9etpx10znAFg91RybrVxjbrhe0SORwIJGFu/T2UE=;
        b=Eqdpy+33nHh0lF7JF1m9J/2+1L9E7YnO+9jfEZuq3UI/RtVUUHQVHJvCDanJerqWA7
         ke86DqQxPt4PJ+Cysy87uPh4Jw1Qle29wA7xfamR9Nvmp8kdyNbUaTwzmj/Sa0XmmA90
         0WE9k76KpN7BXtUy8CBHlD/SWxWCcNncR/Hm973B556cZbOr1N2whMKPI1Ta/nFo7g3W
         IjR/P04OOdBe2q66j1pqP6EBkvzUEqzxeVkuYlcJJ4hxE4qwQK+CzHxKvm0yrl2Stif0
         K8HE3EFLjLBFu65x242zaO4xDYTtJbWQaoee+qw3HvhKpFXbbds3TF5/FyO+id1AwRRE
         1g8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WNF9etpx10znAFg91RybrVxjbrhe0SORwIJGFu/T2UE=;
        b=XTMnBlz/Bk9FTDIepNfwmzfKbqVqQBfYdozTs0bIDf0++Y2bYW3SnjyQD+K4bS7g4B
         R3zKLQP2ITYOFkwWXYesiZl29c4EVBjSd9HmrmBAdBugjPcDNYiOsye/E67t6xk7aYZB
         MP98j6EDZ9PsE+FsSimioqs5+9ub1rg26OuS457O6nuYrIz1HZNIKnePJ567ufUiZioZ
         2LSPX8ksjO9SYiVrw5nshJ/0VwdjXzR5QlZnQL43sp4hQmUYOfCatFIe8hIMVcraVYKu
         P6EdhVLQxc8BcBN/rNg/sFaJEqoqhPW4wDzquOQe9f/mea1UCqr1s6AOO4E/I2RJ+TjI
         m43g==
X-Gm-Message-State: AOAM533soqKhxjfgErAuH9v/JDrDlusG+Xr0ZCm3NsFa+7qeB4uYoNHL
        USWjYLGTXk96v3kcTOfiFIOmyw==
X-Google-Smtp-Source: ABdhPJy4AncAs73T1e7CsZ7TL7HXTr6/HNDo5w5qHUb1x+Sc9NKoQNKVk+mYwyd/Dqt2WPYE59Sd3g==
X-Received: by 2002:aa7:859a:: with SMTP id w26mr2342599pfn.10.1592319354221;
        Tue, 16 Jun 2020 07:55:54 -0700 (PDT)
Received: from cisco ([2001:420:c0c8:1007::16e])
        by smtp.gmail.com with ESMTPSA id s98sm2942415pjb.33.2020.06.16.07.55.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 07:55:53 -0700 (PDT)
Date:   Tue, 16 Jun 2020 08:55:46 -0600
From:   Tycho Andersen <tycho@tycho.ws>
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org, Sargun Dhillon <sargun@sargun.me>,
        Christian Brauner <christian@brauner.io>,
        "David S. Miller" <davem@davemloft.net>,
        Christoph Hellwig <hch@lst.de>,
        Jakub Kicinski <kuba@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Matt Denton <mpdenton@google.com>,
        Jann Horn <jannh@google.com>, Chris Palmer <palmer@google.com>,
        Robert Sesek <rsesek@google.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>, Shuah Khan <shuah@kernel.org>,
        netdev@vger.kernel.org, containers@lists.linux-foundation.org,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v4 10/11] seccomp: Switch addfd to Extensible Argument
 ioctl
Message-ID: <20200616145546.GH2893648@cisco>
References: <20200616032524.460144-1-keescook@chromium.org>
 <20200616032524.460144-11-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200616032524.460144-11-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 15, 2020 at 08:25:23PM -0700, Kees Cook wrote:
> This patch is based on discussions[1] with Sargun Dhillon, Christian
> Brauner, and David Laight. Instead of building size into the addfd
> structure, make it a function of the ioctl command (which is how sizes are
> normally passed to ioctls). To support forward and backward compatibility,
> just mask out the direction and size, and match everything. The size (and
> any future direction) checks are done along with copy_struct_from_user()
> logic. Also update the selftests to check size bounds.
> 
> [1] https://lore.kernel.org/lkml/20200612104629.GA15814@ircssh-2.c.rugged-nimbus-611.internal
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  include/uapi/linux/seccomp.h                  |  2 -
>  kernel/seccomp.c                              | 21 ++++++----
>  tools/testing/selftests/seccomp/seccomp_bpf.c | 40 ++++++++++++++++---
>  3 files changed, 49 insertions(+), 14 deletions(-)
> 
> diff --git a/include/uapi/linux/seccomp.h b/include/uapi/linux/seccomp.h
> index c347160378e5..473a61695ac3 100644
> --- a/include/uapi/linux/seccomp.h
> +++ b/include/uapi/linux/seccomp.h
> @@ -118,7 +118,6 @@ struct seccomp_notif_resp {
>  
>  /**
>   * struct seccomp_notif_addfd
> - * @size: The size of the seccomp_notif_addfd structure
>   * @id: The ID of the seccomp notification
>   * @flags: SECCOMP_ADDFD_FLAG_*
>   * @srcfd: The local fd number
> @@ -126,7 +125,6 @@ struct seccomp_notif_resp {
>   * @newfd_flags: The O_* flags the remote FD should have applied
>   */
>  struct seccomp_notif_addfd {
> -	__u64 size;

Huh? Won't this break builds?

Tycho
