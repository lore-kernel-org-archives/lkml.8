Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 964AFC33CB6
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 19:00:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75E3821835
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 19:00:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AeQM7UCv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729099AbgAVTAK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 14:00:10 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42229 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725884AbgAVTAK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 14:00:10 -0500
Received: by mail-pf1-f196.google.com with SMTP id 4so266452pfz.9;
        Wed, 22 Jan 2020 11:00:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=a4MMYSCXDe4ISRtbUr+W9UTJ2ANFNGQiK03YTa5oxF0=;
        b=AeQM7UCvHwo8zanol0EVl1HZRAmsAzwe16r7ENygXQMu0nTKpJ6xDobuUMqwHr52Gp
         pkRbmK7C+7J3e3w5zMxaj1WqIxyG3p63zLbdfPOn8a+P1XvOcf/MCAlhaHSBztHdhU2k
         PogIVvRyDqekRbPiVmdWtFLzkDcxfzQWbt709kUkLuERhKYvIyQiXNskD1JOvPmsyZnT
         9JBdD3xFH4f5grbqTyiM4jjZMvSFNFH7r+RqQm8fWdXoIkGn10tAyfX2iTh/2eCf9M/9
         Nj0jwTXJy6zMHRUL0joGYKJlTdWwphKgkYu9FW8IluhCpiKk2RhyaMdEmaYTJNNiY6Lg
         +PUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=a4MMYSCXDe4ISRtbUr+W9UTJ2ANFNGQiK03YTa5oxF0=;
        b=jAMssZUQvV5PcAG64sxH3kHm6MlDf2kkdIMNap+iyBXuYUPpfJS8cAI/dAth91h1pn
         wrAjBD6xb4eu9ELyLXSIisEuvPtzlrDFhhHS9/SDOlrE/ziB/rFykbZx1A41PlJmvMMC
         HcJsqHXajnpPKWdWrn9oV/QRESYI6ztFGXEqrIsL+pImq2VHqwOL+gyX0ZqnNUnA+8Xq
         aDUDb3kctVkyi1HbZzZ3OvG1zL/9UpGgQ33SKx2gsNPuB8Za3frDgEcE7Sk58OSAYWMM
         4Pv0W5ckM8LkRCLLKY00TnVFJMapCdsaHPHY8m4W8KjjpbSBVVAi5Ashvjni4+2g4Gld
         BlBA==
X-Gm-Message-State: APjAAAU4Psqs1XE3mw7ZQyka18gp50xkydy8x6MldLcIOcLuNN/nKfVV
        wkMbKAqYJw4eYkWmGyRjiHg=
X-Google-Smtp-Source: APXvYqycSjai/PiXr1y+4XFgWifY7+AGFpIBRarePn/zFvCbe8sD7Lz2BBiPjgGOxUGnrbgERjWBMQ==
X-Received: by 2002:a63:5056:: with SMTP id q22mr5322pgl.20.1579719605609;
        Wed, 22 Jan 2020 11:00:05 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id x7sm49874483pfp.93.2020.01.22.11.00.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 22 Jan 2020 11:00:05 -0800 (PST)
Date:   Wed, 22 Jan 2020 11:00:04 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.14 00/65] 4.14.167-stable review
Message-ID: <20200122190004.GC20093@roeck-us.net>
References: <20200122092750.976732974@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200122092750.976732974@linuxfoundation.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 22, 2020 at 10:28:45AM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.167 release.
> There are 65 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 24 Jan 2020 09:25:24 +0000.
> Anything received after that time might be too late.
> 

Build results:
	total: 172 pass: 172 fail: 0
Qemu test results:
	total: 375 pass: 375 fail: 0

Guenter
