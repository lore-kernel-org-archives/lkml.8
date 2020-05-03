Return-Path: <SRS0=5Fkd=6R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5623C4724C
	for <linux-kernel@archiver.kernel.org>; Sun,  3 May 2020 14:42:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C62A32071C
	for <linux-kernel@archiver.kernel.org>; Sun,  3 May 2020 14:42:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="UBw2EFYa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728718AbgECOmp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 May 2020 10:42:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728696AbgECOmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 May 2020 10:42:44 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3487C061A0F
        for <linux-kernel@vger.kernel.org>; Sun,  3 May 2020 07:42:43 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id d22so2088172pgk.3
        for <linux-kernel@vger.kernel.org>; Sun, 03 May 2020 07:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=x1J8xB3qB59FMBKk1E4mDFgX9EdfMYR5lTCP5KpiWfY=;
        b=UBw2EFYaFAKSOg6WT8kyyUN8c69DWsx+7vfxkrdzLzimHytVrnzz0gcAYXvHOHWv2R
         xkJ1zy10RX4Ka+Y5VyR/AEZOzRDqqL2av9uWZrj99vJVIgOmMwap4RAH2uuRGtL3/27D
         bKPcH+dCkZGtbiMJXlZB6MNikIl2Gw4s/aMSIR5fJu71Ch4yx8HsY2Th3g0AIHhU+4Uo
         +x0dwu/D4DbsqCQte+khi3Lz0g+QXRN6/g4wPeSQFp6oYy2FexgWJYuGe2sPpakYviFf
         7qLAkvKynHIUMi6AqSygJeXUmpdwGLre7bMgYv6eTkYePurOIOgDgx2pybpL5cl6HuJO
         Lq6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=x1J8xB3qB59FMBKk1E4mDFgX9EdfMYR5lTCP5KpiWfY=;
        b=tNhw1wv5gPptqMY+k9jxcXozM/uoZ1v/cynNivg//yDllUbgb2URlO6AWiv2tpNtcY
         jiEHf2XQ3VCAB4nF7KFq/fBDsnSz3l7FG3dGyTeaym1EhaWrZDey5slaCgm0KxAVOyGJ
         +VuifJSCKG9ywp8whQFgC6qwzHdIrF6bHqGFcp8msUZirzf7Wb2YAxfMpQaCkOzfmvhW
         iZRdIqag1Sm2Aw2T2oltvhrPMuObJyMCZqcGxOKhfJvo+yshIz74p2OrtscFmTnvyAlh
         uw4L/drK0MOVzf0w+7ty8BFNFO+7u68y2cf8718Iu1vXY8nwDUfUoO1PW+MhyBi8d2k5
         ktQw==
X-Gm-Message-State: AGi0PuZCQCpfdIT0MINPEqLO20Xez3QxLq9TyfOQIIVET2s7X9WFCFoA
        mgk4SzaUdxpEoniRzqp6D2oj+4vP4m6TYQ==
X-Google-Smtp-Source: APiQypI8R2hl8PnGCRsD3CcgaSWObue96Us/o1aM8g/gvpKTPm10UEvRGg962xdwRA/a9IxxU3gi8g==
X-Received: by 2002:a65:4b8d:: with SMTP id t13mr12223136pgq.388.1588516963069;
        Sun, 03 May 2020 07:42:43 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id p189sm6794303pfp.135.2020.05.03.07.42.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 May 2020 07:42:42 -0700 (PDT)
Subject: Re: [PATCH v4] eventfd: convert to f_op->read_iter()
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <6b29f015-bd7c-0601-cf94-2c077285b933@kernel.dk>
 <20200501231231.GR23230@ZenIV.linux.org.uk>
 <03867cf3-d5e7-cc29-37d2-1a417a58af45@kernel.dk>
 <20200503134622.GS23230@ZenIV.linux.org.uk>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <435c171c-37aa-8f7d-c506-d1e8f07f4bc7@kernel.dk>
Date:   Sun, 3 May 2020 08:42:41 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200503134622.GS23230@ZenIV.linux.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/3/20 7:46 AM, Al Viro wrote:
> On Fri, May 01, 2020 at 05:54:09PM -0600, Jens Axboe wrote:
>> On 5/1/20 5:12 PM, Al Viro wrote:
>>> On Fri, May 01, 2020 at 01:11:09PM -0600, Jens Axboe wrote:
>>>> +	flags &= EFD_SHARED_FCNTL_FLAGS;
>>>> +	flags |= O_RDWR;
>>>> +	fd = get_unused_fd_flags(flags);
>>>>  	if (fd < 0)
>>>> -		eventfd_free_ctx(ctx);
>>>> +		goto err;
>>>> +
>>>> +	file = anon_inode_getfile("[eventfd]", &eventfd_fops, ctx, flags);
>>>> +	if (IS_ERR(file)) {
>>>> +		put_unused_fd(fd);
>>>> +		fd = PTR_ERR(file);
>>>> +		goto err;
>>>> +	}
>>>>  
>>>> +	file->f_mode |= FMODE_NOWAIT;
>>>> +	fd_install(fd, file);
>>>> +	return fd;
>>>> +err:
>>>> +	eventfd_free_ctx(ctx);
>>>>  	return fd;
>>>>  }
>>>
>>> Looks sane...  I can take it via vfs.git, or leave it for you if you
>>> have other stuff in the same area...
>>
>> Would be great if you can queue it up in vfs.git, thanks! Don't have
>> anything else that'd conflict with this.
> 
> Applied; BTW, what happens if
>         ctx->id = ida_simple_get(&eventfd_ida, 0, 0, GFP_KERNEL);
> fails?  Quitely succeed with BS value (-ENOSPC/-ENOMEM) shown by
> eventfd_show_fdinfo()?

Huh yeah that's odd, not sure how I missed that when touching code
near it. Want a followup patch to fix that issue?

-- 
Jens Axboe

