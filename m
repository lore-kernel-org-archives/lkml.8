Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DFC3C3F2CD
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 09:50:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B37020848
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 09:50:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728328AbgCCJuI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 04:50:08 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:11137 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727912AbgCCJuH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 04:50:07 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id AE1EDB7AAA038C916A33;
        Tue,  3 Mar 2020 17:50:04 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.207) with Microsoft SMTP Server (TLS) id 14.3.439.0; Tue, 3 Mar 2020
 17:49:55 +0800
Subject: Re: [PATCH 2/3] erofs: use LZ4_decompress_safe() for full decoding
To:     Gao Xiang <gaoxiang25@huawei.com>, <linux-erofs@lists.ozlabs.org>
CC:     LKML <linux-kernel@vger.kernel.org>, Miao Xie <miaoxie@huawei.com>,
        "Lasse Collin" <lasse.collin@tukaani.org>
References: <20200226023011.103798-1-gaoxiang25@huawei.com>
 <20200226023011.103798-2-gaoxiang25@huawei.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <8c1a119e-7f3d-a42d-3208-d30b476baf73@huawei.com>
Date:   Tue, 3 Mar 2020 17:49:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200226023011.103798-2-gaoxiang25@huawei.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/2/26 10:30, Gao Xiang wrote:
> As Lasse pointed out, "EROFS uses LZ4_decompress_safe_partial
> for both partial and full blocks. Thus when it is decoding a
> full block, it doesn't know if the LZ4 decoder actually decoded
> all the input. The real uncompressed size could be bigger than
> the value stored in the file system metadata.
> 
> Using LZ4_decompress_safe instead of _safe_partial when
> decompressing a full block would help to detect errors."
> 
> So it's reasonable to use _safe in case of corrupted images and
> it might have some speed gain as well although I didn't observe
> much difference.
> 
> Cc: Lasse Collin <lasse.collin@tukaani.org>
> Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
