Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCCC4C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 14:15:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9897F2070B
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 14:15:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596118511;
	bh=dY00H7wSmtOHK/uw4sMHsPRIHx974EK8RbHLR7GWuK4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=v4sQ6jU47Kn3GujCoCFweEuhKL0sVZmVEvil7xvFfT0hYqA5vf6y75rDDUAicvtR1
	 eRtWM+tPeiQmFt/G7GqVhlXI7SNWqnwSeIEG3uJb8kjeMpaIfHmxyNmSHysw0ll9+o
	 utm8fMTb0zfAZWYSbj98fBFD3AG5Ayy0NTJFB2WA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729540AbgG3OPK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 10:15:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728310AbgG3OPJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 10:15:09 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E280C061574
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 07:15:09 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id t6so7637649qvw.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 07:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cOIc35GbadqeLJ9Zr0ZeXeBC0U2pLAaCNW8yxikmhc8=;
        b=QMoWf3BbUtdtIc70Qb0D2HnX5MWeWCLygP1lxIe6xruBOVPodRZY7/VihCNCdVSqTi
         O/BeoWsr3bxl4dJxVamPhbuOzfj4vB03kB0+o1sezlQSE3+XP5tmU08oG4TEc93wlqAi
         Shkm8+jUgwetKFIuCWwcVcZoxMuupHCF3qQqsM0gZfKIoqMDwDPZGnNhP3gCe063HWL1
         LbdnLA/ZcOmmZqo15d63X0cSgoXi/pnYnMKVUY8wkcOW6rNYtJppx6B3HEhW2wLyXTeZ
         nqsBaaS91oJBuCN9BrKP9k0ngVG9KPwFKdBgqpPnY03noMp00halDu4uFI7QOmwnZLP2
         3n1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=cOIc35GbadqeLJ9Zr0ZeXeBC0U2pLAaCNW8yxikmhc8=;
        b=ijJ5w1WB4R44GduS08BkGEI3vXeittGzVogV2VZ531V8Kq9k5+YJvbPoFEuGujwPUf
         3wDz5ti7Wtyl9Jr4QJJMiSoxB1/IZqIKCD25kqGXVt1vOzkjXnz4rSbnJemibDsXPzkf
         +K4riposc/1HkJBCHDY7r4YKTE5QzRK1EuCUtEIU1aMX2AIZF3BJVyFOnQj8+QH3fCoG
         ybDoOreVw38llVMKfs9KnXlN0wK6GBSjzQi8JDIjAeeyXVwHhiyQkS1XCxMA4sf8lNAH
         UgpDZLE60sK3eou6Gx3qdMNaAwQ20Sms+T34z/L7jCWN0zAnpm3jg4cUVxmjX8b59DZd
         ILrA==
X-Gm-Message-State: AOAM531QhaRFYFpj8zv6BnNxmT0Kog8cz9BwBBs1PGT2IBvNwsu9Mtrc
        o7Gylcck3rXdbd8EVuGq0/M=
X-Google-Smtp-Source: ABdhPJxBeNfOKGEVwYP1ubnmlEoNf1ZGmZAdhu9b74sHMPnAr6EwzvPjj9/B7fBifzWXzY7P0g2IkA==
X-Received: by 2002:ad4:4507:: with SMTP id k7mr3033545qvu.170.1596118508507;
        Thu, 30 Jul 2020 07:15:08 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:115b])
        by smtp.gmail.com with ESMTPSA id h55sm4768731qte.16.2020.07.30.07.15.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2020 07:15:07 -0700 (PDT)
Date:   Thu, 30 Jul 2020 10:15:06 -0400
From:   Tejun Heo <tj@kernel.org>
To:     Chengming Zhou <zhouchengming@bytedance.com>
Cc:     axboe@kernel.dk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iocost_monitor: start from the oldest usage index
Message-ID: <20200730141506.GB4601@mtj.duckdns.org>
References: <20200730123104.27023-1-zhouchengming@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200730123104.27023-1-zhouchengming@bytedance.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 30, 2020 at 08:31:04PM +0800, Chengming Zhou wrote:
> iocg usage_idx is the latest usage index, we should start from the
> oldest usage index to show the consecutive NR_USAGE_SLOTS usages.
> 
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
