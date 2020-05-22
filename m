Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37E59C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 22:00:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11EE42068D
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 22:00:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="XLH11UJO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731133AbgEVWAM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 18:00:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731074AbgEVWAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 18:00:09 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77806C08C5C0
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 15:00:09 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id a13so4953489pls.8
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 15:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=+R2PmX2GuncA9li2cFF1oFkmpDyEHWXLGTSivDcpNJU=;
        b=XLH11UJOh/L9Rl5FkPR5BqxDsMzqlH+S7zE1uz0zGHDAtRCNTICnmgbYz/8nUUylNr
         LKqrpsPFT8+TgcTkRKhMVk34mTmI9RwD22c6+fXPQHWZ1iSxtEw8y9DHhEgsEZdckCAr
         BWw6ztHmgIuOU5I8xXQeY+urp4ky/qUrwdq/k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=+R2PmX2GuncA9li2cFF1oFkmpDyEHWXLGTSivDcpNJU=;
        b=QPKRhwwzA6J3oyVzfDS/mLmSBh8KYWkjpzbYTZwvWT0OTieIAJ5EHXFUgdyhfCxZKF
         IDRtrRSNZdhsSUcm2SK6WHXOUGSiYlUj/F1IJTNA8V7jfFg5DXXk+YIKNfDKhj+KFYsu
         CTK98E7l1FftuPfebUE5b4PWoO+FBEv+gR9u/KQPaQAlJt5fcCMxdGbuMuUfakyMN4m8
         q9YFeCijUI8mj988FJhsxAMxN0E9cqe++E7rHxZD/9XDN9lCCgEH4G4VEg+zfA4qk1Mc
         QIgFnSQkLtyDTGz+e0bdamjadtOKPDwTqTkJrblI2Rqjd50SEMNcpuAq5BLsOrJOKoCR
         sf+Q==
X-Gm-Message-State: AOAM531x2bKjYusv9PrArxtJmEoxJc8RONMiqjhMZ7WZx1vdSmKFUKHP
        NChTf71UBiQqUhFyEwU1xKoY80o4PplKKE+q/4sGFTbCSaIf+N45ZBLkM1r8fA7ue25IYCxdW3a
        zyOkdYyPj/3n3ZKUCJoFGRGH7KFWnSgt3R/y2rMW/onWLG0UxTfaMTAzw7X27Ij/m5f5EKGBwnB
        SkdEzleePz
X-Google-Smtp-Source: ABdhPJyAnUWjr21DTPYYoWeHjtEjEM/8f/D8/pBMaUUC/JONxInxo1KkaZn4ABnAVkw7vlhk3x4i+A==
X-Received: by 2002:a17:90a:da05:: with SMTP id e5mr7216725pjv.140.1590184808410;
        Fri, 22 May 2020 15:00:08 -0700 (PDT)
Received: from [10.136.13.65] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id q12sm6752584pfn.129.2020.05.22.15.00.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 May 2020 15:00:07 -0700 (PDT)
Subject: Re: [PATCH v2 2/2] fs: avoid fdput() after failed fdget() in
 kernel_read_file_from_fd()
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        Jens Axboe <axboe@kernel.dk>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <cover.1589311577.git.skhan@linuxfoundation.org>
 <1159d74f88d100521c568037327ebc8ec7ffc6ef.1589311577.git.skhan@linuxfoundation.org>
 <20200513054950.GT23230@ZenIV.linux.org.uk>
 <20200513131335.GN11244@42.do-not-panic.com>
 <CAB=NE6WdYcURTxNLngMk3+JQfNHG2MX1oE_Mv08G5zcw=mPOyw@mail.gmail.com>
From:   Scott Branden <scott.branden@broadcom.com>
Message-ID: <2d298b41-ab6f-5834-19d2-7d3739470b5f@broadcom.com>
Date:   Fri, 22 May 2020 14:59:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAB=NE6WdYcURTxNLngMk3+JQfNHG2MX1oE_Mv08G5zcw=mPOyw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Luis,

On 2020-05-13 7:19 a.m., Luis Chamberlain wrote:
> On Wed, May 13, 2020 at 7:13 AM Luis Chamberlain <mcgrof@kernel.org> wrote:
>> On Wed, May 13, 2020 at 06:49:50AM +0100, Al Viro wrote:
>>> On Tue, May 12, 2020 at 01:43:05PM -0600, Shuah Khan wrote:
>>>> diff --git a/fs/exec.c b/fs/exec.c
>>>> index 06b4c550af5d..ea24bdce939d 100644
>>>> --- a/fs/exec.c
>>>> +++ b/fs/exec.c
>>>> @@ -1021,8 +1021,8 @@ int kernel_read_file_from_fd(int fd, void **buf, loff_t *size, loff_t max_size,
>>>>              goto out;
>>>>
>>>>      ret = kernel_read_file(f.file, buf, size, max_size, id);
>>>> -out:
>>>>      fdput(f);
>>>> +out:
>>>>      return ret;
>>> Incidentally, why is that thing exported?
>> Both kernel_read_file_from_fd() and kernel_read_file() are exported
>> because they have users, however kernel_read_file() only has security
>> stuff as a user. Do we want to get rid of the lsm hook for it?
> Alright, yeah just the export needs to be removed. I have a patch
> series dealing with these callers so will add it to my queue.
When will these changes make it into linux-next?
It is difficult for me to complete my patch series without these other 
misc. changes in place.
>
>    Luis
Regards,
  Scott
