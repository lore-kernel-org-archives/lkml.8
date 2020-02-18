Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59A84C34026
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 18:40:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32BEA24125
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 18:40:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XhDjabUD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbgBRSkd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 13:40:33 -0500
Received: from mail-yw1-f68.google.com ([209.85.161.68]:39575 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726333AbgBRSkd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 13:40:33 -0500
Received: by mail-yw1-f68.google.com with SMTP id h126so9845099ywc.6
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 10:40:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9jZ5yWoaicfmGExgrAkNkbKcks0bHnu5AVQQLZuqwII=;
        b=XhDjabUDEUe8VC3gAy53xtbp5w/d0/4LQrPDSO5xphlcflwkRF7WDbSyvRYY+OZcsj
         VUycx3AWRgY5hEdyGk1X/7OG8eCH5VAtgh9HR/tak1UoJYm7VEwF/NByNTZjCYN1GCbB
         ksPa7tDDuv3QwHIaWV6K+hM2Tixxa/zXjjrGW0Zd15JYWV1PYEs6Kg+UxAkCoygRh5t9
         qPfsh9Nl0EcvB9a3BixgzbfehcM/rhIMVeqzZZN3giOp2JmqrdlHkyQwsVNxRJWk49Hj
         SV3A5F5vI4btdgTEZM+Q4wmhL+HCDOKvr9/Kk145vW3Y2e5QWP9jp56vv6L2dLp7mefl
         ScRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9jZ5yWoaicfmGExgrAkNkbKcks0bHnu5AVQQLZuqwII=;
        b=c+UGEv1ksgPpAtYoIEbnMx4ZZfkchXwFI2mM3Lrv33EN6enC9j+SwJWq1hfXW9aJ63
         RUcQihiwBaHse4SVKreaImmLSaHAUSJL89ly4qqjiWrmjA6/3o/oEjIxJirW5HM8ae0+
         1jMssokQzdAhMf2pgUgJ8XkxztIK/3+FWWEN0Bbe9wFY2KtDJoNMG51lCOJpRDft9754
         CQ9TSKrrZ8OSmiymeMA6XudUG4Fk+4DFjnnCY/a2f21wOcFX7Fo5Dm3XW1bEJ7sqvp76
         Ud1Cuos6UvwEQx64qyU7LVoDACfDuh7lKLAAsI3iOncMZNGa93ceMO4l3EY0MwLJe4am
         Nq8Q==
X-Gm-Message-State: APjAAAVDsEHyyKFppfQHAOUrG5VzgJpsMJf3SDxGwCPhrpruXkTxzNF3
        ppd5keIBRYfskHPpLC/We1I=
X-Google-Smtp-Source: APXvYqy0zWwsFCGehkM8xLQ+AQLpo76Cq17gBqATF/hbY7BC3G5kB4ppNDRcpfyh0/JWt8m9UdwHgg==
X-Received: by 2002:a81:7145:: with SMTP id m66mr17930368ywc.458.1582051232179;
        Tue, 18 Feb 2020 10:40:32 -0800 (PST)
Received: from [192.168.1.46] (c-73-88-245-53.hsd1.tn.comcast.net. [73.88.245.53])
        by smtp.gmail.com with ESMTPSA id s68sm2012903ywg.69.2020.02.18.10.40.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Feb 2020 10:40:31 -0800 (PST)
Subject: Re: [PATCH] COPYING: state that all contributions really are covered
 by this file
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>
References: <20200206154800.GA3754085@kroah.com>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <b3dbaeaf-0960-1b76-e2a7-7f45962ffdd2@gmail.com>
Date:   Tue, 18 Feb 2020 12:40:31 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200206154800.GA3754085@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/6/20 9:48 AM, Greg Kroah-Hartman wrote:
> Explicitly state that all contributions to the kernel source tree
> really are covered under this COPYING file in case someone thought
> otherwise.  Lawyers love to be pedantic, even more so than software
> engineers at times, and this sentence makes them sleep easier.
> 
> Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  COPYING | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/COPYING b/COPYING
> index da4cb28febe6..a635a38ef940 100644
> --- a/COPYING
> +++ b/COPYING
> @@ -16,3 +16,5 @@ In addition, other licenses may also apply. Please see:
>  	Documentation/process/license-rules.rst
>  
>  for more details.
> +
> +All contributions to the Linux Kernel are subject to this COPYING file.
> 

Reviewed-by: Frank Rowand <frowand.list@gmail.com>
