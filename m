Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCC8FC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 14:46:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 874BC204EF
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 14:46:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="lxlss0Zn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730508AbgEVOq2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 10:46:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730105AbgEVOqZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 10:46:25 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D8F5C061A0E
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 07:46:25 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id j21so5083347pgb.7
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 07:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PP3NlRQyU9hVtOdAQG1RX9CTlatqPKoXALMeR0iOkSU=;
        b=lxlss0ZnfC4Z/AbhW67TOHU6mhwsl1MwL6RchBIVSr/q+I2CV8QoajVGUif9/k/4sk
         U/t7cSReHxUX/OESlDS5lVyoJVYFtCzkNBSJ8iskjmqqfmuJpp0LSgBFO8YmuJiE4qqu
         PZsB+Gj7MFYbLow6WLjiKlbkYZJt9cXBYrFOFdV+7HT7H4tyKre3aZalNxIF1wbK6SWo
         2RQO994KR8W0zBxufyyT3KUGbdwoMkvZoYYcePbIhBHPsqbUIL0wWNNbPf+KWy2ix2WO
         JSGx86NTWKao51q6tFo82+UH2Hta73TUuqGLCATWgF1MyeynsJfhdtlWnON4Pvs+Lbnh
         TNDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PP3NlRQyU9hVtOdAQG1RX9CTlatqPKoXALMeR0iOkSU=;
        b=AO+nNIPU+XbFMkrc9p7+Ff/ukyPXtGu3zsAM9I67bbTB+B+EuJ9HUmtiiXYW1k0CLY
         UnTiclFb4A6WVZFJiyDt26SIPva0oKTDQMOPyd9U1JRr2gGlHH8FqWDKJGB9kq78bs4U
         vhpacGxBtuIJSeexKVyEQZLLBxSU3yy+rLfMsHB7xgP5ryPjijx6z+eqVf8X0BtQuv76
         AZ/jCoOqcZWjcw5CkaXUZbMPTh9tURkAFaVcvTPnIm5rQYT62o6595YwzpfOOBdjwadt
         +G1M1lLWB7R0qroN40LcRlagrtjHhOwLCB8s6AOzy1VXcGD9/KvGF8njwQXtVbn3lJ+Y
         kCNg==
X-Gm-Message-State: AOAM532OmL1Q9oPtAFA3NW87zhVZ1XkMXXrlCGrUl+CYSb/3gKM55a2F
        w4/mou4FIB8uw+nDWc6aW2qO6YyFzcw=
X-Google-Smtp-Source: ABdhPJyOskFVbu5Q7jztS/JY+dJEhfz7pdsgkS1G8FHxMjsxcwx7mtvJ/wUGWknKrnr7P9rFJfWeCA==
X-Received: by 2002:aa7:9510:: with SMTP id b16mr4234538pfp.265.1590158784741;
        Fri, 22 May 2020 07:46:24 -0700 (PDT)
Received: from ?IPv6:2605:e000:100e:8c61:892a:d4e5:be12:19f? ([2605:e000:100e:8c61:892a:d4e5:be12:19f])
        by smtp.gmail.com with ESMTPSA id mn19sm7014158pjb.8.2020.05.22.07.46.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 May 2020 07:46:24 -0700 (PDT)
Subject: Re: linux-next: build failure after merge of the block tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
References: <20200522213202.38ebe825@canb.auug.org.au>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <7bb2cb93-062c-4ef5-4986-5dd82694edfe@kernel.dk>
Date:   Fri, 22 May 2020 08:46:22 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200522213202.38ebe825@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/22/20 5:32 AM, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the block tree, today's linux-next build (x86_64
> allnoconfig) failed like this:
> 
> fs/libfs.c: In function 'generic_file_fsync':
> fs/libfs.c:1116:9: error: too few arguments to function 'blkdev_issue_flush'
>  1116 |  return blkdev_issue_flush(inode->i_sb->s_bdev, GFP_KERNEL);
>       |         ^~~~~~~~~~~~~~~~~~
> In file included from fs/libfs.c:7:
> include/linux/blkdev.h:1875:19: note: declared here
>  1875 | static inline int blkdev_issue_flush(struct block_device *bdev, gfp_t gfp_mask,
>       |                   ^~~~~~~~~~~~~~~~~~
> 
> Caused by commit
> 
>   c64644ce363b ("block: remove the error_sector argument to blkdev_issue_flush")

Gah, I'll fold in the fix. Thanks Stephen.

-- 
Jens Axboe

