Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59C73C1975A
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 03:01:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BD6F20738
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 03:01:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=massaru-org.20150623.gappssmtp.com header.i=@massaru-org.20150623.gappssmtp.com header.b="IHTT0YwY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726655AbgCRDBW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 23:01:22 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:34034 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726229AbgCRDBV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 23:01:21 -0400
Received: by mail-qk1-f194.google.com with SMTP id f3so36436699qkh.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Mar 2020 20:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=massaru-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=ydkM02gA1lv2jXZ+vVnjGn/g5VzXdwCSm+r9ur1CJPs=;
        b=IHTT0YwYPoS8iMmX0qpmgTqBgRe4WcF01YbL2TEUEwWqZdjOAZwHvbArCyepsxfcs0
         5RhcvvUs+1Nhtw8Q6FHiVx6OPM4knOtgscqJG4CCaIjYfENTn8BQGSfU8HnjNQ0Au5q5
         fCJ1bE1qbheMPOHu5Rx+kKtWBcbtX1E1cUtDYKEmYlLrkxgQNFYTrzM5p90radr5v1Do
         uKvdEWktYiutwnbjOklODkdp0T+wqHzG0jkZ1uC+yH67D/mYvJ0vRtYBv6vLNZnQN5rh
         lsF+ZTSX4PkQQneVutZwIkM59OL6A9ALmdJbMV/E2fIKiRfxHbcRzHn0n78WLUHNuXvy
         MMcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=ydkM02gA1lv2jXZ+vVnjGn/g5VzXdwCSm+r9ur1CJPs=;
        b=CBQNntlOGHV/85BqyW8AkFXV94kABTVi75DBDICr8eRuLvb4zB5dc+jjeKMa/SF4cD
         sXzLQ+QVa7QWLSgCqa9Q2exw0xBH2ZCCJB62Vq67ZiAVlVHRqk3H6UboJ7NV20nnC14V
         0ZWA0AA2ZTQ4/zAofoT3LFWtGfE3MWZNWafL26N6ytorr+z9qnTJFcv4eBdwpQVK536n
         p5AZPN2X9y/fA8gIXl4/G8y1w1l0rqJ1S4Ov9san85e46FTbtF/sdPoFwXLxgt5OUnIa
         h0OHRG+4FsZaK8Nnafk670c4ZBlkDiuv3uiwP4axgo0oRCqdTRd/P36Dtlx1WXIlHI+U
         xmbw==
X-Gm-Message-State: ANhLgQ3AHSzc6ZA9FVNzlXHUmHW+juddIsLrtse1wgK8ApZuBVPfeAqM
        GzE0FuJYK3xosBhrq+Ha4jRnuQ==
X-Google-Smtp-Source: ADFU+vvoBQmPUjD+nO2M86aMQl7VYth980jIKigj6jVHrMsul9eZMS8ExL6RHyTxp/EV9PKXlpRWrQ==
X-Received: by 2002:a37:6244:: with SMTP id w65mr2061863qkb.350.1584500480945;
        Tue, 17 Mar 2020 20:01:20 -0700 (PDT)
Received: from bbking.lan ([2804:14c:4a5:36c::cd2])
        by smtp.gmail.com with ESMTPSA id i4sm3478217qtr.41.2020.03.17.20.01.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2020 20:01:20 -0700 (PDT)
Message-ID: <3ffd63b480b47aa572a9f95ba620eb4d0ce93f34.camel@massaru.org>
Subject: Re: [PATCH 2/2] xarray: Add missing blank line after declaration
From:   Vitor Massaru Iha <vitor@massaru.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        skhan@linuxfoundation.org
Date:   Wed, 18 Mar 2020 00:01:17 -0300
In-Reply-To: <20200318015553.GG22433@bombadil.infradead.org>
References: <cover.1584494902.git.vitor@massaru.org>
         <7efa62f727eb176341fc0cdfcd47c890ff424451.1584494902.git.vitor@massaru.org>
         <20200318015553.GG22433@bombadil.infradead.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.5 (3.32.5-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthew,

On Tue, 2020-03-17 at 18:55 -0700, Matthew Wilcox wrote:
> On Tue, Mar 17, 2020 at 10:43:03PM -0300, Vitor Massaru Iha wrote:
> > @@ -1624,6 +1624,7 @@ static inline unsigned int
> > xas_find_chunk(struct xa_state *xas, bool advance,
> >  	if (XA_CHUNK_SIZE == BITS_PER_LONG) {
> >  		if (offset < XA_CHUNK_SIZE) {
> >  			unsigned long data = *addr & (~0UL << offset);
> > +
> >  			if (data)
> >  				return __ffs(data);
> >  		}
> 
> Do you seriously think this makes the function in any way more
> legible?

Sorry. I was in doubt whether it would actually improve. I did some
research in older patches and I found something like this.



