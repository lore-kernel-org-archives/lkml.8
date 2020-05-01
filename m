Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D571DC47256
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 22:11:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A740320857
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 22:11:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DFjzYbot"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbgEAWLc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 18:11:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbgEAWLb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 18:11:31 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 706A1C061A0C;
        Fri,  1 May 2020 15:11:31 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id a32so444506pje.5;
        Fri, 01 May 2020 15:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=u8Y7bN7H3NBaGQxBt2FlBwydwfu6JyH+BSZ/RGcBt6M=;
        b=DFjzYbotYOvAh7So9YWE3iaktf3PHtqd03WCc4GYsSZoOWKDQTzQ+JX3xS0RHbMnA5
         C4Pc0uOcbgqK4UsTDdfhPcX4FsnawZYvs6W8IpufuRtaSM+dud1iDDTBrmcJCblDncNH
         a7tVnPEN5uzl6h7O0WBH0xrmi+AjpR00rSG4Js/0zp2d+ITZJxR0ftIby0/uIOiPjzev
         foYWq9ZwpSeit3XbnQVAKpYOzYZIjx2sBQWdYv7drthf4uYf55+WC/TzxBlu6ce2C6Gz
         4JMhoxg7LLmcVvHOj/cKZCk7sJ66bBu878b9PT4YMTGrBzUGDAicKQ6IZehLhzbinqME
         V6qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=u8Y7bN7H3NBaGQxBt2FlBwydwfu6JyH+BSZ/RGcBt6M=;
        b=o8EW56oIzprH91zdQev8bhOZlXOxXo3lBEJDhU/GjUknKW2AHLEeDDt0BR2QgS9PoX
         zEn0l0CrVvcul07P50HkkBkTt9dnt3/zQ+Kq5R3KnZGlBwBLPbVYh7+MX5rg7jbCL89R
         FLQcoeJrwFmnDJj0woD7N0faBFZjNQ6N3Si4No3A2PmJY+hJl0Aqk461M5YBUYL4pS/k
         RKsIwPs7c4yfCWsrVX61nnS9lLRAkeaxDlJJrT6NLd/OPpVH8qoGCQeW4ZXaj/gBJlFU
         ifzdXroIASiDIzqOcT2xSwr1ZxIHtLigTgAFHsMCAqG3zSRlWSnROVCnC1QnKg/ya34/
         WWkw==
X-Gm-Message-State: AGi0PubC3zqwMF0HfgnBKRtHoEzu3DC30Xbo1gmqZMgiA4M8uHtYsUpe
        FeU7DDimwF/B7l/gOXi9sGGU/xqL
X-Google-Smtp-Source: APiQypKf20Apdbkut98tSfrP8HCkPz8z+Ddn2L0ShUxN/DC5uzAd60Q8qcRyPz7WkE8XxhhtDj8QOA==
X-Received: by 2002:a17:90a:6343:: with SMTP id v3mr2005863pjs.127.1588371090942;
        Fri, 01 May 2020 15:11:30 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id h9sm3033716pfo.129.2020.05.01.15.11.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 01 May 2020 15:11:30 -0700 (PDT)
Date:   Fri, 1 May 2020 15:11:29 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.19 00/46] 4.19.120-rc1 review
Message-ID: <20200501221129.GD44185@roeck-us.net>
References: <20200501131457.023036302@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200501131457.023036302@linuxfoundation.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 01, 2020 at 03:22:25PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.120 release.
> There are 46 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 03 May 2020 13:12:02 +0000.
> Anything received after that time might be too late.
> 

Build results:
	total: 155 pass: 155 fail: 0
Qemu test results:
	total: 418 pass: 418 fail: 0

Guenter
