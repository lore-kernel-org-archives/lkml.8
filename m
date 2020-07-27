Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9482EC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 22:34:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F7F620729
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 22:34:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hh3U81Gh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727064AbgG0WeB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 18:34:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726171AbgG0WeA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 18:34:00 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E573C061794
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 15:34:00 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id di5so8247071qvb.11
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 15:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qdRJPfeh5unLgeU8AmitK4ZcKNveusAvABQiizyUCDs=;
        b=hh3U81GhCy8kQSwX8BCigvuYF0zagijulCGFoytEaIYbrGxnz4puPKlCb9AuPxk+aF
         2Quut0UsjOaOClJRMvcjQjVts5Sm6ipo3/Hktv7Iep6RzEfEsHKgOoiUlN6IWLwc0J9L
         PrFlFUwd7PqM4vj2owBZuLDLHCugFabY/GeNK/iiKjUpSYfYv/lxgBUNisVgzeZu/26Y
         epEqhW8VSn0VRxB8QKM5y7aPJpsTl7Z4JbQwqZjKIs/nmo3VX1F4OBNbKPctT0Jt4DEh
         T6wwYLfXTcFheUSUkCnjuU2m8FTj8iviMFQuZejdEXBCcs0BeglwCcJKn3CbgOy5IuK+
         xHuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qdRJPfeh5unLgeU8AmitK4ZcKNveusAvABQiizyUCDs=;
        b=Ut1DxrfjlRFQlLAUQvo9R1dAkb4E4MJOsMDHrxi8nIpPncg8XStrqbUW9Iyfn301m/
         5JBFwpXmsg/yweswyjgd4KqgJ6m+pJEnzxpkzCYxXRrScF06/kIzC7NP1On0tvI7L5m0
         TxfCIGeNU5f3w/wu6oBseCzUAcMdDoBMoxXm4Tw7AUW3/oEcj6RdHSQb5S+pXYqTZ5Xh
         81ix9XblvCBeWhxtNfZGpSS5TZKUm9j3EEYEvrLYMrKEL009n4DOri5LgqXojwqS2l07
         1tJd3M+9rM766KTDsb2PGS1fUq2NFbk0oNtsAlDnDzi9vzsGZqvAgUYfEHo4chI/U/dj
         OQZg==
X-Gm-Message-State: AOAM533z7RfDJZYt1f2LM+9pA3vVHOp5RfN/ErS+C+sIvJxyL7b9Ze7X
        xRFEMVFXWdD83Ow06lc74P0aT5JnOA==
X-Google-Smtp-Source: ABdhPJwZ1I1WmUcL7yD7/isTmdXBnVJZX/XmomlAIyrrdEd1/vNKh8c+rv/2d9uwmtKD0r5KESK3iQ==
X-Received: by 2002:a0c:a306:: with SMTP id u6mr24953891qvu.88.1595889239764;
        Mon, 27 Jul 2020 15:33:59 -0700 (PDT)
Received: from PWN ([209.94.141.207])
        by smtp.gmail.com with ESMTPSA id n68sm21044944qkd.89.2020.07.27.15.33.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2020 15:33:59 -0700 (PDT)
Date:   Mon, 27 Jul 2020 18:33:57 -0400
From:   Peilin Ye <yepeilin.cs@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [Linux-kernel-mentees] [PATCH v3] media/v4l2-core: Fix
 kernel-infoleak in video_put_user()
Message-ID: <20200727223357.GA329006@PWN>
References: <20200726220557.102300-1-yepeilin.cs@gmail.com>
 <20200726222703.102701-1-yepeilin.cs@gmail.com>
 <CAK8P3a3NB2BVo9fH-Wcinrhhs-QJ=9dK59Ds83TvgLmEkRy3qA@mail.gmail.com>
 <20200727131608.GD1913@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200727131608.GD1913@kadam>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 27, 2020 at 04:16:08PM +0300, Dan Carpenter wrote:
> drivers/block/floppy.c:3132 raw_cmd_copyout() warn: check that 'cmd' doesn't leak information (struct has a hole after 'flags')

(Removed some Cc: recipients from the list.)

I'm not very sure, but I think this one is also a false positive.

Here Smatch is complaining about a linked list called `my_raw_cmd`
defined in raw_cmd_ioctl():

drivers/block/floppy.c:3249:

	ret = raw_cmd_copyin(cmd, param, &my_raw_cmd);

In raw_cmd_copyin(), each element of the linked list is allocated by
kmalloc() then copied from user:

drivers/block/floppy.c:3180:

loop:
	ptr = kmalloc(sizeof(struct floppy_raw_cmd), GFP_KERNEL);
	      ^^^^^^^
	if (!ptr)
		return -ENOMEM;
	*rcmd = ptr;
	ret = copy_from_user(ptr, param, sizeof(*ptr));
	      ^^^^^^^^^^^^^^

I think copy_from_user() is filling in the paddings inside `struct
floppy_raw_cmd`?

Thank you,
Peilin Ye
