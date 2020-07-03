Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B04FC433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 03:40:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A54A20737
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 03:40:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="a+n+ymXi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726206AbgGCDkl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 23:40:41 -0400
Received: from terminus.zytor.com ([198.137.202.136]:58803 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725937AbgGCDkk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 23:40:40 -0400
Received: from hanvin-mobl2.amr.corp.intel.com ([192.55.55.45])
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id 0633eVnt1800193
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Thu, 2 Jul 2020 20:40:32 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 0633eVnt1800193
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2020062301; t=1593747633;
        bh=817oCu8K6NZbSa3m7/cJOBsGe3z0gmQJiu7c/e326N0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=a+n+ymXiIIrIXe97vQU0jX0h5wBF/2nvDGCnmMQsbE7hP3weL+UD+vC0IIKcxBQ4u
         llcKVTWJOPx24lHw7+MGSmxvb5vvnPxcxHSja8cF+lzLeA/lHXA9ZM8OH8GsUqe7KO
         aOntkd4MWesL1SBDSDQzKSAXaJCbpKDLClNWVt20yoH3RmmrljoLB4JpB4k3x9qeIg
         UT1VFZwB2gT05Z5s4lYsjvBe9gN/ImG64u8KFKSo6hXk8ZzdnPN57+dZ2N16DnVj7U
         m0BenlB0+RXDIuVGaPYw+XIQwjSwq0dlE/oaRZ8sx0O9AS2s0Ifwq3PxwcPptydLWO
         KBIELBW8lP/2A==
Subject: Re: [PATCH 09/16] initrd: remove the BLKFLSBUF call in handle_initrd
To:     Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org
Cc:     Song Liu <song@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-raid@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20200615125323.930983-1-hch@lst.de>
 <20200615125323.930983-10-hch@lst.de>
From:   "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <514b0176-d235-f640-b278-9a7d49af356f@zytor.com>
Date:   Thu, 2 Jul 2020 20:40:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200615125323.930983-10-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-06-15 05:53, Christoph Hellwig wrote:
> BLKFLSBUF used to be overloaded for the ramdisk driver to free the whole
> ramdisk, which was completely different behavior compared to all other
> drivers.  But this magic overload got removed in commit ff26956875c2
> ("brd: remove support for BLKFLSBUF"), so this call is entirely
> pointless now.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Does *anyone* use initrd as opposed to initramfs anymore? It would seem
like a good candidate for deprecation/removal.

	-hpa

