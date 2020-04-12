Return-Path: <SRS0=29S8=54=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A3C7C2D0EC
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Apr 2020 20:59:45 +0000 (UTC)
Received: from vger.kernel.org (unknown [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D298206E5
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Apr 2020 20:59:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D298206E5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ubuntu.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728205AbgDLU7n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Apr 2020 16:59:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.18]:42362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728180AbgDLU7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Apr 2020 16:59:43 -0400
Received: from youngberry.canonical.com (youngberry.canonical.com [91.189.89.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DC7FC0A3BF5
        for <linux-kernel@vger.kernel.org>; Sun, 12 Apr 2020 13:59:43 -0700 (PDT)
Received: from ip5f5bd698.dynamic.kabel-deutschland.de ([95.91.214.152] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jNjhN-0004xc-Qh; Sun, 12 Apr 2020 20:59:25 +0000
Date:   Sun, 12 Apr 2020 22:59:23 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Zhiqiang Liu <liuzhiqiang26@huawei.com>
Cc:     ebiederm@xmission.com, oleg@redhat.com, tj@kernel.org, guro@fb.com,
        joel@joelfernandes.org, jannh@google.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mingfangsen <mingfangsen@huawei.com>,
        Yanxiaodan <yanxiaodan@huawei.com>,
        linfeilong <linfeilong@huawei.com>
Subject: Re: [PATCH] signal: check sig before setting info in
 kill_pid_usb_asyncio
Message-ID: <20200412205923.a63kxtlqrczhyjwf@wittgenstein>
References: <f525fd08-1cf7-fb09-d20c-4359145eb940@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f525fd08-1cf7-fb09-d20c-4359145eb940@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 30, 2020 at 10:18:33AM +0800, Zhiqiang Liu wrote:
> 
> In kill_pid_usb_asyncio, if signal is not valid, we do not need to
> set info struct.
> 
> Signed-off-by: Zhiqiang Liu <liuzhiqiang26@huawei.com>
> Acked-by: Christian Brauner <christian.brauner@ubuntu.com>

Applied, thanks!
Christian
