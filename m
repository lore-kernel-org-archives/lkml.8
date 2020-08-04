Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD7A3C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 07:48:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABF1622B45
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 07:48:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596527332;
	bh=HGontRWxCYghMSz4ZGc0b8/EA8pm9V6ud6CvntyG8ok=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=xzDOO/DW0iWiMG987EcgFCEFg3dCePIvh0JeIOKt5sptWa+NMKClBWOV005fFSbKz
	 K71+0HLLG31UGY8JzIzAi/Td4SLqCQv59tGXx0iGMzRupG/aTRbKTrV+s4g19IyZJh
	 NetIylgKryioSQggar93pvEza+iWxKklg6g5R4sc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728500AbgHDHsv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 03:48:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:54240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726722AbgHDHsu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 03:48:50 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 32EAF22B40;
        Tue,  4 Aug 2020 07:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596527330;
        bh=HGontRWxCYghMSz4ZGc0b8/EA8pm9V6ud6CvntyG8ok=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kUvso19X1j14yNWq/8C7RuCKp5AlFUUBda4FIUT6Z6jQ9srcMO1Jr1XJaRlDIQVUj
         42GDQQJDsZf1ncxUYflFG6ASDfblxRZYpPDvEB7eBKlhW5+lhRiBS9Uyn9djuebo9J
         IPjB4zFSIgqmJlY4tMu6Gmpxl/SkiqjA90dBs+Lg=
Date:   Tue, 4 Aug 2020 09:48:31 +0200
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     =?utf-8?B?5ZCz5piK5r6E?= Ricky <ricky_wu@realtek.com>
Cc:     Chris Clayton <chris2553@googlemail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "philquadra@gmail.com" <philquadra@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: PATCH: rtsx_pci driver - don't disable the rts5229 card reader
 on Intel NUC boxes
Message-ID: <20200804074831.GB1761483@kroah.com>
References: <862172f0-cd23-800c-27b1-27cb49e99099@googlemail.com>
 <a9a94d7f-4873-7a10-4911-f3c760257c5c@googlemail.com>
 <5729c72bbc2740d3917619c85e2fde58@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5729c72bbc2740d3917619c85e2fde58@realtek.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 04, 2020 at 02:44:41AM +0000, 吳昊澄 Ricky wrote:
> Hi Chris,
> 
> rtsx_pci_write_register(pcr, FPDTL, OC_POWER_DOWN, OC_POWER_DOWN);
> This register operation saved power under 1mA, so if do not care the 1mA power we can have a patch to remove it, make compatible with NUC6
> We tested others our card reader that remove it, we did not see any side effect 
> 
> Hi Greg k-h,
> 
> Do you have any comments? 

comments on what?  I don't know what you are responding to here, sorry.

greg k-h
