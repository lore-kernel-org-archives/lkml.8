Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07213C2BB55
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 15:58:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D043720771
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 15:58:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GL7pvYxP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728367AbgDIP6d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 11:58:33 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:42766 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727865AbgDIP6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 11:58:32 -0400
Received: by mail-pf1-f195.google.com with SMTP id 22so4300064pfa.9;
        Thu, 09 Apr 2020 08:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4HttX7fnLVCaSn2ezS9sZMy4gjMZf1fmvfPjQPq5pBk=;
        b=GL7pvYxPnMFE/RUkudbo0OnaSeJX1Z9cEfl12pKTTNNPaEUvrY93DOa4hnpQhip+e0
         mCNYLWoIvaEid3RqLowMU173EkQBW74a/4wj53gJrjtu5iGvyQ4V4Uizsth5YR49eHI+
         Pi23TvOOKtPWsCPmuTvsMHPw/iJt8VjSbg9aOk0gnjKpR3Pc89dnA5UrVY1pzPrelNv3
         FEqDD9d5myKczUnzW+7ctfz0DFtavg66cJY3dj43wzXgcPJSBC2NOc4CZYlBlA6rUALw
         4+yEEGfzuLkWPjCynyLa/wn+TNV0/JiWxQ7GSdpYCRp2Y3XtjuOJmuiXzhezb6EghIvE
         Aayg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=4HttX7fnLVCaSn2ezS9sZMy4gjMZf1fmvfPjQPq5pBk=;
        b=t2qiPD++V8PkVF04t3WLrUWuAa/9Ml3l9M6lj5ZtYAed8x6QABFvgiK3L1bFwM8xM5
         12wxJ9LTGrceTRYEvcuaFkUteoN3OnsElzoOQHaC+ynVTpfxOKfR320BJFw/Xwn/Db23
         waGdPyTmR0o8RJZ+rN8GVcGQQUYnHqj6r6Johd3dSoZqjbOeP0tCcnzVDrZyK7Ckfq4c
         eamqd+i96bpl0Qqzi8XtqWu2wz01QQ1uLdyzZpaRWCmAbqdBUW5HrIIdLyARFYTFJNRp
         GYSnBUfV+u4PwjfTGmRG9Ec/wkGqbh7pz3hovBFiJZG6bNMhbJrMVnOUkRHaF3v9VGTD
         tNsg==
X-Gm-Message-State: AGi0Puao0Xa6g3Fn9MU/CEbixAI0sIno/rW0fxvaddVy7Zqlza7JMidY
        wTblXS2bNIit3ANSR/hSPVs=
X-Google-Smtp-Source: APiQypJ8B3DMZmM2Yv12592zLTV5MRsJQH0aU8e2WQ3tTwqMDsenkDCcW/skwUVPy3VLGpAepFxE/A==
X-Received: by 2002:a63:b954:: with SMTP id v20mr136164pgo.100.1586447912058;
        Thu, 09 Apr 2020 08:58:32 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id m14sm2564094pje.19.2020.04.09.08.58.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 Apr 2020 08:58:31 -0700 (PDT)
Date:   Thu, 9 Apr 2020 08:58:30 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Jason Yan <yanaijie@huawei.com>
Cc:     clemens@ladisch.de, jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] hwmon: (k10temp) make some symbols static
Message-ID: <20200409155830.GA99897@roeck-us.net>
References: <20200409084502.42126-1-yanaijie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200409084502.42126-1-yanaijie@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 09, 2020 at 04:45:02PM +0800, Jason Yan wrote:
> Fix the following sparse warning:
> 
> drivers/hwmon/k10temp.c:189:12: warning: symbol 'k10temp_temp_label' was
> not declared. Should it be static?
> drivers/hwmon/k10temp.c:202:12: warning: symbol 'k10temp_in_label' was
> not declared. Should it be static?
> drivers/hwmon/k10temp.c:207:12: warning: symbol 'k10temp_curr_label' was
> not declared. Should it be static?
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Jason Yan <yanaijie@huawei.com>

Applied.

Thanks,
Guenter
