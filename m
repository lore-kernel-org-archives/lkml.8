Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 592F1C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 08:04:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 23C6A2177B
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 08:04:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729667AbgIHIET (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 04:04:19 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:43478 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729566AbgIHICB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 04:02:01 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id CC0F86FC8FB9F0E75DEE;
        Tue,  8 Sep 2020 16:01:59 +0800 (CST)
Received: from [10.67.102.197] (10.67.102.197) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.487.0; Tue, 8 Sep 2020 16:01:49 +0800
To:     <jack@suse.cz>, <amir73il@gmail.com>
CC:     <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <wangle6@huawei.com>
From:   Xiaoming Ni <nixiaoming@huawei.com>
Subject: Question: Why is there no notification when a file is opened using
 filp_open()?
Message-ID: <25817189-49a7-c64f-26ee-78d4a27496b6@huawei.com>
Date:   Tue, 8 Sep 2020 16:01:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.0.1
MIME-Version: 1.0
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.197]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The file opening action on the system may be from user-mode sys_open() 
or kernel-mode filp_open().
Currently, fsnotify_open() is invoked in do_sys_openat2().
But filp_open() is not notified. Why? Is this an omission?

Do we need to call fsnotify_open() in filp_open() or  do_filp_open() to 
ensure that both user-mode and kernel-mode file opening operations can 
be notified?

Thanks
Xiaoming Ni
