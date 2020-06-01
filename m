Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C100C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 23:47:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C8702073B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 23:47:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591055228;
	bh=WeGkpdeTlH9sVNS3yUaDBxNm2uoZZkZHLtBKh4PdjyA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=dF2F70wNKT5v1sVLevcVY5Rjb2Iab+gwYZOtoPb0IxriWyhlBZwBjxTZOkPwFPHyi
	 +PdENNuJn/UKkWBha8xWGvJTYC0XLcKXRpEaryw5EIDPm/gGjwv8UWu5CpeNLnZ23z
	 uTyUFVjqkrlD+L6c7w+NBT47fR3reDGJK+dgGLps=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728336AbgFAXrH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 19:47:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbgFAXrH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 19:47:07 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84B77C05BD43
        for <linux-kernel@vger.kernel.org>; Mon,  1 Jun 2020 16:47:05 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id r125so4971569lff.13
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jun 2020 16:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YPAAhtEgMQMtmHDbk4KgNVVpl7a42uJF+VjoetnC8jI=;
        b=bESB1wsrBJTiKsNhLK8BXuVH4tt31XqGwfNRhMk2+/Xu4/15TnKxr/43IFI11Ff20e
         E71y386MHxjxyD7FDbtXRAwyaf210o9T33Um8QCdKVeopCwtiFvuy3IyPzIPDwLGTs6I
         Skc//o42qw2/7f77dLgDy021eRqbsEEj0r+Ak=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YPAAhtEgMQMtmHDbk4KgNVVpl7a42uJF+VjoetnC8jI=;
        b=PtpCt020SAEltN7zYTUJcTM8kSv1Oupi0TiyNzKkWy14K6uthBd7LcLCeofjyT3elf
         3YMw+SrEKxzr0GMuE5PM6zNK4VkymOXdNYp169fiLXqKsX8LNrYVqIYiPzbL0tKWdeFz
         tDucI/c+lKzrp3xtqY3EEoHzEHqaxqGzAEevJIPCY3ley7izUK9j9yaVTrpWpvrvNxm3
         HiA/Y0pykCXN+kzJzibYWs5ec5G74g9SvnUucDBkv774uCoppPM4uOIesMy0vSxPCFST
         qDSq9IvJpmGPxkeKvd6h8a2ugW5aCPO09tJjj1ZdPpFRRSp9wjmOb5afXoGE6mkUXt5O
         9IXQ==
X-Gm-Message-State: AOAM532o47qn2BCFaX/cj9NssG0uLX2/4u3VghOzUmNbevft3ndYtm9o
        2BG1qSqjYdq/lMYq9QSOU407BKy2ISY=
X-Google-Smtp-Source: ABdhPJxdxQt4JhLyO/WyUswNZ4XSPR9kisEQcztxoqw6ZZ/TmlMV46pYrytCbgJd8B/V+R6Ci7AXNw==
X-Received: by 2002:a19:c187:: with SMTP id r129mr12465470lff.35.1591055222904;
        Mon, 01 Jun 2020 16:47:02 -0700 (PDT)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id q4sm197544ljj.47.2020.06.01.16.47.01
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jun 2020 16:47:02 -0700 (PDT)
Received: by mail-lf1-f52.google.com with SMTP id r125so4971547lff.13
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jun 2020 16:47:01 -0700 (PDT)
X-Received: by 2002:ac2:5a0a:: with SMTP id q10mr12574943lfn.142.1591055221658;
 Mon, 01 Jun 2020 16:47:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200601184036.GH23230@ZenIV.linux.org.uk>
In-Reply-To: <20200601184036.GH23230@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 1 Jun 2020 16:46:45 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjQ8vRE3jSby=KOejXORsL2qgQ2g=KQ=Y10NvVoVBFtxQ@mail.gmail.com>
Message-ID: <CAHk-=wjQ8vRE3jSby=KOejXORsL2qgQ2g=KQ=Y10NvVoVBFtxQ@mail.gmail.com>
Subject: Re: [git pull] vfs patches from Miklos
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Miklos Szeredi <mszeredi@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 1, 2020 at 11:40 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
>         Assorted patches from Miklos; an interesting part here is /proc/mounts
> stuff...

You know, this could really have done with more of a real description, Al...

              Linus
