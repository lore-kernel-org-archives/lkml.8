Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1CEAC4332D
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 19:35:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B528D2070A
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 19:35:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584646538;
	bh=NpZCvIMKU6ltgSmw8AWuaZSMP0CWrOKWYTgoxZHPGBk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=NmQ+xDDlCVQn2jhCLK4Ug/MK7m/n36kqWYA3kh0ihKt3fzApv5TJyvlf1ODovYe9n
	 VFsOH0T7df7oVPNMq1VEV1tYcYZE3W6LXeXjGJSgMNKURx58DO3wWUKKdEthnSDjzs
	 opHCRiPvgN67GZBJk05XWc3TQUrBIISWXhKgKZ+c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbgCSTfh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 15:35:37 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:34666 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbgCSTfh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 15:35:37 -0400
Received: by mail-lj1-f194.google.com with SMTP id s13so3909183ljm.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Mar 2020 12:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zwaSZAyBgCIZeC4t7rnJ7Lh5ahlUl1/pDosFFnSot5M=;
        b=VISVR6qgdmZHt7rFNVuX4o9uGjVCBGQzMyK3eyuARwBINFBy5ywzu7N7qqmutTtQpk
         b3hERWf73wWLukd5IKMG6hU2QrXD1in7NvDFXjUdbYTbOQ4siWN2ciUM+faSwX4d/tl7
         /7cPUwTQnuE+hs2hZv0WEPeFKVxXYAU0maC8U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zwaSZAyBgCIZeC4t7rnJ7Lh5ahlUl1/pDosFFnSot5M=;
        b=afY2tKUWdwNp+HJhM3Iqg5J7/O2TusXuFCsiixxduh7E6oxg19KiqB2t5EzFe4ivt0
         4e+t3kctgfFMfZ1DWrui74Sdw7MzmRItoyF2y60f6fwbTY9QKa8jUce4XWLcWRx8Cw8F
         9NDi74fOYaqzGg+3bjUmjNTeHP0SKMwNCYuqHvXA9lunudPfk76bx5kyNJbcyzHDtdak
         q1R8ZVtbd2JmVQZgYXeR3piaimXYD5+YkL/Z4w/VnU6xm/6bfdnD6H7lGte1HRBIrx7Z
         7VvXHxRM2AQXuRkdSAoCmJmp/JH5WJUWZx6GFQ1N/rtnIlYVCMHYvfSen9i3mtM0rAXk
         CwWQ==
X-Gm-Message-State: ANhLgQ139e9tgfJwlbWampBhZ0gN3DWg24dOKpJNjrlZVd+J5hI5Ck7H
        xEDLs5o1Ayls8XymTRCz7UB9OX5zUm4=
X-Google-Smtp-Source: ADFU+vsWh0QzH4DNKy5OCoY+0W1H7wL3KyaTzNJn18kWRTaDshdFbHTprFkDrCVamhCgxmHlGxPNEw==
X-Received: by 2002:a2e:145d:: with SMTP id 29mr3126957lju.281.1584646532900;
        Thu, 19 Mar 2020 12:35:32 -0700 (PDT)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id n23sm1992326lfe.83.2020.03.19.12.35.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Mar 2020 12:35:31 -0700 (PDT)
Received: by mail-lj1-f175.google.com with SMTP id w4so3855192lji.11
        for <linux-kernel@vger.kernel.org>; Thu, 19 Mar 2020 12:35:31 -0700 (PDT)
X-Received: by 2002:a05:651c:44a:: with SMTP id g10mr3204953ljg.16.1584646531011;
 Thu, 19 Mar 2020 12:35:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200308140314.GQ5972@shao2-debian> <1bfba96b4bf0d3ca9a18a2bced3ef3a2a7b44dad.camel@kernel.org>
 <87blp5urwq.fsf@notabene.neil.brown.name> <41c83d34ae4c166f48e7969b2b71e43a0f69028d.camel@kernel.org>
 <ed73fb5d-ddd5-fefd-67ae-2d786e68544a@huawei.com> <923487db2c9396c79f8e8dd4f846b2b1762635c8.camel@kernel.org>
 <36c58a6d07b67aac751fca27a4938dc1759d9267.camel@kernel.org>
 <878sk7vs8q.fsf@notabene.neil.brown.name> <c4ef31a663fbf7a3de349696e9f00f2f5c4ec89a.camel@kernel.org>
 <875zfbvrbm.fsf@notabene.neil.brown.name> <CAHk-=wg8N4fDRC3M21QJokoU+TQrdnv7HqoaFW-Z-ZT8z_Bi7Q@mail.gmail.com>
 <0066a9f150a55c13fcc750f6e657deae4ebdef97.camel@kernel.org>
 <CAHk-=whUgeZGcs5YAfZa07BYKNDCNO=xr4wT6JLATJTpX0bjGg@mail.gmail.com>
 <87v9nattul.fsf@notabene.neil.brown.name> <CAHk-=wiNoAk8v3GrbK3=q6KRBrhLrTafTmWmAo6-up6Ce9fp6A@mail.gmail.com>
 <87o8t2tc9s.fsf@notabene.neil.brown.name> <CAHk-=wj5jOYxjZSUNu_jdJ0zafRS66wcD-4H0vpQS=a14rS8jw@mail.gmail.com>
 <f000e352d9e103b3ade3506aac225920420d2323.camel@kernel.org>
 <877dznu0pk.fsf@notabene.neil.brown.name> <CAHk-=whYQqtW6B7oPmPr9-PXwyqUneF4sSFE+o3=7QcENstE-g@mail.gmail.com>
 <b5a1bb4c4494a370f915af479bcdf8b3b351eb6d.camel@kernel.org>
 <87pndcsxc6.fsf@notabene.neil.brown.name> <ce48ed9e48eda3c0f27d2f417314bd00cb1a68db.camel@kernel.org>
 <CAHk-=whnqDS0NJtAaArVeYQz3hcU=4Ja3auB1Jvs42eADfUgMQ@mail.gmail.com>
 <5d7b448858d5a5c01e97aceb45dcadff24d6fc28.camel@kernel.org>
 <CAHk-=wj=UEVBObnZNtSnvX_9afJ3XHBSuXACPbriCBkCUGTHmA@mail.gmail.com> <7c10010c3d7745857ee1fba8eb06e7fe047eaa13.camel@kernel.org>
In-Reply-To: <7c10010c3d7745857ee1fba8eb06e7fe047eaa13.camel@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 19 Mar 2020 12:35:14 -0700
X-Gmail-Original-Message-ID: <CAHk-=whAWFw5vZB-krqUteHuAYCYypKG6683WEydOynBizpixQ@mail.gmail.com>
Message-ID: <CAHk-=whAWFw5vZB-krqUteHuAYCYypKG6683WEydOynBizpixQ@mail.gmail.com>
Subject: Re: [locks] 6d390e4b5d: will-it-scale.per_process_ops -96.6% regression
To:     Jeff Layton <jlayton@kernel.org>
Cc:     NeilBrown <neilb@suse.de>, yangerkun <yangerkun@huawei.com>,
        kernel test robot <rong.a.chen@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        Bruce Fields <bfields@fieldses.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 19, 2020 at 12:24 PM Jeff Layton <jlayton@kernel.org> wrote:
>
> >
> > If you have other things, send me a pull request, otherwise just let
> > me know and I'll apply the patch directly.
>
> That's it for now.

Lol. You confused me with your question of whether I wanted a pull
request or not.

I had already applied the patch as dcf23ac3e846 ("locks: reinstate
locks_delete_block optimization") yesterday ;)

            Linus
