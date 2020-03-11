Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89A4EC0044D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 16:48:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C52DB206E7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 16:48:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583945327;
	bh=aARKqVTvyooCoR41r7AaHeG71kie0335/r0bble2Pdw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=NN/glcnJrXUJ8W/t1ZxisL08kzFkTJDJIe/0cW162o74gTphl2dD45RayepVTTIZ2
	 YElpQ7EzGgp8scg2PK+k6Fx8+okAMcBGMBBMVz7QWGGxPXEoV8v0pJPaCmUBMJRdYq
	 TiTvUhcNr25hCPdIFZS5NhjI3bcuCWnAXTP/AZzQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730203AbgCKQsq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 12:48:46 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:43357 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729584AbgCKQsq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 12:48:46 -0400
Received: by mail-lf1-f65.google.com with SMTP id q9so2307394lfc.10
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 09:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nvdaEzJa7BlyOVahyajCu5RaMgVluQfvfvpupgNvYPI=;
        b=gTYXTGLbY5loy6LLU50Ij4wvtWSkC1KAWrZXcHsoO1uCYD/i8UHh+Fp6H4Lfe4kdbN
         +iCHTAZrtgnoEbw/v9CPYJjmPJSY9iJAV9hHJtzdILJGtgEkVlpC0w+CR2pyEVwiAyC5
         UbZvFt+oRjc8PidJ6oJOx+Xw/Ygl8qTl+1lDw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nvdaEzJa7BlyOVahyajCu5RaMgVluQfvfvpupgNvYPI=;
        b=WmAeZKYzsF7v3ZDX6VdRpBxMWMBk6JzL4unn/EiERWJtgxx8szhPUAYM4hjt8Vr+1R
         VtgyAJOqB6h+RnjqjYOixlNCXuXup/08NxKroa/M7JjCrJ52kXt+ewQmYKgwzHIcog54
         aSFm3oVvqLoRZSWYgC52yk5hs2mhzGJuz/JNRiaDnhOvzvKWv7fHk2avKmxdSCB2Z09Q
         p0H1TfKvVMBF5FnZ2BhJReJxeq9ufEs/wzTROdRTEBRjVbqO6nIKHNF3bhHs+j3D1bAB
         uiFaLN2R+j2t3xQzECBkE0TnabG3yyXGXKAY/5hyiabVlm9TDiQ9uS3io4XWc5XzfxHE
         FiAQ==
X-Gm-Message-State: ANhLgQ2bK92IQikTOjcv7Hh7UPZKr+W8F5HOs48kGuZBCUgPbLGvH3tD
        x6bzkljYykDMyel57fvzaUigRYrR8eI=
X-Google-Smtp-Source: ADFU+vsfRKe2zmxBIOETApWTP1+wZnS51uBivMQ3evMQuYGLlms4U7D/XirxAa+dS9ffP3NAYLwDpg==
X-Received: by 2002:ac2:4116:: with SMTP id b22mr2473616lfi.172.1583945322842;
        Wed, 11 Mar 2020 09:48:42 -0700 (PDT)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id b23sm4778966lfi.55.2020.03.11.09.48.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Mar 2020 09:48:42 -0700 (PDT)
Received: by mail-lj1-f181.google.com with SMTP id s13so3142552ljm.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 09:48:41 -0700 (PDT)
X-Received: by 2002:a2e:89c7:: with SMTP id c7mr2718156ljk.265.1583945321533;
 Wed, 11 Mar 2020 09:48:41 -0700 (PDT)
MIME-Version: 1.0
References: <bug-206175-5873@https.bugzilla.kernel.org/> <bug-206175-5873-S6PaNNClEr@https.bugzilla.kernel.org/>
 <CAHk-=wi4GS05j67V0D_cRXRQ=_Jh-NT0OuNpF-JFsDFj7jZK9A@mail.gmail.com>
 <20200310162342.GA4483@lst.de> <CAHk-=wgB2YMM6kw8W0wq=7efxsRERL14OHMOLU=Nd1OaR+sXvw@mail.gmail.com>
 <20200310182546.GA9268@lst.de> <20200311152453.GB23704@lst.de>
 <e70dd793-e8b8-ab0c-6027-6c22b5a99bfc@gmx.com> <20200311154328.GA24044@lst.de>
 <20200311154718.GB24044@lst.de> <962693d9-b595-c44d-1390-e044f29e91d3@gmx.com>
 <CAHk-=wj0E9vCO_VTiK6xuXAW13ZeeLsW=G3v+yNsCaUm1+H61A@mail.gmail.com> <CAHk-=whFu_p-eiyJfiEevV=a+irzW=9LMWjMaaFSaaasXout9w@mail.gmail.com>
In-Reply-To: <CAHk-=whFu_p-eiyJfiEevV=a+irzW=9LMWjMaaFSaaasXout9w@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 11 Mar 2020 09:48:25 -0700
X-Gmail-Original-Message-ID: <CAHk-=whkKCxj-U9343Tk4Bbkc7oatqq26XGdAM6JJ+X==R_iNQ@mail.gmail.com>
Message-ID: <CAHk-=whkKCxj-U9343Tk4Bbkc7oatqq26XGdAM6JJ+X==R_iNQ@mail.gmail.com>
Subject: Re: [Bug 206175] Fedora >= 5.4 kernels instantly freeze on boot
 without producing any display output
To:     "Artem S. Tashkinov" <aros@gmx.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        iommu <iommu@lists.linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 11, 2020 at 9:24 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> So it will have a different commit ID, updated message, and be a mix
> of my patch and Christoph's.

I ended up pushing it out before starting on the pull requests, so
it's out there now.

Artem, it would be good to have confirmation that my (modified) tip of
tree now works for you. I don't actually doubt it does, but a final
confirmation would be appreciated.

            Linus
