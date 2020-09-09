Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88689C43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 17:36:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 390E420757
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 17:36:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729251AbgIIRgM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 13:36:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726440AbgIIRgI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 13:36:08 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE625C061573;
        Wed,  9 Sep 2020 10:36:07 -0700 (PDT)
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 5520B37C;
        Wed,  9 Sep 2020 17:36:07 +0000 (UTC)
Date:   Wed, 9 Sep 2020 11:36:06 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Denis Efremov <efremov@linux.com>
Cc:     Harry Wei <harryxiyou@gmail.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: filesystems: replace to_dev() with kobj_to_dev()
Message-ID: <20200909113606.37ffc039@lwn.net>
In-Reply-To: <20200830144135.6956-1-efremov@linux.com>
References: <20200830144135.6956-1-efremov@linux.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 30 Aug 2020 17:41:35 +0300
Denis Efremov <efremov@linux.com> wrote:

> Commit a4232963757e ("driver-core: Move kobj_to_dev from genhd.h to device.h")
> introduced kobj_to_dev() function.
> 
> Signed-off-by: Denis Efremov <efremov@linux.com>
> ---
>  Documentation/filesystems/sysfs.rst                    | 3 +--
>  Documentation/translations/zh_CN/filesystems/sysfs.txt | 3 +--
>  2 files changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/filesystems/sysfs.rst b/Documentation/filesystems/sysfs.rst
> index ab0f7795792b..5a3209a4cebf 100644
> --- a/Documentation/filesystems/sysfs.rst
> +++ b/Documentation/filesystems/sysfs.rst
> @@ -172,14 +172,13 @@ calls the associated methods.
>  
>  To illustrate::
>  
> -    #define to_dev(obj) container_of(obj, struct device, kobj)
>      #define to_dev_attr(_attr) container_of(_attr, struct device_attribute, attr)
>  
>      static ssize_t dev_attr_show(struct kobject *kobj, struct attribute *attr,
>  				char *buf)
>      {
>  	    struct device_attribute *dev_attr = to_dev_attr(attr);
> -	    struct device *dev = to_dev(kobj);
> +	    struct device *dev = kobj_to_dev(kobj);
>  	    ssize_t ret = -EIO;

Applied, thanks.

jon
