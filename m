Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C30BBC4332D
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 18:20:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A07B520784
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 18:20:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ROF8fL4c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727211AbgCTSU0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 14:20:26 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:33443 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726789AbgCTSU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 14:20:26 -0400
Received: by mail-pl1-f193.google.com with SMTP id g18so2868113plq.0
        for <linux-kernel@vger.kernel.org>; Fri, 20 Mar 2020 11:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RVSRfcV+K0pn1zszQCXh+F75MQYeICFTBaMdga96uY8=;
        b=ROF8fL4cRZOKjexdiQjvRriYL5aMB2v6UG48zv2w65UIZVXk7AuVFSi6y696oOXNgd
         OvVHFsVQNRrgCH99H9N1yvFIVrPS6ys9mIlNNMSdcv+QWT7LmYHbymhkONJJ4Iind7wU
         XawwvMxLzn/ahDIsk46CsBzOvZd50S7qX5rI8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RVSRfcV+K0pn1zszQCXh+F75MQYeICFTBaMdga96uY8=;
        b=NtOlxtQc/aEXKreEovN71zotVw+UPPTu6IlBjdLP5GIq3i4bd7Cx9nK/gqT/VwzwWG
         LeqX4YnJ1bYqJxruU0ucwlgeooYI/CW6gtJ4PH6btv93V3F/1PrYXardIC0HvzLITf0+
         yMKOBQDFjtVbsM/EkNlZzQ+eoU/8DaNuqFf73SPUixgJorexcQeoVGidd5uoyjpknu37
         jzGM8GmKbEf+GL1UUlSEjLNek8GryWhZhbnEWtUVyLy2psk0HXy7PxsPYzE0Q5zXIq0/
         mSSj/cg1nkweu2ikPkj/VocDUr4GXB1fTj0TDdHF0eocdYtIA3VjxkfQVRS+CaOTOaeN
         YR0g==
X-Gm-Message-State: ANhLgQ2Sof79UEPf4o7CUi1uzdhwPyh4RAiGXoreae39yjBxvkDkHuBl
        lArHRA1PnCYp6pEerj1z5PoBwQ==
X-Google-Smtp-Source: ADFU+vvh9wNdOc6LXFIlkPM76qeYw8uzvfR7zvmRHA7t4NFIeMW1f7FJ0y8bVnB9QWXKTnZPYdAwPw==
X-Received: by 2002:a17:902:8348:: with SMTP id z8mr8998254pln.342.1584728424639;
        Fri, 20 Mar 2020 11:20:24 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id g9sm6093642pfi.37.2020.03.20.11.20.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2020 11:20:23 -0700 (PDT)
Date:   Fri, 20 Mar 2020 11:20:22 -0700
From:   Kees Cook <keescook@chromium.org>
To:     WeiXiong Liao <liaoweixiong@allwinnertech.com>
Cc:     Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org
Subject: Re: [PATCH v2 01/11] pstore/blk: new support logger for block devices
Message-ID: <202003201111.BE5EAB9A@keescook>
References: <1581078355-19647-1-git-send-email-liaoweixiong@allwinnertech.com>
 <1581078355-19647-2-git-send-email-liaoweixiong@allwinnertech.com>
 <202002251626.63FE3E7C6@keescook>
 <5fd540be-6ed9-a1c7-4932-e67194dddca8@allwinnertech.com>
 <202003180944.3B36871@keescook>
 <dab67ab1-c03f-0507-3d56-4a9578e85f6b@allwinnertech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dab67ab1-c03f-0507-3d56-4a9578e85f6b@allwinnertech.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 20, 2020 at 09:50:36AM +0800, WeiXiong Liao wrote:
> On 2020/3/19 AM 1:23, Kees Cook wrote:
> > On Thu, Feb 27, 2020 at 04:21:51PM +0800, liaoweixiong wrote:
> >> On 2020/2/26 AM 8:52, Kees Cook wrote:
> >>> On Fri, Feb 07, 2020 at 08:25:45PM +0800, WeiXiong Liao wrote:
> >>>> +obj-$(CONFIG_PSTORE_BLK) += pstore_blk.o
> >>>> +pstore_blk-y += blkzone.o
> >>>
> >>> Why this dance with files? I would just expect:
> >>>
> >>> obj-$(CONFIG_PSTORE_BLK)     += blkzone.o
> >>>
> >>
> >> This makes the built module named blkzone.ko rather than
> >> pstore_blk.ko.
> > 
> > You can just do a regular build rule:
> > 
> > obj-$(CONFIG_PSTORE_BLK) += blkzone.o
> > 
> 
> I don't get it. If make it as your words, the built module will be
> blkzone.ko.
> The module is named pstore/blk, however it built out blkzone.ko. I think
> it's confusing.

I mean just pick whatever filename you want it to be named. The Makefile
case for ramoops was that ramoops got renamed but we wanted to keep the
old API name.

So, if you want it named pstore-blk.ko, just rename blkzone.c to
pstore-blk.c.

> >>> If you're expecting concurrent writers (use of atomic_set(), I would
> >>> expect the whole write to be locked instead. (i.e. what happens if
> >>> multiple callers call blkz_zone_write()?)
> >>>
> >>
> >> I don't agree with it. The datalen will be updated everywhere. It's useless
> >> to lock here.
> > 
> > But there could be multiple writers; locking should be needed.
> > 
> 
> All the recorders such as dmesg, pmsg, console and ftrace have been
> locked on
> pstore and upper layers. So, a recorder will not write in parallel and
> different
> recorders operate privately zone. They don't have any influence on each
> other.

Yes, sorry, I was confusing myself about pmsg, and I forgot it had a
global lock. Each are locked or split by CPU.

> The only parallel case I think is that recorder writes while dirty-flush
> thread is
> working. And the dirty-flusher will flush the whole zone rather than
> part of it, so,
> it is OK to call in parallel.

Okay, thanks for clarifying.

> Based on these reasons, I don't think locking should be needed.

Agreed.

-- 
Kees Cook
