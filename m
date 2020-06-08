Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB4E9C433E1
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 01:41:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9AA9206A4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 01:41:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728648AbgFHBlw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Jun 2020 21:41:52 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5859 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728065AbgFHBlw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jun 2020 21:41:52 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 2B368121B37DE8895072;
        Mon,  8 Jun 2020 09:41:49 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.211) with Microsoft SMTP Server (TLS) id 14.3.487.0; Mon, 8 Jun 2020
 09:41:45 +0800
Subject: Re: [f2fs-dev] [PATCH 1/2] fs: docs: f2fs.rst: fix a broken table
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
CC:     Jonathan Corbet <corbet@lwn.net>, <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        Jaegeuk Kim <jaegeuk@kernel.org>
References: <cover.1591137229.git.mchehab+huawei@kernel.org>
 <52f851cb5c9fd2ecae97deec7e168e66b8c295c3.1591137229.git.mchehab+huawei@kernel.org>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <1f9b6b21-4593-8b72-1726-b65a5fd77e10@huawei.com>
Date:   Mon, 8 Jun 2020 09:41:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <52f851cb5c9fd2ecae97deec7e168e66b8c295c3.1591137229.git.mchehab+huawei@kernel.org>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/6/3 6:38, Mauro Carvalho Chehab wrote:
> As reported by Sphinx:
> 
> 	Documentation/filesystems/f2fs.rst:229: WARNING: Malformed table.
> 	Text in column margin in table line 126.
> 
> 	====================== ============================================================
> 	background_gc=%s       Turn on/off cleaning operations, namely garbage
> ...
> 	test_dummy_encryption
> 	test_dummy_encryption=%s
> 	                       Enable dummy encryption, which provides a fake fscrypt
> 	                       context. The fake fscrypt context is used by xfstests.
> 	                       The argument may be either "v1" or "v2", in order to
> 	                       select the corresponding fscrypt policy version.
> 
> This table is now broken, as some texts are bigger than a
> column. While it would be feasible to fix it by adding two extra
> positions at the table, it would still output something wrong,
> as "test_dummy_encryption" would appear on a separate row.
> 
> So, the best solution here seems to remove the table markup.
> 
> The html and PDF output won't be as nice as a table, but it will
> still be reasonable.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
