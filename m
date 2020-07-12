Return-Path: <SRS0=5Khs=AX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6BCDC433E2
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jul 2020 21:10:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9DFA82067D
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jul 2020 21:10:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O6F8mkCN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729473AbgGLVKu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jul 2020 17:10:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729020AbgGLVKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jul 2020 17:10:50 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39E65C061794;
        Sun, 12 Jul 2020 14:10:50 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id u185so5071825pfu.1;
        Sun, 12 Jul 2020 14:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lUm4cLOAP9oD2S5sJi8gYSXH2QfTVX1GOTo0+hkX9Vw=;
        b=O6F8mkCNKikIkJNPo8IyOR2P1aVobZP0JBcpPYikcOWdR66LKUkequBincy02tlLVy
         hcAxeAoGq+5TjhwWDKaRP716hbMChV0VTPnjGKpbAqNBXei8oDMKRk5YPID0Bvpgomxi
         TwPLqsGkWFsyaa1/nskgH15LdhQX0iy/0DsXFTrkfuccF6eqWxGbxlqiixcP+v9D0dpK
         qMapDHxkhgfPi0O62NVbKzUklImQDWs+FNxt0fMVCseWHXNZQWB/8obwHHuqD9N/pSBj
         o/4ynkYyIXaijTMou/mlVC3ievRIJtiIlRqp6Z4yaS68Of5WCao/vyl54IY1num1+f6X
         vPPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lUm4cLOAP9oD2S5sJi8gYSXH2QfTVX1GOTo0+hkX9Vw=;
        b=d1sSnGdiqVmPsisNvSFxRGwACEq/7+EvweJDZT42Sn+a5CZszg/F2t7QgKj5D8zJ8N
         LgBL/QO3E9aHWgwLsg/GNlh4shpDiDz+bIG8XjyjvZ0ebEdz2gUH0w49D9iPxj87TzTb
         OM3uCPzeaFzeCauEa3KXMog41hCJCJF1WZQj4lp71oPn0v/cCdWtibn+hHGoTRR8YNN1
         dTQwW5dBBWDSLSZ04gBFFbcYwVkvrmx2W5oVCb51Xvci5UyzUNV+2oXGHh3+G8WVhbgU
         QT+WX4wKU3t0hz/HyNAxNvQ5f9M01qfzcwq5lRs2a7MacRN+5NLc+7JR5gZcySEQ4o58
         /nyQ==
X-Gm-Message-State: AOAM532QDTifoxkq58QpvDQAkDfowFVLo0alGq5seRCgMTxV3/4PgfpW
        asJMB1mIzdIc6Up0Di2BBSY=
X-Google-Smtp-Source: ABdhPJy3vL+y6+PJJgo91UvG6zi9x0U+Z/p1fmB+bUb9pJVVBrqWVjmhlbkhKbSU+d9auRivIZIbrA==
X-Received: by 2002:a63:c603:: with SMTP id w3mr65777252pgg.284.1594588249757;
        Sun, 12 Jul 2020 14:10:49 -0700 (PDT)
Received: from austin-fedora (IP-168-124.cs.nctu.edu.tw. [140.113.168.124])
        by smtp.gmail.com with ESMTPSA id 204sm12275757pfx.3.2020.07.12.14.10.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2020 14:10:49 -0700 (PDT)
Date:   Mon, 13 Jul 2020 05:10:45 +0800
From:   Austin Chang <austin880625@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     dm-devel@redhat.com, Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dm-cache: document zeroing metadata device step
Message-ID: <20200712211045.GA332416@austin-fedora>
References: <20200712194039.329035-1-austin880625@gmail.com>
 <20200712195932.GV12769@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200712195932.GV12769@casper.infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 12, 2020 at 08:59:32PM +0100, Matthew Wilcox wrote:
> On Mon, Jul 13, 2020 at 03:40:39AM +0800, Austin Chang wrote:
> > +  # When using dmsetup directly instead of volume manager like lvm2,
> > +  # the first 4k of the metadata device should be zeroed to indicate
> > +  # empty metadata.
> > +  dd if=/dev/zero of=/dev/mapper/metadata bs=4k conv=notrunc
> 
> ... don't you need 'count=1' or you'll zero the entire device?

Oops, I copied the command I just used since zeroing the whole metadata
device didn't harm. But 'count=1' should match what I've just written.
I will send a v2 patch later
