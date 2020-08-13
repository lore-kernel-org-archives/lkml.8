Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43775C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 08:48:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13D8020771
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 08:48:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axtens.net header.i=@axtens.net header.b="R0EO8jRc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726568AbgHMIs3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 04:48:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726082AbgHMIs1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 04:48:27 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFE42C061757
        for <linux-kernel@vger.kernel.org>; Thu, 13 Aug 2020 01:48:27 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id u128so2471429pfb.6
        for <linux-kernel@vger.kernel.org>; Thu, 13 Aug 2020 01:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=tQ+XJ86Q75z7YMaMgzrVYfwbmUJG1wIysexAed3omC4=;
        b=R0EO8jRcC3b+HX/0l95QKw8su+E0KG2JmljzjyRkm3AY86mnG11Aj1wi053m12GdNk
         ilxSrERwKMSWBcEXaRo2P/VGtoy00QPIPiD2jln5gmu8TbKfAOVzl8OhoKUDjL3I50cF
         L4AI7veL3ihxcTrgIk861Er16COfz4Azj9IZs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=tQ+XJ86Q75z7YMaMgzrVYfwbmUJG1wIysexAed3omC4=;
        b=tM+1Yx8cdrNO92Pz6eInnj5g0RhV+f/jKhDZY+nWwM59h0EhVg+Vq8pp88Wlc5f/ht
         S1Fn6JNjDg/yfep6iT3cynCBhDlRickiXh6PlWM9gAh/KbT5hpAqWudKlqlzws55J8Hr
         XTPmM+B2qDbAvSHgwMcErEIT2eEsc1E+M8st4/eKwR1eRYVBMDgedke2HASugLMvz9qV
         vU767aCmbC1XB2CYp3vS+bZYy6Qfd0QlCzVlRSUCJDgn+JhgP8KTIg8b3x9RQDfG6lq6
         qYQvYBLn4cqAA8RCowZUffClJfNoPy7Zxt9z2zPhWPblLqKnyYStrdlVWYdIy0AfBc2s
         rCAg==
X-Gm-Message-State: AOAM533kRe66mZZBg3lY+uThw9wbohPY8BuYlWkdDhLaaLf3J1r6cHBA
        ukLIa62DauDtOiEGVpAo9/nMHw==
X-Google-Smtp-Source: ABdhPJwn00mgylH0fW+1CfjtqqDDYplaEK62eGDUC3ycdST3x9u88Bsm2CX7lGAsQu0GIJ2jmrxJJw==
X-Received: by 2002:a62:7785:: with SMTP id s127mr3256200pfc.196.1597308507353;
        Thu, 13 Aug 2020 01:48:27 -0700 (PDT)
Received: from localhost (2001-44b8-1113-6700-b095-181e-17b3-2e29.static.ipv6.internode.on.net. [2001:44b8:1113:6700:b095:181e:17b3:2e29])
        by smtp.gmail.com with ESMTPSA id s6sm4469130pjn.48.2020.08.13.01.48.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2020 01:48:26 -0700 (PDT)
From:   Daniel Axtens <dja@axtens.net>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs/select.c: batch user writes in do_sys_poll
In-Reply-To: <20200813073220.GB15436@infradead.org>
References: <20200813071120.2113039-1-dja@axtens.net> <20200813073220.GB15436@infradead.org>
Date:   Thu, 13 Aug 2020 18:48:18 +1000
Message-ID: <87zh6zlynh.fsf@dja-thinkpad.axtens.net>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@infradead.org> writes:

> On Thu, Aug 13, 2020 at 05:11:20PM +1000, Daniel Axtens wrote:
>> When returning results to userspace, do_sys_poll repeatedly calls
>> put_user() - once per fd that it's watching.
>> 
>> This means that on architectures that support some form of
>> kernel-to-userspace access protection, we end up enabling and disabling
>> access once for each file descripter we're watching. This is inefficent
>> and we can improve things by batching the accesses together.
>> 
>> To make sure there's not too much happening in the window when user
>> accesses are permitted, we don't walk the linked list with accesses on.
>> This leads to some slightly messy code in the loop, unfortunately.
>> 
>> Unscientific benchmarking with the poll2_threads microbenchmark from
>> will-it-scale, run as `./poll2_threads -t 1 -s 15`:
>> 
>>  - Bare-metal Power9 with KUAP: ~48.8% speed-up
>>  - VM on amd64 laptop with SMAP: ~25.5% speed-up
>> 
>> Signed-off-by: Daniel Axtens <dja@axtens.net>
>
> Seem like this could simply use a copy_to_user to further simplify
> things?

I'll benchmark it and find out.

> Also please don't pointlessly add overly long lines.

Weird, I ran the commit through checkpatch and it didn't pick it
up. I'll check the next version more carefully.

Regards,
Daniel
