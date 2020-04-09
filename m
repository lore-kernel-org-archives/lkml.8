Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABBCFC2BB1D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 04:11:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81BEF20757
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 04:11:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586405513;
	bh=Xk/DeEzJO9h3n1nM5e/75sl5xSYuZ6PfNI1l16qoFXA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=borCwaS+v43URJPMpp/jFc9SqkiTCVyVg7+5HAXCgXTAu4kYxCMBXHRtyZUQof65+
	 HAx2HibNfzvV5/WdMhkjqL4sdmCp21uFGIPZGqEzzt+S8V8cY60iSnX4i7fO5W1qhh
	 UoJaOjCGn2ctkflxIPtEIxLbgNGzzq/HXKXWNkgE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725970AbgDIELv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 00:11:51 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:34837 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725283AbgDIELu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 00:11:50 -0400
Received: by mail-lf1-f67.google.com with SMTP id r17so6853473lff.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Apr 2020 21:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HZV2tyyn5kRqCcuYzyXRvuvJ3LvB/Ij4cHXWeK01HzY=;
        b=gwLIomC7wLBmb6JFfXV96AHH+ECKwQVO7CEBA3QESJy1aFRjCCjozlVwvUf1aCLCsj
         8jaUU8mqD94X0bBewdTWHRVlAhvr8lSsF8tT+bastkAziEMAu/ftwTQbFrchjedOpQw7
         UWlNvtjMfgbVHPwRtbHBjzt9Zvmeqs6ZbdTVo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HZV2tyyn5kRqCcuYzyXRvuvJ3LvB/Ij4cHXWeK01HzY=;
        b=oJLRstI+S8aBbc7enkftpwvf1wzYG2v7yCEVrR3gwHRKWDdojTFC8nn/dQjQCMR2xW
         D6jZoFwYfykkS7gpRAXrcoiyhutWSd9zCwP2JK1AC+uywNHen29y1zM95GMr8k/DJ1pH
         CpMlx++BVh+4EmRJUCtIS9/qmaM2Kk7z2ckHdh9rSoSImI/1F27c13FiB4y2meW+apnP
         W2Vxrn37zvj9RM9tTm+Z9tcTN7/5Dz2juczHIGXUE4yRRvm5ES7BBhKRsG8Fst6TzXjr
         cSC63BvPVhqmSqLdW5DjlxD/4GGRzWnXoju500a+t5/y1XLBRlL97kIv7HATWYf3H36M
         ufNQ==
X-Gm-Message-State: AGi0Pub/3ONWWzfyNlaz3Uhba/Dc/nm8ag+t9PjpAcXwRMnwaKxzyYo4
        EKEC8fOW9BuLgF6UTwJYGM12uLxzhP0=
X-Google-Smtp-Source: APiQypJ9zVumkSqJgPe7ylhvy8n8U5Zo9ZM+DmNlzhI0xp7Dvx+ynpciL+olWUmYagcNXW/9I/FdfA==
X-Received: by 2002:a05:6512:3135:: with SMTP id p21mr5005209lfd.36.1586405507445;
        Wed, 08 Apr 2020 21:11:47 -0700 (PDT)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id e8sm2241096lja.3.2020.04.08.21.11.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Apr 2020 21:11:46 -0700 (PDT)
Received: by mail-lj1-f175.google.com with SMTP id r24so10008602ljd.4
        for <linux-kernel@vger.kernel.org>; Wed, 08 Apr 2020 21:11:46 -0700 (PDT)
X-Received: by 2002:a2e:a58e:: with SMTP id m14mr6845493ljp.204.1586405505983;
 Wed, 08 Apr 2020 21:11:45 -0700 (PDT)
MIME-Version: 1.0
References: <CAPcyv4gKr57qNnMEupjcjQmH9Vy_iZuLPE1VA36QAkKhzEbzSA@mail.gmail.com>
In-Reply-To: <CAPcyv4gKr57qNnMEupjcjQmH9Vy_iZuLPE1VA36QAkKhzEbzSA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 8 Apr 2020 21:11:30 -0700
X-Gmail-Original-Message-ID: <CAHk-=whm-J+j86gqWA93tpBHDfOwsLGt=dV2px8bUL7pbRR4ug@mail.gmail.com>
Message-ID: <CAHk-=whm-J+j86gqWA93tpBHDfOwsLGt=dV2px8bUL7pbRR4ug@mail.gmail.com>
Subject: Re: [GIT PULL] libnvdimm for v5.7
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vishal L Verma <vishal.l.verma@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 7, 2020 at 1:12 PM Dan Williams <dan.j.williams@intel.com> wrote:
>
>       mm/memremap_pages: Introduce memremap_compat_align()

Why is this an exported function that just returns a constant?

Why isn't it just a #define (or inline) in a header file?

Yes, yes, it would need to be conditional on not having that
CONFIG_ARCH_HAS_MEMREMAP_COMPAT_ALIGN, but it does look strange.

I've pulled it, since it doesn't matter that much, but I find it silly
to have full-fledged functions - and exported them GPL-only - to
return a constant. Crazy.

             Linus
