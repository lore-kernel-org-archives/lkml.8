Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F17CC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 19:24:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74DF8206D7
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 19:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591989851;
	bh=tkdoGaDmtkQIZe8s75Yl+A9UWwuBWQvVdxP629Si20c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=X+HanWimpZjpQHxlgyzVPd4Ee48rIYjZ6TZjBTM1VSDKtlZ0PGTTMlbuatT4zfY07
	 Qy7LE5SsP3saI0pnalczOKZVdVTcrH9wGTaaHxcFr0RF+9C6ElG1rMQ9CynKh0jogO
	 fTk2Mjis5UnyWrpkY7htX5T+dz4myVY9D/zU+o+w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726327AbgFLTYK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 15:24:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbgFLTYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 15:24:09 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF115C03E96F
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 12:24:08 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id y11so12357003ljm.9
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 12:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TCcYxMzSmrdlhigKp7aCnsE882khzEZEkfB4TmM4Bdg=;
        b=iNBWJvbJ26Z9sGmdy88BthOnQc6hc14YR9MWYyu8II9G3YLysxwW8697VXQMUTln/r
         Xc6ZFFWFR3cp0sCyH1yStm8dQ8f1PheRAwGxmH8m/OGbjqjh36KdNvZAg4tlsLkIg31J
         qlgKnPxT6+NzqQ9EtPTxK98KgxF/S0zZzH6Ns=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TCcYxMzSmrdlhigKp7aCnsE882khzEZEkfB4TmM4Bdg=;
        b=cRnV+DK/EXXKFysYO21rOH8nbL2kxVj6j8qE7poVZMQ2Z5pCNzfYlG8DPOSS0icWqC
         sdBYvuMtKnfbWIhTsD/F1JJd1lxf15oMBi+6HlQHQVZNrrS9/8vnuvzZU7R0iIesbyhW
         SUiZURUQPv0yAVRWZsM6vID48Kzad7bltM/tSaTjQ1+yUNzrjjH8BzODENkDohvzT1NU
         xDBDDPA7gPGoRiWGadZHlBv+97+wW37A5u75cw1LCuuvBecVgc9+fHIcqtyMsr/xU2GD
         9rcsr4WM99/ZHD01iyhnyd/kZwIwCpzAg8D6F2yG3CO0piH1lEB16L8c/X115CGM2IrE
         mTWg==
X-Gm-Message-State: AOAM5305bKemkheckovPQjSJv7S1TEAzCqKchsFm0UY+hJuo+bHbxj6G
        +2lzwAq4VxkeEHaB+Kc6LSVcEXQnDFs=
X-Google-Smtp-Source: ABdhPJxT4DTsF1EduxZp888VudsegVVEGRJvu2YhmZXTKZTobwS+wr1E+3kCJqQpsQQOheSgZvfMnA==
X-Received: by 2002:a2e:959a:: with SMTP id w26mr7061036ljh.74.1591989846763;
        Fri, 12 Jun 2020 12:24:06 -0700 (PDT)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id l22sm1936217ljg.41.2020.06.12.12.24.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jun 2020 12:24:05 -0700 (PDT)
Received: by mail-lj1-f181.google.com with SMTP id 9so12331259ljv.5
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 12:24:05 -0700 (PDT)
X-Received: by 2002:a2e:8991:: with SMTP id c17mr6689370lji.421.1591989845076;
 Fri, 12 Jun 2020 12:24:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200612152205.GA18833@8bytes.org>
In-Reply-To: <20200612152205.GA18833@8bytes.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 12 Jun 2020 12:23:49 -0700
X-Gmail-Original-Message-ID: <CAHk-=whtWYyUWP2Us3ZnOQB8i=C6JkVRZ7EG74rVY3K2v-gKaQ@mail.gmail.com>
Message-ID: <CAHk-=whtWYyUWP2Us3ZnOQB8i=C6JkVRZ7EG74rVY3K2v-gKaQ@mail.gmail.com>
Subject: Re: [git pull] iommu: Move Intel and AMD drivers to a subdirectory
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        iommu <iommu@lists.linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 12, 2020 at 8:22 AM Joerg Roedel <joro@8bytes.org> wrote:
>
> I am not sure it is the right time to send this.

Looks good to me. Any time a directory starts to have a lot of
filenames with a particular prefix, moving them deeper like this seems
to make sense. And doing it just before the -rc1 release and avoiding
unnecessary conflicts seems like the right time too.

So pulled.

Looking at it, it might even be worth moving the Kconfig and Makefile
details down to the intel/amd subdirectories, and have them be
included from the main iommu ones? But that's up to you.

Thanks,

            Linus
