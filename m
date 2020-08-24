Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 437CDC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 02:01:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 151FA20768
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 02:01:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X4fLhJpu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727913AbgHXCBL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Aug 2020 22:01:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727882AbgHXCBL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Aug 2020 22:01:11 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F5BAC061573
        for <linux-kernel@vger.kernel.org>; Sun, 23 Aug 2020 19:01:10 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id d22so4019363pfn.5
        for <linux-kernel@vger.kernel.org>; Sun, 23 Aug 2020 19:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/EPwsOjNAOJnCAlukSWZN+FIBKRBbYip6lL2WUYmrb4=;
        b=X4fLhJpuYLT9HBTn0MCHAO23k+DOxUoepGCYCLJcNCdkw+2uo7fXEY2BA340MEwfCB
         d7ehL2aAhL9p7UzcVSCa/KI+OtxPiIGcHErN1yKPlmoLaZ6JHwHpQv2vcsZ+PkhRQTpI
         QAvDmyLsOe56m9Oi9rNodzo3h6xmKIWMx76q4O7F47NpfdMRMvgxZqwTlgWceDZALmEq
         Pwk9ImMaYtalMkB9TCaYwDXh947gnkugHtsHtH5OFaiXi/nqm7TvgzBU9OEhbldHvpoG
         ABJ70gaXptcBtQYXwkH4Cc8dj8kSy0DBXjfEp/4dNUcGYanJ/nqJeUBNCxyrJgCG8Nxj
         Ma/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/EPwsOjNAOJnCAlukSWZN+FIBKRBbYip6lL2WUYmrb4=;
        b=OBW1Ph4lSn7c9xXe+jiUMxKZNfF+jcCWPYdsw+ES0XAo2N/intqEfODpVDc7ClLZmo
         /QzY8rlNtd54iZe0pWaGOPrjHZMlG5ERyNHz1il/TklIcsn7x6zyC1I1uYfFYCH9ARot
         zHnmStZ4k4zzbJMsUDWpSYtiWtMvgJmBJb7f4ALuKTtWCxOlPK4bvYdcXZk9ZASL3NpO
         ORi0F2rqr0wN1+vnscWBAJt2poVtZzrZKk0O2Oz3s0JyT50SQVUP8awjtG4LmdRFjsN4
         cWZ9eZ72TvrQibSgT8nQOs7mokM/7RAFhs0bVCD7w1kf5F7ecprD6jEVPrEV7Diypogy
         NSlQ==
X-Gm-Message-State: AOAM530INAupJjg8vSOEzMRXoh6/oV5+oLz0hpD4PmZqNavB6ZUtewyC
        0CEnJrOgWSBW5xnvrMXC8lA=
X-Google-Smtp-Source: ABdhPJxFfBdTcZQPgJcrxm+oQh/zQtDnzfKaFDqAVIatruFMa4d8yl7DsgEe6TtRST/nV59dfqRmlg==
X-Received: by 2002:a63:6a47:: with SMTP id f68mr2052164pgc.170.1598234469821;
        Sun, 23 Aug 2020 19:01:09 -0700 (PDT)
Received: from thinkpad (104.36.148.139.aurocloud.com. [104.36.148.139])
        by smtp.gmail.com with ESMTPSA id y72sm9584176pfg.58.2020.08.23.19.01.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2020 19:01:09 -0700 (PDT)
Date:   Sun, 23 Aug 2020 19:01:46 -0700
From:   Rustam Kovhaev <rkovhaev@gmail.com>
To:     Anton Altaparmakov <anton@tuxera.com>
Cc:     "linux-ntfs-dev@lists.sourceforge.net" 
        <linux-ntfs-dev@lists.sourceforge.net>,
        LKML <linux-kernel@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] ntfs: add check for mft record size in superblock
Message-ID: <20200824020146.GA209078@thinkpad>
References: <20200823152147.55766-1-rkovhaev@gmail.com>
 <F206DE99-102C-475D-9129-5B9ACBAED8E6@tuxera.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F206DE99-102C-475D-9129-5B9ACBAED8E6@tuxera.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 24, 2020 at 01:44:06AM +0000, Anton Altaparmakov wrote:
> Hi Rustam,
> 
> Thank you for the patch but it introduces an endianness bug - you have to us le32_to_cpu(m->bytes_allocated) both when doing the comparison and then printing the message.
> 
> Also, please drop the square brackets.  Wherever the driver prints such things it never uses brackets around the numbers and it would be better to have this consistent throughout.
> 
> Can you please resend with the above issues addressed?  You can then also add to the commit message:
> 
> 	Acked-by: Anton Altaparmakov <anton@tuxera.com>
> 
> Thanks!
> 
> Best regards,
> 
> 	Anton
> 
hi Anton,
thank you for the review, my bad, i'll get it fixed and i'll resend the patch
