Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C25AC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 17:19:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB8D120823
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 17:19:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593019180;
	bh=YEJjSSgHOTBuhnoSFcjivuGSb7q6OB7nYlugJPBBv0I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=WSq/uSyKr8er6C81VDWAcjgvIogO4xrXa/eGVWlKFNPMVIV6CePLzRpVuK1JPt9SF
	 JEwLJy4WSyCL0oH6N0aQ0/ugBhVMqm12+SEJXYLgpKZUV76wcMKkwkoYgX0HUQciKZ
	 08tSwHafL22lOb95+cUfe32AkI/8HkCCQwYTAl6U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405481AbgFXRTj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 13:19:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405470AbgFXRTg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 13:19:36 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE16DC0613ED
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 10:19:35 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id m26so1673251lfo.13
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 10:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qnO8hKovA7hP7JvwvjuDQY7Jzg/02N7Frk2urzNRpI4=;
        b=P4yma5zFPApj98Kr5mjr+nS/v3AyFaHaehqB4iRF6Laev6mPoAvKUOpXS81ZdH52io
         MBVLjtssxRQN2czblUcwihfke8lVaDX2X0b0qkoR7A/UTBs4xokVujZODTlvBx7KgXeX
         3VC6Jav+FZPi4s3KLN6PaNUXdSrLsqzenGGdM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qnO8hKovA7hP7JvwvjuDQY7Jzg/02N7Frk2urzNRpI4=;
        b=GY+WFEj68VQflBlriQawXQ6eX3H/rx/oW7waYsr1lus5NqXSmoNIODL02AJY7jeRUe
         g+6b9ENaDPsAjQKIu3fGuuii+VKYoBrHPjF5Ko4rdm5eBleb6ye20Ihgs/4gfdwRRx/w
         DIgVTrCQhdV/ZOVQYV/QiA0GFe7P4GxSppKIyrkvfR+EsdcTOXI7E9RpK9UnuI8fr84g
         5RAP7LXcWCG1+83468pyPHFYXsBtXR66OHFaAhiQKvWV25oI6zbKFlFDWBwT+4n25lSh
         0XDLIxTEo4FnNGaP+kKb7P4EKs8sik1DRZ1mvB4cTOX2BhRuUSCNhPjbPSPifXurUv2a
         kEzw==
X-Gm-Message-State: AOAM530DF3aAKxygZgvR1YkWtGkW9K4nlLS18qI2VTO0GSkSGaG5JqKJ
        HWQV8gYR+ecffmmoNhFp2ziOJpS7dUU=
X-Google-Smtp-Source: ABdhPJwJLWA6vhOCf7ZUfQlrlyzFrYpUSFxypNg6W/jLAcGPNh/EH8gm4O92R7bGtN1QkRM4JRyN7g==
X-Received: by 2002:a19:1d1:: with SMTP id 200mr16294487lfb.57.1593019173830;
        Wed, 24 Jun 2020 10:19:33 -0700 (PDT)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id r8sm4967356ljj.81.2020.06.24.10.19.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jun 2020 10:19:33 -0700 (PDT)
Received: by mail-lf1-f50.google.com with SMTP id d21so1696547lfb.6
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 10:19:32 -0700 (PDT)
X-Received: by 2002:ac2:5093:: with SMTP id f19mr16132062lfm.10.1593019172581;
 Wed, 24 Jun 2020 10:19:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200624162901.1814136-1-hch@lst.de> <20200624162901.1814136-4-hch@lst.de>
In-Reply-To: <20200624162901.1814136-4-hch@lst.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 24 Jun 2020 10:19:16 -0700
X-Gmail-Original-Message-ID: <CAHk-=wit9enePELG=-HnLsr0nY5bucFNjqAqWoFTuYDGR1P4KA@mail.gmail.com>
Message-ID: <CAHk-=wit9enePELG=-HnLsr0nY5bucFNjqAqWoFTuYDGR1P4KA@mail.gmail.com>
Subject: Re: [PATCH 03/11] fs: add new read_uptr and write_uptr file operations
To:     Christoph Hellwig <hch@lst.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 24, 2020 at 9:29 AM Christoph Hellwig <hch@lst.de> wrote:
>
> Add two new file operations that are identical to ->read and ->write
> except that they can also safely take kernel pointers using the uptr_t
> type.

Honestly, I think this is the wrong way to go.

All of this new complexity and messiness, just to remove a few
unimportant final cases?

If somebody can't be bothered to convert a driver to
iter_read/iter_write, why would they be bothered to convert it to
read_uptr/write_uptr?

And this messiness will stay around for decades.

So let's not go down that path.

If you want to do "splice() and kernel_read() requires read_iter"
(with a warning so that we find any cases), then that's fine. But
let's not add yet _another_ read type.

Why did you care so much about sysctl, and why couldn't they use the iter ops?

                    Linus
