Return-Path: <SRS0=3sb/=3H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18C8EC33CB7
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jan 2020 20:46:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E198A24683
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jan 2020 20:46:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Inb6NhQE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727465AbgARUqk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jan 2020 15:46:40 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:33588 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726997AbgARUqj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jan 2020 15:46:39 -0500
Received: by mail-pl1-f196.google.com with SMTP id ay11so11380063plb.0
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jan 2020 12:46:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=aBvwG5hs/viXjFOybOIYOqL0J9/NjAJR55aMcHkMqz4=;
        b=Inb6NhQE6dYl3CVHDsOi2zXEBpNBU5RUcTsbaziD/JicVz7jAIJPYErWhulW0IFZp3
         cHAFAsTbSpWgpbFJmrSjM42Td8TOgCcYdYy14I3nGBDv1Qif2VoKS/CB+acWtavKJ7SA
         yL+4Zfo3ukT6yP30COGuuI27F4hb7jGd5IAngkeHzL2N+n5XFOsCnTwe0wpZGtlBFM2E
         Phwb0Q1CACMW+jKyz+hU1TlshN1a0cPwtEWQ8Jg1LpHoztXMOfGoktO0Eqj3YJu1U8Wv
         7ObOXnYx0Q/fkRYmp7zdzu5D138+Tm0KDmQUxW55+WlEc2qeUHRMeeycc5FWTatrrW+g
         xKeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aBvwG5hs/viXjFOybOIYOqL0J9/NjAJR55aMcHkMqz4=;
        b=TGlgqCXFjlqBf6ZmTuIIKt3cNmMWohjC44VjTPK/Jl5gKnqSoIpMMhJmhu76TUqA/2
         9Ew3At9ycAk/rJXpc2W29TcsKQVLjq/CZRfW8bPWCBpv0pqq8eTKLD7AJ+hmAS1Qgoyg
         vYPgHyGhLz72AefsxdWHoLmlCU+s65ljEKlXPprqmi63GEXOA8f2y51i/UiIB8PrAQKO
         plrmiBWtZp2nkByCbINrWD6S1nEnqIBP5wJqdVGtMfUnaLmIHeqXPNAb48/4pXrp+po6
         uzIlD5D8hYuagjum2jbC0xCO5W9gQJSS/Ck/gXibnQFh0ykD+9NCtJ8cV/L/3N6Y8Ckj
         u7GQ==
X-Gm-Message-State: APjAAAUF2bTGqjdjPxTZ1Syr0yNCKst+OB6basgR9zzFNYBF0k171A+l
        PG/wF6ZvEKcKrYjIvi3fx96zvaZXdMg=
X-Google-Smtp-Source: APXvYqwWTGIwEbfvkeQFgWzlMG5o9J+qp/K4p7RgFLPHkAwxfZU7UIbBuw6opSlpBy0gmhhLpiTp6w==
X-Received: by 2002:a17:90a:2351:: with SMTP id f75mr14131461pje.133.1579380399007;
        Sat, 18 Jan 2020 12:46:39 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id o7sm35806945pfg.138.2020.01.18.12.46.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Jan 2020 12:46:38 -0800 (PST)
Subject: Re: [PATCH] io_uring: use labeled array init in io_op_defs
To:     Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <b23c570236ab4b1f47603e52ef545875ac632df8.1579372106.git.asml.silence@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <8eadfa1b-5dee-a6b4-e217-81fdd2484218@kernel.dk>
Date:   Sat, 18 Jan 2020 13:46:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <b23c570236ab4b1f47603e52ef545875ac632df8.1579372106.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/18/20 11:35 AM, Pavel Begunkov wrote:
> Don't rely on implicit ordering of IORING_OP_ and explicitly place them
> at a right place in io_op_defs. Now former comments are now a part of
> the code and won't ever outdate.

Looks good to me, thanks. Applied.

-- 
Jens Axboe

