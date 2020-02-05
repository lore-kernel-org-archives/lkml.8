Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FF93C35249
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 06:56:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 720E2217BA
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 06:56:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580885772;
	bh=xAUlHd+fo6fQvSh1wAiS6Lpb7973H9+jRyttKqmL/Mo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=KYVBSO3hOZXWNBPVLRMOLtqQ+5us/nFuJ1Bp0ypCpH3lfyDOsjfBOL3E/wGVJKjUx
	 jUu3tAafOsZtR3AE0C1MvazHfDd+Z56zSKIhlpN36FG1bMThkjY0DXG1p/Mq/84+kj
	 ekPa6DNyKLtt5EM/r4gr39lBqcjxYJM6VZsq7GHA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbgBEG4L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 01:56:11 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:37231 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725875AbgBEG4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 01:56:11 -0500
Received: by mail-lf1-f67.google.com with SMTP id b15so674597lfc.4
        for <linux-kernel@vger.kernel.org>; Tue, 04 Feb 2020 22:56:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eaeNjDMY0uYjijMDWYXE4Y/guSYZA/DvST2lOWVAhH4=;
        b=FnqBmnHap+h8ESz0fHD6GyHA9tn1+8OyNZQuWUeufudz1T1B7DW1+Vb168niiLDgx2
         qdR7lMITxlOIVHt9z8VGeKxYvVdBD+CdSX9ByYen+1dsT0nx4DxL6yNUWPckPVVilhM+
         N0MkFkDzcb4duPfB1NKud2CJv4ftaSTH/rSaM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eaeNjDMY0uYjijMDWYXE4Y/guSYZA/DvST2lOWVAhH4=;
        b=deqWojYt3+43Z/UVZdmKobqfAUKZmFra4GMN99HnLf09pgAokpa1U5b/oMhDIoFMPt
         wUgO5wqNCJCMPUUADsCvnP31JOkr1RJl0QrD51EYvaOy6qjnzcschtSDvczeMzsgHldn
         /ZsDW5bkBv1+fom5D+ohZkqlkEXJyUH0hDrPQCR8bpn3F8xPZ9NTQxhl7kTT0fO2c83o
         6Q12lkYmHUM2891c1N9kAmyFx01ZIiHCQwZkpgMMwVfm19sLSeSgaJvbta+UKkul6NpK
         FqF7NB94frOwDpvzdohGL3UoYA5jTeqCERNd9OKdFbZP5VlYZoue0bqqA2eF1UnN9ioI
         tR/w==
X-Gm-Message-State: APjAAAXuMU2p5iKXo1ZrGGVEiLW1sr+Sa7VNUTOuC5JD1xggFCDXvzpV
        QxUVw7QqS9nyqBz/dK2ZhPmhuQG5wuakrg==
X-Google-Smtp-Source: APXvYqzM52hMm6W2+zNoddLcN4x+8FhzsUC4X6pPLA4EDERLlcpsoJhkQRLw9jn/noLyVznuf/Hm/A==
X-Received: by 2002:ac2:5e29:: with SMTP id o9mr17125400lfg.81.1580885769115;
        Tue, 04 Feb 2020 22:56:09 -0800 (PST)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id d22sm11622993lfi.49.2020.02.04.22.56.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Feb 2020 22:56:08 -0800 (PST)
Received: by mail-lj1-f179.google.com with SMTP id r19so1155027ljg.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Feb 2020 22:56:08 -0800 (PST)
X-Received: by 2002:a2e:580c:: with SMTP id m12mr19722280ljb.150.1580885767991;
 Tue, 04 Feb 2020 22:56:07 -0800 (PST)
MIME-Version: 1.0
References: <20200205065152.873-1-masahiroy@kernel.org>
In-Reply-To: <20200205065152.873-1-masahiroy@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 5 Feb 2020 06:55:52 +0000
X-Gmail-Original-Message-ID: <CAHk-=wgF6+PqsfQZyTNM9bXK+moUy6kSzbb3ZxxRVo93-_Cc=w@mail.gmail.com>
Message-ID: <CAHk-=wgF6+PqsfQZyTNM9bXK+moUy6kSzbb3ZxxRVo93-_Cc=w@mail.gmail.com>
Subject: Re: [PATCH] kbuild: make multiple directory targets work properly
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 5, 2020 at 6:52 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> If you want to use this patch soon (seems useful since
> you are travelling), please feel free to apply it directly.
>
> If you wait for my next pull request, I will apply it to
> my tree.

I'll wait for the proper channels, I'm heading back home tomorrow
anyway, and it's not been a big problem for me.

Just an oddity I happened to hit because of doing slightly different
things while on the road.

Thanks,
                Linus
