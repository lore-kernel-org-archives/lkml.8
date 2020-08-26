Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ED1EC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 09:50:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DAA3221741
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 09:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598435451;
	bh=flqfdinl/qRnKOjzS9tis3TK7zjuqgYHmK53RRzGca8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=PnWcJ1SYaoHKev7uyWWAHQmgm9kkZNJ0E4fHK3uQnpiJWVdKntXzRvXgDMmCyX5CT
	 iDfR7C9o7rpWIM8qi+HtBsQx2DQeHfiMcvEmnrCNlTJOiAciTtyKa3NOtC5nY1eAjg
	 S8nAhSgv7g1c8a5H8yFyGYvxyx+L1lyCh9IT8xXg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728357AbgHZJuu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 05:50:50 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41949 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727997AbgHZJut (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 05:50:49 -0400
Received: by mail-wr1-f68.google.com with SMTP id p17so1142520wrj.8
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 02:50:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XYRj2v7R5LZk+33zWoDyl+Re6PBI0A19OrU7pGYabjI=;
        b=Q61lvIPv+Mb13FBVAyoqdqcW50jZS+XekIhpOtWxvGxXv9P5ELYR+dK8xhyoC2Qmup
         WQdnFRqcjQhcYsugmT6shCxPkqt6OJ4YpVDJBZipHvNlVRRtLhAFEoCi9EkDTfYsUmyW
         Nv/dTx6RQ+LIv5nYFH3waVIZgIBKpIOTjvD26kqznCXWpGeXnPiXwnWwN4Y/rL4C18AM
         kwWID0AFwNsfCbuZuZv2naGbq1ijMd6pSUUc6/SzNVR7EsXOgpOjOKgGq9q958tJCiuO
         bpMNTGpTlDAzEbgFjb1NoEZ9e8zub4Mg61TY0OUn6hKqin9F7UhBUXVs0ly0IH0mPZDX
         pwyw==
X-Gm-Message-State: AOAM531sn86tNFIXiYLQOF6hjHKCrVA/YidKNzrJCBani/tL44yPyy70
        If8QdP9XAX1OJ3OSJbjlSlg=
X-Google-Smtp-Source: ABdhPJyWu0V1esE6oDyreBUd1DUUpYrwKeqiun61wKB0Gr2F9LIQxVUafOqdYLIn2weWfK2GyZJQPA==
X-Received: by 2002:adf:a106:: with SMTP id o6mr14689307wro.1.1598435447191;
        Wed, 26 Aug 2020 02:50:47 -0700 (PDT)
Received: from pi3 ([194.230.155.216])
        by smtp.googlemail.com with ESMTPSA id k24sm3964995wmj.19.2020.08.26.02.50.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2020 02:50:46 -0700 (PDT)
Date:   Wed, 26 Aug 2020 11:50:44 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     "Ramuthevar, Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>, thomas.langer@intel.com,
        cheol.yong.kim@intel.com, qi-ming.wu@intel.com, yin1.li@intel.com
Subject: Re: [PATCH v1 0/9] extcon: extcon-ptn5150: Add the USB external
 connector support
Message-ID: <20200826095044.GA12835@pi3>
References: <20200818065727.50520-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20200818084044.GD1891694@smile.fi.intel.com>
 <69e13a74-8b8d-cbc0-915d-ce289e7d4a70@linux.intel.com>
 <CAHp75VfwBnDgR6WR_On1nh+dX4meWrX1Q-CiUKqkV39=o2m5Hg@mail.gmail.com>
 <b9187c39-8d94-6b41-9e1c-b95161b17c1c@linux.intel.com>
 <20200825081935.GE189773@kuha.fi.intel.com>
 <bc66fcec-fa52-71a3-57d1-514a4d716605@linux.intel.com>
 <20200826091804.GF1891694@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200826091804.GF1891694@smile.fi.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 26, 2020 at 12:18:04PM +0300, Andy Shevchenko wrote:
> On Wed, Aug 26, 2020 at 10:51:37AM +0800, Ramuthevar, Vadivel MuruganX wrote:
> > On 25/8/2020 4:19 pm, Heikki Krogerus wrote:
> > > On Wed, Aug 19, 2020 at 04:45:38PM +0800, Ramuthevar, Vadivel MuruganX wrote:
> > > > On 19/8/2020 3:55 pm, Andy Shevchenko wrote:
> > > > > On Wed, Aug 19, 2020 at 8:38 AM Ramuthevar, Vadivel MuruganX
> > > > > <vadivel.muruganx.ramuthevar@linux.intel.com> wrote:
> > > > > > On 18/8/2020 4:40 pm, Andy Shevchenko wrote:
> > > > > > > On Tue, Aug 18, 2020 at 02:57:18PM +0800, Ramuthevar,Vadivel MuruganX wrote:
> > > > > > > > USB external connector chip PTN5150 used on the Intel LGM SoC
> > > > > > > > boards to detect the USB type and connection.
> > > > > > > Internally I meant you can send cleanups, but couple of patches here are the
> > > > > > > features and were still under discussion... But here we are.
> > > > > > 
> > > > > > you mean asking us to implement the Heikki suggested as below..
> > > > > > 
> > > > > > Heikki Krogerus: register the port and the partner attached to it with
> > > > > > the USB Type-C connector class in the driver. Is my understaanding
> > > > > > right? if not, please explain it. Thanks!
> > > > > 
> > > > > When you mention somebody, don't forget to Cc them (now done by me).
> > > > Sure, Thank you
> > > 
> > > So the patches 1-5 are fine. The rest needs to be rewritten.
> > Already Krzysztof submitted all the patches and got approved, so we started
> > sending only one patch which support to Intel LGM SoC based boards, Thanks!
> 
> I'm not sure what you meant by above.
> 
> Krzysztof suggested you to squash all first patches into 1 (or two) and he
> approves it. What you have to do is follow his advise and send v2 where it will
> be one (or two) patch with his tag attached.
> 
> Krzysztof, is it correct what I'm saying?

Yes, correct. I guess Vadivel mentioned my patchset which was sent some
days before and recently got applied into extcon tree.

I think there is no misunderstanding here.

Best regards,
Krzysztof

