Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CFA9C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 20:05:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CAA42207DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 20:05:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bUcJUqeH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728172AbgHTUFc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 16:05:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726908AbgHTUFa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 16:05:30 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D5D4C061385;
        Thu, 20 Aug 2020 13:05:30 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id mt12so1448816pjb.4;
        Thu, 20 Aug 2020 13:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=siSHZ4eLzVbDLxB01jnzcke6E54SrDO+53qYcaTKiqw=;
        b=bUcJUqeH+QmByAhZmLkpZngz5Zw8zcCh6a/KYyeV8SlGwFKO214ScXSDPRlSmlAZ4X
         VNxwAd/dHEvWHvZg80m8bhpsMXVzOrtJ/q3I1xPxyjdnix7Q357vzGSRwLZj+B0n+MvM
         KYSoULdJjzrLPjPtPkL8CcCLTICi/YEKzey4SHkXDnJHhX0K3X60wLYbEVn20URcl1Tw
         h0+Yep9BluPCASHhS0DdaxceoJPbQhtbYtc7pwYKt7gKT2kwf5P1TpAZH6WW9vhtchhZ
         f3OoDdhDqLJo1/2l8vculqa3Q8arn5FgYYC+H8PVxclB3HutJnCIkRswDbo06VM3p8eO
         ta+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=siSHZ4eLzVbDLxB01jnzcke6E54SrDO+53qYcaTKiqw=;
        b=cmAFZvBQENNIVryP2HyyEsLHgYyZt3kLGumlLXCwUdR6nZGIRvD2qbqg3+8LlrEW3O
         OhOwqCYpw66KWf4wxNgO+3w6lfeyF5D2155wzQUypuUR2Ou8lGAyfgziZrQ9hK1Zwd1G
         CAV36YwlL01q9qpaeY17zQQY5tEi7gln4rE06bL1UXxcequplwO3d9x3HhrqAjI6vxZQ
         9XXh8vWwLtKIzBc3H028ORwXFCAnL3y9gU22WVwOkdLgrEiWya0G4EC46cMaHfALPiFh
         a9V8XzjKdyjorKd79XRZqrLGDilSfMXw2r6oUjDl3GBGplQAQehypxlgxuvVE3ohWBQv
         oKnA==
X-Gm-Message-State: AOAM530Y8oZNL0aI7+bsUreA/6UkrHLqKDqLxo//EKbmcl0Iq0GTJIgh
        gzUVepWOmghwEDCx7AMWgBc=
X-Google-Smtp-Source: ABdhPJzBJL1Qk2beak/06uUgidAIsvbHRMOpuluEM5a0xGJJVDqNa2ivmHXxe1H44HTmE75IAlDbEg==
X-Received: by 2002:a17:90a:7485:: with SMTP id p5mr253918pjk.130.1597953929958;
        Thu, 20 Aug 2020 13:05:29 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id x20sm3382071pgh.93.2020.08.20.13.05.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Aug 2020 13:05:29 -0700 (PDT)
Date:   Thu, 20 Aug 2020 13:05:28 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.14 000/226] 4.14.194-rc2 review
Message-ID: <20200820200528.GG84616@roeck-us.net>
References: <20200820135009.684062405@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200820135009.684062405@linuxfoundation.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 20, 2020 at 03:51:02PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.194 release.
> There are 226 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 22 Aug 2020 13:49:29 +0000.
> Anything received after that time might be too late.
> 

Tested-by: Guenter Roeck <linux@roeck-us.net>

