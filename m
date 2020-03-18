Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 469DCC5ACD6
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 17:24:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1738F20753
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 17:24:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="StJGpa7X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726879AbgCRRX7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 13:23:59 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38918 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726638AbgCRRX6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 13:23:58 -0400
Received: by mail-pl1-f193.google.com with SMTP id m1so3269661pll.6
        for <linux-kernel@vger.kernel.org>; Wed, 18 Mar 2020 10:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5lZ1QU2FiFM13mpL/1LqV4PfZUlqUvmQr/hvDd3BQGQ=;
        b=StJGpa7X9j349/Ka4aTMwiWNnGwdyfD0gMlTqoa+GisQnaXFbZ/RQcqbALgC4QicTu
         kzwOuj51JOzHmGkT4YXyHkw275RLPDETMsKJPSzN6ba1GUUYmHWTnk1+7ddddvBsJqmo
         1OY0XUffqBgdgPAYeeunnU0zbXtrnvfOQndS4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5lZ1QU2FiFM13mpL/1LqV4PfZUlqUvmQr/hvDd3BQGQ=;
        b=a7UGguMwYKivhebVVSe/DTCuQ0XGsxe4YqBgWfMUdYnl5QgCzJg44q/1FokZ/mugau
         e+pR/ER0bHS7OEFWtUMfckbb+KPdTTFSE5/dQU2I8J3NLicWI3xKfe51kSDrxz5GzS9z
         5We1CmWQmVE54pZDsEj0jW+6YW2VWUDndv4T5/ykqkWWZ0rEgl34QpcfsnYLZj6WVssr
         pnVw8oPkd/zvogEVC64yQHH9DNXlxBDdzyLMK2qtTIudF+TvpwTU9goGGQqDtzc2XqDa
         GQLdiGBn7h0pjftyIfGVBiu9YxXmuVrt8yn1juB9ewezmCtnHX9ZsuRsJ8ehlyjRUcOI
         LOiw==
X-Gm-Message-State: ANhLgQ1wzQG1b1o9zd/hDKucUBiI3r4DNiiB8nYOe8LnUJmml56r05Cq
        gLSZmCroQ8Ug50hrFPOGBv6Rnw==
X-Google-Smtp-Source: ADFU+vuY5ynlbZILs/Hp7bMDvzaH2hLDfKwtDf1FS/pi7nzyIJJX2IjC+XKLfrRkLst7Wkf6xPdaJQ==
X-Received: by 2002:a17:902:8505:: with SMTP id bj5mr1150596plb.235.1584552237151;
        Wed, 18 Mar 2020 10:23:57 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b20sm6161330pff.51.2020.03.18.10.23.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2020 10:23:56 -0700 (PDT)
Date:   Wed, 18 Mar 2020 10:23:55 -0700
From:   Kees Cook <keescook@chromium.org>
To:     liaoweixiong <liaoweixiong@allwinnertech.com>
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
Message-ID: <202003180944.3B36871@keescook>
References: <1581078355-19647-1-git-send-email-liaoweixiong@allwinnertech.com>
 <1581078355-19647-2-git-send-email-liaoweixiong@allwinnertech.com>
 <202002251626.63FE3E7C6@keescook>
 <5fd540be-6ed9-a1c7-4932-e67194dddca8@allwinnertech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5fd540be-6ed9-a1c7-4932-e67194dddca8@allwinnertech.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 27, 2020 at 04:21:51PM +0800, liaoweixiong wrote:
> On 2020/2/26 AM 8:52, Kees Cook wrote:
> > On Fri, Feb 07, 2020 at 08:25:45PM +0800, WeiXiong Liao wrote:
> >> +obj-$(CONFIG_PSTORE_BLK) += pstore_blk.o
> >> +pstore_blk-y += blkzone.o
> > 
> > Why this dance with files? I would just expect:
> > 
> > obj-$(CONFIG_PSTORE_BLK)     += blkzone.o
> > 
> 
> This makes the built module named blkzone.ko rather than
> pstore_blk.ko.

You can just do a regular build rule:

obj-$(CONFIG_PSTORE_BLK) += blkzone.o

