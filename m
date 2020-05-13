Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7038C43458
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 15:01:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16F51207D3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 14:42:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p/IjhOHp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388935AbgEMOmM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 10:42:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388167AbgEMOmL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 10:42:11 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F246DC061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 07:42:09 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id e1so7274363wrt.5
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 07:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=IYL8fI7CQMIGkZ0xC9HxhZ1ZIDbZHbcwItjJbx9L/aw=;
        b=p/IjhOHpVwMOXUBvNr/RpYOLLL941aJmfWkaDL5FFd/ybg9rBGCG7LZGGhxYuEoxBo
         G2DYb3xsrspolrpUVNZy2TOosp0ouTO9+sx18MC5swupML102RvrzU6H/+PxOxBwp9ix
         SCPJINKXpVA75iyWYAibrqEjkEw2dlN9LqyU/bBQpxjkh5/ftf+/l0dh3BOxzJysmRHv
         yNKwo+pz1eRnJDNSVxHZP6tbsSRchhyn6dMzjMvcBCGzZBzXmXas7YaMem+5chbKJgAd
         fplACozYq9zaz74cGR7dZTpy+CJhxlt+uMcirDcVtiRKPOaBOuoCwDGnG8E2IGPFPMrg
         1QFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IYL8fI7CQMIGkZ0xC9HxhZ1ZIDbZHbcwItjJbx9L/aw=;
        b=rmERB4S+TcfwTXt6brFsSIF8hs+DkdYUnCVpjMw78Yew7U/voo3FrlQocbgeFv4QOY
         QXGOzFqkbwa4iQoGSMAfitZ+TbV/3WZiaPE0HLk6wLlqU097FHzpNbn1ESmQNJ0TUxg6
         8AaRLdVDWo3LDn1Hb3hItj9nzH3MaXOIzh4lL4uUz/YFe7+YauT26FwDZRv/jXXPD1BV
         ifoLKKy6MCFYW+dmdlEiWeNDPilmqO28Iykplb+K36tKCM0a0fbgaxiJw+g4+YNgCnIq
         W9mh3OUutmRUceFiRNh/qZqnuNP87+Y9H/2T7TOil6Kuwj/OWF64ngx29x1zpgc8m8oX
         fYjQ==
X-Gm-Message-State: AGi0PuZt2GZSyt17IrNnHO2DI44v60xCbJ4HuKO4V60v3z6cUVfXRceC
        SkQsf1eUs63VGxhNSTfMtuE=
X-Google-Smtp-Source: APiQypIGKuBjmOArm0XD6T163TlI+OjkoACu3quQnLZN/g+avrPUs5iZUd5L/g6x25ybP1JuxNbrRA==
X-Received: by 2002:a5d:6ac1:: with SMTP id u1mr31100897wrw.319.1589380928762;
        Wed, 13 May 2020 07:42:08 -0700 (PDT)
Received: from ?IPv6:2a00:23c6:9e09:2900:3d38:90c1:858b:902e? ([2a00:23c6:9e09:2900:3d38:90c1:858b:902e])
        by smtp.gmail.com with ESMTPSA id n128sm9674675wmb.47.2020.05.13.07.42.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 May 2020 07:42:08 -0700 (PDT)
Subject: Re: x86/smp: adding new trace points
To:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Cc:     mingo@redhat.com, hpa@zytor.com, x86@kernel.org
References: <4d54953b-f968-63f5-569f-9e09bc0f361c@gmail.com>
 <b638ef03-04c2-94bf-f026-a01691888624@gmail.com>
 <87y2pw2fav.fsf@nanos.tec.linutronix.de>
From:   Wojciech Kudla <wk.kernel@gmail.com>
Message-ID: <b3e3c317-17e4-081f-0bb6-3e6f291f8b86@gmail.com>
Date:   Wed, 13 May 2020 15:42:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <87y2pw2fav.fsf@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/05/2020 13:24, Thomas Gleixner wrote:

> Why would the SMP call function single interrupt go through the
> PLATFORM_IPI_VECTOR? It goes as the name says through the
> CALL_FUNCTION_SINGLE_VECTOR.
> 

Wrong vector, my bad.

However 2) still stands in my opinion. We don't have "ipi raise" trace point for x86.
RESCHEDULE_VECTOR, CALL_FUNCTION_SINGLE_VECTOR, as well as TLB invalidation vectors are essentially inter-processor-interrupts if I'm not mistaken.
Would a patch adding such trace point be considered here?

Thanks,
Wojtek
