Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E741C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 05:25:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1D3A208DB
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 05:25:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726384AbgIAFZz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 01:25:55 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:27611 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726044AbgIAFZy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 01:25:54 -0400
X-IronPort-AV: E=Sophos;i="5.76,378,1592841600"; 
   d="scan'208";a="98760910"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 01 Sep 2020 13:25:52 +0800
Received: from G08CNEXMBPEKD06.g08.fujitsu.local (unknown [10.167.33.206])
        by cn.fujitsu.com (Postfix) with ESMTP id 7C7D348990F7;
        Tue,  1 Sep 2020 13:25:50 +0800 (CST)
Received: from [10.167.226.60] (10.167.226.60) by
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Tue, 1 Sep 2020 13:25:49 +0800
Subject: Re: [PATCH] Documentation/x86/boot.rst: minor improvement
From:   Cao jin <caoj.fnst@cn.fujitsu.com>
To:     <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <x86@kernel.org>
CC:     <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <hpa@zytor.com>, <corbet@lwn.net>
References: <20200901034157.5482-1-caoj.fnst@cn.fujitsu.com>
Message-ID: <da11d436-8910-f560-e132-827132576f1d@cn.fujitsu.com>
Date:   Tue, 1 Sep 2020 13:25:53 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200901034157.5482-1-caoj.fnst@cn.fujitsu.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.167.226.60]
X-ClientProxiedBy: G08CNEXCHPEKD05.g08.fujitsu.local (10.167.33.203) To
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206)
X-yoursite-MailScanner-ID: 7C7D348990F7.A9DD8
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: caoj.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, I mis-copied 2 addresses. make sure they are CCed.

On 9/1/20 11:41 AM, Cao jin wrote:
> Typo fix & file name update
> 
> Signed-off-by: Cao jin <caoj.fnst@cn.fujitsu.com>
> ---
>  Documentation/x86/boot.rst | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/x86/boot.rst b/Documentation/x86/boot.rst
> index 7fafc7ac00d7..c04afec90486 100644
> --- a/Documentation/x86/boot.rst
> +++ b/Documentation/x86/boot.rst
> @@ -1379,7 +1379,7 @@ can be calculated as follows::
>  In addition to read/modify/write the setup header of the struct
>  boot_params as that of 16-bit boot protocol, the boot loader should
>  also fill the additional fields of the struct boot_params as described
> -in zero-page.txt.
> +in zero-page.rst.
>  
>  After setting up the struct boot_params, the boot loader can load
>  64-bit kernel in the same way as that of 16-bit boot protocol, but
> @@ -1391,7 +1391,7 @@ In 64-bit boot protocol, the kernel is started by jumping to the
>  
>  At entry, the CPU must be in 64-bit mode with paging enabled.
>  The range with setup_header.init_size from start address of loaded
> -kernel and zero page and command line buffer get ident mapping;
> +kernel and zero page and command line buffer get identity mapping;
>  a GDT must be loaded with the descriptors for selectors
>  __BOOT_CS(0x10) and __BOOT_DS(0x18); both descriptors must be 4G flat
>  segment; __BOOT_CS must have execute/read permission, and __BOOT_DS
> 


-- 
Sincerely,
Cao jin


