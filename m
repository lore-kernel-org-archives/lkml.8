Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97E7EC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 16:09:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D9452071A
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 16:09:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Rkw9rZaV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732967AbgFPQJl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 12:09:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732839AbgFPQJc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 12:09:32 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D1E0C0613EE
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 09:09:32 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id b201so9737555pfb.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 09:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=Qr6LU5AJyvXIew1juXMAoqiI4cF7kmvmZdA39adClnc=;
        b=Rkw9rZaVLXXtIQ0m20+mYgJQ4gcuayp8YvWp0pVNnyS2Ud5bvdUdx69IRXMW08dI+y
         pzV/H7bWfkwsJ9crKNCDPM1q0WUffbNtBokPP+PZDWzzEdUIZWHq9M86Wqe0z1bOibJL
         0kj7zDc/gs1pT2s4SL4bLi137RE65s/ZSVNpo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Qr6LU5AJyvXIew1juXMAoqiI4cF7kmvmZdA39adClnc=;
        b=I4H/sc//ZKvrG2obVO9D9PbDcSYrsVWUapTeRh5hqU/Itx1jJF6q7BlMB2/AtOZOBr
         sYOzQxdaHyIWsmhAQ4d+5eQSxDtaRr6HpfdkKRQYg0t6UJcZJnfo6Gq2gbgb5TR/bezP
         dBSph09Hd2ZKBBnGY5e9qNBpKPxKylw2Znfu11DeG8U+hOfQxKUA/ylNZFn5T66yZ4DJ
         G1k6JLqfXxin5lm9O3dYd3hNsV2r/0tCggMNop7R5JMvBYzmN+5dJQbSY2dg/AxHNLB5
         RnhQuP/uqIu/dvkoQgTKw9QB3UhUbyxGyBE9Zfhr22baAETPuevkTSqlZnStnQyxnnRJ
         1ATA==
X-Gm-Message-State: AOAM531AukYqid84b/dPQITRprMPYKx6WNsRSAkvQby2sRrexUYo7ufH
        I+pfJ0odZEgiBlWBXzmNHPaUYA==
X-Google-Smtp-Source: ABdhPJw0IGP4wrEgB7iuDlwGXE4MMae76XZ2NoGZ/467ZGcMrf6sY2DenPwGzgjt24xH+kDh+E9WqA==
X-Received: by 2002:a62:9242:: with SMTP id o63mr2821188pfd.310.1592323771469;
        Tue, 16 Jun 2020 09:09:31 -0700 (PDT)
Received: from [10.136.13.65] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id p8sm14999992pgs.29.2020.06.16.09.09.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jun 2020 09:09:30 -0700 (PDT)
Subject: Re: [PATCH v9 1/8] fs: introduce kernel_pread_file* support
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Wolfram Sang <wsa@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Brown <david.brown@linaro.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Shuah Khan <shuah@kernel.org>, bjorn.andersson@linaro.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Mimi Zohar <zohar@linux.ibm.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Olof Johansson <olof@lixom.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Colin Ian King <colin.king@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        Takashi Iwai <tiwai@suse.de>, linux-kselftest@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
References: <20200615194151.7011-1-scott.branden@broadcom.com>
 <20200615194151.7011-2-scott.branden@broadcom.com>
 <20200616073423.GC30385@infradead.org>
From:   Scott Branden <scott.branden@broadcom.com>
Message-ID: <b89a3f0f-51b9-7705-3a23-26196ae7716e@broadcom.com>
Date:   Tue, 16 Jun 2020 09:09:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200616073423.GC30385@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

On 2020-06-16 12:34 a.m., Christoph Hellwig wrote:
> Seriously, no more additions to fs.h for this interface please.  As
> requested before as the very first thing move it out of this header
> used by just about every file in the kernel.  That is in addition
> to all the other issues with the interface.
I can add such to the start of this patch series. I'm guessing from:
#define __kernel_read_file_id(id) \
to
extern int kernel_read_file_from_fd(int, void **, loff_t *, loff_t,
                     enum kernel_read_file_id);


