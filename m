Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88F0BC35240
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 17:33:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 631482082E
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 17:33:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O85n7FHE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727159AbgAaRc7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 12:32:59 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:38878 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726749AbgAaRc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 12:32:59 -0500
Received: by mail-pl1-f195.google.com with SMTP id t6so3007388plj.5;
        Fri, 31 Jan 2020 09:32:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5cbBb9/NsB+SrRsxeI2ZyWmiFu7xVFhQ6nXwiDmpXdA=;
        b=O85n7FHE3pkb7hva1ILwcwHnv7QLzOHRF33ZtYrephebqSxiSb/APjC4JIwIHucDd4
         HyPnyFYMwnjOSCwJfePYgC5SzWEDKMXq7Dy/yauTJusoAx21y+uKYt2530Mo2KG8u2gy
         chvyr7/LiF4jm9AGLWALxcaJKRUbD/9mEDmRikWT/5Jfd23ffIp3kyi8fZ2CZbK7Dx4h
         09FLcqWxe7w6Iwt457P2hENwfBDZSMmy6R9QX2BSmXyMehjLXlNzYAk3WecJDvdrAcao
         XCA0G8akx1sp2PR7D6NjGlDCXRPhVMOqOc43k3BKpHZvMlGgQsnbRzssqF2YU8w2cdKK
         A+CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=5cbBb9/NsB+SrRsxeI2ZyWmiFu7xVFhQ6nXwiDmpXdA=;
        b=dz2nJBgwU/tAbgUrBOWUNSjERBeA/3ikDxKWUDXe1gaw3C20M+myS2FvXAOZWABdoW
         wnSj7cnIF9tUjUVOVHeDJXIDetDnRmSF+fXM8emeQB5Y81zgcPnbjVP7LvIuDuHiVfQp
         8sgPfxiyEGiHxl3R8IX5yZkUCLC3kysV+9SYeq3hobOk2S+Jn9nHKj5gH9QvjbUJ0STI
         UI5kz7+dohr+XqbZVFvWjJIfSn/Xdl6pPu7ajFcSSGD5KRZnz7DW3bvnccig9yIGMdLZ
         cjQuEwkX+Eh5RZFFLRyb1ADW1LGdJcK69SSwUpRGKfd+gLfANPbLCYjQGoiXGhKR7eHM
         oxzw==
X-Gm-Message-State: APjAAAUhqyEMsskGzE390IJzU5QTDFqAdP8CAUl7hW8VwXw8mVewqR0/
        iQIgJYsvGBp+K8ss7z3JMGs=
X-Google-Smtp-Source: APXvYqxAq07tVsskmi7+35/7zPxLrD4Gsudx1YZCwFW6UR0GpTnXs0wT7P/Uq/RPF1r0wnQST924ug==
X-Received: by 2002:a17:90a:fa81:: with SMTP id cu1mr1012432pjb.31.1580491978899;
        Fri, 31 Jan 2020 09:32:58 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id k3sm11055179pgc.3.2020.01.31.09.32.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 31 Jan 2020 09:32:58 -0800 (PST)
Date:   Fri, 31 Jan 2020 09:32:57 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 5.5 00/56] 5.5.1-stable review
Message-ID: <20200131173257.GC16567@roeck-us.net>
References: <20200130183608.849023566@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200130183608.849023566@linuxfoundation.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 30, 2020 at 07:38:17PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.5.1 release.
> There are 56 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 01 Feb 2020 18:35:06 +0000.
> Anything received after that time might be too late.
> 

Build results:
	total: 157 pass: 157 fail: 0
Qemu test results:
	total: 388 pass: 388 fail: 0

Guenter
