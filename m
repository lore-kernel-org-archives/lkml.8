Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B491DC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 15:07:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E1E520738
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 15:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591024048;
	bh=6XPSzDvLbMyIOacmUWm58GtdKy1BITFv/22cBq6lq00=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Gkon/BkiKhnSCEFay56pjrxO1WqzsvSAKQzEFnTbfh0/FX8aAX1+bz71qFkfZ5JAD
	 Oih96T/RMoHbomQpk3zSpAm6G2ms4R7wFjAOmBLX7mwljHIrhs56ClNcQ9oCm3+wyM
	 seYg4vBfbz0fStbtwgSZaYqO5gLvDlmi7/ocHRuU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727921AbgFAPH2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 11:07:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726289AbgFAPH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 11:07:27 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39EA5C05BD43
        for <linux-kernel@vger.kernel.org>; Mon,  1 Jun 2020 08:07:26 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id i16so1264358qtr.7
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jun 2020 08:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dDYZB9lTVYeHtCAtfKzkccxai0YTPwdjfV3JZa59HxI=;
        b=hMTe61Xoczz59gLGp+3uonxURMPP96pxbQPuRnrTdmN9rcPdz3NbJTdUxHNKi36Lvh
         QpwZGMbYP+O5B6ux9Z1z/VIA4CaNeKtjuRsY+1YCVUsN16uTHCp6hvNLbv6kHuKIr+NW
         nMaGvbIacwyztMmU1d2hMeeAj5xepsTTqZovTjcjsgsAAPDVlhKhwmhtGxpL3n1qHaQR
         pP5KA95VYSmUH3BcNQo3O4ltoV61OUB8o7zEDcyydnNE+AcYxsfHQbIyYuEdff9h3lKy
         /w8ui8z69sIKdZZgTWnAU5tAr5YFzt1T214BsBL1HwITD/jmTJqjDSRLvtNL7S3pJpng
         aVbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=dDYZB9lTVYeHtCAtfKzkccxai0YTPwdjfV3JZa59HxI=;
        b=OzADk2k7BoPmF7AAjELk9L/hHxInPYZfoCIxCYT0jFYbYK8BstUj8ZVJEjCuwDkFt8
         1uac+ym3tygI3BvFq+L1ELdM8DVHHjY2G+NOXH3+7/5luHuY0WhholWtLfNuir02s83l
         HRmfGk+6yaI5YJe5/QhKj7wp/iF5AymY0XAaCFcj/mRTjj76jfj1Bv/M7JDkL/eG/L0R
         Ev9Ll5po9seXfyWCc2ksLHRxJw59cxEX4gpoqtjuyfYJ2zWbUSIcMvhomIzhFGMmoj9i
         d76rU2wep2es0K0DpKGUCXMv4/WoBI+w/L8jOPF35OyPVPY2/fD5R162tdCH2d1pa8wi
         W8Pw==
X-Gm-Message-State: AOAM533JIZNl9tDfG7EMWlFtONAFBYCtk1gmB3JKwr3fEM4pqdJ/0/JZ
        k84ffAoKbvlRv86WH7Sy6lnqkBOb
X-Google-Smtp-Source: ABdhPJxmiEXWhtkFsJ5xe/vmIPNBJ6V/BnYLkhUNOfkrdbMXxCiwsBAwL+h445oZ6XP6sMGCwdUp+g==
X-Received: by 2002:ac8:6edb:: with SMTP id f27mr21576146qtv.325.1591024045216;
        Mon, 01 Jun 2020 08:07:25 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:eb8b])
        by smtp.gmail.com with ESMTPSA id p6sm8785338qtd.91.2020.06.01.08.07.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2020 08:07:24 -0700 (PDT)
Date:   Mon, 1 Jun 2020 11:07:23 -0400
From:   Tejun Heo <tj@kernel.org>
To:     Lai Jiangshan <laijs@linux.alibaba.com>
Cc:     linux-kernel@vger.kernel.org,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: [PATCH 4/4] workqueue: slash half memory usage in 32bit system
Message-ID: <20200601150723.GA31548@mtj.thefacebook.com>
References: <20200601084442.8284-1-laijs@linux.alibaba.com>
 <20200601084442.8284-5-laijs@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200601084442.8284-5-laijs@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 01, 2020 at 08:44:42AM +0000, Lai Jiangshan wrote:
> The major memory ussage in workqueue is on the pool_workqueue.
> The pool_workqueue has alignment requirement which often leads
> to padding.
> 
> Reducing the memory usage for the pool_workqueue is valuable.
> 
> And 32bit system often has less memory, less workqueues,
> less works, less concurrent flush_workqueue()s, so we can
> slash the flush color on 32bit system to reduce memory usage
> 
> Before patch:
> The sizeof the struct pool_workqueue is 256 bytes,
> only 136 bytes is in use in 32bit system
> 
> After patch:
> The sizeof the struct pool_workqueue is 128 bytes,
> only 104 bytes is in use in 32bit system, there is still
> room for future usage.
> 
> Setting WORK_STRUCT_COLOR_BITS to 3 can't reduce the sizeof
> the struct pool_workqueue in 64bit system, unless combined
> with big refactor for unbound pwq.

Have you calculated how much memory is actually saved this way on a typical
system?

Thanks.

-- 
tejun
