Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8712AC433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 19:48:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52A492071B
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 19:48:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732153AbgIATsO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 15:48:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726936AbgIATsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 15:48:13 -0400
X-Greylist: delayed 366 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 01 Sep 2020 12:48:13 PDT
Received: from mail.itouring.de (mail.itouring.de [IPv6:2a01:4f8:a0:4463::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C811C061244;
        Tue,  1 Sep 2020 12:48:13 -0700 (PDT)
Received: from tux.applied-asynchrony.com (p5ddd7bcc.dip0.t-ipconnect.de [93.221.123.204])
        by mail.itouring.de (Postfix) with ESMTPSA id EDBD33E15;
        Tue,  1 Sep 2020 21:42:03 +0200 (CEST)
Received: from [192.168.100.223] (ragnarok.applied-asynchrony.com [192.168.100.223])
        by tux.applied-asynchrony.com (Postfix) with ESMTP id A9FD1F01603;
        Tue,  1 Sep 2020 21:42:00 +0200 (CEST)
Subject: Re: [PATCH 5.8 000/255] 5.8.6-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20200901151000.800754757@linuxfoundation.org>
From:   =?UTF-8?Q?Holger_Hoffst=c3=a4tte?= <holger@applied-asynchrony.com>
Organization: Applied Asynchrony, Inc.
Message-ID: <5a6083e7-1ec2-4643-83dd-667bc4ea3251@applied-asynchrony.com>
Date:   Tue, 1 Sep 2020 21:42:00 +0200
MIME-Version: 1.0
In-Reply-To: <20200901151000.800754757@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-09-01 17:07, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.8.6 release.

This one has a bunch of things I care about, so I gave it a try
on both my server & desktop (Gentoo, x86_64). Applies & builds cleanly,
everything working fine: no spontaneous fires or unexpected screams
from the underworld.

Cheers!
Holger
