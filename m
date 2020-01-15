Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9149C33CB2
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 16:42:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 814372081E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 16:42:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="dxK79Nck"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729080AbgAOQmC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 11:42:02 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:36307 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726483AbgAOQmB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 11:42:01 -0500
Received: by mail-pj1-f68.google.com with SMTP id n59so183402pjb.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jan 2020 08:42:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=V2uWqO7PQFpi/zdSVofh092jxm4FAhmJjQJPAhbVzhM=;
        b=dxK79Nck5Z1AUWDmVeAZ6wPqOrbTaXF13wjUbMrN3MEZeuMjXwYyUsJXQ2Um+Abf+T
         iHtKJeAW9g/zI4qGYpzqyvsZkyJ7Uke6dmg07EDswHlkioYwbfYAHXBHwinjW4WJZq7O
         9NzrGG5JwSk6acoypINPTR/I09dvd5g2CyDKZDwUsMKdz1uD12RcM3VrtrhBu+Md+oW+
         UFsYdcCxvg+Cd5f98epqIw+uCYd1ok7c3J3Xg3c5ezsTwqxmBYR/r+a06oS1dALdIo7x
         WGcybwGGUUYxCOEs/sAPa4yixmXeTJJdpOj0OwrevZ1B2HiqjaZoYo3vAGU740TI18vb
         dJww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=V2uWqO7PQFpi/zdSVofh092jxm4FAhmJjQJPAhbVzhM=;
        b=JdNJav1I1A8CII7EByv9v538sc99eRwjggKVKC8m5JF63EgJRSPCd/wtx9I4R+Ue1g
         7eOOeda1Pa0wipkCZ7x4wY2IIoC0Wg9SSBxd2++7UKI+6swTFhta+XRIpnGKvpR7nZvR
         IutBWX64+Bf9BZ+rqA0smZhbE+Cxpj1vbE0B+OoKCs80uP8UkVRUhbnZ6jteJYItQzA9
         wxBuh5xAhEfVqj6lpWjbQLMuNXWGuW8IeG2wOGVeqjhSH50hhsVKFzgxq4ZlhwB+ONBA
         dNXY/jmnwp1j5XzxWqzoDXhN3+p9H/3qYsGvufxl2qG9bbCOG1MhInpwbqjknDjjMv25
         cgHQ==
X-Gm-Message-State: APjAAAUjxt0WM17neUqH1xcHaFfKAGQRZbugqi82iMwSXb0rvYJqQ3VM
        +dTseF45X9/C5EHkaZmiRntcgg==
X-Google-Smtp-Source: APXvYqwEUltaJGoxxUqBqGekg1fUtPf73MYWL11rqoSEPatWa4/mPEkQP/d1QMfUH39UIEN7TqcPlg==
X-Received: by 2002:a17:90b:3cc:: with SMTP id go12mr752934pjb.89.1579106520273;
        Wed, 15 Jan 2020 08:42:00 -0800 (PST)
Received: from ?IPv6:2620:10d:c081:1132::1049? ([2620:10d:c090:180::4bca])
        by smtp.gmail.com with ESMTPSA id d3sm21833134pfn.113.2020.01.15.08.41.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jan 2020 08:41:59 -0800 (PST)
Subject: Re: [PATCH] io_uring: fix compat for IORING_REGISTER_FILES_UPDATE
To:     Eugene Syromiatnikov <esyr@redhat.com>,
        linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-kernel@vger.kernel.org, Jeff Moyer <jmoyer@redhat.com>,
        "Dmitry V. Levin" <ldv@altlinux.org>
References: <20200115163538.GA13732@asgard.redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <cce5ac48-641d-3051-d22c-dab7aaa5704c@kernel.dk>
Date:   Wed, 15 Jan 2020 09:41:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200115163538.GA13732@asgard.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/15/20 9:35 AM, Eugene Syromiatnikov wrote:
> fds field of struct io_uring_files_update is problematic with regards
> to compat user space, as pointer size is different in 32-bit, 32-on-64-bit,
> and 64-bit user space.  In order to avoid custom handling of compat in
> the syscall implementation, make fds __u64 and use u64_to_user_ptr in
> order to retrieve it.  Also, align the field naturally and check that
> no garbage is passed there.

Good point, it's an s32 pointer so won't align nicely. But how about
just having it be:

struct io_uring_files_update {
	__u32 offset;
	__u32 resv;
	__s32 *fds;
};

which should align nicely on both 32 and 64-bit?

-- 
Jens Axboe

