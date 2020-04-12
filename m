Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=3.0 tests=DATE_IN_PAST_12_24,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19AB3C2BA19
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 07:34:16 +0000 (UTC)
Received: from vger.kernel.org (unknown [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFB852076B
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 07:34:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="USimkyWj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFB852076B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729384AbgDMHeO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 03:34:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.18]:33530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727612AbgDMHeO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 03:34:14 -0400
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB50EC008651
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 00:34:12 -0700 (PDT)
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D5CFE2073E;
        Mon, 13 Apr 2020 07:34:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586763252;
        bh=H+IBjRXlom1TFxVLGFhtyKNUQs9twEnHqO5GU21vrGk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=USimkyWjOQlsc3yQZ8z+4g/qhYbZetmADpwZrDpDmlDno6uNrcgFdWN8rw5xS9LXD
         SQEZTQyAnKdsXyUQuTiwf3cR77+mgebwVCW5iIMzTdXwNW/L5vbBPZZcR7fdRmbbn9
         CzM/lmSYZG6nzdAjhj+7P//Jgr5ujA2a5kqtr7z8=
Date:   Sun, 12 Apr 2020 09:46:29 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Tang Bin <tangbin@cmss.chinamobile.com>
Cc:     arve@android.com, maco@android.com, tkjos@android.com,
        joel@joelfernandes.org, christian@brauner.io,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] binderfs: Fix binderfs.c selftest compilation warning
Message-ID: <20200412074629.GB2707594@kroah.com>
References: <20200411145151.5576-1-tangbin@cmss.chinamobile.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200411145151.5576-1-tangbin@cmss.chinamobile.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 11, 2020 at 10:51:51PM +0800, Tang Bin wrote:
> Fix missing braces compilation warning in the ARM
> compiler environment:
>     drivers/android/binderfs.c: In function 'binderfs_fill_super':
>     drivers/android/binderfs.c:650:9: warning: missing braces around initializer [-Wmissing-braces]
>       struct binderfs_device device_info = { 0 };
>     drivers/android/binderfs.c:650:9: warning: (near initialization for ‘device_info.name’) [-Wmissing-braces]

What compiler and version is giving this warning?  It's odd we have not
seen this yet...

thanks,

greg k-h