> >> +#define BLK_SIG (0x43474244) /* DBGC */
> > 
> > I was going to suggest extracting PERSISTENT_RAM_SIG, renaming it and
> > using it in here and in ram_core.c, but then I realize they're not
> > marking the same structure. How about choosing a new magic sig for the
> > blkzone data header?
> > 
> 
> That's OK to me. I don't know if there is a rule to get a new magic?
> In addition, all members of this structure are the same as
> struct persistent_ram_buffer after patch 2. Maybe it's a good idea to
> extract it
> if you want to merge ramoops and pstore/blk.

Okay, let's leave it as-is for now.

> >> +	uint32_t sig;
> >> +	atomic_t datalen;
> >> +	uint8_t data[];
> >> +};
> >> +
> >> +/**
> >> + * struct blkz_dmesg_header: dmesg information
> > 
> > This is the on-disk structure also?
> > 
> Yes. The structure blkz_buffer is a generic header for all recorder
> zone, and the
> structure blkz_dmesg_header is a header for dmesg, saved in
> blkz_buffer->data.
> The dmesg recorder use it to save it's specific attributes.

Okay, can you add comments to distinguish the on-disk structures from
the in-memory, etc?

> >> +#define DMESG_HEADER_MAGIC 0x4dfc3ae5
> > 
> > How was this magic chosen?
> 
> It's a random number. Maybe should I chose a meaningful magic?

That's fine; just add a comment to say so.

> >> + * @dirty:
> >> + *	mark whether the data in @buffer are dirty (not flush to storage yet)
> >> + */
> > 
> > Thank you for the kerndoc! :) Is it linked to from any .rst files?
> > 
> 
> I don't get your words. There is a document on the 6th patch. I don't know
> whether it is what you want?

Patch 6 is excellent; I think you might want to add references back to
these kern-doc structures using the ".. kernel-doc::
fs/pstore/blkzone.c" syntax:
https://www.kernel.org/doc/html/latest/doc-guide/kernel-doc.html#including-kernel-doc-comments

> >> +static int blkz_zone_write(struct blkz_zone *zone,
> >> +		enum blkz_flush_mode flush_mode, const char *buf,
> >> +		size_t len, unsigned long off)
> >> +{
> >> +	struct blkz_info *info = blkz_cxt.bzinfo;
> >> +	ssize_t wcnt = 0;
> >> +	ssize_t (*writeop)(const char *buf, size_t bytes, loff_t pos);
> >> +	size_t wlen;
> >> +
> >> +	if (off > zone->buffer_size)
> >> +		return -EINVAL;
> >> +	wlen = min_t(size_t, len, zone->buffer_size - off);
> >> +	if (buf && wlen) {
> >> +		memcpy(zone->buffer->data + off, buf, wlen);
> >> +		atomic_set(&zone->buffer->datalen, wlen + off);
> >> +	}
> > 
> > If you're expecting concurrent writers (use of atomic_set(), I would
> > expect the whole write to be locked instead. (i.e. what happens if
> > multiple callers call blkz_zone_write()?)
> > 
> 
> I don't agree with it. The datalen will be updated everywhere. It's useless
> to lock here.

But there could be multiple writers; locking should be needed.

> One more things. During the analysis, I found another problem.
> Removing old files will cause new logs to be lost. Take console recorder as
> am example. After new rebooting, new logs are saved to buf while old
> logs are
> saved to old_buf. If we remove old file at that time, not only old_buf
> is freed, but
> also length of buf for new data is reset to zero. The ramoops may also
> has this
> problem.

Hmm. I'll need to double-check this. It's possible the call to
persistent_ram_zap() in ramoops_pstore_erase() is not needed.

> >> +static int blkz_recover_dmesg_data(struct blkz_context *cxt)
> > 
> > What does "recover" mean in this context? Is this "read from storage"?
> 
> Yes. "recover" means reading data back from storage.

Okay. Please add some comments here. I would think of it more as "read"
or "load". When I think of "recover" I think of "finding something that
was lost". But the name isn't important as long as there is a comment
somewhere about what it's doing.

-Kees

-- 
Kees Cook
