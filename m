Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8F3FC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 05:14:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE61A207CD
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 05:14:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mhi3Y848"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726227AbgGBFO4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 01:14:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbgGBFOz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 01:14:55 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 799AEC08C5C1;
        Wed,  1 Jul 2020 22:14:55 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id o1so4254148plk.1;
        Wed, 01 Jul 2020 22:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=q2AmPf54k6V+7YFyiJal5EYJsUdyj94UY6PchwcvXgE=;
        b=Mhi3Y8486oj84DtikJxaCfYVKOB48AuEVcdz9zXATCez1PDm9uGjq9ljKqSTe/Rg7Y
         48g5DsXTSLkStEwAGOxLh+C4TO24duoO0Fd7faKjR9vhDPOaANKNV3F2V15zE/T/VP3A
         G/RLqHivbxcamVKMSk+QknhcL1esCCcvGxlkLjuRkXJxLqw8sa0jXsHu4BhqIAHLlJ6K
         adH8ppBdN//81dxXBrQP18WIeG8k4JWlXHaX74R1duzy8i7qVHRA2DbHzNp9/ow6Pt7K
         oxeN44983tGOXJHsKU2HzMc7WZnnAASgmEl8JCL7esWL199UFDpa22Sb34h2vExIsMvM
         Mn7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=q2AmPf54k6V+7YFyiJal5EYJsUdyj94UY6PchwcvXgE=;
        b=gm70aJfv+DsJQjWCxRWc5SKqfFj3/frzrN0webXcslBix5DQhgwcYLkTm14mFLSzK0
         rDW/0JZdPd4KPYcH2IkDNpkv75Q6ajw+LXfCMxCIBmSCrZSxC6bjAtsmK68MlMF2abK3
         aebr1bqjj6ge6+kaS+Qy1yKGaKq3iUEZcteusjqDFaXLFzS8pskFhmcUHArOX70JykT4
         4UeVaMWm7dVC/MxZvJhOmlhyIVmgf9d2HVQBT0AbfMk//OBHtN4JNJS5Kvr4uRezKAY7
         NMZwFLRCRVKawxzQpUyY6VPMeWpxRcspRuhIA1BTsMmpbujdp+ceREJcS5OZ0jIqyH1f
         qnPA==
X-Gm-Message-State: AOAM533q6V95j9/BExqNaPIIJRHSbKji+iZCQJgdQB1MvrNO3AEnjdF9
        IBMytr5J3VlH0+RIhRCZtYI=
X-Google-Smtp-Source: ABdhPJxUSRo5a108Q/nySxmd/hO3m1jwUtrDffjQ3A8Afm6suRTmK1b5bXou9m4MLz/f/KB67nbIDw==
X-Received: by 2002:a17:902:d68d:: with SMTP id v13mr25904277ply.10.1593666894865;
        Wed, 01 Jul 2020 22:14:54 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id n188sm7505225pfn.104.2020.07.01.22.14.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 01 Jul 2020 22:14:54 -0700 (PDT)
Date:   Wed, 1 Jul 2020 22:14:53 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Chu Lin <linchuyuan@google.com>
Cc:     jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, jasonling@google.com,
        belgaied@google.com, zhongqil@google.com
Subject: Re: [PATCH] hwmon:max6697: Allow max6581 to create tempX_offset
 attributes
Message-ID: <20200702051453.GA235128@roeck-us.net>
References: <20200630174350.2842555-1-linchuyuan@google.com>
 <20200702014223.4096977-1-linchuyuan@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200702014223.4096977-1-linchuyuan@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 02, 2020 at 01:42:23AM +0000, Chu Lin wrote:
> Per max6581, reg 4d and reg 4e is used for temperature read offset.
> This patch will let the user specify the temperature read offset for
> max6581. This patch is tested on max6581 and only applies to max6581.
> 
Patchwork received four versions of this patch, with two different
subject lines.

How am I supposed to know which one to look at ?

Guenter
