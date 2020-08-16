Return-Path: <SRS0=yO2T=B2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83563C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Aug 2020 22:27:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D5CE2078D
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Aug 2020 22:27:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="q2WwMNgp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729227AbgHPW1t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Aug 2020 18:27:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726314AbgHPW1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Aug 2020 18:27:47 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C31BC061786
        for <linux-kernel@vger.kernel.org>; Sun, 16 Aug 2020 15:27:47 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id c10so7092659pjn.1
        for <linux-kernel@vger.kernel.org>; Sun, 16 Aug 2020 15:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6Y0aXUk2biw46jG8sHyV+C+5po3p5VP6vf/C5mG6lo8=;
        b=q2WwMNgpn9uMzDmQA3ncY/lKdYUfZdWVVxX01yTY39QrYq8eKY1072xx6Z3280HNQl
         HmX11KJnh8FD1lhUxRdNbwapdH0dNF21IR1q7jgyuFJf2zzYX2t5KRqUkXPC4BMlt8of
         BwIkIgpNF5X01IhGa8TXVGbJoPxw4+7QQpjrqybqYP4k8l8KmxTSOaQaM6rqyIW1IJMT
         EYlatUsNUbz8aQJ9+p8fabw/QQfQuF1gPJIlvxgBfWP4vEKqBMbYsSMi3EFN/uEqlf7C
         LY+nF/2587WG1gtyxtHihdB7UDSQFK1S29yGKm0VDxMQduokAHOMj3YyiBZrhIYDt8Pr
         mTmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6Y0aXUk2biw46jG8sHyV+C+5po3p5VP6vf/C5mG6lo8=;
        b=Nz2z3RghKwp0UudmGIby12i8xdXSFSLl49R1TQfp0dPZ7A9T7hg29zfr4eDsjchlBc
         60RGwWUbn4rvruTos7WQo24iHuxZEKVSB0rJcHM6KsdUev4ocj2yk8GScvOUpSKn6czc
         sT1VEfCNdAauxGO+uUvJgHmhvEhDcQ8WlHPwUJOL3JvJiy30Q13qo+d1X68L05Ap/7C6
         w3O/CJGWfSW0E/E88zPEvDTAZRsaVZgzK8VYLTilF73xwAK3jhGXcl1iwkyqAnmfj8Yc
         i4rtNMGAhB7U8wRA4IK3FLJ7hWT0vN+u+HZ0LHOm0dQ9bnO4Tfp0nQ7Qz6sxnhifumaK
         PXhg==
X-Gm-Message-State: AOAM531bTjH76ygxE7dZTPkf3dxEdI7RGiMHl8yQ2tsBg9yu3GzAooDr
        oEtrOuaz2cTwgFwieovbF11TuQ==
X-Google-Smtp-Source: ABdhPJxYjxxRcA3WlVWUkg7JvhRwxDozSKvh0Ns212XwLPRb04eZ0RJfvTdJ88chO1GTFLbX5wWKuw==
X-Received: by 2002:a17:902:b943:: with SMTP id h3mr8950156pls.286.1597616866999;
        Sun, 16 Aug 2020 15:27:46 -0700 (PDT)
Received: from ?IPv6:2605:e000:100e:8c61:ea1b:63b0:364:3a3b? ([2605:e000:100e:8c61:ea1b:63b0:364:3a3b])
        by smtp.gmail.com with ESMTPSA id s125sm17512507pfc.63.2020.08.16.15.27.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Aug 2020 15:27:46 -0700 (PDT)
Subject: Re: [PATCH] block: blk-mq.c: fix @at_head kernel-doc warning
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@collabora.com>,
        linux-block@vger.kernel.org
References: <20200816222519.313-1-rdunlap@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <df01e29e-a863-bfcd-af79-cfbe7634b92a@kernel.dk>
Date:   Sun, 16 Aug 2020 15:27:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200816222519.313-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/16/20 3:25 PM, Randy Dunlap wrote:
> Fix a new kernel-doc warning in block/blk-mq.c:
> 
> ../block/blk-mq.c:1844: warning: Function parameter or member 'at_head' not described in 'blk_mq_request_bypass_insert'

Applied, thanks.

-- 
Jens Axboe

