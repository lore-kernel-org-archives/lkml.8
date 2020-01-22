Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F513C2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 19:00:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA8542465A
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 19:00:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P/3E7Mno"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729143AbgAVTAz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 14:00:55 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35190 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725884AbgAVTAy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 14:00:54 -0500
Received: by mail-pf1-f195.google.com with SMTP id i23so284463pfo.2;
        Wed, 22 Jan 2020 11:00:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=folNp+UVit8R2kkGaowLfrquM4rQ+0SG2L65J4F/fMI=;
        b=P/3E7MnoK82nbITgfXIfm7qTHC0Nr4ogI08WJCHH/DSLuAN3SQtPF5ybwaNjUCY2pa
         xQto0V+PMJCLGXlqsqnhxW+tRguS96oBdEkFByVRtsNvhXaFlpplt6Z5RvktIlMH9Gmq
         sNRWz/amGiLuLZT6hxoMBc3NvxZNar3KbLkxYE6nyylYVEVy1mSDAwOaYISfDCid/p/R
         LYGFnkJaMXUBXpnbAjdAtN1EEfvYttFGh9tieu2Aig4rlm7RehJQrLZfIlOd16WB6C9K
         9qQqk5dMUNrwhDMff/crwvQd1j//uohvaa+tcTTRhIquWzEFOXoNn3XMaI0HQlmZTbTI
         ZtmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=folNp+UVit8R2kkGaowLfrquM4rQ+0SG2L65J4F/fMI=;
        b=UnsQvNuoW7+vIzeHrKzCWYU65PrF26LEaxcyNpGBGHNT6JPQpu+oQbukTGsGNFVSVK
         tvuFaWCqeVdmq89+iR1nIVD3CfRlRERbT/iUXjWAsTOE4eufVEYRCjQYNPY0AyU4dt9a
         7ohm8WvJxaeFO+UQ+nXYZf8Y2oxqoEVxP6Ag2e0qobrNN3Jr4y5Oru1rVZqjQXKmTU/p
         s73lTGhiApGBBpzpOv5OdrQB4CkM8aOn9FiNx1AfXyZNXflPc8rz4kubM70OwRAn5yJm
         7w+IWn9RTEKJdGP/Nlpq3oF0V7Ro4ATamlw3d0HNxvO2PxVu9OJdgzRGy+ina1yn9rny
         zObw==
X-Gm-Message-State: APjAAAVP0pqfNpKm6ayuRYPJC9Xmq/QsqbgAruD0BZ78Kv5A68Vbl+vW
        0KTEikQ4uqWHoiwM9OOaxxY=
X-Google-Smtp-Source: APXvYqxKo6xG6NA1Fn40Z/JIEaa+8qhJlzSmaNDgP7TgbW12hexgeo0ga3RBvHxBxIgOxdGLWZO32A==
X-Received: by 2002:a63:3cb:: with SMTP id 194mr5471pgd.123.1579719654036;
        Wed, 22 Jan 2020 11:00:54 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id u1sm45511784pfn.133.2020.01.22.11.00.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 22 Jan 2020 11:00:53 -0800 (PST)
Date:   Wed, 22 Jan 2020 11:00:52 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 5.4 000/222] 5.4.14-stable review
Message-ID: <20200122190052.GE20093@roeck-us.net>
References: <20200122092833.339495161@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200122092833.339495161@linuxfoundation.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 22, 2020 at 10:26:26AM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.14 release.
> There are 222 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 24 Jan 2020 09:25:24 +0000.
> Anything received after that time might be too late.
> 

Build results:
	total: 158 pass: 158 fail: 0
Qemu test results:
	total: 389 pass: 389 fail: 0

Guenter
