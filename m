Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4318C47438
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 18:10:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A869248F3
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 18:03:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599242633;
	bh=ccyx3QqIPtjL3bI9RNp1tboe5Yo1AeKfWAAnxyqAHV8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=UcQ99unn3XoQlAhM+Q9qa+02KvO1GrzANbDPpEXUBTKSGBgc8s3qmXrXKDlQepzvG
	 LOEPIWgoOCPAOM+whrisbszMbOHQj64eGzjtM91nxHwmlTqA4xh4sQGe/ykrPqB0HS
	 v575HFjS+5bn0n9zk+vDlXM5ihdEdNRXOOkyTr6Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727004AbgIDRLs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 13:11:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726127AbgIDRLr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 13:11:47 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E4F1C061244
        for <linux-kernel@vger.kernel.org>; Fri,  4 Sep 2020 10:11:47 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id b13so3368099qvl.2
        for <linux-kernel@vger.kernel.org>; Fri, 04 Sep 2020 10:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Wg+0AXi/s7873Utji8lGdFF3pkA/ZiGcFAsTC0mgF5I=;
        b=XCP0Z52zDX52O8oyqtuDs271FnpFMYUARRwf/flhD1j8rgajfs+xBsqJVST+lpzFhe
         K0Sl/vXklct/Vu2RUQgkuZBh7rGJZYbZNpWYIhUDHfSv0JowLSXEcC8MoHmFwEbVRqoH
         kVuRK6SITHf9paGSgkTS4ZX4NeOK4AgYL3ZfelmtVNyLFx9M4odCIN70cE+TwnZd4Vf3
         3gzTmhFUKF0OzzUwt332Zhv3T4RHftwdruhrfYREpedbIsSeAhz7ZaECvyUJYr4dC6CI
         3ua/MQpkEoBQuDRqC+1SrAtgFWKD9o07Wdr2Yxmy8kSmKTK1Pb6KYZUJZOufisecrfqy
         ssjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=Wg+0AXi/s7873Utji8lGdFF3pkA/ZiGcFAsTC0mgF5I=;
        b=FQpDOjTDOh0ISlg+wkoa8pVswVVXBAQuXqWoiZSBgweZqHNxOSJjfPwhvAdnmlebmL
         VeIW3lPpljh5JmhV3xhwtWNaH0gSbe5wVMofR3rti6xndyW0r5ktMDBcvt9oOgWZWJ5L
         MHs/D+ScE3dBKfXLLuAgSfFQuzBK2eFzeBpF5ltEsmaBdTu84qeP6MJ/16GJG2rfxJyY
         Y0yrx+c1iS+oFFU+snIMeLFyroEn/+Jmt8K/+VOLllDLlgJBidcMiD/IO9IYF5YhzyGY
         idbLk9CTk5De4CllMCVyYQSITu8aOjL4i6iNylFvKSuZcrxi/+mrLJ7y/Fm9GRh6EHCD
         avYA==
X-Gm-Message-State: AOAM530XyhBB1AMxg0HwOF6WJlroSp4XMQt37c7IvmSwSuhD7nSX+p4i
        3QkuaHbqJQudbtFtZCJyNJk=
X-Google-Smtp-Source: ABdhPJyFDg5LmrqhLFVeV+w0tI7N3ZIpM4ib7aztm30+mn4A1PCYiBzR1ftDQ7JzH5bvPCLY5xCs4w==
X-Received: by 2002:a0c:f945:: with SMTP id i5mr8675746qvo.80.1599239506420;
        Fri, 04 Sep 2020 10:11:46 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:f2f5])
        by smtp.gmail.com with ESMTPSA id g4sm4824209qth.30.2020.09.04.10.11.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2020 10:11:45 -0700 (PDT)
Date:   Fri, 4 Sep 2020 13:11:44 -0400
From:   Tejun Heo <tj@kernel.org>
To:     linmiaohe <linmiaohe@huawei.com>
Cc:     jiangshanlai@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] workqueue: Use wake_up_worker() to wake up first idle
 worker
Message-ID: <20200904171144.GD4295@mtj.thefacebook.com>
References: <1595852969-21049-1-git-send-email-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1595852969-21049-1-git-send-email-linmiaohe@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 27, 2020 at 08:29:29PM +0800, linmiaohe wrote:
> From: Miaohe Lin <linmiaohe@huawei.com>
> 
> Use wrapper function wake_up_worker() to wake up first idle worker.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Applied to wq/for-5.10.

Thanks.

-- 
tejun
