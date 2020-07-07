Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56AD6C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 18:39:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 394E020720
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 18:39:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="HR0L6o45"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728665AbgGGSjc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 14:39:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728318AbgGGSjb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 14:39:31 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56037C08C5DC
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 11:39:31 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id o3so19510288ilo.12
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 11:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5xeeSJNl89hdKNZc1p2IwCwGKPk4JGxYiYMtbRQmKxI=;
        b=HR0L6o45VkMPdZEhOiGtgwb0XyoPs1smLQhWsbJoJFM3270Dny+fsvO465OMms0KLl
         cQkrkK2q6o6bnFjMkNwLcvhlO0Hm0ylhjSyQG8eGo44G83CAvKjF5PxmQS2HnI75yPPq
         weVjhbIk7cUu7LM7sH5fIMJPy1/GVyMt+EuIKx3EMB7/VNGeOddk4itL0OYuHjzAWBfn
         zHgXKV6M0ChVIhJB6K8gAqOjuxPxFa1TJfs4kpUDiYgPnhWdWLZyXIYGe6TjiWpJz2XB
         OhcIYCsc2GYpQD/2zTI8sOCbvSuzPMgBmqPKyQ9MwYBdB2EPrMzpPitk++G4wT9utrVB
         cnyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5xeeSJNl89hdKNZc1p2IwCwGKPk4JGxYiYMtbRQmKxI=;
        b=rIHNGydj7XLkbqcJibffv8CT4jgHTuHyXrm2sU3WR0AZAPLNehzJrsA5nJ/EmUb+9o
         lDAIFCskzPEf3+Mr5YA+HwPqjaR+PfAm0v11xXADOzgxt6EdsT8e4WJdtM/SV1Z70lZx
         QgP+vBpyqQ4mAT0c94b1KqV3z0adBIP1VU+HTedpvMueslN1T6mAg3m+g3b0VnlUAG7m
         T9t2V5kdm9Hejljow/PAi/ci54Kqg/abXdbAdT1zOeSWAAXG8y7V6vxXVaxjH1u/Xzwm
         tED2fUBhLVnbWW5yObJPyK+XLrNSJnHFmNBiMhhx9URIleOwb6Izqb7oXsnV0g5qaFv6
         VMdA==
X-Gm-Message-State: AOAM530TdRFrUJemJT/Um5SRrxsAL7f4/pfnmUxgzuK6SAGxvscjKY1u
        spfixLWXKuJbC5sNMtGBYOMLSks7E8e7yQ==
X-Google-Smtp-Source: ABdhPJzXMYDY68ecmhBSVS35kxyxucMZrFavc7ZlIavGwuXlLW9FHoAZuz7G2RqaKLRDUCHGnuud7w==
X-Received: by 2002:a92:cd01:: with SMTP id z1mr37863825iln.103.1594147170503;
        Tue, 07 Jul 2020 11:39:30 -0700 (PDT)
Received: from [192.168.1.58] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id w5sm13211479ilm.46.2020.07.07.11.39.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jul 2020 11:39:29 -0700 (PDT)
Subject: Re: [RFC v3 1/2] fs: Add IOCB_NOIO flag for generic_file_read_iter
To:     Andreas Gruenbacher <agruenba@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20200707144457.1603400-1-agruenba@redhat.com>
 <20200707144457.1603400-2-agruenba@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <e49c5a2b-866f-14ae-9665-284726815bbd@kernel.dk>
Date:   Tue, 7 Jul 2020 12:39:29 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200707144457.1603400-2-agruenba@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/7/20 8:44 AM, Andreas Gruenbacher wrote:
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 3f881a892ea7..1ab2ea19e883 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -315,6 +315,7 @@ enum rw_hint {
>  #define IOCB_SYNC		(1 << 5)
>  #define IOCB_WRITE		(1 << 6)
>  #define IOCB_NOWAIT		(1 << 7)
> +#define IOCB_NOIO		(1 << 8)

Just to make this even more trivial in terms of merge conflicts, could
you do 1 << 9 instead?

-- 
Jens Axboe

