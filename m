Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79336C352A4
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 19:58:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48AC421739
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 19:58:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581537481;
	bh=hDBPuQJs4qv8LaQDcqEYUh0ns59INLi4LN/R5iIzvRE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=mNs0a75ZDD4EVoBJqo3wVrAXv/xG4taHi14ox6hcE7Rn2yjbEWvaLgf+xYHmLbwxU
	 oJn7Jrhd+nFewbKJZBhk5tKQzlTsH/UEdd9hbkGs/kzuPkFbovMuP+eaBfRE8zRkK/
	 PnkVUDEzddL1d3+FIEKKZP/obpMmSmzcNXdVYJug=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729013AbgBLT6A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 14:58:00 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:41924 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727361AbgBLT6A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 14:58:00 -0500
Received: by mail-lf1-f65.google.com with SMTP id m30so2480037lfp.8
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2020 11:57:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NRxcPbZlBU1OfoVhDxO+pK182w0JxdOcMu6TqmSPFkg=;
        b=YIbsOvX279zgq2GNeD3QTxy7DFi/fsk2dXh7EwDz4DKlq1WnaGL1O6aJNZc6Kkg+FW
         podzQGkA8Ywe7kEXUGeKV1w18qVFoa08RedAdK0W0BtUxK39vbkSBLTC2BRmPXXFU2xI
         rH0QxKFIcHCt0njslvx9uzY6RvM1922Kz9QvA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NRxcPbZlBU1OfoVhDxO+pK182w0JxdOcMu6TqmSPFkg=;
        b=O0/duNOwK18h/u2kd2lSVy6tuSnR9DuoMGygV+B6+kXCtmFVeheVmcEcUYo8ykbAHp
         ZfvLl3uDApbQZHkbm2w8m56jiPPjK8rmjCyukjpau9prCdZUYf4qJzpIWQyC5Ld+nxS8
         ucSv+m2vB1rY9tQNUe+TPpxaK3pJ50BL1ecrBC1QwxUVtrroNngWi3C0/GEHK1SEmWyE
         HLnraS4p1oCRRU8C34z339eGifG+EFp0PX9KEo42ZwIMkZpS4EkVx4obB3zJZkKhoEkz
         kSMj4AV6uCq6mnBrVpm7hp0gwOVO9AmyYW4WKIeUvgTASDrZZxxjPwUoEzRZwlPVLD/z
         lmQA==
X-Gm-Message-State: APjAAAX2ZM441tamropaR2rUvaV/3qXHBJ+BH3t9BR8d9YwrsR9MT2y1
        2bg9eJocklH3tGkq7d/vak4eCNeRB/8=
X-Google-Smtp-Source: APXvYqwAcNY2sLM3D6llzcHfxC5mf9gTVsACs+3l600K3iMAw2u6idDaHLjrz2e1ZlAYmnS4Uv7J5Q==
X-Received: by 2002:a19:f514:: with SMTP id j20mr7522634lfb.31.1581537476504;
        Wed, 12 Feb 2020 11:57:56 -0800 (PST)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id k4sm72046lfo.48.2020.02.12.11.57.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Feb 2020 11:57:55 -0800 (PST)
Received: by mail-lf1-f46.google.com with SMTP id z18so2504793lfe.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2020 11:57:55 -0800 (PST)
X-Received: by 2002:a19:c82:: with SMTP id 124mr7345985lfm.152.1581537475126;
 Wed, 12 Feb 2020 11:57:55 -0800 (PST)
MIME-Version: 1.0
References: <0956ab21-9b9a-4d1e-fe43-b853d1602781@infradead.org>
In-Reply-To: <0956ab21-9b9a-4d1e-fe43-b853d1602781@infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 12 Feb 2020 11:57:39 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjU6YdzhdhevAJ8od96RWvvqtV+h3TWvJ3QcSNrQJbMMg@mail.gmail.com>
Message-ID: <CAHk-=wjU6YdzhdhevAJ8od96RWvvqtV+h3TWvJ3QcSNrQJbMMg@mail.gmail.com>
Subject: Re: [PATCH] linux/pipe_fs_i.h: fix kernel-doc warnings after @wait
 was split
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 9, 2020 at 7:36 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> Fix kernel-doc warnings in struct pipe_inode_info after @wait was
> split into @rd_wait and @wr_wait.

Thanks, applied.

I've considered adding some doc building to my basic tests, but it is
(a) somewhat slow and (b) has always been very noisy.

And that (b) is why I really don't do it. The reason I require the
basic build to be warning-free is that because that way any new
warnings stand out. But that's just not the case for docs.

What do you use to notice new errors? Or is there some trick to make
it less noisy?

               Linus
