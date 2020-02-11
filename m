Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1561C3B186
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 07:51:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6111206CC
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 07:51:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DYimQr9D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727652AbgBKHvt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 02:51:49 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:42412 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727384AbgBKHvs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 02:51:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581407507;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1xwr64UV9VKg+sHvBjEA7Eu36dUv9exVUomu8ZIrlE0=;
        b=DYimQr9Db0Q72sUy2LtSF8kt5XZyWf3nNuHNENtUWSKANMkgSc94JcamHabhunlJ64eVZD
        vjFgOSMoTgbKyo1MqJtGibQJRYoGdcmVfsm6ILzAWIqDPzfhvShv+iaUeQtqrPGOj2Kn5F
        1Rdf43wgneL3LFjP1PF8KjpY9BBc4ME=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-178-p8hRxa60Pz2c7ZvQleE9Mw-1; Tue, 11 Feb 2020 02:51:44 -0500
X-MC-Unique: p8hRxa60Pz2c7ZvQleE9Mw-1
Received: by mail-wr1-f70.google.com with SMTP id o9so5850726wrw.14
        for <linux-kernel@vger.kernel.org>; Mon, 10 Feb 2020 23:51:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1xwr64UV9VKg+sHvBjEA7Eu36dUv9exVUomu8ZIrlE0=;
        b=kn1UM7zAHEZXRQYXXTsw0GJNSfVqfOSEgkwn+bIt8cAfZ7rPWSbnHJl8XB5U7LEkCw
         /HeEg2T0i/xmEfDgBEnW3qVkB7iUvYNUayynzK5+ycak0m65gDkd39+SBU6+vmDzzMGF
         J95R2ZkYye6WgMImX3J96AvjnSyTxgup2sHZ5cmDsBjqFCr3/t7v45y/zypn5ZrXzcIE
         LrMgOuxl659HV4G0/U1dWZ06+fNK9FTviqaD4joJV5R3oM7iAkIjjSXfPQ8FWTVDOXxk
         7wmjzTHnrVuSt1/VfURE1ZbnUiXSr2SteDC0qC5ogCQ3iEUsJJ96QBJYU3UudRZaJvjJ
         0IYg==
X-Gm-Message-State: APjAAAVadtWxDmymd62GcN+9xeaiug8/rSfvq3L6tbsLESvpZxPRzh9c
        KBYXxXFeXzAVt+nxihaLyUXxyX6lWaTDXOa1Sq4u0FgXX6vqrf+G3gNJtj7rJVNqHNi0jPU1Hbb
        rDwha5TJjdkIvPjrQHifFJqHW
X-Received: by 2002:a05:600c:2c08:: with SMTP id q8mr4116355wmg.45.1581407503169;
        Mon, 10 Feb 2020 23:51:43 -0800 (PST)
X-Google-Smtp-Source: APXvYqzeYTtG62q8lqll9oayqUmeeOuFpXPsABW/C1+dPJ8MoqbRSYCxcFNkydl/JRlNYzQLPD1V5A==
X-Received: by 2002:a05:600c:2c08:: with SMTP id q8mr4116311wmg.45.1581407502685;
        Mon, 10 Feb 2020 23:51:42 -0800 (PST)
Received: from ?IPv6:2a01:cb14:58d:8400:ecf6:58e2:9c06:a308? ([2a01:cb14:58d:8400:ecf6:58e2:9c06:a308])
        by smtp.gmail.com with ESMTPSA id g15sm4216078wro.65.2020.02.10.23.51.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Feb 2020 23:51:41 -0800 (PST)
Subject: Re: [PATCH 1/3] objtool: Fail the kernel build on fatal errors
To:     Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, Borislav Petkov <bp@suse.de>,
        Peter Zijlstra <peterz@infradead.org>
References: <cover.1581359535.git.jpoimboe@redhat.com>
 <f18c3743de0fef673d49dd35760f26bdef7f6fc3.1581359535.git.jpoimboe@redhat.com>
From:   Julien Thierry <jthierry@redhat.com>
Message-ID: <efa81d0d-5e26-a3e4-a8d5-ec0d3f6499ee@redhat.com>
Date:   Tue, 11 Feb 2020 07:51:40 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <f18c3743de0fef673d49dd35760f26bdef7f6fc3.1581359535.git.jpoimboe@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/10/20 6:32 PM, Josh Poimboeuf wrote:
> When objtool encounters a fatal error, it usually means the binary is
> corrupt or otherwise broken in some way.  Up until now, such errors were
> just treated as warnings which didn't fail the kernel build.
> 
> However, objtool is now stable enough that if a fatal error is
> discovered, it most likely means something is seriously wrong and it
> should fail the kernel build.
> 
> Note that this doesn't apply to "normal" objtool warnings; only fatal
> ones.
> 
> Suggested-by: Borislav Petkov <bp@suse.de>
> Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>

Reviewed-by: Julien Thierry <jthierry@redhat.com>

> ---
>   tools/objtool/check.c | 12 +++++++++---
>   1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/objtool/check.c b/tools/objtool/check.c
> index b6da413bcbd6..61d2d1877fd2 100644
> --- a/tools/objtool/check.c
> +++ b/tools/objtool/check.c
> @@ -2509,8 +2509,14 @@ int check(const char *_objname, bool orc)
>   out:
>   	cleanup(&file);
>   
> -	/* ignore warnings for now until we get all the code cleaned up */
> -	if (ret || warnings)
> -		return 0;
> +	if (ret < 0) {
> +		/*
> +		 *  Fatal error.  The binary is corrupt or otherwise broken in
> +		 *  some way, or objtool itself is broken.  Fail the kernel
> +		 *  build.
> +		 */
> +		return ret;
> +	}
> +
>   	return 0;
>   }
> 

-- 
Julien Thierry

