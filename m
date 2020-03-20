Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AC2FC4332D
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 02:45:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AF1A20752
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 02:45:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B/ntnAB8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726726AbgCTCpO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 22:45:14 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:55703 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725856AbgCTCpN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 22:45:13 -0400
Received: by mail-pj1-f68.google.com with SMTP id mj6so1842196pjb.5
        for <linux-kernel@vger.kernel.org>; Thu, 19 Mar 2020 19:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=B0e5LRI2Wa1iU6sPlsrx1pyem4JRVh3a+Pduzbqq+EQ=;
        b=B/ntnAB8R/IWZqllfofDf1Cy0HBW6QeVeOQaCQNaFEn54whxq7ET9gSZ0BSlGD7BbH
         Amlr58LfHtL/28JEhAhbOZANiS/nZHcpmaKeLuomd19UpemBIH6dPv6qu5QdET5mq8qA
         Yk/PZZKviUjbKNkWdwyKKutseoaFNuuIriz4DOBjP2m77i8mA5fyiwmysuTfAs0NPy45
         1iiVV8rpD4gMpR8w07FDOJYpxY2ZMmlGGaO/MerpwVxtdTmdOXMCWXAR5ihYD0BDmfKa
         iZ2paTN7MI9N54czPId6Mpt/bcW22GFlMf9mGz0rvhyYCWDHZXI5i45fh0gRVFdab3qx
         WVYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=B0e5LRI2Wa1iU6sPlsrx1pyem4JRVh3a+Pduzbqq+EQ=;
        b=lAedGvHJQp1A9+RyVoDsjAKuSZOeLlfG7QxVQtfv60p+f5S59YmxLwLtR6x8Hym9jo
         uI0/2hiL243jng5ztVNiOvqk5yT9RePSl1LMw3LeFZ6iGADHWtLig2vFZ2OejaYsK6EX
         a4FRd9PRRX8B/GMPvZkos1iUTI2humFUEwdfKEcSlGdckuctY/fej5SnixLs9PiV5L+t
         5XeZoRHtgv6XhBhLNmtuu/QKPeBOb+9CKWm4GyAedutbc1CPQfvP0iloM9+L7FToWMmQ
         tUCmplTHxcDKXfmrfhvaEaEGZHme/YSgoyKItGmLC/EeNkNi2Ffdr3XlDyootrSNEudV
         FQhQ==
X-Gm-Message-State: ANhLgQ3bzzc4CPHWGRmPF4cM4iQ6Ul9yM4xXpuzRdX/kxQ+Q520S+tSy
        NdchESTSiD6tyhzz6kXm1OA=
X-Google-Smtp-Source: ADFU+vuF2pQaGz8eLAO7mgZCbrs0IF/dZLOQnUVdHDWxWYd+f/NzUuKBiSZb8TeCTvygkmjZwLYdLg==
X-Received: by 2002:a17:90a:d205:: with SMTP id o5mr6895475pju.46.1584672312336;
        Thu, 19 Mar 2020 19:45:12 -0700 (PDT)
Received: from localhost ([2401:fa00:8f:203:5bbb:c872:f2b1:f53b])
        by smtp.gmail.com with ESMTPSA id d13sm3075379pjs.44.2020.03.19.19.45.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2020 19:45:11 -0700 (PDT)
Date:   Fri, 20 Mar 2020 11:45:08 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Bruno Meneguele <bmeneg@redhat.com>
Cc:     linux-kernel@vger.kernel.org, pmladek@suse.com,
        sergey.senozhatsky@gmail.com, rostedt@goodmis.org,
        David.Laight@ACULAB.COM
Subject: Re: [PATCH v2] kernel/printk: add kmsg SEEK_CUR handling
Message-ID: <20200320024508.GB104374@google.com>
References: <20200317103344.574277-1-bmeneg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200317103344.574277-1-bmeneg@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/03/17 07:33), Bruno Meneguele wrote:
> Userspace libraries, e.g. glibc's dprintf(), perform a SEEK_CUR operation
> over any file descriptor requested to make sure the current position isn't
> pointing to junk due to previous manipulation of that same fd. And whenever
> that fd doesn't have support for such operation, the userspace code expects
> -ESPIPE to be returned.
> 
> However, when the fd in question references the /dev/kmsg interface, the
> current kernel code state returns -EINVAL instead, causing an unexpected
> behavior in userspace: in the case of glibc, when -ESPIPE is returned it
> gets ignored and the call completes successfully, while returning -EINVAL
> forces dprintf to fail without performing any action over that fd:
> 
>   if (_IO_SEEKOFF (fp, (off64_t)0, _IO_seek_cur, _IOS_INPUT|_IOS_OUTPUT) ==
>   _IO_pos_BAD && errno != ESPIPE)
>     return NULL;
> 
> With this patch we make sure to return the correct value when SEEK_CUR is
> requested over kmsg and also add some kernel doc information to formalize
> this behavior.
> 
> Signed-off-by: Bruno Meneguele <bmeneg@redhat.com>

Acked-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>

	-ss
