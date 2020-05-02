Return-Path: <SRS0=7DLR=6Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D909C47256
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 18:56:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1AB932137B
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 18:56:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tessares-net.20150623.gappssmtp.com header.i=@tessares-net.20150623.gappssmtp.com header.b="Irh8N5dQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728516AbgEBS4m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 May 2020 14:56:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728449AbgEBS4l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 May 2020 14:56:41 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25CC2C061A0E
        for <linux-kernel@vger.kernel.org>; Sat,  2 May 2020 11:56:41 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id x17so15913482wrt.5
        for <linux-kernel@vger.kernel.org>; Sat, 02 May 2020 11:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=z0MfvGDD4YkFw60+Ps16ZYHcvLXoiQilDNUVAcRo53Y=;
        b=Irh8N5dQpWro1LlVadiznKhrd6dm7ic0bj//+XJqPEthN+j4X6GJeLD7l+kuy/qybe
         T3hI4DYpaV2J0QLolmFr6o4iGgaWVVFbho6d7YbsX4eVbONwSHztjogFGcON26Vr80f3
         1suQjumRJDtYKY4tsIH/mzwkrij2DhGUEv9n6tgAuWRz2Gfhdd5ykd/ad9Hwmdn24tsT
         ey411x2eh0BlE0pKMhljCp1QSrEwKdM04G3eFwztbxh5KkLBkmQKdWSwWfIu3xk5aWJN
         nYmJgbdOSyBa2fd5CoxInkv4ZaI7Lq8EY++tPGVTOjQe9cthSqNhUldSBiORch1j8yKK
         hBcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=z0MfvGDD4YkFw60+Ps16ZYHcvLXoiQilDNUVAcRo53Y=;
        b=UabjgfdoFxPc9T0c75kviegfOi09tq93Fid/RSQZ7/vxYaTKbsjzHHFZvBfQLbdm7C
         qKWlUcbWYC6sGCLxamp3fj5va58i69WvM5Fu7M0LopZ2h3vZdCcaRDPptVGUM43z3QHy
         4AQR7TTJVwBVSwm4RE8d2SE7DGSmUijMvi6kZ01tB50kkZHeRAUmtFTKFABELhupWF81
         SE33k9hAud7fTj/IyebCgCz+PaQhzZq2A+6NaaJhlfYAWvCBnoselMcZw2aQ0H0rFDs3
         m23/6OsnytfKxJKGZbRMP1JhMUUwDqKMcdOH3tbBfNrmJ3n7OlIf7wXJtYbHxe9Utu/p
         GzpA==
X-Gm-Message-State: AGi0Pub7+RfHI5E+yJHbp8ydO56+Kj7LUpWYTIaWIP/B/lJ25smJygmJ
        PDtB0tHsvfNxftnVt6Gnl7ASHg==
X-Google-Smtp-Source: APiQypLHeatZbob+JOGRdFpn7hrsx6IXwJ4KdbOhv8SZvibLjcqwXaw58bK8WFMlanza3Z6ZSzhu1Q==
X-Received: by 2002:adf:ee0c:: with SMTP id y12mr11425646wrn.0.1588445799673;
        Sat, 02 May 2020 11:56:39 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net ([213.211.144.192])
        by smtp.gmail.com with ESMTPSA id 2sm5955884wre.25.2020.05.02.11.56.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 May 2020 11:56:39 -0700 (PDT)
Subject: Re: [MPTCP] [PATCH 1/7] mptcp: use SHA256_BLOCK_SIZE, not
 SHA_MESSAGE_BYTES
To:     Eric Biggers <ebiggers@kernel.org>, linux-crypto@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        Theodore Ts'o <tytso@mit.edu>, mptcp@lists.01.org,
        Paolo Abeni <pabeni@redhat.com>
References: <20200502182427.104383-1-ebiggers@kernel.org>
 <20200502182427.104383-2-ebiggers@kernel.org>
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
Message-ID: <22ea2039-18f3-12f0-cdc3-99b49c413f77@tessares.net>
Date:   Sat, 2 May 2020 20:56:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200502182427.104383-2-ebiggers@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eric,

On 02/05/2020 20:24, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> In preparation for naming the SHA-1 stuff in <linux/cryptohash.h>
> properly and moving it to a more appropriate header, fix the HMAC-SHA256
> code in mptcp_crypto_hmac_sha() to use SHA256_BLOCK_SIZE instead of
> "SHA_MESSAGE_BYTES" which is actually the SHA-1 block size.
> (Fortunately these are both 64 bytes, so this wasn't a "real" bug...)

Good catch! I guess it was left when switching from SHA-1 to SHA-256 in 
65492c5a6ab5 (mptcp: move from sha1 (v0) to sha256 (v1)).

For MPTCP related code, it looks good to me, thank you for this!

Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>

-- 
Matthieu Baerts | R&D Engineer
matthieu.baerts@tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
