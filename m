Return-Path: <SRS0=qKPt=7M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD04FC433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 21:19:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B01D42076B
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 21:19:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tNpSqQ5V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729375AbgE3VTo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 May 2020 17:19:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728741AbgE3VTn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 May 2020 17:19:43 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B718C03E969
        for <linux-kernel@vger.kernel.org>; Sat, 30 May 2020 14:19:43 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id x1so5539614ejd.8
        for <linux-kernel@vger.kernel.org>; Sat, 30 May 2020 14:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=brLuk/7nKmQrq9OdsWk89Pl0Pl7TBX9LKXsVmuQiI/s=;
        b=tNpSqQ5VC34UhuLF6P7w6PvXgsmGVU9DiLW8qcRDHAARcmlP7upty+uniT+lFNdC/1
         ar6UZGyI7GH5UQfIbPiqxt8BJLYXWkNmbz0DICXqvgQfpuIVSLkHrlaXmxyQTv5AQ+2v
         gVOrIJUy2f0ps8czEo459gRt3BqmbUHqESTjMrmW8EI6L3hthmhKVkwNNWFsxd66Z7C8
         Z94FAbCPNxq/a7nozA2pVcF1uim1qOo3gG5vA+em0oY5NDYB8Wx/bBeb6YyYgMhUG2Bj
         6tFUa2A6PlEGiF5ti/3If1TiV92Rs1N9cFO6ALboc6iFMTUSvlIYzoRQST+RWphENF+X
         DMTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=brLuk/7nKmQrq9OdsWk89Pl0Pl7TBX9LKXsVmuQiI/s=;
        b=BWQOO2Hm4ra1UUVg+/GQONssa8pqWCeBsjHzkt6bR+/Xc+9ME/inEeDEjXd3ecS1cw
         pMp2WwTBAEhCeCHQn+jgHK0SdGGAWSfiL+T1T2Mc9GcCJShaxj7DLcQET/Ce5Ah9augW
         T4HdhyWo4CLPg/kXE8GsOOczC8VlDpSb/8Vnh/P0bBicXom//5eeZI777PwY6hio8d/D
         tU2bi3j/Y7unfbmxyK+8yXwVDg6ZLfb/ZEFK43ySSfuJpn4u2G+K/WDD7ViiIe4JbYVI
         I5MEDN7lBphFYIc5onC6S9jV7VTiYiV4/cApPtO+YmjV00cpnODCPqzadv9ucFyVJsCf
         H67A==
X-Gm-Message-State: AOAM531mqlP1Bz6FXFR4hOX4SP0l7YSAGqzGvgLZ4ZK5HOhr2lSbXNbB
        osYWBec0PM0CcKYp26e4y6A=
X-Google-Smtp-Source: ABdhPJxEPmJSTZgaLJr2rg6ytiY4FLnN/AGl8motcUKiqWvL1Uj9euFeNlfHcKA6w5ikVPGrjFD0/w==
X-Received: by 2002:a17:906:5285:: with SMTP id c5mr2813445ejm.372.1590873581808;
        Sat, 30 May 2020 14:19:41 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id c34sm11112129edd.7.2020.05.30.14.19.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 30 May 2020 14:19:40 -0700 (PDT)
Date:   Sat, 30 May 2020 21:19:40 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Wei Yang <richard.weiyang@gmail.com>, akpm@linux-foundation.org,
        christian.brauner@ubuntu.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lib: make a test module with get_count_order/long
Message-ID: <20200530211940.yninqlngnzfvsvki@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20200530004328.30530-1-richard.weiyang@gmail.com>
 <20200530102531.GA1634618@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200530102531.GA1634618@smile.fi.intel.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 30, 2020 at 01:25:31PM +0300, Andy Shevchenko wrote:
>On Sat, May 30, 2020 at 12:43:28AM +0000, Wei Yang wrote:
>> A test module to make sure get_count_order/long returns the correct result.
>
>>  lib/Kconfig.debug                  | 13 ++++++
>>  lib/Makefile                       |  2 +
>>  lib/test_getorder.c                | 64 ++++++++++++++++++++++++++++++
>
>I didn't get why it's not a part of test_bitops?
>

I see the document of test_bitops says it does exercise on clear_bit and
set_bit. So not sure it is proper to put them together.

>-- 
>With Best Regards,
>Andy Shevchenko
>

-- 
Wei Yang
Help you, Help me
