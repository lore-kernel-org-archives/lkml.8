Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B722C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 14:03:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17CCC2083B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 14:03:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tWcyINfG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726890AbgGQODb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 10:03:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbgGQODa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 10:03:30 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28AF9C0619D3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 07:03:30 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id z15so11231506wrl.8
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 07:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=RbOdxTlyI/3XAl9I0H4CmZU9SzIOJB1OUydhqh4FBss=;
        b=tWcyINfGOtyDShLYeEK02hBFV/l5a8CG8sfXDhxwe+Br8WJ4vwIhzGNfuvJiLqaZHd
         TTNVHLIBC24RsTN0lmiQqTokcUZxSc2/hcXzfMy0zf9dja11DF6n1JVaSmUVK4AqFM4Z
         LZfF6/KmbEMGVJwKIxp0aEY5/FDuB9L3Cj2qVb6+kXXYZMH65TRY2ylJWVh2FgvF2Fjh
         6O7sa2cJNofLopOOukDUGbEvoPkGt5rTZRGGvYTqrFGJ93TYlfZGiATRbeqbA9eZUUqI
         MCvBYTjcUyUlHL+UnGMthgs8bqfyfU6sJpCu+tNIPzkzbdGAcbZX3htNgcl3b6khbQxJ
         +RLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=RbOdxTlyI/3XAl9I0H4CmZU9SzIOJB1OUydhqh4FBss=;
        b=CZNKQSc2iIX2pTiVg6yIq/RagcWjQ+G1v/OnI75KEX4KpdapvsSXi0XLF0EXgaDHjh
         QsDfmdtguhziJGjNdQaj/X7RuWuRQIF17Gca5ClYnINSxOs6FTNnYm85qgt2PAl/OZ5z
         /2lwJcdJC7Ij+zQU7BDQHanSheU1EBvzINROHo22QY1JLfTv7bLf/3QSz+SiANzypk8t
         gMjDj0rdsmeXQkdpZN+2GZDHaN3R5Sc3BoQlOiuZIph4GfM/Mr+5MXZ4UuHDU4AwdRnj
         FWGicy2+kV3CaGbkAjwWCmE2StnD14YVbfu+jQcZC+Hiy4j5jd+/rB+bruLiUXFUnWCS
         I0lg==
X-Gm-Message-State: AOAM533SwzdFw1qq6IRZTtnkr2cTo6M2Mm2gUYcB+SFuIfbKPTW1vqbM
        lwerHsxcvAogIeS69tnxTIQi5Q==
X-Google-Smtp-Source: ABdhPJztHsBgGovks545WPzg+s4wqHMB3T2D1WGezjpsODG5+6zyHP9SWLYPg6/frHageCw2tVb7KA==
X-Received: by 2002:a5d:4687:: with SMTP id u7mr11091880wrq.357.1594994608729;
        Fri, 17 Jul 2020 07:03:28 -0700 (PDT)
Received: from dell ([2.27.167.94])
        by smtp.gmail.com with ESMTPSA id w13sm14635829wrr.67.2020.07.17.07.03.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 07:03:28 -0700 (PDT)
Date:   Fri, 17 Jul 2020 15:03:26 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     syzbot <syzbot+2fa4c81b0e82fb808f38@syzkaller.appspotmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
        sfr@canb.auug.org.au, syzkaller-bugs@googlegroups.com
Subject: Re: linux-next build error (10)
Message-ID: <20200717140326.GJ3165313@dell>
References: <00000000000018715505aaa390ed@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <00000000000018715505aaa390ed@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Jul 2020, syzbot wrote:

> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    aab7ee9f Add linux-next specific files for 20200717
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=123cefcf100000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=66b5d44ee3d87c99
> dashboard link: https://syzkaller.appspot.com/bug?extid=2fa4c81b0e82fb808f38
> compiler:       gcc (GCC) 10.1.0-syz 20200507
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+2fa4c81b0e82fb808f38@syzkaller.appspotmail.com
> 
> drivers/mfd/mfd-core.c:147:17: error: implicit declaration of function 'of_read_number' [-Werror=implicit-function-declaration]

This is fixed already, but thanks for the heads-up.

> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
