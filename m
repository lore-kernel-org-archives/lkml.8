Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9751C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 20:15:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB37822CA1
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 20:15:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596658507;
	bh=Foh04wF0e32hfUQpUIo4XyVMj/ypq2vh62IhP/5MmVE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=si+0OaMjTl/xh1C8+zzp3gcRg4zEoQmeCuob7ILlAvSaPMN31bJcK2J49XXbsx3wz
	 IpK48ih8orfBFWB2oeNiIYgvDgwsQ5nPlkWhJfFWNsLlGlxMVR9+g2/cylOX1TDvB0
	 qp+BSg3zp1hu4Eri02ZgY7ISi1BNi/Sz3DrpFGzM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729822AbgHEUPG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 16:15:06 -0400
Received: from mail-lf1-f48.google.com ([209.85.167.48]:40840 "EHLO
        mail-lf1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726585AbgHEQVC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 12:21:02 -0400
Received: by mail-lf1-f48.google.com with SMTP id m15so23907579lfp.7
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 09:21:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=29PkptMrIh0wL9+y+cJ5jR3/l+AuSbnf80pfRQhXI6Y=;
        b=dTibp3nObfdWJnTarzU3qIoY1mtETKuafEGlU4yplAbFLJSCzNBimrDjRq/qATLpwS
         gRs5XYvsXYBDs85iMQJaMJQRLaCvYhUai0dMmyEauFaiwFHHM5xKoqrVoIAtaF+sBsv9
         wrlfMeM2ce2OMAzsAeUO3ESADzXYC6ig7fRfprtPkoTxiNA9tIhVMeB1yypl1MY6p3mp
         UGmZwFoOfprFqE4faN1fOFRUYzhxotX54hnZlL8FebdhLBbD0BdBHG5l1J+JSrMniiOo
         G5QnVLjUarzMd4Mtdw6bUbrG2dxvg1wpMd9Gu3+rdwwMKWCJJLstxN9gtvRDR/OfryMJ
         8kWQ==
X-Gm-Message-State: AOAM531ibLZjCc7LsWpAa7uM/u6rmBpXFUIsblkzhg0llMncpC3J8X3Q
        wMhC4+Ft5+PU9Q3u7RS9ICw=
X-Google-Smtp-Source: ABdhPJwRYPUdeEvLiz482raxZOFw8HkgE2IwIkweXVoWC2qvJ9WAhYrqx0qx0zGOZKDFxLndOgXJ3A==
X-Received: by 2002:a19:457:: with SMTP id 84mr1946291lfe.191.1596644459745;
        Wed, 05 Aug 2020 09:20:59 -0700 (PDT)
Received: from xi.terra (c-beaee455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.174.190])
        by smtp.gmail.com with ESMTPSA id a16sm1165711ljj.108.2020.08.05.09.20.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2020 09:20:58 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1k3MA2-00005N-PL; Wed, 05 Aug 2020 18:21:02 +0200
Date:   Wed, 5 Aug 2020 18:21:02 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Alex Elder <elder@ieee.org>
Cc:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        greybus-dev@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] greybus: Use fallthrough pseudo-keyword
Message-ID: <20200805162102.GK3634@localhost>
References: <20200727183258.GA28571@embeddedor>
 <63871608-e076-26b0-85df-cff11699c3a3@ieee.org>
 <e36013ba-e19a-86c9-cb68-d7ad5559c292@ieee.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e36013ba-e19a-86c9-cb68-d7ad5559c292@ieee.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 05, 2020 at 08:14:47AM -0500, Alex Elder wrote:
> On 7/28/20 5:37 PM, Alex Elder wrote:
> > On 7/27/20 1:32 PM, Gustavo A. R. Silva wrote:
> >> Replace the existing /* fall through */ comments and its variants with
> >> the new pseudo-keyword macro fallthrough[1].
> >>
> >> [1] https://www.kernel.org/doc/html/v5.7/process/deprecated.html?highlight=fallthrough#implicit-switch-case-fall-through
> > 
> > Thanks for the patch.  It looks good, but it raises
> > another question I'd like discussion on.

Sorry about the late reply on this.

> It's been a week, and we heard back from Viresh (and Joe) on
> this, but no one else.  Viresh left out the break statement on
> the last case of the switch statement intentionally, arguing
> that it is not needed (much like a return statement at the end
> of a void function).  But he doesn't feel strongly enough
> insist it should stay that way.  I'm sure the others omitted
> the break statement intentionally as well.

I really don't mind break statements in the final case and often do add
them, but I'm a bit reluctant to suggest that this is something that
need "fixing". There are a ton of these all over the kernel, and I think
we have too many opportunities for people to do mechanical clean ups
already.

Especially after Gustavo's work, the only real argument for adding them
is mostly moot as the compiler would catch it if anyone adds a new case
and forgets about the break statement.

> Given no strong pushback, I'll ask you (Gustavo) to post a
> second patch adding the missing break statements I described
> (and look for any others I might have missed).  If you would
> prefer not to do that, just say so, and I will send out such
> a patch myself.

I'd probably just leave it as is, if only to not inspire others to send
copy-cat "fixes".

Johan
