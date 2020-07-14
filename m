Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DCB7C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 19:31:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4821422AB9
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 19:31:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594755085;
	bh=cUXASkGUYuLCw2oKmIZFxgnmouGC/MpqGIpF0lF7HC8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=MHuqUBcojhN+4Z/9YvN7RM7/b1ngwVBHYbO32izW7R1f7Nl0xt2VCHSx3pEEsyzjN
	 GgiAh88iD9bSgh/VQgg3BAhPq9/bv7Do2RxAOhg/5nZ9Hu2337xPYlDmR+VsX+3mB/
	 0G9939LNEJZ6ckBPW4D/WHOIy/mvIHj+N/p9BP6s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729704AbgGNTbY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 15:31:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728428AbgGNTbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 15:31:23 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76E1AC061794
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 12:31:22 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id e4so24968091ljn.4
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 12:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cPk5LMoGoThBA0eFxbivhO2pS56bC/86EhKFPKHKu4c=;
        b=VLmnr+RKkXZkAascGHD+AaCNa6Y2XPywcyp6v/mdbuMkz/hf+hhfE1/nd7RM0JXapm
         cVYAMBvwJI3Gd5pMjW+DZXpL4Lk84F0PSZHOcvKhlEII13xTPasta+T1CpQkTxCpx6DR
         hsyOPnSmMSJKICLP2tLHfz+bnE3r2Zf/mvQgo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cPk5LMoGoThBA0eFxbivhO2pS56bC/86EhKFPKHKu4c=;
        b=J32LLnDh/amBZ1xOQ1t+vlpbl3cXBft/+zd4YbtCsy0VJA7/3IguE8SB6HEqzqX35Y
         SUYBS94sHsI5FCiJqj70fGg7x2s/g3Cy/jTamLnL86idPdWPLCVvMIL9nuAwrUGL7Oq8
         EjK0FREbB4NTzK62lBmxGqRug9yKICeaTAMM6nv0heZo7ZWws96EgWjmTdxVT96kIQv8
         sCk8+eJ352fciO5m0WSFy4Y6QsOCi+dxOH+SEPj5zePuX9oVCz4vhQ6dU0WgSx43v/M/
         26fhJpTaPb+alLAfn8a9UiqkXQMCzNUp/dqmaqSe3OPklewS49w65aHWaR0ecIkNcduS
         svrg==
X-Gm-Message-State: AOAM530ympgcDq5r23Ae9R6VXEL0AI7c+yF1AL59C+eC96HjRGq5HoQL
        S6pBHa8Yi9/ezdHbOTJ147a9i1QmiTY=
X-Google-Smtp-Source: ABdhPJxIgVv920VvRzsqbcR4uSLCPepgQCUsjCkLg9FdKn8dHWn83KUEyvZammItA6oEPBrnfOfg9A==
X-Received: by 2002:a05:651c:30b:: with SMTP id a11mr1570468ljp.126.1594755080559;
        Tue, 14 Jul 2020 12:31:20 -0700 (PDT)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id i16sm1759ljn.50.2020.07.14.12.31.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jul 2020 12:31:19 -0700 (PDT)
Received: by mail-lj1-f169.google.com with SMTP id h19so24972009ljg.13
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 12:31:18 -0700 (PDT)
X-Received: by 2002:a2e:86c4:: with SMTP id n4mr3168247ljj.312.1594755078276;
 Tue, 14 Jul 2020 12:31:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200714190427.4332-1-hch@lst.de> <20200714190427.4332-18-hch@lst.de>
In-Reply-To: <20200714190427.4332-18-hch@lst.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 14 Jul 2020 12:31:01 -0700
X-Gmail-Original-Message-ID: <CAHk-=whDbHL7x5Jx-CSz97=nVg4V_q45DsokX+X-Y-yZV4rPvw@mail.gmail.com>
Message-ID: <CAHk-=whDbHL7x5Jx-CSz97=nVg4V_q45DsokX+X-Y-yZV4rPvw@mail.gmail.com>
Subject: Re: [PATCH 17/23] initramfs: switch initramfs unpacking to struct
 file based APIs
To:     Christoph Hellwig <hch@lst.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Song Liu <song@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, linux-raid@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 14, 2020 at 12:09 PM Christoph Hellwig <hch@lst.de> wrote:
>
> There is no good reason to mess with file descriptors from in-kernel
> code, switch the initramfs unpacking to struct file based write
> instead.

Looking at this diff, I realized this really should be cleaned up more.

 +                       wfile = filp_open(collected, openflags, mode);
> +                       if (IS_ERR(wfile))
> +                               return 0;
> +
> +                       vfs_fchown(wfile, uid, gid);
> +                       vfs_fchmod(wfile, mode);
> +                       if (body_len)
> +                               vfs_truncate(&wfile->f_path, body_len);
> +                       vcollected = kstrdup(collected, GFP_KERNEL);

That "vcollected" is ugly and broken, and seems oh-so-wrong.

Because it's only use is:


> -               ksys_close(wfd);
> +               fput(wfile);
>                 do_utime(vcollected, mtime);
>                 kfree(vcollected);

which should just have done the exact same thing that you did with
vfs_chown() and friends: we already have a "utimes_common()" that
takes a path, and it could have been made into "vfs_utimes()", and
then this whole vcollected confusion would go away and be replaced by

        vfs_truncate(&wfile->f_path, mtime);

(ok, with all the "timespec64 t[2]" things going on that do_utime()
does now, but you get the idea).

Talk about de-crufting that initramfs unpacking..

But I don't hate this patch, I'm just pointing out that there's room
for improvement.

             Linus
