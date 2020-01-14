Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEC63C33CB3
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 18:15:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF6262084D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 18:15:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VnlRUSvV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728879AbgANSPw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 13:15:52 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41178 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728733AbgANSPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 13:15:51 -0500
Received: by mail-pf1-f195.google.com with SMTP id w62so6961898pfw.8;
        Tue, 14 Jan 2020 10:15:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Z1JXceF769IJbVwWR+ELECPVM/G8qbCKbWyr0f/ru+0=;
        b=VnlRUSvVgtgeJjoa4e36OIws1Bj0wmmgIpvchN4BXYYEVLd5sc2CcqEbVaIU99B4rN
         UKtwjEYRyFNoq04mLDgSfpU9/5Cr8xDNw8wThfZvVIkpX0WKavFnsnPd3oHqSKPK0Ci3
         zH8OcFQ3Eu7ZuACy5n8o8E5FG4AQHsNI2BJyYSWNDLeaRF4z5Z7vGN8NQUZ5IgSh7c4z
         iIEeVda/J2yRlqTla3KzBqDe0FaW5oCzedVv3Sd74nvFqYQK03hYyyYf/mhJ+e1c8AfR
         bRgEAfORUcvoZmkd72KndzbglXKre6tOXEsJNjrWiJTRbNN1pEceASPEN9wBo2N3gRQ/
         iBJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Z1JXceF769IJbVwWR+ELECPVM/G8qbCKbWyr0f/ru+0=;
        b=j+9CRIoJ9qdiaqoMd9LIDvRcjlOqkLJAat5OtmN9TQ0sDhaqwMboIQtXY4DX5TS1zA
         PqKEb6A21hshn3T16iaUIwiUgqsBEC2uozW9KEmjdqQydaNZSZCRNaLpeH+rHg4BR6eP
         vKd1q10wHBvngZTPagHMP0+nrGQ4JSCAvCKp/7PS4K8zt1rLMOtxCDUqzj7kak7c6cKb
         XCWgILglpHX3ZOPUQl9opkdZzYw3nHqaGi6LDPPnmLRVZZQdtPV90BQYGGcy92nRojS8
         Pc09rS5gHEiuWg6FAahKThwaPZ4/NfxEL2U583L43NRyrYi+wF2jqrK0VbMIVmkRVCWG
         0MeQ==
X-Gm-Message-State: APjAAAWIuRmAibHowvWdDu+myYl9/uH3XV12CsoHZvX5obc5b1xRc06t
        CEHewSfy2YBRecTF2NWXvug3EtOV
X-Google-Smtp-Source: APXvYqz+g3KbpU/yAfdNbK35YcZOuho/RBJ1+KWp/3gUOMe6jK2cgubqGwglJQoEKf/YKD/xa3IC+w==
X-Received: by 2002:a63:4287:: with SMTP id p129mr27926278pga.122.1579025750894;
        Tue, 14 Jan 2020 10:15:50 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id s21sm18883925pfe.20.2020.01.14.10.15.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 Jan 2020 10:15:50 -0800 (PST)
Date:   Tue, 14 Jan 2020 10:15:49 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.19 00/46] 4.19.96-stable review
Message-ID: <20200114181549.GC18872@roeck-us.net>
References: <20200114094339.608068818@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200114094339.608068818@linuxfoundation.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 14, 2020 at 11:01:17AM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.96 release.
> There are 46 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 16 Jan 2020 09:41:58 +0000.
> Anything received after that time might be too late.
> 

Build results:
	total: 156 pass: 156 fail: 0
Qemu test results:
	total: 383 pass: 383 fail: 0

Guenter
