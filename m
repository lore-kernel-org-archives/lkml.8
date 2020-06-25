Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9BB3C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 15:54:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B48642089D
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 15:54:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XOAyqDVG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390671AbgFYPyo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 11:54:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389678AbgFYPyn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 11:54:43 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48D98C08C5C1;
        Thu, 25 Jun 2020 08:54:43 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id f3so3490173pgr.2;
        Thu, 25 Jun 2020 08:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wZbVDVoV8+BSrK9d8GDL2NQGXtBvCubLIF6UvDqQ0UE=;
        b=XOAyqDVG3mpCUbCh8BXFiR8i7q9p0ubrOsu4eenzHL74WHYXYHXV8MNCATgdFgJVTx
         adTIdZ4nAe6cAwXcGgOG1pGTYsu5GYcNY0HNJHtW7SZ30KWJ1M93aW0lydwk0rKW4ic1
         Z7KRORq+GQPSgcCvVNM4mOVPt3MKuPu9LALeGlySkn3g/BKpzl1M7wJXmNehYv0CwgoQ
         5vRcIq2J5n6P8oscd8gQiJqP/V7meF9R4TGa/DitjmL2MHU14IpYoyJaQ4+239xeDzPX
         uNloFu3UxKQl97tRp/t7dfMG6xAGjPN0dCDBOokpVrpc6PRxsIpPP9JdwLk4kOyFLnRV
         fxEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=wZbVDVoV8+BSrK9d8GDL2NQGXtBvCubLIF6UvDqQ0UE=;
        b=nzmuDC+pFykIl2yLFfkt1yaZX04xhxJHrQD7sKowkUp5Vs42x/dbkOJoqzB8FEZouo
         2bvVj0I/sQhuIxPSCkdA4+Rw+/tfs96C/DGYGwM/PeYAxVzQ0THZjXYH0zIv+tcktAxx
         +nH8SlTF33ncDPnd3zclpp0EXCTSMRmjjBInbC45lNiwH4DIEyGlYu/6dWOvc2RPim7r
         ZhhSKY1ttKPVQqyVaDozKdhDG0B4+/inhWg3uVFg76ySoJDhh/+IouGqtsH31jOKYJlp
         KpnevDLxI1E9jV8WaT3/Raa3gp0UnNkiCtvYETfQ66w6XT6Y1pmCKOFUrXZh6ekoSNxM
         cJsw==
X-Gm-Message-State: AOAM533cGL5r8cttgprmJtNDtUjDEmAHQXCq4TSquwdGrk6pEjtg4WhJ
        hIGc9spBzgpVby43/UsGqvE=
X-Google-Smtp-Source: ABdhPJyQtNEJGhxqHhX1u82KXRkpi4Tmu/HLFP3tjJ0wfcbOL7cas2+QisHPgMEW5hc3iRcy5nUEeg==
X-Received: by 2002:a05:6a00:14ce:: with SMTP id w14mr35895100pfu.121.1593100482927;
        Thu, 25 Jun 2020 08:54:42 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id gq13sm5298624pjb.7.2020.06.25.08.54.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Jun 2020 08:54:42 -0700 (PDT)
Date:   Thu, 25 Jun 2020 08:54:41 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.19 000/207] 4.19.130-rc3 review
Message-ID: <20200625155441.GB149301@roeck-us.net>
References: <20200624172351.011387771@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200624172351.011387771@linuxfoundation.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 24, 2020 at 07:27:18PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.130 release.
> There are 207 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 26 Jun 2020 17:23:16 +0000.
> Anything received after that time might be too late.
> 

Build results:
	total: 155 pass: 155 fail: 0
Qemu test results:
	total: 421 pass: 421 fail: 0

Guenter
