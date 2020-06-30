Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EB0DC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 23:46:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1625920781
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 23:46:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="fldmVEKk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727819AbgF3Xql (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 19:46:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726828AbgF3Xqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 19:46:38 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 635F4C03E97A
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 16:46:36 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id e22so17916483edq.8
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 16:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=4ut4qu0PwkMI+FHizXNRSNmLt93UoCOy1a8veHSnROM=;
        b=fldmVEKk98jg6orMokPCDgCcRmy6AUwAKBx1BAqCatpdq2mA9mjC5cyIEGtU/4jSMY
         0PeK24RixNKNOlN/FjUCtpIN9z1JaFKOHaFAATvqwbOs5DDahEKImbeUoFohIrG34Jpo
         Rw3FH/WnIfEv0QnAHoqz1dp9h5u1SNOi/fPfI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=4ut4qu0PwkMI+FHizXNRSNmLt93UoCOy1a8veHSnROM=;
        b=RzxXiMoq9uwT6m3IZsCBP5HDazRQWJ6CWsOgFwlxe5nLqolGUHX+7fT76hjcNf6OGr
         fXgfJGZZ9P/FiftYC+NwOfRzNBAQtDAUwE5X8gklLfrYZOvzX4IBvt94yfd9Oq0nxd1a
         k4d/0m/6f7g4xZCi3SlmcP7pFplhnr9b30EJ7PpTiaNOXziH9JiHc6s8B/n6NOz3kUls
         6yyU/EDc05I/7TOK2Y6nhUsKWyFk4oqceimGGEGPuQDgLV6ChhLXuIc+lz7+c90JDLhg
         gpQm0bWMneblACYjUekONxLejs9ZgOkIxN9usLHVZNnxN8psSqT8dS3irVmd50ElFp38
         p+fQ==
X-Gm-Message-State: AOAM530hZEzTsyGWXX9F83yfLZEGFci5siGORz06wpX3pt2paXRiFRY4
        I4ILxkaEoEOgMwt/5ePTsVMreA==
X-Google-Smtp-Source: ABdhPJw7+YsKgwSqrDRw9IXTk7nrj5lLYNZo5jZ+h0dbyRH8xFwM0Yfm9rfF+bJpMYn9Ok+nLMLbKg==
X-Received: by 2002:a50:e14e:: with SMTP id i14mr24736204edl.279.1593560795045;
        Tue, 30 Jun 2020 16:46:35 -0700 (PDT)
Received: from [10.136.13.65] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id lj18sm3159522ejb.43.2020.06.30.16.46.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jun 2020 16:46:34 -0700 (PDT)
Subject: Re: [PATCH v3 1/1] fs: move kernel_read_file* to its own include file
To:     Christoph Hellwig <hch@lst.de>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Eric Biederman <ebiederm@xmission.com>,
        Jessica Yu <jeyu@kernel.org>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        kexec@lists.infradead.org, linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org
References: <20200617161218.18487-1-scott.branden@broadcom.com>
 <20200624075516.GA20553@lst.de>
From:   Scott Branden <scott.branden@broadcom.com>
Message-ID: <a1447797-c6b7-d04a-0661-897845942864@broadcom.com>
Date:   Tue, 30 Jun 2020 16:46:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200624075516.GA20553@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Al (Viro),

Are you able to take this patch into your tree or does someone else?

On 2020-06-24 12:55 a.m., Christoph Hellwig wrote:
> Looks good,
>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

