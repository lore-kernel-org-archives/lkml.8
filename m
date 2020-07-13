Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E833C433E5
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 13:50:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0203E206F4
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 13:50:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="CMkxtAGi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729982AbgGMNug (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 09:50:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729873AbgGMNue (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 09:50:34 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F34C6C061794
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 06:50:33 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id g13so9916337qtv.8
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 06:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=vlrDlUYUKGml5UggZTrPldaeCrJJpueT2vaP2F68WPk=;
        b=CMkxtAGi5opCIFDLDXatbH+st+eB5Ijn5qpYvzvMWfQ90tknvaEy3MWVjkhemIW8eG
         U5/7yxTthqhhWaMF/SpDUkLPGfC8wmS+ZoPJxCjfWU4vs+KvgGotLhm8u/F79uArh6vf
         1Ds0opoMWMhCcpz6uuq1Ant+g33AgkPod8rY6ovOdjQnv8ZkjVJBbP5HvcAIVonbgi6+
         940mziew1e1lRJYw16UpuD1W1jd+ofNNjVqHZvyIf8Dxe0jyq4mjBrXTtjfA4Gy45JyL
         mxhnBofUAvf8q4M4qCdC5UnJ4rTOMRmGIXxgyz/SWGDdf5yxktbW9ueC4//mrcduf65f
         sCDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=vlrDlUYUKGml5UggZTrPldaeCrJJpueT2vaP2F68WPk=;
        b=AmAF9bMgC5igplKHaPRmKjQ7o9uUCkf+tbIdrRUjrmdPD/zMwr595I5w94Rsa8czCh
         3PyOScg92B+GtgflN4vM+He63xDY8dmEHEld95Ja9PvytUrtyfa+nSdNAT6JOAw9lDdi
         n2My9RXJDEkJ3+WSy5mQwxTqQb0k8KTz/cyfBww1otpsLkX8Bbp/ckVgUEdY1An5tc5q
         J8syqF7c81nxv/bYTKtmh0BFz44sNfpK63OZV3HTY/mGL1U5Z41vaqsw/rKl7iS3LzCK
         UwizW2vu60anx6gOdf9idB9vLbD+Y6QWPz4EY1WBcibnvHGR/RL6Ly5Od8GWMtkkgFjn
         qwgQ==
X-Gm-Message-State: AOAM531wr3XDh9JaiSAIUCVJj25C9ZZXAnrO6bUJFyhXFxYXw99h6x2o
        60rnH9yWT4IIiSFdmPELYi5HY3asTe3ZWg==
X-Google-Smtp-Source: ABdhPJwLXMUyr7KJNqN8opqxSnS0V/qOb48twXlcI7xQ5LwDgvA+ZzNgxKc5tOh2DjVsaADIqEy1Gw==
X-Received: by 2002:ac8:4588:: with SMTP id l8mr85227289qtn.189.1594648232276;
        Mon, 13 Jul 2020 06:50:32 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id a185sm18070623qkg.3.2020.07.13.06.50.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 06:50:31 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.93)
        (envelope-from <jgg@ziepe.ca>)
        id 1juyql-009hrJ-6b; Mon, 13 Jul 2020 10:50:31 -0300
Date:   Mon, 13 Jul 2020 10:50:31 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Cc:     Bart Van Assche <bvanassche@acm.org>, dledford@redhat.com,
        linux-rdma@vger.kernel.org, target-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        David Miller <davem@davemloft.net>,
        Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] SCSI RDMA PROTOCOL (SRP) TARGET: Replace HTTP links with
 HTTPS ones
Message-ID: <20200713135031.GA25301@ziepe.ca>
References: <20200709194820.27032-1-grandmaster@al2klimov.de>
 <3d230abd-752e-8ac1-e18d-b64561b409ff@acm.org>
 <8fca4633-41ad-7e86-2354-36381bf5c734@al2klimov.de>
 <bf85e454-cccc-37ef-d55f-d44a5c5c51df@acm.org>
 <c6b97005-e4c7-0a46-37eb-b5bb187ee919@al2klimov.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c6b97005-e4c7-0a46-37eb-b5bb187ee919@al2klimov.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 12, 2020 at 10:15:29PM +0200, Alexander A. Klimov wrote:
> 
> 
> Am 12.07.20 um 21:52 schrieb Bart Van Assche:
> > On 2020-07-10 11:12, Alexander A. Klimov wrote:
> > > Am 10.07.20 um 16:22 schrieb Bart Van Assche:
> > > > On 2020-07-09 12:48, Alexander A. Klimov wrote:
> > > > > diff --git a/drivers/infiniband/ulp/srpt/Kconfig b/drivers/infiniband/ulp/srpt/Kconfig
> > > > > index 4b5d9b792cfa..f63b34d9ae32 100644
> > > > > +++ b/drivers/infiniband/ulp/srpt/Kconfig
> > > > > @@ -10,4 +10,4 @@ config INFINIBAND_SRPT
> > > > >          that supports the RDMA protocol. Currently the RDMA protocol is
> > > > >          supported by InfiniBand and by iWarp network hardware. More
> > > > >          information about the SRP protocol can be found on the website
> > > > > -      of the INCITS T10 technical committee (http://www.t10.org/).
> > > > > +      of the INCITS T10 technical committee (https://www.t10.org/).
> > > > 
> > > > It is not clear to me how modifying an URL in a Kconfig file helps to
> > > > reduce the attack surface on kernel devs?
> > > 
> > > Not on all, just on the ones who open it.
> > 
> > Is changing every single HTTP URL in the kernel into a HTTPS URL the best
> > solution? Is this the only solution? Has it been considered to recommend
> > kernel developers who are concerned about MITM attacks to install a browser
> > extension like HTTPS Everywhere instead?
> I've installed that addon myself.
> But IMAO it's just a workaround which is (not available to all browsers, not
> installed by default in any of them and) not even 100% secure unless you
> tick a particular checkbox.
> 
> Anyway the majority of maintainers and Torvalds himself agree with my
> solution.
> 
> I mean, just look at
> git log '--author=Alexander A. Klimov <grandmaster@al2klimov.de>' \
> 
> Or (better) wait for v5.9-rc1 (and all the yet just applied patches it will
> consist of) *and then* run the command.

Well, if you are going to do this please send just one patch for all
of drivers/infiniband/ and include/rdma

I don't need to see it broken up any more than that

Jason
