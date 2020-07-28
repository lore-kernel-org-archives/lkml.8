Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F0DFC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 13:13:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49624206D8
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 13:13:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pL1VEAIF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730007AbgG1NNe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 09:13:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729688AbgG1NNd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 09:13:33 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AC99C061794
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 06:13:33 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id m9so9059669qvx.5
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 06:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wVQ4PCIk/Mi+M+QeA/Wca4Cre04s8hgp15ZLx5XfDZg=;
        b=pL1VEAIFMSgD3WD2ciXOwyWiQoTMEvG6XL7SyqSWpiABvpcc2rO2EdXKjFV8xD1lYg
         GNa/yBNZnQO2TMGeoptsApl90kDiJxOFe560qW2avPXvLhtuSxr6PM56HqH/D2yTpR4W
         A9lumU99tKynCllpYhOZmqFC/txXwd22MAwmMG97kVlSetVIujR6IJvngw3jd54H5N5u
         DB+ALBuED2jut236BveYoqI8QiicwZetSaW70xlO3Gd0FhzHhQ3tIJHNkYtNKHtniOYR
         O808Xsd7dyg9KQZUtMVz2awkTt7J0OHzoTs0lTRBcG6LVGKz+tvke6GYErsCZHpsZ4ia
         JT5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wVQ4PCIk/Mi+M+QeA/Wca4Cre04s8hgp15ZLx5XfDZg=;
        b=BNr8rc3HiXfyYparY9BZ/p5mYjcUPMaXvHDA/yt57VldBx5HaO1cSO8DmPLVCl9IsG
         S4wpD5vSAAjKIthOKsqEeWY77jFNBgxODBjE5BTSvkUzL4DivmihxCbcM3ffGxxWlUyd
         1JsIjJXDRucCoiaBUqiM6/+5pm+EMUWHAb3mhr5Lzsq/TfiUxutO1xTluy6z7f6T4JEV
         CpyyJ31zBq0nBnnHg1xevK6LkaabKi4ITi8yNXGZm2enw5OqvhBgAyb0L/FhikIGGpm3
         b1qK1O7M9vpZ+GOhrMaSe5FE9N4mi/fXPpvoE5ZyuEihJzUVJV2LmQn4TWomdtL8ZDuQ
         E6wQ==
X-Gm-Message-State: AOAM532aNc7ypClzGBiBCwB2duK+KuzwotM9jMqwLSbC7W8QdfU+cOQy
        +jtWa5QaDqfTllLBGuX0ligVrBCJIw==
X-Google-Smtp-Source: ABdhPJy6Yk6QbdnipbQ8OQ58GUMrB3Xz1lgcBJcOXLEaYFkhBZnlkY1lFBZAQIoTm0QmsSp5YAdNfQ==
X-Received: by 2002:ad4:5912:: with SMTP id ez18mr25898937qvb.24.1595942011649;
        Tue, 28 Jul 2020 06:13:31 -0700 (PDT)
Received: from PWN (c-76-119-149-155.hsd1.ma.comcast.net. [76.119.149.155])
        by smtp.gmail.com with ESMTPSA id 65sm18057540qkn.103.2020.07.28.06.13.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2020 06:13:31 -0700 (PDT)
Date:   Tue, 28 Jul 2020 09:13:28 -0400
From:   Peilin Ye <yepeilin.cs@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [Linux-kernel-mentees] [PATCH v3] media/v4l2-core: Fix
 kernel-infoleak in video_put_user()
Message-ID: <20200728131328.GA410244@PWN>
References: <20200726220557.102300-1-yepeilin.cs@gmail.com>
 <20200726222703.102701-1-yepeilin.cs@gmail.com>
 <CAK8P3a3NB2BVo9fH-Wcinrhhs-QJ=9dK59Ds83TvgLmEkRy3qA@mail.gmail.com>
 <20200727131608.GD1913@kadam>
 <20200727223357.GA329006@PWN>
 <20200728094707.GF2571@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200728094707.GF2571@kadam>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 28, 2020 at 12:47:07PM +0300, Dan Carpenter wrote:
> On Mon, Jul 27, 2020 at 06:33:57PM -0400, Peilin Ye wrote:
> > On Mon, Jul 27, 2020 at 04:16:08PM +0300, Dan Carpenter wrote:
> > > drivers/block/floppy.c:3132 raw_cmd_copyout() warn: check that 'cmd' doesn't leak information (struct has a hole after 'flags')
> > 
> > (Removed some Cc: recipients from the list.)
> > 
> > I'm not very sure, but I think this one is also a false positive.
> 
> No, it's a potential bug.  You're over thinking what Smatch is
> complaining about.  Arnd is right.
> 
>   3123  static int raw_cmd_copyout(int cmd, void __user *param,
>   3124                                    struct floppy_raw_cmd *ptr)
>   3125  {
>   3126          int ret;
>   3127  
>   3128          while (ptr) {
>   3129                  struct floppy_raw_cmd cmd = *ptr;
>                                               ^^^^^^^^^^
> The compiler can either do this assignment as an memcpy() or as a
> series of struct member assignments.  So the assignment can leave the
> struct hole uninitialized.

I see, I didn't realize this line could cause the issue. Thank you for
pointing this out, I will do this then send a patch:

diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
index 09079aee8dc4..398c261fd174 100644
--- a/drivers/block/floppy.c
+++ b/drivers/block/floppy.c
@@ -3126,7 +3126,8 @@ static int raw_cmd_copyout(int cmd, void __user *param,
        int ret;

        while (ptr) {
-               struct floppy_raw_cmd cmd = *ptr;
+               struct floppy_raw_cmd cmd;
+               memcpy(&cmd, ptr, sizeof(cmd));
                cmd.next = NULL;
                cmd.kernel_data = NULL;
                ret = copy_to_user(param, &cmd, sizeof(cmd));

Thank you,
Peilin Ye

>   3130                  cmd.next = NULL;
>   3131                  cmd.kernel_data = NULL;
>   3132                  ret = copy_to_user(param, &cmd, sizeof(cmd));
>                                                   ^^^^
> potential info leak.
> 
>   3133                  if (ret)
>   3134                          return -EFAULT;
>   3135                  param += sizeof(struct floppy_raw_cmd);
>   3136                  if ((ptr->flags & FD_RAW_READ) && ptr->buffer_length) {
>   3137                          if (ptr->length >= 0 &&
>   3138                              ptr->length <= ptr->buffer_length) {
>   3139                                  long length = ptr->buffer_length - ptr->length;
>   3140                                  ret = fd_copyout(ptr->data, ptr->kernel_data,
>   3141                                                   length);
>   3142                                  if (ret)
>   3143                                          return ret;
>   3144                          }
>   3145                  }
>   3146                  ptr = ptr->next;
>   3147          }
>   3148  
>   3149          return 0;
>   3150  }
> 
> regards,
> dan carpenter
