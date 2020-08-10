Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D63F6C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 12:14:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4E662073A
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 12:14:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WajYfFnP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726800AbgHJMOu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 08:14:50 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:60608 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726146AbgHJMOu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 08:14:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597061688;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mFGq01KB6yv2eF3br0aTnbULoIv6iDtWfkD0dwkNAI0=;
        b=WajYfFnPLOTRHgU/1LPcHjaDdxwD/crqd9RfLpkOKtHuCEsek41QqIZ6zeduJzaApFtHz9
        zupf54aK9RU+kMrFsq7jtRHd+nSyUWsaNiMvh6tf7J4jf1rJS5JjiiMATBIl/Fhqop1n3J
        eoUDslWjrYVL+VrFqJOT4neSJvjRGeU=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-239-X9L_UFuoPqCq2f1eGxr6aA-1; Mon, 10 Aug 2020 08:14:47 -0400
X-MC-Unique: X9L_UFuoPqCq2f1eGxr6aA-1
Received: by mail-pf1-f199.google.com with SMTP id z16so7594350pfq.7
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 05:14:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mFGq01KB6yv2eF3br0aTnbULoIv6iDtWfkD0dwkNAI0=;
        b=DyjPcghTmolcy7RltuPVFU4Df7tQiW/7Tzc30CWXEwlcxZRCz56My4wfbYq4cOYOtU
         aQItcjIsSYWGaNKNLaG4ZojJGaknJ7MdHs9KlLubYx/GAZ+1FwL+gwfgTkGVbSEs52uF
         wr2LEs34ndMoAHjLRAiHVocBCx/KGWmRU4uhHrGqwwlCZhAqUsolMrsKXzF8xay5Uemg
         CH6CuNCFezB6F9rqM0nOK13Kkg1YAaAx1mYOMu68fisS3Heb7YEwzfoNlsaoMRPtpJ17
         sgIQRdO+luQeb09fZ+OE7aOOm+IkLWICGfqwzBzQSVJQhMZF84EFlyy89AHokynp3O/C
         ddNg==
X-Gm-Message-State: AOAM530rSc524TmPV2O4SNtwT8el0/1C4A6uI84NZeRjYJchtV7rIDFN
        6A0lXLP18A2eduqIJUH5tRHXvjgQ4NYu+up2sPf5/IqAe2RKn2MlfTv15WKoW6IlyjkV7PdCXjq
        B8WwJi3JtjFRVhxpAHFB2h9ES
X-Received: by 2002:a17:90a:b78e:: with SMTP id m14mr25463850pjr.94.1597061686087;
        Mon, 10 Aug 2020 05:14:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxwzStnT1u0RTwRtZhvrYJsV6+Z8bupkxANdv4pxTA87mAexwynwJf+TvDHVo5R1Izkxqwdlg==
X-Received: by 2002:a17:90a:b78e:: with SMTP id m14mr25463826pjr.94.1597061685829;
        Mon, 10 Aug 2020 05:14:45 -0700 (PDT)
Received: from xiangao.remote.csb ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id a2sm23693831pfh.152.2020.08.10.05.14.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2020 05:14:45 -0700 (PDT)
Date:   Mon, 10 Aug 2020 20:14:34 +0800
From:   Gao Xiang <hsiangkao@redhat.com>
To:     Chao Yu <yuchao0@huawei.com>, linmiaohe <linmiaohe@huawei.com>
Cc:     xiang@kernel.org, chao@kernel.org, linux-erofs@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] erofs: Convert to use the fallthrough macro
Message-ID: <20200810121434.GA13109@xiangao.remote.csb>
References: <1596878486-23499-1-git-send-email-linmiaohe@huawei.com>
 <f8ff563e-3d20-fc44-37ca-7eb05407ddc8@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f8ff563e-3d20-fc44-37ca-7eb05407ddc8@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 10, 2020 at 11:39:42AM +0800, Chao Yu wrote:
> On 2020/8/8 17:21, linmiaohe wrote:
> > From: Miaohe Lin <linmiaohe@huawei.com>
> > 
> > Convert the uses of fallthrough comments to fallthrough macro.
> > 
> > Signed-off-by: Hongxiang Lou <louhongxiang@huawei.com>
> > Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> 
> Reviewed-by: Chao Yu <yuchao0@huawei.com>

Looks good to me too,

Reviewed-by: Gao Xiang <hsiangkao@redhat.com>

(Although it seems some exist discussions here, e.g.,
 https://lore.kernel.org/r/20200708065512.GN2005@dread.disaster.area 
 Will confirm that before the next cycle.)

Thanks,
Gao Xiang

> 
> Thanks,
> 

