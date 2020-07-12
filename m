Return-Path: <SRS0=5Khs=AX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DC65C433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jul 2020 14:47:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 294C82067D
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jul 2020 14:47:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CP+nep1z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728865AbgGLOm3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jul 2020 10:42:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728786AbgGLOm3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jul 2020 10:42:29 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CD63C061794
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jul 2020 07:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=8PQTd+bknAVPnrNGvl0PEMnX7aqFU1TM3kH3Dmuty4c=; b=CP+nep1ztvKG57pBw56SDDGBcr
        WGuJwkUdjmGIobceRpQkLnzJEWv6a7vj7BIhJJXkBkCz23rwMWNkOcdXafRWVofjzVx3GGar2Wv80
        sqAdP67U1FEEbVlccsHj/ASwIl0WEb1mAKngjeOJ9buZewMyuaaQawpsIF31KiEUbMNlBpPD9Zzxm
        eVwyVca2voACv9b5XAqsWxcoDC/j/MM7OrEUPv4KbV3RjHaadnxG/WEbeluI6H+iCiQ8+hkmTuZbT
        hC3225gKH6pI00xKwin77MgzTR354pdcrDSVdLXa6Vp2wp2HuMUFzUh/9VuMnt6/ozIllUvIl1VpK
        RvBwO5nQ==;
Received: from [2601:1c0:6280:3f0:897c:6038:c71d:ecac]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1judBK-0004GB-HZ; Sun, 12 Jul 2020 14:42:19 +0000
Subject: Re: [PATCH 04/20] dlb2: add device ioctl layer and first 4 ioctls
To:     Gage Eads <gage.eads@intel.com>, linux-kernel@vger.kernel.org,
        arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     magnus.karlsson@intel.com, bjorn.topel@intel.com
References: <20200712134331.8169-1-gage.eads@intel.com>
 <20200712134331.8169-5-gage.eads@intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <68d23285-9028-a70d-1dee-f044c507109d@infradead.org>
Date:   Sun, 12 Jul 2020 07:42:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200712134331.8169-5-gage.eads@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/12/20 6:43 AM, Gage Eads wrote:
> +/********************/
> +/* dlb2 ioctl codes */
> +/********************/
> +
> +#define DLB2_IOC_MAGIC  'h'

Hi,
This magic value should be documented in
Documentation/userspace-api/ioctl/ioctl-number.rst.

thanks.
-- 
~Randy

