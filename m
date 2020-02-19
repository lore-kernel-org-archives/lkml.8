Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59C44C35254
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 20:04:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26923208C4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 20:04:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582142691;
	bh=PTXcNLU7VFbKS/B8PLaK9EnVE3sefYyOOH070hQ/Kv4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=wDz2l0/xLzVd4PJpyk3TxPxb77uOvAozUtA9YuHc3RphWDpmnteDst4/7FuLYHNNM
	 kbvpNp9CCjFVR5NKS9oDMlwXQCLB0V9LDA5606BypAsj8CVXBaaGUuU5pnaJGBjysV
	 H50Pw5vF3AsCDt577m0/FGPfZu1D1VlYTf0mazzY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727161AbgBSUEt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 15:04:49 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:37465 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726734AbgBSUEs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 15:04:48 -0500
Received: by mail-ot1-f66.google.com with SMTP id b3so192603otp.4;
        Wed, 19 Feb 2020 12:04:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Y69m6YreEhpROt0GtdE3QRjZbmZdIsP2QJE7zPyHFN4=;
        b=GveT5HD62VRq3wSZf1HAtvg4d+BWv43t8X9wj6DK5I2jC2yk3tw8icKrmb8GLpdJjL
         C2zDkXpgyemOmGRhp2yT1mxm4XBWw5DgwotccL0GiIlH+3erUvBmfz4pFfN1ifrM/09R
         lXlHmRJczn5Ee4eJaIug066ElVFudMAgFek/K8QvvyEWwRWDP64CTsTyhI+H/YpxyBLh
         S4L+G1ehsPTxQh0erLltDnIwFUr805rwADzsnde7GTQaVNjqaYbQDgCzB8+QxxB7C9nt
         GfjaZF5oWHJwy/pRji5Hdt0yY00Oexs6HGpwX9XakrYyHzF7g6zU8r1RA/an6V78Nj3d
         Tbnw==
X-Gm-Message-State: APjAAAXJeaP8pMsLhTtmr7WTinBzRh3ii+j63dOoBJngUSmX60KbCt1n
        EAEMROfzzP8L4LDP6NRNNbyoqDGZdw==
X-Google-Smtp-Source: APXvYqy9ep6W/LTmMOkwrhw7JdGWKGRsfHd4P94n6XKXnadr81O+WabVg5ygLiU9RKAYZBhcbDJl0A==
X-Received: by 2002:a05:6830:1149:: with SMTP id x9mr21373149otq.156.1582142687849;
        Wed, 19 Feb 2020 12:04:47 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 3sm267357otd.15.2020.02.19.12.04.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 12:04:47 -0800 (PST)
Received: (nullmailer pid 15016 invoked by uid 1000);
        Wed, 19 Feb 2020 20:04:46 -0000
Date:   Wed, 19 Feb 2020 14:04:46 -0600
From:   Rob Herring <robh@kernel.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infread.org
Subject: Re: [PATCH] MAINTAINERS: remove myself from DT bindings entry
Message-ID: <20200219200446.GA8502@bogus>
References: <20200206120457.9054-1-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200206120457.9054-1-mark.rutland@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 06, 2020 at 12:04:57PM +0000, Mark Rutland wrote:
> For quite a while Rob has been handling DT binding maintenance, and I
> haven't had the time to review bindings outside of a few targetted
> cases. Given that, I think being listed in MAINTAINERS is more
> misleading than helpful.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: devicetree@vger.kernel.org
> ---
>  MAINTAINERS | 1 -
>  1 file changed, 1 deletion(-)

:( Applied.

Feel free to continue to chime in on any crap bindings when you get the 
urge. :)

Rob
